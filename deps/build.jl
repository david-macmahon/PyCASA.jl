using Conda
Conda.pip_interop(true)
Conda.pip("install", [
          "casadata==2023.4.10",
          "casaplotms==1.8.7",
          "casaplotserver==1.4.6",
          "casashell==6.5.2.26",
          "casatasks==6.5.2.26",
          "casatools==6.5.2.26",
          "casaviewer==1.6.6",
          "python-casacore"
         ])
