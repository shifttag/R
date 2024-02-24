''' 24 - 02 - 24 강의 자료 '''

''' 통계적 가설 검정

- 기술 통계
  -> 데이터를 요약해서 설명하는 통계 기법
  -> ex) 사람들이 받는 월급을 집계해 전체 월급을 구하기 

- 추론 통계
  -> 단순히 숫자를 요약하는 것을 넘어 
      어떤 값이 발생할 확률을 계산하는 통계 기법
  -> ex) 수집 데이터에서 성별에 따라 월급 차이가 있는 것으로
          나타났을 때, 이런 차이가 우연히 발생할 확률을 계산
          
  1) 이러한 차이가 우연히 나타날 확률이 작다.
  -> 성별에 따른 월급 차이가 통계적으로 유의하다고 결론
  
  2) 이러한 차이가 우연히 나타날 확률이 크다.
  -> 성별에 따른 월급 차이가 통계적으로 유의하지 않다 결론
  
  3) 기술통계분석에서 집단 간 차이가 있는것으로 나타나더라도
      이는 우연에 의한 차이일 수가 있다
  -> 데이터를 사용해서 신뢰할 수 있는 결론을 내리려면
      유의확률을 계산하는 통계적 가설 검정 절차를 거쳐야함
      
- 통계적 가설 검정
  -> 유의확률을 이용해서 가설을 검정하는 방법
  
- 유의확률 (p-value)
  -> 실제로는 집단 간 차이가 없는데 우연히 차이가 있는 데이터가 추출될 확률
  -> 통상적으로 기준이 0.05다
  
  1) 분석 결과 유의확률이 크다
    -> 집단 간 차이가 통계적으로 유의하지 않다고 해석
    -> 실제로 차이가 없더라도 우연에 의해 이 정도의 차이가 관찰될 가능성이
        크다
        
  2) 분석 결과 유의확률이 작다
    -> 집단 차이가 통계적으로 유의하다고 해석
    -> 실제로 차이가 없는데 우연히 이 정도의 차이가 관찰될 가능성이 작다,
        우연이라고 보기 힘들다
'''
# ------------------------------------------------------------------------------

''' t-검정 : 두 집단의 평균 비교

-> 두 집단의 평균에 통계적으로 유의한 차이가 있는지 알아볼 때 사용하는
    통계 분석 기법
'''

### compact 자동차와 sub 자동차의 도시 연비 t 검정

mpg <- as.data.frame(ggplot2 :: mpg)
library(dplyr)    
mpg_diff <- mpg %>%
  select(class, cty) %>%
  filter(class %in% c('compact', 'suv'))

head(mpg_diff)    
table(mpg_diff$class)    

## t-test
t.test(data = mpg_diff, cty~class, var.equal = T)
  
''' - 결과 해석

1. p-value < 2.2e-16
-> p-value 가 유의확률을 의미한다. < 2.2e-16 은 유의확률이 2.2 앞에 0의 개수가
    16개 있는 값보다 작다. 이 평균 비교 분석 결과는
    "compact"와 "suv"간 평균 도시 연비 차이가 통계적으로 유의하다.
    
2. sample estimates:
mean in group compact     mean in group suv 
             20.12766              13.50000 
             
-> 각 집단의 도시 연비 평균을 나타낸 표이다  
-> compact 자동차의 도시연비는 평균적으로 20인 반면, suv는 13이니까
    suv 보다 compact의 도시연비가 더 높다고 얘기할 수 있다.
  '''

### 일반 휘발유(r)와 고급 휘발유(p)의 도시 연비 t 검정
mpg_diff2 <- mpg %>%
  select(fl, cty) %>%
  filter(fl %in% c('r', 'p'))
table(mpg_diff2$fl)    

t.test(data = mpg_diff2, cty~fl, val.eqaul = T)

''' - 결과 해석   
1. p-value = 0.2875
-> p-value가 0.2875로 0.05보다 크다
-> 실제로는 차이가 없는데 우연에 의해 관찰될 확률이 28%라는 말이 된다.
    따라서 일반 휘발유와 고급 휘발유를 사용하는 자동차 간 도시 연비 차이가
    통계적으로 유의하지 않다
'''    

