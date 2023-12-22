# For mix tests
Mix.shell(Mix.Shell.Process)

excludes =
  if Version.match?(System.version(), "~> 1.14") do
    []
  else
    [:mix_phx_new]
  end

ExUnit.start(exclude: excludes)
