# ベースイメージとしてNVIDIAの公式CUDAイメージを使用
FROM nvidia/cuda:12.4.0-devel-ubuntu22.04

# 環境変数を設定
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/usr/local/cuda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    python3-venv \
    python3-dev \
    libpq-dev \
    intel-mkl \
    wget \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Pythonのシンボリックリンクを作成
RUN ln -sf /usr/bin/python3.10 /usr/bin/python \
    && ln -sf /usr/bin/pip3 /usr/bin/pip

# pipをアップグレード
RUN pip install --upgrade pip

# 作業ディレクトリを設定
WORKDIR /app

# CUDAが適切に設定されていることを確認
RUN nvidia-smi || echo "Note: nvidia-smi will not work during build, but should work when container runs with GPU access"
