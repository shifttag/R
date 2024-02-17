''' 24 - 02 - 17 강의자료 '''

'''
- Review

1. 데이터 준비, 패키지 준비
mpg <- as.data.frame(ggplot2::mpg)
library(dplyr)
library(ggplot2)

2. 데이터 파악 함수
head() : 앞부분
tail() : 뒷부분
str() : 속성
summary() : 요약 통계량

3. 변수명 수정
mpg <- rename(mpg, company(바꿔줄 변수명) = manufacturer(기존 변수명))

4. 파생변수 생성
mpg$total <- (mpg$cty + mpg$hwy) / 2
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")

5. 빈도 확인
table(mpg$test)
qplot(mpg$test)

6. 조건에 맞는 데이터만 추출
exam %>% filter(english >= 80)

7. 정렬
exam %>% arrange(math)  # 오름 차순
exam %>% arrange(desc(math))  # 내림 차순

8. 파생변수
exam %>%
  mutate(total = math + eng + science)
  
exam %>%
  mutate(test = ifelse(science >= 60, "pass", "fail"))
  
9. 집단별로 요약
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math))
  
10. 결측치

  1) 확인
  table(is.na(df$score))
  
  2) 제거
  df_nomiss <- df %>% filter(!is.na(score) & !is.na(s))
  
  3) 함수의 결측치 제거 기능
  mean(df$score, na.rm = T)
  exam %>% summarise(mean_math = mean(math, na.rm = T))
  
11. 이상치

  1) 확인
  table(outlier$s)
  
  2) 결측 처리
  outlier$s <- ifelse(outlier$s == 3, NA, outlier$s)
  
  3) boxplot
  boxplot(mpg$hwy)$stats
  
  4) 극단치 결측 처리
  mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
'''
#-------------------------------------------------------------------------------

''' R로 만들수 있는 그래프 '''

### ggplot2 의 레이어 구조
'''
1 단계 : 배경 설정 (축)
2 단계 : 그래프 추가 (점, 막대, 선 등)
3 단계 : 설정 추가 (축 범위, 색, 표식)
'''

''' 
산점도 (Scatter Plot) : 데이터를 x축과 y축에 점으로 표현한 그래프
-> 나이나 소득처럼 연속된 값으로 된 두 변수의 관계를 표현할 때 사용 (X-Y그래프)  
'''

library(ggplot2)

# x축 displ, y축 hwy 로 지정
ggplot(data = mpg, aes(x = displ, y = hwy))

# 그래프 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

# 축 범위를 조정하는 설정 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() + 
  xlim(3,6) +
  ylim(10,30)

'''
qplot() -> 전처리 단계에서 데이터 확인용, 문법 간단, 기능 단순
ggplot() -> 최종 보고용, 색, 크기, 폰트 등 세부 조작이 가능
'''

# ------------------------------------------------------------------------------
'''
막대 그래프 (Bar Chart) : 데이터의 크기를 막대의 길이로 표현한 그래프
-> 성별 소득 차이처럼 집단 간 차이를 표현할 때 주로 사용

1. 평균 막대 그래프
2. 빈도 막대 그래프
'''

### 평균 막대 그래프

# 1. 집단별 평균표 생성
library(dplyr)

mpg <- as.data.frame(ggplot2::mpg)

df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

df_mpg

# 2. 그래프 생성
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

# 3. 크기순으로 정렬
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) +
  geom_col()

### 빈도 막대 그래프 - 값의 개수(빈도)로 막대의 길이를 표현한 그래프

# x축 범주 변수, y축 빈도
ggplot(data = mpg, aes(x = drv)) + geom_bar()

# x축 연속 변수, y축 빈도
ggplot(data = mpg, aes(x = hwy)) + geom_bar()

'''
평균 막대 그래프 : 데이터를 요약한 평균표를 먼저 만든 후 평균표를 
                    이용해서 그래프 생성 - geom_col()
빈도 막대 그래프 : 별도로 표를 만들지 않고 원자료를 이용해 바로 
                    그래프 생성 - geom_bar()
'''

'''
Q1. suv 차종만 추출한 뒤에 회사별 cty 평균을 구하고, 상위 5위만 출력
Q2. Q1으로 만든 표를 이용해서 막대그래프로 표현 해보세요.
'''

df_mpg1 <- mpg %>%
  filter(class == 'suv') %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)
  
ggplot(data = df_mpg1, aes(x = reorder(manufacturer, -mean_cty), y = mean_cty)) + geom_col()