# ------------------------------------------------------------------------------
''' 상관분석 - 변수간의 관계를 분석

-> 두 연속 변수가 서로 관련이 있는지를 검정하는 통계 분석 기법
1. 상관계수로 두 변수가 얼마나 관련되어 있는지 관련성의 정도를 파악할 수 있다.
2. 상관계수는 0~1 사이의 값을 지니고 1에 가까울수록 관련성이 크다
3. 상관계수가 양수면 정비례, 음수 반비례
'''
    
economics <- as.data.frame(ggplot2::economics) 
    
### 개인소비지출(pce)과 실업자수(unemploy)의 상관관계분석    
cor.test(economics$pce, economics$unemploy)

''' - 결과해석
1. p-value < 2.2e-16
-> p-value가 2.2e-16 이므로 0.05 보다 작다. 즉, 개인소비지출과
    실업자수의 상관이 통계적으로 유의하다
    
2. sample estimates:
      cor 
0.6145176 
-> cor(상관계수)이 0.6145176 으로 양수 0.61이다 즉, 실업자수와 
    개인소비지출은 한 변수가 증가하면 다른 변수도 증가하는 비례관계에 있다.
'''

### 상관 행렬 히트맵 생성
''' mtcars : R에 기본적으로 내장되어 있는 데이터, 자동차 32종의 11개 속성에
              대한 정보를 담고 있는 데이터
'''
head(mtcars)

car_cor <- cor(mtcars)  # 상관행렬 생성
car_cor
round(car_cor, 2)     # 반올림함수

install.packages('corrplot')  # 상관행렬 시각화 패키지
library(corrplot)

corrplot(car_cor)

## 숫자로 보고 싶을 때
corrplot(car_cor, method = 'number')

## 다양한 옵션 추가
corrplot(car_cor,               # 활용할 상관 행렬
         method = 'color',      # 색으로 표현
         type = 'lower',        # 왼쪽 아래 행렬만 표시 (하부삼각행렬)
         order = 'hclust',      # 유사한 상관 계수끼리 군집화
         addCoef.col = 'black', # 상관계수 색
         tl.col = 'black',      # 변수명 색깔
         tl.srt = 45,           # 변수명을 45도로 기울임
         diag = F)              # 대각 행렬 제외

## 다른 히트맵
install.packages('ggcorrplot')
library(ggcorrplot)

ggcorrplot(car_cor)
ggcorrplot(car_cor, 
           outline.color = 'white',             # 테두리 라인 색
           type = 'lower',                      # 하부삼각행렬
           lab = TRUE,                          # 상관계수 표시할건지
           lab_size = 3,                        # 상관계수의 크기
           lab_col = 'black',                   # 상관계수의 색
           ggtheme = theme_dark(),              # 뒷배경 색
           colors = c('blue', 'white', 'red'))  # 범주의 색(- ~ +)

# ------------------------------------------------------------------------------
''' 텍스트 마이닝 : 비정형 텍스트를 정형화해서 의미있는 패턴이나
                    새로운 인사이트를 찾아내는 프로세스
-> 기업에서는 나이브 베이즈, svm, 기타 딥러닝 알고리즘과
    같은 분석 기술을 적용함으로써 비정형 데이터에 숨겨진
    관계를 탐색하고 발견
    
1) 정형 데이터 : 여러 행과 열로 이루어진 표준 테이블 형식
                  분석 및 머신러닝 알고리즘에 적합하고 처리하기
                  용이하다.
2) 비정형 데이터 : 사전 정의된 데이터 형식이 없는 데이터
                    소셜미디어나 제품 리뷰 같은 소스의 텍스트,
                    비디오나 오디오 파일같은 리치 미디어 형식이
                    여기에 해당
3) 반정형 데이터 : 정형 데이터와 비정형 데이터의 형식이 혼합된
                    데이터, 어느정도 체계화는 되어 있지만, 관계형
                    데이터베이스의 요구사항을 충족하기에는 정형성이
                    부족한 데이터
                    ex) XML, JSON, HTML 형식
                    
-> 전 세계 데이터의 약 80% 비정형 형식이므로 텍스트 마이닝은
    현업에서 매우 중요한 프로세스

-> 형태소 분석 : 문장을 구성하는 어절들이 어떤 품사로 되어 있는지
                  파악하는 작업
                  
                 동해,물,과, 백두산,이, 마르,고, 닳(다),도록,

'''

### 1. java 설치
### 2. rjava 설치
install.packages('multilinguer')
library(multilinguer)
multilinguer::install_jdk()

### 3. 시스템 환경 변수 편집

