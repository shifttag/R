''' 24 - 02 - 03 강의 자료 '''

''' Review

1. 주석 : 실행 결과에 영향을 미치지 않는 텍스트
  -> 코드에 대한 설명, 소제목 
  -> # : 한줄, ''' ''' : 장문

2. 변수 (Variable) : 변하는 수
  -> 지정을 할 변수명 <- 값
  
3. 데이터 프레임 (df) : 리스트를 2차원으로 확장한 자료형
  -> 엑셀과 비슷한 구조
    
4. 함수 : 기능을 하는 수
  -> 입력을 받아서 출력을 내는 수
  
5. 패키지 (Pakage) : 함수와 변수의 꾸러미
  -> 다양한 함수와, 변수를 포함 한다
  -> 함수를 사용하려면 패키지를 먼저 설치
  
6. ggplot2 패키지 : 그래프 시각화 패키지
  -> 설치 : install.packages('ggplot2')
  -> 로드 : library(ggplot2)

'''
#-------------------------------------------------------------------------------

'''
다섯명의 학생이 시험을 봤습니다. 학생 다섯명의 시험 점수를 
담고있는 변수를 만들어서 출력을 하세요. 각 학생의
시험 점수는 다음과 같습니다

1. 시험 점수 변수 생성

80, 60, 70, 50, 90

2. 전체 평균 구하기

3. 전체 평균 변수 만들고 출력하기
'''
score <- c(80,60,70,50,90)
mean(score)
mean_score <- mean(score)
mean_score

'''
데이터 프레임

-> '열'은 속성 -> 변수, column
-> '행'은 한 사람의 정보 -> row
-> 데이터가 크다 : 행 또는 열이 많다
'''

### 데이터 프레임 생성 - 시험 성적 데이터
english <- c(90,80,60,70)
math <- c(50,60,100,20)

df_midterm <- data.frame(english, math)
df_midterm

class <- c(1,1,2,2)
df_midterm <- data.frame(english, math, class)
df_midterm

## 평균 산출
''' 데이터 프레임에서 변수를 가지고 올 때 사용하는 기호 : $ '''

# 영어 평균
mean(df_midterm$english)

#수학 평균
mean(df_midterm$math)

## 데이터 프레임 한 번에 생성
df_midterm <- data.frame(eng = c(90,80,60,70), 
                         math = c(50,60,100,20),
                         class = c(1,1,2,2))
df_midterm

### 외부 데이터 활용
''' - 확장자
csv 파일 : 쉼표로 값을 구분해 놓은 파일 (엑셀로 열림)
xlsx 파일 : 엑셀 통합 문서
'''
## 엑셀 파일 불러오기
install.packages('readxl')
library(readxl)

df_exam <- read_excel('C:/R_Project_hdh/excel_exam.xlsx')  # 엑셀 파일을 불러와 df_exam할당
df_exam

mean(df_exam$english)
mean(df_exam$science)

## 엑셀 파일 첫 번째 행이 변수명이 아닌 경우
df_exam_novar <- read_excel('C:/R_Project_hdh/excel_exam_novar.xlsx', col_names = F)
df_exam_novar

# 엑셀 파일에 시트가 여러 개인 경우
df_exam_sheet <- read_excel('C:/R_Project_hdh/excel_exam_sheet.xlsx', sheet = 3)
df_exam_sheet

### csv 파일 불러오기
'''
csv : 쉼표로 구분된 값 파일
  -> 범용 데이터 형식
  -> 용량이 작음, 다양한 소프트웨어에서 사용한다.
'''
df_csv_exam <- read.csv('C:/R_Project_hdh/csv_exam.csv')
df_csv_exam

mean(df_csv_exam$math)

## 데이터 프레임을 csv 파일로 저장
df_midterm <- data.frame(english = c(90,80,70,60),
                         math = c(50,60,100,20),
                         class = c(1,1,2,2,))
write.csv(df_midterm, file = 'C:/R_Project_hdh/df_midterm.csv')

#----------------------------------------------------------------------------------
'''
데이터 파악 - 다루기 쉽게 수정
'''

'''
- 데이터 파악 함수
1. head() : 데이터의 앞부분 출력
2. tail() : 데이터의 뒷부분 출력
3. View() : 뷰어 창에서 데이터 확인 (잘 안씀) 
4. dim() : 데이터의 차원 출력 (잘 안씀)
5. str() : 데이터의 속성 출력 (*)
6. summary() : 요약 통계량 출력 (*)
'''

exam <- read.csv('C:/R_Project_hdh/csv_exam.csv')

head(exam)  # 앞에서 부터 6행만 출력 (기본값)
head(exam, 10)  # 앞에서 부터 10행만 출력