#-------------------------------------------------------------------------------
''' 
선 그래프(Line Chart) : 데이터를 선으로 표현한 그래프

시계열 그래프 (Time Series Chart)
-> 일정한 시간 간격을 두고 나열된 시계열 데이터를 선으로 표현한 그래프
    환율, 주가 등 경제 지표가 시간에 따라 어떻게 변하는지 표현할 때 활용
'''

economics <- as.data.frame(ggplot2::economics)

ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()

#-------------------------------------------------------------------------------
'''
상자 그림 (그래프) - 데이터의 분포(퍼짐의 형태)를 직사각형 상자 모양으로
                      표현한 그래프
-> 분포를 알 수 있기 때문에 평균만 볼 때 보다 데이터의 특성을 좀 더
    자세히 알 수 있다.
'''

ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

# 1.5 IQR : 사분의 범위(Q1 ~ Q3 간 거리)의 1.5배 {를 벗어나면 극단치}

# ------------------------------------------------------------------------------
'''
한국복지패널데이터 분석

-> 한국보건사회연구원에서 발간한 데이터
-> 우리나라 가구의 경제활동을 연구해서 정책 지원에 반영할 목적
-> 2006 ~ 2015년 까지 전국에서 7천여 가구를 선정해서 매년 추적 조사
-> 경제활동, 생활실태, 복지욕구 등 수천개의 변수에 대한 정보로 구성
'''
### 데이터 로드
install.packages('foreign')
library(foreign)    # spss 파일 로드
library(dplyr)      # 전처리
library(ggplot2)    # 시각화
library(readxl)     # 엑셀 파일 로드

# 원본 데이터 불러오기
raw_welfare <- read.spss(file = 'C:/R_Project_hdh/Koweps_hpc10_2015_beta1.sav',
                         to.data.frame=T)

# 복사본 생성
welfare <- raw_welfare

# 데이터 검토 (파악)
str(welfare)
summary(welfare)

### 변수명 입맛에 맞게 수정

welfare <- rename(welfare, 
                  s = h10_g3,               # 성별
                  birth = h10_g4,          # 태어난 연도
                  marriage = h10_g10,      # 혼인 상태
                  religion = h10_g11,      # 종교
                  income = p1002_8aq1,     # 월급
                  code_job = h10_eco9,     # 직종 코드
                  code_region = h10_reg7)  # 지역 코드
'''
- 데이터 분석 절차

1 단계 : 변수 검토 및 전처리
2 단계 : 변수간 관계 분석 (요약표 만들기, 그래프 만들기)
'''

# ------------------------------------------------------------------------------
''' 
성별에 따른 월급 차이 - 성별에 따라 월급이 다를까?
'''

### 변수 검토
class(welfare$s)
table(welfare$s)

### 전처리
table(welfare$s)  # 이상치
''' 만약에 이상치가 존재한다면 결측 처리를 해야하지만 지금은 보이지 않는다'''

table(is.na(welfare$s))   # 결측치 확인

# 1. 성별에 이름 부여
welfare$s <- ifelse(welfare$s == 1, "male", "female")
table(welfare$s)
qplot(welfare$s)

### 월급 변수 검토 및 전처리
class(welfare$income)

welfare$income

summary(welfare$income)
qplot(welfare$income) + xlim(0,1000) 

# 2. 전처리
table(is.na(welfare$income))

# 2-1. 이상치 결측 처리
welfare$income <- ifelse(welfare$income %in% c(0,9999), NA, welfare$income)
table(is.na(welfare$income))    # 눈에 보이지 않는 이상치가 있을수 있음

### 성별에 따른 월급 차이 분석

s_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(s) %>%
  summarise(mean_income = mean(income))
s_income

ggplot(data = s_income, aes(x = s, y = mean_income)) + geom_col()

# ------------------------------------------------------------------------------
''' 나이와 월급의 관계 - 몇 살에 월급을 가장 많이 받을까? '''

### 나이 변수 검토
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

### 나이 변수 전처리

# 결측치 확인
table(is.na(welfare$birth))

# 이상치 결측 처리
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))

### 파생 변수 - 나이
welfare$age <- 2015 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$age)

### 나이와 월급의 관계 분석
age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))
head(age_income, 20)

ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()

# ------------------------------------------------------------------------------
''' 연령대에 따른 월급 차이 - 어떤 연령대의 월급이 가장 많은가? '''

### 파생 변수 - 연령대
'''
초년층 - 0 ~ 29살
중년층 - 30 ~ 59살
노년층 - 60살 이상
'''
welfare <- welfare %>% 
  mutate(ageg = ifelse(age < 30, 'young', 
          ifelse(age < 60, 'middle', 'old')))
table(welfare$ageg)
qplot(welfare$ageg)

### 연령대에 따른 월급 차이 분석
ageg_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))
ageg_income

ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col()