''' 
윈도우 -> 시스템 환경 변수 편집 -> 환경변수 -> 시스템 변수 -> Path ->
새로 만들기 -> C:\Program Files\Java\jdk-11.0.12 -> corretto 아래에 배치 ->
'''

### 4. KoNLP 수동 설치 후 확인 -> packages에 뜨지 않는다 -> 깃허브에서 설치
install.packages('Konlp')
library(KoNLP)

# git
remotes::install_github('haven-jeon/KoNLP',
                        upgrade = 'never',
                        INSTALL_opts = c('--no-multiarch'),
                        force = TRUE)

library(KoNLP)
useNIADic()
extractNoun('안녕하세요 R을 공부중입니다.')   # 형태소 분석기

### 위의 코드에서 실행이 된다면 의존성 패키지 설치 x
install.packages('rJava')
install.packages('memoise')
install.packages('Sejong')
install.packages('hash')
install.packages('tau')
install.packages('devtools')
install.packages('KoNLP')  # 한글 자연어 처리, 한국어를 분석할 수 있는 27개 이상의 함수가 존재한다

### 데이터 로드
txt <- readLines('C:/R_Project_hdh/ash island.txt')

### 특수문자 제거
install.packages('stringr')
library(stringr)

txt <- str_replace_all(txt, '\\W', ' ')  # \\W : 특수문자
txt

### 가장 많이 사용된 단어를 확인

# 1. 명사 추출
library(KoNLP)
nouns <- extractNoun(txt)
nouns

# 2. 추출한 명사 list 를 문자열 벡터로 변환, 단어별로 빈도 생성
wordcount <- table(unlist(nouns))
wordcount

df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word

# 3. 생성된 데이터 프레임 변수명 수정
library(dplyr)
df_word <- rename(df_word, 
                  word = Var1,
                  freq = Freq)

# 4. 자주 사용된 단어 빈도표 생성 (두 글자 미만은 제외)
df_word <- filter(df_word, nchar(word) >= 2)
df_word

# 5. 빈도 기준으로 정렬 후 상위 20개 추출
top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)
top20

### 워드 클라우드 - 단어 구름 시각화
install.packages('wordcloud')
library(wordcloud)
library(RColorBrewer)   # 글자 색 표현 패키지

# 1. 단어 색상 목록 코드
a <- brewer.pal.info  # 팔렛트 확인
a
pal <- brewer.pal(8, 'Dark2') # Dark2 색상 목록에서 8개의 색상 추출

# 2. 난수 고정 - 워드 클라우드 실행할 때 마다 단어의 위치를 변경
set.seed(1234)

# 3. 워드클라우드 생성
wordcloud(words = df_word$word,  # 단어 입력
          freq = df_word$freq,   # 빈도 입력
          min.freq = 2,          # 최소 단어 빈도
          max.words = 200,       # 표현 단어 수
          random.order = F,      # 고빈도 단어를 중앙에 배치
          scale = c(4, 0.3),     # 단어 크기 범위
          colors = pal)          # 색상

### 국정원 트윗 텍스트 마이닝

'''
국정원 계정 트윗 데이터 : 국정원 대선 개입 사실이 밝혀져 논란이 되었던 
                          2013년 6월, 독립 언론 뉴스타파가 인터넷을
                          통해 공개한 데이터
'''

### 데이터 로드
twitter <- read.csv('C:/R_Project_hdh/twitter.csv',
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = 'UTF-8')
head(twitter, 5)

# 변수명 수정
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)

# 특수문자 제거
twitter$tw <- str_replace_all(twitter$tw, '\\W', ' ')
head(twitter$tw)

# 단어 빈도표 생성
nouns <- extractNoun(twitter$tw)

# 추출한 명사 list 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))
  
# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

# 두 글자 이상으로 된 단어 추출, 빈도 기준 상위 20 추출
df_word <- filter(df_word, nchar(word) >= 2)

top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)
top20

# 워드 클라우드
pal <- brewer.pal(9, 'Blues')[5:9]
set.seed(1234)

wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 10,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(6, 0.2),
          colors = pal)

# ------------------------------------------------------------------------------
''' 나이브 베이즈 분류 '''
'''
기계 학습 분야에서 나이브 베이즈는 특성들 사이의 독립을 가정하는
베이즈 정리를 적용한 확률 분류기의 일종
'''
''' tm 패키지 : 텍스트 마이닝 패키지 '''

install.packages('tm')
library(tm)

