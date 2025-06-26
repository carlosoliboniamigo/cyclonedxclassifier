#!/bin/bash

# Default to version 1.10.0 if no argument provided
VERSION=${1:-1.10.0}

echo "Generating SBOM with CycloneDX plugin version $VERSION"

if [ "$VERSION" == "1.10.0" ]; then
    # Use the default build.gradle file
    ./gradlew cyclonedxBom
elif [ "$VERSION" == "2.3.1" ]; then
    # Use the specific build file for 2.3.1
    ./gradlew -b build-2.3.1.gradle cyclonedxBom
else
    echo "Unsupported version: $VERSION. Supported versions are 1.10.0 and 2.3.1."
    exit 1
fi

# Copy the generated file to the project root for easier access
cp build/reports/cyclonedx-sbom-$VERSION.json ./ 2>/dev/null || echo "Failed to copy SBOM file. It may not have been generated."

if [ -f "cyclonedx-sbom-$VERSION.json" ]; then
    echo "SBOM generated: cyclonedx-sbom-$VERSION.json"
else
    echo "SBOM generation failed."
fi
