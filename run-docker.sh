#!/bin/bash

# CivicPulse Streamlit Technical Report - Docker Quick Start

echo "🏛️  CivicPulse Technical Report - Docker Setup"
echo "=============================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker Desktop."
    exit 1
fi

echo "✓ Docker is installed"
echo ""

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "⚠️  Docker Compose not found. Using 'docker compose' instead..."
    DOCKER_COMPOSE="docker compose"
else
    DOCKER_COMPOSE="docker-compose"
fi

echo "🔨 Building Docker image..."
$DOCKER_COMPOSE build

echo ""
echo "🚀 Starting Docker container..."
$DOCKER_COMPOSE up

echo ""
echo "📱 Application running at http://localhost:8501"
echo "Press Ctrl+C to stop"
