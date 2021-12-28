using Conda
Conda.pip_interop(true)
Conda.pip("install", [
          "casadata",
          "casaplotms",
          "casaplotserver",
          "casashell",
          "casatasks",
          "casatools",
          "casaviewer",
          "python-casacore"
         ])