### 막대 정렬 : 초년 - 중년 - 노년 순서로 정렬
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) +
  geom_col() + scale_x_discrete(limits = c('young', 'middle', 'old'))

# ------------------------------------------------------------------------------

''' 연령대 및 성별 월급 차이 - 성별 월급차이는 연령대별로 다를까? '''
s_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg, s) %>%
  summarise(mean_income = mean(income))
s_income

ggplot(data = s_income, aes(x = ageg, y = mean_income, fill = s)) + 
  geom_col() + scale_x_discrete(limits = c('young', 'middle', 'old'))

### 성별 막대 분리
ggplot(data = s_income, aes(x = ageg, y = mean_income, fill = s)) +
  geom_col(position = 'dodge') +
  scale_x_discrete(limits = c('young', 'middle', 'old'))

# ------------------------------------------------------------------------------
''' 나이 및 성별 월급 차이 분석 '''
s_age <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age, s) %>%
  summarise(mean_income = mean(income))
head(s_age)

ggplot(data = s_age, aes(x = age, y = mean_income, col = s)) +
  geom_line()

# ------------------------------------------------------------------------------
''' 어떤 직업이 월급을 가장 많이 받을까 ? '''

### 직업 변수 검토
class(welfare$code_job)
table(welfare$code_job)

# 직업 전처리
library(readxl)
list_job <- read_excel('C:/R_Project_hdh/Koweps_Codebook.xlsx',
                       col_names = T,
                       sheet = 2)

# welfare 에 직업명을 결합
welfare <- left_join(welfare, list_job, by = 'code_job')

welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  head(10)

### 직업별 월급 차이 분석
job_income <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))
head(job_income, 15)

# 상위 10 추출
top10 <- job_income %>%
  arrange(desc(mean_income)) %>%
  head(10)
top10

# 그래프 생성
ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col() + coord_flip() 

# 하위 10 추출
bottom10 <- job_income %>%
  arrange(mean_income) %>%
  head(10)
bottom10

# 그래프 생성
ggplot(data = bottom10, aes(x = reorder(job, -mean_income), y = mean_income)) +
  geom_col() + coord_flip() + ylim(0,850)

# ------------------------------------------------------------------------------
''' 지역별 연령대 비율 - 노년층이 많은 지역은 어디일까? '''

### 지역 변수 검토
class(welfare$code_region)
table(welfare$code_region)

# 지역 변수 전처리
list_region <- data.frame(code_region = c(1:7),
                          region = c('서울',
                                     '수도권(인청/경기)',
                                     '부산/경남/울산',
                                     '대구/경북',
                                     '대전/충남',
                                     '강원/충북',
                                     '광주/전남/전북/제주도'))
list_region

# welfare 에 지역명 변수 추가
welfare <- left_join(welfare, list_region, by = 'code_region')

welfare %>%
  select(code_region, region) %>%
  head(20)

### 지역별 연령대 비율 분석

region_ageg <- welfare %>%
  group_by(region, ageg) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n),
         pct = round(n / tot_group * 100, 2))
head(region_ageg)  

# 그래프 만들기
ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() + coord_flip()

# 정렬 - 노년층 비율 내림차순 정렬
list_order_old <- region_ageg %>%
  filter(ageg == 'old') %>%
  arrange(pct)
list_order_old

# 지역명 순서 변수 생성
order <- list_order_old$region
order

ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() + coord_flip() + scale_x_discrete(limits = order)

# ------------------------------------------------------------------------------

''' 인터렉티브 그래프 : 반응형 그래프 '''

install.packages('plotly')
library(plotly)

# ggplot 으로 그래프 만들기
p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) +
  geom_point()
p

ggplotly(p)


# 인터렉티브 막대 그래프 생성
p2 <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) + 
  geom_bar(position = 'dodge')
p2

ggplotly(p2)

# 인터렉티브 시계열 그래프 생성

install.packages('dygraphs')
library(dygraphs)

economics <- ggplot2 :: economics
head(economics)

# 시간 순서 속성을 지니는 xts 데이터 타입으로 변경
library(xts)

eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)

dygraph(eco)

# 날짜 범위 선택 기능 추가!!!
dygraph(eco) %>% dyRangeSelector()

# 여러 값 표현하기
eco_a <- xts(economics$psavert, order.by = economics$date)
eco_b <- xts(economics$unemploy / 1000, order.by = economics$date)

eco2 <- cbind(eco_a, eco_b)                   # 데이터 결합
colnames(eco2) <- c('psavert', 'unemploy')    # 변수명 바꾸기

head(eco2)

dygraph(eco2) %>% dyRangeSelector()
















































