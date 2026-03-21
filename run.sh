#!/bin/bash

# CivicPulse Streamlit Technical Report - Quick Start Script
# This script sets up and runs the Streamlit technical report locally

set -e  # Exit on error

echo "🏛️  CivicPulse Technical Report - Setup"
echo "=========================================="
echo ""

# Check Python version
python_version=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
echo "✓ Python version: $python_version"

# Check if we need to create a virtual environment
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
else
    echo "✓ Virtual environment already exists"
fi

# Activate virtual environment
echo "🔄 Activating virtual environment..."
source venv/bin/activate

# Install/upgrade dependencies
echo "📥 Installing dependencies..."
pip install --upgrade pip setuptools wheel > /dev/null 2>&1
pip install -r requirements.txt > /dev/null 2>&1

echo "✓ Dependencies installed"
echo ""

# Check if .streamlit directory exists
if [ ! -d ".streamlit" ]; then
    echo "⚠️  .streamlit directory not found. Creating..."
    mkdir -p .streamlit
fi

# Check if config.toml exists
if [ ! -f ".streamlit/config.toml" ]; then
    echo "⚠️  Streamlit config not found. Creating default..."
    cp .streamlit/config.toml .streamlit/config.toml 2>/dev/null || echo "Please copy .streamlit/config.toml"
fi

echo ""
echo "🚀 Starting Streamlit application..."
echo "📱 Open your browser to: http://localhost:8501"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

streamlit run streamlit_technical_report.py