tail(exam)
tail(exam, 10)

dim(exam) # 행, 열 수 출력

str(exam) # 데이터 속성 확인

summary(exam) # 요약 통계량

### mpg 데이터 파악하기

# ggplot2 에 내장된 데이터 -> mpg 데이터
'''
미국환경 보호국에서 공개한 자료로, 1999 - 2008년 사이 미국에서 
출시된 자동차 234종의 연비 관련 정보를 담고 있는 데이터
'''
library(ggplot2)
?mpg

# ggplot2 의 mpg 데이터를 데이터 프레임 형식으로 불러오기
mpg <- as.data.frame(ggplot2::mpg)

str(mpg)
summary(mpg)

## 데이터 수정 - 변수명 바꾸기
''' dplyr 패키지 : 데이터 조작 패키지'''
install.packages('dplyr')
library(dplyr)

df_raw <- data.frame(var1 = c(1,2,1),
                     var2 = c(2,3,2))
df_raw

df_new <- df_raw  # 복사본 생성 (원본 데이터 손실 방지)
df_new

# rename() : 변수명 수정 함수
''' 유의할 점 : 새 변수명 = 기존 변수명 순서다. '''
df_new <- rename(df_new, v2 = var2) # var2 를 v2로 수정
df_new

'''
mpg 데이터의 변수명은 축약어로 되어 있다. cty는 도시연비,
hwy는 고속도로 연비를 의미한다. 이것을 수정하려 하고 mpg 데이터를
이용해서 문제를 해결해보자

Q1. ggplot2 패키지의 mpg 데이터를 사용할 수 있도록 불러온 뒤에  
    복사본을 생성하시오
    
Q2. 복사한 데이터를 사용해서 cty는 city로, hwy는 highway로 수정
    하시오.
    
Q3. 데이터의 일부를 출력해서 변수명이 바뀌었는지 확인하시오.
    상위 15개만 출력
'''

# Q1
mpg <- as.data.frame(ggplot2::mpg)
mpg_new <- mpg

# Q2
mpg_new <- rename(mpg_new, city = cty, highway = hwy)

# Q3
head(df_mpg, 15)

'''
파생변수 : 기존의 변수들을 조합해서 새로 추가하는 변수
'''
df <- data.frame(var1 = c(4,3,8),
                 var2 = c(2,6,1))
df

df$var_sum <- df$var1 + df$var2
df

df$var_mean <- df$var_sum / 2
df

## mpg에 통합 연비 변수 생성
mpg_new$total <- (mpg_new$city + mpg_new$highway) / 2
head(mpg_new)

## 조건문을 활용해서 파생변수 생성
summary(mpg_new$total)
hist(mpg_new$total)

# 20 이상이면 pass, 그렇지 않으면 fail 부여

# mpg_new$test <- ifelse(조건, 조건에 맞을 때, 조건에 맞지 않을 때)
mpg_new$test <- ifelse(mpg_new$total >= 20, 'pass', 'fail')
head(mpg_new, 20)     

# 빈도표로 합격 판정 자동차 수 살펴보기
table(mpg_new$test)

qplot(mpg_new$test)

## 중첩 조건문 - 연비 등급 변수 생성
'''
등급 기준
A : 연비 30 이상
B : 연비 20 ~ 29
C : 연비 20 미만
'''

# total을 기준으로 등급 부여

mpg_new$grade <- ifelse(mpg_new$total >= 30, 'A', 
                        ifelse(mpg_new$total >= 20, 'B',
                        ifelse(mpg_new$total >= 10, 'C', 'D')))
head(mpg_new, 20)
tail(mpg_new, 20)

# 빈도 확인
table(mpg_new$grade)
qplot(mpg_new$grade)

#------------------------------------------------------------------------------
'''
데이터 가공 - 원하는 형태로 데이터 가공
'''

''' 데이터 전처리 - dplyr 패키지
1. filter() : 행 추출
2. select() : 열 추출
3. arrange() : 정렬
4. mutate() : 변수 추가
5. summarise() : 통계치 산출
6. group_by() : 집단별로 나누기
7. left_join() : 데이터 합치기 (열 기준)
8. bind_rows() : 데이터 합치기 (행 기준)
'''

### 조건에 맞는 데이터만 추출하기
library(dplyr)
exam <- read.csv('C:/R_Project_hdh/csv_exam.csv')
exam

# 1반만 추출
''' %>% : 파이프 기호 -> 전처리 함수들을 사용할 때 쓰는 기호 '''
exam %>% filter(class == 1)

# 2반만 추출
exam %>% filter(class == 2)

