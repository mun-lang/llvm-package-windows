$llvm_version = "7.1.0"

# Check if scoop is installed
if (!(Get-Command "scoop" -errorAction SilentlyContinue)) {
    Write-Error "scoop is not installed, get it at: https://https://scoop.sh/"
}

if (!(Get-Command "git" -errorAction SilentlyContinue)) {
    Write-Output "git is not installed, installing with scoop"
    scoop install git
}

if (!(Get-Command "cmake" -errorAction SilentlyContinue)) {
    Write-Output "cmake is not installed, installing with scoop"
    scoop install cmake
}

if (!(Get-Command "7z" -errorAction SilentlyContinue)) {
    Write-Output "7z is not installed, installing with scoop"
    scoop install 7z
}

$current_dir = (Get-Location)
$source_dir = "$current_dir\llvm"
$build_dir = "$source_dir\build"
$install_dir = "$current_dir\llvm-$llvm_version-windows-x64-msvc15"

# Clone the llvm repository
git clone --single-branch --branch "llvmorg-$llvm_version" --depth 1 "https://github.com/llvm/llvm-project.git" $source_dir

# Construct a build directory and run cmake
New-Item -ItemType "directory" -Force -Path $build_dir
cmake -S "$source_dir\llvm" -B $build_dir -G "Visual Studio 15 2017" -Thost=x64 -A x64 -DLLVM_ENABLE_PROJECTS="lld;clang" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$install_dir"

# Build the project
New-Item -ItemType "directory" -Force -Path $install_dir
cmake --build $build_dir --target INSTALL --config Release

# Create an archive from the installation
7z a -mx9 "llvm-$llvm_version-windows-x64-msvc15.7z" "$install_dir\*"

# Clean up all the directories
Get-ChildItem -Path $install_dir -Recurse | Remove-Item -force -recurse
Get-ChildItem -Path $source_dir -Recurse | Remove-Item -force -recurse
Remove-Item $install_dir -Force 
Remove-Item $source_dir -Force 