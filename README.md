# Citrix Workspace Portable

## Description

`citrix_workspace-portable` is a containerized version of the Citrix ICA Client, designed for use with Distrobox. It is especially useful for users who need to access Citrix environments but prefer or require an isolated setup. This containerization approach is inspired by the Citrix ICA Client package available on the Arch Linux AUR ([icaclient](https://aur.archlinux.org/packages/icaclient)), which should be acknowledged for its contribution to the community.

## Building the Image

To build the `citrix_workspace-portable` image:

1. Clone the repository:

   ```bash
   git clone https://github.com/rafaelpalomar/citrix_workspace-portable.git
   cd citrix_workspace-portable
   ```

2. Build the container image:

   ```bash
   podman build -t quay.io/rafael_palomar/citrix_workspace-portable:latest .
   ```

## Using citrix_workspace-portable with Distrobox

To use `citrix_workspace-portable` with Distrobox:

1. Create a new Distrobox container:

   ```bash
   distrobox create -i quay.io/rafael_palomar/citrix_workspace-portable:latest -n citrix_workspace
   ```

2. Enter the Distrobox container:

   ```bash
   distrobox enter citrix_workspace
   ```

## Exporting the Application

To export `citrix_workspace-portable`:

1. Enter the Distrobox container:

   ```bash
   distrobox enter citrix_workspace
   ```

2. Export the Citrix ICA Client application:

   ```bash
   distrobox-export --app wfica
   ```

This does not install a directly callable application (i.e., a `.desktop` file) but instead associates `.ica` files with the Citrix application. Therefore, the Citrix Workspace will be accessible when `.ica` files are opened.

## File Associations

After exporting the application, `.ica` files will be automatically associated with the Citrix Workspace application within the container. Opening these files will launch the Citrix session using the containerized Citrix client.

## Verifying the Image with Cosign

To verify the signed container image:

1. Download the `cosign.pub` key from the repository.

2. Run the following command to verify the signature:

   ```bash
   cosign verify --key cosign.pub quay.io/rafael_palomar/citrix_workspace-portable:latest
   ```

## Contributions and Feedback

Your contributions and feedback are welcome! Feel free to open issues or pull requests on [GitHub](https://github.com/rafaelpalomar/citrix_workspace-portable).