# 1반 제외하고 추출
exam %>% filter(class != 1)

## 초과, 미만, 이상, 이하 조건

# 수학 점수가 50점을 초과한 경우
exam %>% filter(math > 50)

# 영어 점수가 80점 이상인 경우
exam %>% filter(english >= 80)

## 여러 조건을 충족하는 행 추출
'''
그리고 (&) : 모든 조건을 만족
또는 (|) : 둘 중에 하나라도 만족한다면
'''

# 1반이면서 수학점수가 50점 이상인 경우
exam %>% filter(class == 1 & math >= 50)

## 여러 조건 중 하나 이상 충족하는 행 추출

# 수학 점수가 90점 이상이거나 영어 점수가 90점 이상인 경우
exam %>% filter(math >= 90 | english >= 90)

## 목록에 해당하는 행 추출

# 1, 3, 5 반에 해당되면 추출
exam %>% filter(class == 1 | class == 3 | class == 5)

''' %in% : 포함 연산자 '''
exam %>% filter(class %in% c(1,3,5))

'''
※ R에서 사용하는 기호들
- 논리 연산자
1. < : 작다
2. <= : 작거나 같다 (< =)
3. == : 같다        (= =)
4. != : 같지 않다   (! =)
5. | : 또는 (or)
6. & : 그리고 (and)
7. %in% : 매칭 확인 (포함 연산자)

- 산술 연산자
1. +, - : 더하기, 뻬기
2. * : 곱하기
3. / : 나누기
4. ^, ** : 제곱
5. %/% : 나눗셈의 몫
6. %% : 나눗셈의 나머지
'''

### 필요한 변수만 추출하기
exam %>% select(class, math, english)

# 변수 제외
exam %>% select(-english)
exam %>% select(-math, -english)

### dplyr 함수 조합하기

# class가 1인 행만 추출하고 english 추출
exam %>% filter(class == 1) %>% select(english)

가독성 있는 줄바꿈
exam %>% 
  filter(class == 1) %>% 
  select(english)

### 정렬
exam %>% arrange(math)  # 오름차순

exam %>% arrange(desc(math))  # 내림차순

# 정렬 기준 변수 여러개 지정
exam %>% arrange(class, math)

### 파생변수 추가하기
exam %>% 
  mutate(total = math + english + science) %>%
  head

# 파생변수 한 번에 추가하기
exam %>% 
  mutate(total = math + english + science ,
  mean = (math+ english + science) / 3) %>%
  head

# mutate() 에 ifelse() 적용
exam %>%
  mutate(test = ifelse(science >= 60, 'pass', 'fail')) %>%
  head

# 추가한 변수를 dplyr 코드에 바로 적용하기
exam %>%
  mutate(total = math + english + science) %>%
  arrange(total) %>%
  head

### 집단별로 요약하기
exam %>% summarise(mean_math = mean(math))

exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math))

# 여러 요약 통계량 한 번에 산출하기
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math),       # 수학 평균
            sum_math = sum(math),         # 수학 합계
            median_math = median(math),   # 수학 중앙값
            student_count = n())                      # 학생 수
'''
- 자주 사용하는 요약 통계량 함수
1. mean() : 평균
2. sd() : 표준 편차
3. sum() : 합계
4. median : 중앙값
5. min() : 최소값
6. max() : 최댓값
7. n() : 빈도
'''

# 각 집단별로 다시 집단 나누기
a <- mpg %>%
  group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty)) %>%
  head(10)

'''
회사별로 -> group_by
'suv' 자동차의 -> filter
도시 및 고속도로 통합 연비 -> mutate
평균을 -> summarise
구해서 내림차순으로 정렬하고 -> arrange(desc())
1~5위 까지 출력하기 ->(5)
'''

mpg %>%
  group_by(manufacturer) %>%
  filter(class == 'suv') %>%
  mutate (tot = (cty + hwy) / 2) %>%
  summarise(mean_tot = mean(tot)) %>%
  arrange(desc(mean_tot)) %>%
  head(5)


''' 실패한 코드
mpg %>% 
  group_by(class == 'suv') %>%
  mutate(avg = (cty + hwy) / 2) %>%
  arrange(desc(avg)) %>%
  head(5)
'''
  
### 데이터 합치기
'''
1. 가로로 합치기 : 데이터가 옆으로 커진다
2. 세로로 합치기 : 데이터가 아래로 커진다
'''

## 가로로 합치기

# 중간고사
test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(60,80,70,90,85))

# 기말고사
test2 <- data.frame(id = c(1,2,3,4,5),
                    final = c(70,83,65,95,80))


total <- left_join(test1, test2 , by='id') # id 변수 기준으로 합치기
total

