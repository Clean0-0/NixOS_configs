# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;

      efiSysMountPoint = "/boot/efi";
    };
    grub = {

      device = "nodev";
      
      enable = true;

      efiSupport = true;
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Enable zsh for all users
  users.defaultUserShell = pkgs.zsh; 
  
  # Networking
  networking = {
    networkmanager.enable = true;

    hostName = "Pengi";
  };

  # Programs
    programs = { 
    steam = {
      enable = true;

      localNetworkGameTransfers.openFirewall = true;

      dedicatedServer.openFirewall = true;

      remotePlay.openFirewall = true;
    };
    zsh.enable = true;

    hyprland.enable = true;
  };
 
  # Hardware
  hardware = {
      # Enable openGL
      graphics.enable = true; 

      nvidia = {

      # Modesetting is required.
      modesetting.enable = true;

      # Use the open source nvidia drivers
      open = true;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;
    };
  };

  # Services
  services = {
    # Load nvidia driver for Xorg and Wayland
    xserver.videoDrivers = ["nvidia"];

  };
  
  # Enable experimental nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Guernsey";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.clean = {
    isNormalUser = true;
    description = "Stella De Carteret";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim 
    wget
    zsh
    hyprland
    xwayland
    kitty
    inxi
    pciutils
    firefox
    wofi
    fastfetch
    hyfetch
    git
    steam
    gcc
    rustup
    discord
    pavucontrol
    sway-contrib.grimshot
    efibootmgr
    gh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
