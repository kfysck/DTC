CMAKE_MINIMUM_REQUIRED (VERSION 3.10)

# Set modern CMake policies
if(POLICY CMP0074)
  cmake_policy(SET CMP0074 NEW)  # Find_package uses <PackageName>_ROOT variables
endif()
if(POLICY CMP0077)
  cmake_policy(SET CMP0077 NEW)  # option() honors normal variables
endif()

PROJECT(dtc)

# Set default build type if not specified
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Build type" FORCE)
endif()

# Enable modern compiler features while maintaining GCC 4.9 compatibility
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Compiler-specific flags for modern GCC support
if(CMAKE_COMPILER_IS_GNUCXX)
  # Add compiler version checks for better compatibility
  if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL "6.0")
    # Modern GCC flags
    add_compile_options(-Wno-misleading-indentation)
    add_compile_options(-Wno-address-of-packed-member)
  endif()
  
  # Common flags for all GCC versions
  add_compile_options("$<$<COMPILE_LANGUAGE:CXX>:-fpermissive>")
  add_compile_options(-Wno-builtin-macro-redefined)
  
  # Use old ABI for compatibility with bundled libraries
  add_definitions(-D_GLIBCXX_USE_CXX11_ABI=0)
endif()

#Use optional command `cmake -DCMAKE_TEST_OPTION=ON ..` to build test demo.
option(CMAKE_TEST_OPTION "option for test_demo" OFF)

ADD_SUBDIRECTORY(./src)

#if you want to uninstall libraries, you should enter "build" folder, and use this command
# cat install_manifest.txt | sudo xargs rm
