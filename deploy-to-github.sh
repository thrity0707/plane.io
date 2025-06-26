#!/bin/bash

# 🚀 GitHub Pages 快速部署脚本
# Unity WebGL Minimal Shooting Game

echo "🎮 GitHub Pages 部署脚本启动..."
echo ""

# 检查是否在正确的目录
if [ ! -f "index.html" ]; then
    echo "❌ 错误: 请在 WebGLBuild 目录下运行此脚本"
    echo "   cd WebGLBuild && ./deploy-to-github.sh"
    exit 1
fi

# 获取用户输入
echo "📝 请输入您的GitHub信息："
read -p "GitHub用户名: " GITHUB_USERNAME
read -p "仓库名称 (默认: minimal-shooting-webgl): " REPO_NAME

# 设置默认仓库名
if [ -z "$REPO_NAME" ]; then
    REPO_NAME="minimal-shooting-webgl"
fi

echo ""
echo "🔗 准备部署到: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo ""

# 检查Git状态
if [ ! -d ".git" ]; then
    echo "❌ 错误: Git仓库未初始化"
    echo "   请先运行: git init"
    exit 1
fi

# 添加远程仓库
echo "🔗 添加GitHub远程仓库..."
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

# 检查是否有未提交的更改
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "📦 发现未提交的更改，正在提交..."
    git add .
    git commit -m "Update WebGL build for GitHub Pages deployment"
fi

# 推送到GitHub
echo "🚀 推送到GitHub..."
git branch -M main
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 部署成功！"
    echo ""
    echo "📍 下一步："
    echo "1. 前往: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
    echo "2. 点击 Settings -> Pages"
    echo "3. 选择 Source: Deploy from a branch"
    echo "4. 选择 Branch: main"
    echo "5. 点击 Save"
    echo ""
    echo "🎮 游戏将在以下地址可用 (等待5-10分钟):"
    echo "   https://$GITHUB_USERNAME.github.io/$REPO_NAME/"
    echo ""
    echo "🎉 恭喜！您的Unity射击游戏即将在全世界可访问！"
else
    echo ""
    echo "❌ 推送失败！"
    echo "请检查："
    echo "1. GitHub用户名和仓库名是否正确"
    echo "2. 仓库是否已创建"
    echo "3. 您是否有仓库的写入权限"
    echo ""
    echo "💡 提示: 可能需要先在GitHub上创建仓库"
fi 