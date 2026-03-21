# CivicPulse Technical Report - Streamlit Deployment Guide

## Overview

This directory contains an advanced technical report for **CivicPulse: AI-Powered Government Navigator for Seattle Entrepreneurs**, designed for ML professors and AI researchers.

Built with **Streamlit**, **Plotly**, and **Pandas** - optimized for professional presentation of ML methodologies, evaluation results, and technical architecture.

## Project Files

- `streamlit_technical_report.py` - Main Streamlit application
- `requirements.txt` - Python dependencies
- `Dockerfile` (optional) - For containerized deployment
- `.streamlit/config.toml` - Streamlit configuration

## Local Development

### Installation

```bash
# Clone or navigate to project
cd /Users/ashishdubey/Downloads/Git_CivicPulse

# Create virtual environment (optional but recommended)
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### Running Locally

```bash
streamlit run streamlit_technical_report.py
```

The app will be available at `http://localhost:8501`

### Development Tips

- Streamlit auto-reloads when you save changes
- Use `st.cache_data` for expensive computations
- Use `st.secrets` for API keys (create `.streamlit/secrets.toml`)
- Check console output for errors

## Deployment Options

### Option 1: Streamlit Cloud (Recommended for Quick Sharing)

**Easiest option - no infrastructure needed:**

1. Push code to GitHub:
```bash
git add .
git commit -m "Add technical report"
git push origin main
```

2. Go to [Streamlit Cloud](https://share.streamlit.io)
3. Click "New app"
4. Select your GitHub repo, branch, and `streamlit_technical_report.py`
5. Deploy!

**Benefits**:
- Free tier available
- Automatic deployments on git push
- Built-in SSL/HTTPS
- Custom domain support
- Easy secret management

### Option 2: Docker (For Production)

Create `Dockerfile`:

```dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY streamlit_technical_report.py .
COPY .streamlit .streamlit

EXPOSE 8501

CMD ["streamlit", "run", "streamlit_technical_report.py", "--server.port=8501", "--server.address=0.0.0.0"]
```

Build and run:

```bash
docker build -t civicpulse-report .
docker run -p 8501:8501 civicpulse-report
```

Deploy to services like:
- AWS ECS / App Runner
- Google Cloud Run
- DigitalOcean App Platform
- Heroku (with custom buildpack)

### Option 3: Virtual Private Server (VPS)

For organizations wanting full control:

```bash
# On VPS (Ubuntu 22.04)
sudo apt-get update
sudo apt-get install python3 python3-pip python3-venv git

git clone https://github.com/your-repo/civic-pulse.git
cd civic-pulse
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Run with systemd or supervisor for persistence
```

### Option 4: University/Institution Server

Many universities provide hosting:
- UW Information School servers
- Institutional cloud credits (AWS Educate, GCP for Education)
- Docker-friendly compute clusters

## Configuration

### Streamlit Settings (`.streamlit/config.toml`)

```toml
[theme]
primaryColor = "#0066CC"
backgroundColor = "#0F1419"
secondaryBackgroundColor = "#1A1F2E"
textColor = "#E8EAED"
font = "sans serif"

[client]
showErrorDetails = false
maxUploadSize = 200

[server]
maxUploadSize = 200
enableXsrfProtection = true
enableCORS = false
```

### Environment Variables

For sensitive data, create `.streamlit/secrets.toml`:

```toml
openai_api_key = "sk-..."
database_url = "postgresql://..."
github_token = "ghp_..."
```

Access in app:

```python
import streamlit as st
api_key = st.secrets["openai_api_key"]
```

## Performance Optimization

### Caching

```python
@st.cache_data
def load_evaluation_data():
    # Expensive operation
    return data

@st.cache_resource
def get_database_connection():
    # Maintain single connection
    return connection
```

### Session State

```python
if 'counter' not in st.session_state:
    st.session_state.counter = 0
```

### Monitoring

Streamlit Cloud provides built-in analytics. For self-hosted:
- Use monitoring tools (DataDog, New Relic)
- Set up error tracking (Sentry)
- Monitor resource usage (CPU, memory)

## Customization

### Changing Colors

Edit the CSS in `streamlit_technical_report.py`:

```python
COLOR_PRIMARY = "#0066CC"      # Change blue
COLOR_SECONDARY = "#FF6B35"    # Change orange
COLOR_ACCENT = "#00D9FF"       # Change cyan
```

### Adding Sections

The app uses tabs. To add a new tab:

```python
tab1, tab2, tab3 = st.tabs(["Tab 1", "Tab 2", "Tab 3"])

with tab1:
    st.markdown("## Content")
```

### Replacing Static Data

Edit the `PROJECT_INFO`, `ML_METHODOLOGY`, and metric dictionaries at the top of the file.

## Troubleshooting

### App loads slowly

```python
# Use caching more aggressively
@st.cache_data(ttl=3600)  # Cache for 1 hour
def expensive_function():
    pass
```

### Charts don't display

- Check Plotly version: `pip install --upgrade plotly`
- Ensure data is not empty
- Check browser console for errors

### Deployment fails

```bash
# Check requirements compatibility
pip install -r requirements.txt --dry-run

# Test locally first
streamlit run streamlit_technical_report.py
```

## Updating the Report

To update with new evaluation data:

1. Edit data dictionaries in the file
2. Modify chart functions if needed
3. Test locally: `streamlit run streamlit_technical_report.py`
4. Commit and push to trigger auto-deployment

## Security Considerations

For production deployments:

- [ ] Enable HTTPS (included in Streamlit Cloud, Docker best practices)
- [ ] Add authentication if needed (e.g., `streamlit-authenticator`)
- [ ] Sanitize user inputs
- [ ] Store secrets in environment variables, not code
- [ ] Set up monitoring and alerting
- [ ] Use CORS restrictions appropriately
- [ ] Rate limit endpoints if exposing APIs

## Support & Resources

- **Streamlit Docs**: https://docs.streamlit.io
- **Plotly Reference**: https://plotly.com/python/
- **GitHub Issues**: Report bugs in the main CivicPulse repo
- **Streamlit Community**: https://discuss.streamlit.io

---

**Last Updated**: March 2026  
**Python Version**: 3.10+  
**Streamlit Version**: 1.28+
