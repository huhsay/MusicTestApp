#!/bin/bash
# ============================================================
#  MusicTestApp — GitFlow 로컬 초기 세팅 스크립트
#  실행: chmod +x gitflow-setup.sh && ./gitflow-setup.sh
# ============================================================

set -e  # 오류 발생 시 즉시 중단

REPO_URL="https://github.com/huhsay/MusicTestApp.git"

echo ""
echo "🎵 MusicTestApp GitFlow 세팅 시작"
echo "================================================"

# 1. git 초기화 (아직 안 된 경우)
if [ ! -d ".git" ]; then
  echo "📦 git 초기화..."
  git init
  git remote add origin "$REPO_URL"
else
  echo "✅ git 이미 초기화됨"
  if ! git remote | grep -q origin; then
    git remote add origin "$REPO_URL"
    echo "🔗 remote origin 추가됨"
  fi
fi

# 2. 원격에서 전체 fetch
echo ""
echo "📡 원격 브랜치 fetch 중..."
git fetch --all

# 3. main 브랜치 설정
echo ""
echo "🌿 main 브랜치 설정..."
git checkout -B main origin/main

# 4. develop 브랜치 설정
echo ""
echo "🌿 develop 브랜치 설정..."
git checkout -B develop origin/develop

# 5. 기본 작업 브랜치를 develop으로
echo ""
echo "🔀 현재 브랜치를 develop으로 전환..."
git checkout develop

# 6. 완료 메시지
echo ""
echo "================================================"
echo "✅ GitFlow 로컬 세팅 완료!"
echo ""
echo "📋 브랜치 현황:"
git branch -a
echo ""
echo "🚀 GitFlow 작업 흐름:"
echo ""
echo "  새 기능 시작:"
echo "    git checkout develop"
echo "    git checkout -b feature/기능명"
echo ""
echo "  기능 완료 후 develop에 머지:"
echo "    git checkout develop"
echo "    git merge --no-ff feature/기능명"
echo "    git branch -d feature/기능명"
echo "    git push origin develop"
echo ""
echo "  릴리즈 준비:"
echo "    git checkout -b release/1.0.0 develop"
echo "    git checkout main && git merge --no-ff release/1.0.0"
echo "    git tag -a v1.0.0 -m 'Release 1.0.0'"
echo "    git checkout develop && git merge --no-ff release/1.0.0"
echo "    git branch -d release/1.0.0"
echo ""
echo "  긴급 핫픽스:"
echo "    git checkout -b hotfix/버그명 main"
echo "    git checkout main && git merge --no-ff hotfix/버그명"
echo "    git checkout develop && git merge --no-ff hotfix/버그명"
echo "    git branch -d hotfix/버그명"
echo ""
echo "🎉 즐거운 개발 되세요!"
