FILE(GLOB_RECURSE SRC_LIST ./*.cc ./*.c)

include(../../utils.cmake)

INCLUDE_DIRECTORIES (
    .
    ../mysql/include
    ../libs/hsql/include/
    ../log4cplus/include
    ../yaml-cpp/include
    ../../libs/dep
    ../../daemons
    ../stat
    ../core
    ../zlib/include64)

LINK_DIRECTORIES (
    ${PROJECT_SOURCE_DIR}/src/libs/mysql/libs
    ${PROJECT_SOURCE_DIR}/src/libs/log4cplus/libs
    ${PROJECT_SOURCE_DIR}/src/libs/yaml-cpp/libs
    ${PROJECT_SOURCE_DIR}/src/libs/zlib/lib/libz64.a
    ${PROJECT_SOURCE_DIR}/src/libs/hsql/libs
)

LINK_LIBRARIES(liblog4cplus.a) 
LINK_LIBRARIES(libyaml-cpp.a)
LINK_LIBRARIES(libsqlparser.a)
LINK_LIBRARIES(libz64.a)
LINK_LIBRARIES(pthread)
LINK_LIBRARIES(libmysqlclient.a)

ADD_DEFINITIONS ("-g -fPIC -fpermissive -std=gnu++11 -D_GLIBCXX_USE_CXX11_ABI=0")
ADD_DEFINITIONS(-Wno-builtin-macro-redefined)

ADD_LIBRARY (common ${SRC_LIST})

TARGET_LINK_LIBRARIES(common liblog4cplus.a libyaml-cpp.a libsqlparser.a libz64.a libmysqlclient.a)
redefine_file_macro(common)