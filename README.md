# YBIGTA SPARK DOCKER IMAGE

## 소개

와이빅타 엔지니어링 팀에서 사용하는 spark를 위한 도커 이미지 입니다.  
[참고](https://github.com/xodhx4/how_to_code_together/blob/master/docker/docker.md)

## 특징

- 아나콘다 3.5.2
- 자바 openjdk 8
- 하둡 2.9
- 스파크 2.3.0
- pyspark
- 하이브 2.3.3
- 분산 처리가 아닌 로컬로 실행
- [ybigta 엔지니어링 위키](https://github.com/YBIGTA/EngineeringTeam/wiki/01.-PySpark-%EC%8B%A4%EC%8A%B5-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95,-Python-%EA%B0%9C%EB%B0%9C-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95)를 기본으로 생성하였습니다.

## 사용법

### 1. 인스턴스 만들기
생략

### 2. 레포 다운로드
`git clone https://github.com/xodhx4/ybigta_pyspark_docker.git`

### 3. 도커 다운로드

1. repo 안으로 이동한다.

2. `docker_install.sh`를 실행한다.  
   `sh docker_install.sh`

3. 다시 로그인 할 때부터는 sudo를 안붙여도 도커 실행 가능

### 이미지 다운로드

1. repo안으로 이동한다.

2. docker image 생성

   ```sh
   docker build --tag IMAGE_NAME_YOUWANT:VERSION_YOUWANT .
   #예시
   docker build --tag hello:1.0 .
   ```

### 컨테이너 생성 및 실행

```sh
docker run -it --name MYCONTAINER -p 10001:10001 -v ~/workspace:/root/workspace hello:1.0
# 이름이 MYCONTAINER, host의 10001번과 container의 10001번 포트를 연결
# host의 ~/workspace 폴더와 container의 /root/workspace 폴더를 연결
# hadoop, hive, spark 까지 자동 실행 되므로
# https://{ec2 ip}:10001 에 접속
```



### 컨테이너 중지

```sh
# pyspark를 종료 한 후
kill $(ps -ef | grep hive | awk '{print $2}')
# hive 종료
$HADOOP_HOME/sbin/stop-yarn.sh
$HADOOP_HOME/sbin/stop-dfs.sh

exit
```

### 컨테이너 중지하지 않고 bash 만 빠져나가고 싶을 때

`ctrl + p + q`

### 컨테이너 재실행

```sh
docker start MYCONTAINER
docker attach MYCONTAINER
```

### 주피터 노트북 비밀번호 설정

`jupyter_init.sh` 파일에서

```sh
jupyter notebook password << END
admin # 이 두 개 부분을 원하는 비밀 번호로 바꾸신 후
admin # 이미지를 새로 build 해주세요
END
```

