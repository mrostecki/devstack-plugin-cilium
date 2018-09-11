# check for service enabled
if is_service_enabled cilium; then
    if [[ "$1" == "source" ]]; then
        # Initial source of lib script
        source $(dirname "$0")/lib/cilium
    fi

    if [[ "$1" == "stack" && "$2" == "pre-install" ]]; then
        # Set up system services
        echo_summary "Configuring system services cilium"
        pre_install_cilium

    elif [[ "$1" == "stack" && "$2" == "install" ]]; then
        # Perform installation of service source
        echo_summary "Installing cilium"
        install_cilium

    elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
        # Configure after the other layer 1 and 2 services have been configured
        echo_summary "Configuring cilium"
        configure_cilium

    elif [[ "$1" == "stack" && "$2" == "extra" ]]; then
        # Initialize and start the cilium service
        echo_summary "Initializing cilium"
        init_cilium
    fi

    if [[ "$1" == "unstack" ]]; then
        # Shut down cilium services
        # no-op
        shutdown_cilium
    fi

    if [[ "$1" == "clean" ]]; then
        # Remove state and transient data
        # Remember clean.sh first calls unstack.sh
        # no-op
        cleanup_cilium
    fi
fi
