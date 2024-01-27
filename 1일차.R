''' 24 - 01 - 27 강의 자료 '''

'''
주석 : 코드 실행 결과에 영향을 미치지 않는 텍스트
-> 보통 코드에 대한 설명을 작성할 때 사용한다
-> 한 줄 주석 : #
-> 장문 주석 : ''' '''
'''

# 변수 지정
a <- 10

## 소제목
### 큰제목

# -------------------------------------------

### 숫자형 벡터 생성
ex_vector1 <- c(70, 80, 90)
ex_vector1

### 숫자형 벡터 속성과 길이 확인
mode(ex_vector1)    # 속성
str(ex_vector1)     # 속성, 길이, 요약(자주씀)
length(ex_vector1)  # 길이

### 정수형, 문자형, 논리형
str(12345)
str("Hello")
str(TRUE)

### 문자형 벡터
ex_vector2 <- c("Hello", "Hi~!")
ex_vector2
ex_vector3 <- c("1", "2", "3")    # 따옴표 안에 있는 숫자는 문자로 취급
ex_vector3
ex_vector3_1 <- c("'1'") 
'''
'1', '2', '3'
'''
ex_vector3_1

str(ex_vector2)
str(ex_vector3)

### 논리형 벡터 - TRUE, FALSE
### -> 주로 데이터 값을 비교할 때 쓴다

ex_vector4 <- c(TRUE, FALSE, TRUE, FALSE)
ex_vector4
str(ex_vector4)

### 범주형 자료
ex_vector5 <- c(1,1,2,2,3,3)
factor(ex_vector5, labels = c('Apple', 'Banana', 'Cherry'))

#-------------------------------------------------------------------------------
'''
행렬 : 행과 열로 구성된 2차원 단일형
배열 : 행렬을 n 차원으로 확대한 구조
'''

### 행렬 생성
x <- c(1,2,3,4,5,6)
matrix(x , nrow = 2 , ncol = 3)
matrix(x , nrow = 3 , ncol = 2)

matrix(x , nrow = 2 , ncol = 3 ,byrow = T)

### 배열 - array()
y <- c(1,2,3,4,5,6)
array(y, dim = c(2, 2, 3))

# ------------------------------------------------------------------------------
'''
리스트 : 1차원 데이터인 벡터나 서로 다른 구조의 데이터를 
          그룹으로 묶은 데이터 세트다.
          
데이터 프레임 : 이러한 리스트를 2차원으로 확대한 것
'''
### 리스트 생성 - list()
list1 <- list(c(1,2,3), 'hello', TRUE)
list1     # 포함된 값을 데이터 형 별로 구분해서 출력한다

'''
데이터 분석을 위한 기초
'''

### 변수 (Variable) -> 계속해서 변하는 수
## 다양한 값을 지니고 있는 하나의 속성
## 변수는 데이터 분석의 대상

### 변수 생성법
a <- 1
a

b <- 3.5
b

## 변수 연산
a + b
a * b
5 * a
# 제곱 : **
b ** 3

## 여러 값으로 구성된 변수 생성
var1 <- c(1,2,5,7,8)
var1

var2 <- c(1:150)
var2

# seq()
var3 <- seq(1, 5)   # 1 ~ 5 까지 연속값으로 var3 변수 생성
var3

var4 <- seq(1, 1000, by=2)    # 1 ~ 10 까지 2간격 연속값으로 var4 생성
var4

var5 <- seq(2, 100, by=2)     # 1 ~ 100 까지 짝수만 생성
var5

# 연속값 변수로 연산
var1
var1 + 2
var1 / 100
var2 <- c(1,2,3,4,5)
var1 + var2
var1 + var4

## 연속 문자 변수 생성
str1 <- c('a', 'b', 'c')
str1

str2 <- c

# ------------------------------------------------------------------------------
'''
함수 : 기능을 하는 수
-> 입력을 받아서 출력을 내는 수
-> 값을 넣으면 특정 기능을 수행해서 처음과 다른 값으 출력
'''

### 숫자를 다루는 함수들

x <- c(1,2,3)

# 1. 평균 함수
mean(x)

# 2. 최대값 함수
max(x)

# 3. 최소값 함수
min(x)

### 문자를 다루는 함수
str3 <- c('Hello!', 'World', 'is', 'good!')

paste(str3, collapse = '   ')   # 쉼표를 구분자로 str4의 단어를 다 합쳐준다

### 함수의 결과물로 새로운 변수를 만들기
x_mean <- mean(x)

str5_paste <- paste(str3, collapse = ' ※ ')

# ------------------------------------------------------------------------------
'''
패키지(Package) : 함수와 변수의 꾸러미
-> 하나의 패키지에 다양한 함수가 들어있음.
-> 함수를 사용하려면 패키지를 먼저 설치를 해야한다.
'''

### ggplot2 패키지 : 그래프 시각화 패키지
install.packages('ggplot2')   # 설치 명령어
library(ggplot2)    # 패키지 로드 명령

### ggplot2 함수 사용
x <- c('a','a','b','c')
qplot(x)  # qplot() : 빈도 함수 그래프

'''
거의 모든 패키지에는 함수를 테스트할 수 있는 테스트용
데이터가 존재한다.

ex) ggplot 에는 mpg 데이터가 존재한다.
'''
mpg <- ggplot2::mpg

# mpg 데이터에 존재하는 차들의 고속도로 연비(hwy) 빈도 그래프
qplot(data = mpg, x = hwy)

# 도심연비 (cty) 빈도 그래프
qplot(data = mpg , x = cty)

# 구동 방식별 고속도로 연비 그래프
qplot(data = mpg, x = drv, y = hwy)

# 구동 방식별 고속도로 연비 선그래프
qplot(data = mpg, x = drv, y = hwy, geom ='line')

# 구동 방식별 고속도로 연비 상자 그림 + 색상
qplot(data = mpg, x = drv, y = hwy, geom ='boxplot', colour = drv)



