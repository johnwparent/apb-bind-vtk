An example repo for binding VTK with AutoPyBind11

Will configure and generate, but will not build due to current state of APB

CMake Generation command line from non source build directory

`cmake <path to source directory> -DVTK_BUILD_TREE=<path to vtk build tree>`

The specified build tool can then be used to generate the bindings and compile the project
Currently this step will fail.