name <- data.frame(class = c(1,2,3,4,5),
                   teacher = c('kim','lee','park','choi','jung'))
name

# 기준 매칭
exam_new <- left_join(exam, name, by = 'class')

## 세로로 합치기

group_a <- data.frame(id = c(1,2,3,4,5),
                      test = c(60,80,70,90,85))
group_b <- data.frame(id = c(6,7,8,9,10),
                      test = c(70,83,65,95,80))
group_a
group_b

all <- bind_rows(group_a, group_b)
all

# -------------------------------------------------------------------------------
'''
데이터 정제 - 빠진 데이터, 이상한 데이터 제거
'''

### 빠진 데이터 : 결측치 (Missing Value)
# -> 누락된 값, 비어있는 값
# -> 함수에 적용 x, 분석 결과를 왜곡
# -> 제거하고 분석을 해야한다.

## 결측치 찾기
df <- data.frame(s = c("M", "F", NA, "M", "F"),
                 score = c(5,4,3,4,NA))
df

# 결측치 확인
is.na(df)

# 결측치 빈도 출력
table(is.na(df))

# 변수별로 결측치 확인
table(is.na(df$s))

## 결측치 제거하기
library(dplyr)

df %>% filter(is.na(score))   # score가 NA인 데이터만 출력
df %>% filter(!is.na(score))  # score 결측치 제거

## 결측치를 제외한 데이터로 분석
df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)

## 여러 변수 동시에 결측치가 없는 데이터 추출
df_nomiss <- df %>% filter(!is.na(score) & !is.na(s))
df_nomiss

## 결측치가 하나라도 있으면 제거하기
df_nomiss2 <- na.omit(df)
df_nomiss2

# na.omit() 를 쓸 때 유의할 점
# -> 분석에 필요한 데이터까지 손실 될 가능성이 있다
# -> 데이터의 양이 작아질 수가 있음

## 함수의 결측치 제외 기능 사용
mean(df$score, na.rm = T) # 결측치를 제외하고 평균 산출

exam[c(3,8,15), 'math'] <- NA # 일부러 결측치 삽입
exam

exam %>% summarise(mean_math = mean(math, na.rm = T),
                   sum_math = sum(math, na.rm = T),
                   median_math = median(math, na.rm = T))

'''
결측치를 대체하기
- 결측치 많을 경우 모드 제외하면 데이터 손실 큼
- 대안 : 다른 값 채워넣기 (평균, 최빈값 등...)
- 통계 분석 기법 적용
'''

## 평균으로 대체
exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))
exam

mean(exam$math)

### 이상한 데이터 - 이상치(Outlier) : 정상범주에서 크게 벗어난 값
# -> 이상치를 포함한 분석 결과 왜곡
# -> 결측 처리하고 제외해서 분석

'''
존재할 수 없는 값 - 성별변수에 3 - 결측 처리
극단적인 값 - 신발 사이즈 변수에 400 - 정상범위 기준을 정해서 결측 처리
'''

## 존재할 수 없는 값
outlier <- data.frame(s = c(1,2,1,3,2,1),
                      score = c(5,4,3,4,2,6))
outlier

# 이상치 확인
table(outlier$s)
table(outlier$score)

# 결측 처리하기
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier$s <- ifelse(outlier$s >2, NA, outlier$s)

# 결측을 제외하고 분석
outlier %>%
  filter(!is.na(s) & !is.na(score)) %>%
  group_by(s) %>%
  summarise(mean_score = mean(score))

## 극단적인 값 - 극단치
# -> 정상범위 기준 정해서 벗어나면 결측 처리

''' 판단기준
1. 논리적 판단 : 성인 몸무게 40kg ~ 150kg 벗어나면 극단치
2. 통계적 판단 : 상하위 0.3% 극단치 또는 상자그림 1.5 IQR 벗어나면 극단치
'''

## 상자그림으로 극단치 기준 정해서 제거하기

# 상자 그림 생성
mpg <- as.data.frame(ggplot2 :: mpg)
boxplot(mpg$hwy)          # 점 : 극단치,    # 위아래선 : 극단치 경계      # 점선 : 윗수염(하위 75% ~ 100%), 아랫수염(하위 0% ~ 25%)
                          # 박스 윗줄 : 3사분위수(Q3) : 하위 75%,         # 박스 아랫줄 : 1사분위수(Q1) : 하위 25%
                          # 중간 굵은선 : 중앙값 = 2사분위수(Q2) : 하위 50%
# 상자그림 통계치 출력
boxplot(mpg$hwy)$stats  # 12 ~ 37

# 결측 처리
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

# 결측치 제외하고 분석
mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm = T))