sms_raw <- read.csv('C:/R_Project_hdh/sms_spam.csv', stringsAsFactors = F)
str(sms_raw)
str(sms_raw$type)

table(sms_raw$type)

sms_corpus <- VCorpus(VectorSource(sms_raw$text))
''' 
tm 패키지의 기능 : 텍스트 문서를 corpus 형식으로 변환하는 함수를 보유
corpus : 언어 모음을 만들어 놓은 자료형 
'''
sms_corpus
inspect(sms_corpus[1:2])
as.character(sms_corpus[[1]]) # 1의 값을 문자형으로 바꿔서 지정 
lapply(sms_corpus[1:2], as.character)
''' lapply : 벡터, 리스트, 표현식, 데이터프레임 등에 함수를 적용하고
              그 결과를 리스트로 반환 '''

sms_corpus_clean <- tm_map(sms_corpus, content_transformer(tolower))
'''
tm_map : 반응형 함수라 하며, 데이터 정제를 할 때 자주 쓰이는 함수,
          문서에 함수를 적용해서 변환된 결과를 반환, 텍스트 변환 함수
content_transformer() : 문자 변환 함수
'''
as.character(sms_corpus_clean[[1]])

stopwords() # 불용어(stopwords) : 의미없게 쓰이는 단어

sms_corpus_clean <- tm_map(sms_corpus_clean, removeNumbers) # 숫자 제거기
sms_corpus_clean <- tm_map(sms_corpus_clean, removeWords, stopwords()) # 불용어제거
sms_corpus_clean <- tm_map(sms_corpus_clean, removePunctuation) # 특수문자 제거

install.packages("SnowballC")
''' SnowballC 패키지 : 어휘 비교를 지원하기 위해서 단어를 공통 어근으로
                        축소하는 단어 형태소 알고리즘을 구현한 패키지 '''
library(SnowballC)
wordStem(c('learn', 'learning', 'learned', 'learns'))
''' wordStem() : 벡터에서 주어진 각 단어의 공통 어근을 찾는 함수 
    -> 단어가 기본 구성요소로 줄어들어야 단어의 비교가 쉽다.
    -> 어근 만으로 변환을 해야 나이브 베이즈 형태를 구축할 수 있다.
'''

sms_corpus_clean <- tm_map(sms_corpus_clean, stemDocument)
# Porter의 스태밍 알고리즘을 사용해서 텍스트 문서의 어간단어 추출

sms_corpus_clean <- tm_map(sms_corpus_clean, stripWhitespace)
# 텍스트 문서의 공백 제거

sms_dtm <- DocumentTermMatrix(sms_corpus_clean)
sms_dtm
''' DocumentTermMatrix : 여러 문서들의 집단에서 단어를 추출한 뒤, 
                          행에 출현했던 단어 리스트를 나열하고,
                          열에 각 문서들은 나열한 행렬 '''

sms_dtm2 <- DocumentTermMatrix(sms_corpus,
                               control = list(tolower = TRUE,
                                              removeNumbers = TRUE,
                                              stopwords = TRUE,
                                              removePunctuation = TRUE,
                                              stemming = TRUE))
sms_dtm
sms_dtm2

### 러닝
sms_dtm_train <- sms_dtm[1:4179,] # 학습데이터
sms_dtm_test <- sms_dtm[4180:5559,] # 검증데이터

sms_train_labels <- sms_raw[1:4179,]$type    # 타입 추출
sms_test_labels <- sms_raw[4180:5559,]$type  # 타입 추출

''' R 에서 비율을 구하는 방법은 여러가지 있는데, 그 중에서 matrix
테이블을 한번에 proportion 테이블로 변환시키는 작업을 하게 된다.
prop.table() 을 이용해서 proportion/비율/퍼센트 를 구할수 있다. '''

prop.table(table(sms_train_labels))
prop.table(table(sms_test_labels))

library(wordcloud)
wordcloud(sms_corpus_clean, min.freq = 50, random.order = F)

spam <- subset(sms_raw, type == 'spam') # subset : 추출함수
ham <- subset(sms_raw, type == 'ham')

wordcloud(spam$text, max.words = 40, scale = c(3, 0.5))
wordcloud(ham$text, max.words = 40, scale = c(3, 0.5))

sms_freq_words <- findFreqTerms(sms_dtm_train, 5)
# 문서-용어 또는 용어-문서 매트릭스에서 자주 사용되는 단어를 찾아주는 함수
# 하한값
str(sms_freq_words)
