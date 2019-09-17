FROM jupyter/scipy-notebook:1386e2046833

# install requirements and enable Jupyter extensions
COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt && \ 
    conda install -y -c conda-forge tqdm jupyter_contrib_nbextensions && \
    jupyter nbextension enable toc2/main --sys-prefix && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager
