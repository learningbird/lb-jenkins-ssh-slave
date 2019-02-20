# lb-transcode-video
The repository for the lb-transcode-video container

# Building
To build this image, tag the commit with your changes and push the tag. Jenkins will pick it up and start building
right away.

The build process prevents the accidental moving of tags. If it is asked to build a commit which is ahead of the
tag's commit, then it will stop the build.
