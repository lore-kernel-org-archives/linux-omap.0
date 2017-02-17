From: Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 04/22] Documentation: PCI: Guide to use pci endpoint
 configfs
Date: Fri, 17 Feb 2017 13:05:32 +0000
Message-ID: <ac16c03a-e415-327c-27b3-bcc700a6f953@synopsys.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-5-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487325042-28227-5-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Às 9:50 AM de 2/17/2017, Kishon Vijay Abraham I escreveu:
> Add Documentation to help users use pci endpoint to configure
> pci endpoint function and to bind the endpoint function
> with endpoint controller.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/PCI/00-INDEX                      |    2 +
>  Documentation/PCI/endpoint/pci-endpoint-cfs.txt |   84 +++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-cfs.txt
> 
> diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
> index ba950b2..f84a23c 100644
> --- a/Documentation/PCI/00-INDEX
> +++ b/Documentation/PCI/00-INDEX
> @@ -14,3 +14,5 @@ pcieaer-howto.txt
>  	- the PCI Express Advanced Error Reporting Driver Guide HOWTO
>  endpoint/pci-endpoint.txt
>  	- guide to add endpoint controller driver and endpoint function driver.
> +endpoint/pci-endpoint-cfs.txt
> +	- guide to use configfs to configure the pci endpoint function.
> diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt b/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
> new file mode 100644
> index 0000000..d9f8734
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
> @@ -0,0 +1,84 @@
> +                   CONFIGURING PCI ENDPOINT USING CONFIGFS
> +                    Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> +
> +The PCI Endpoint Core exposes configfs entry (pci_ep) in order to configure the
> +PCI endpoint function and in order to bind the endpoint function
> +with the endpoint controller. (For introducing other mechanisms to
> +configure the PCI Endpoint Function refer [1]).
> +
> +*) Mounting configfs
> +
> +The PCI Endpoint Core layer creates pci_ep directory in the mounted configfs
> +directory. configfs can be mounted using the following command.
> +
> +	mount -t configfs none /sys/kernel/config
> +
> +*) Directory Structure
> +
> +The pci_ep configfs directory structure has been created to reflect the
> +natural tree like structure of PCI devices. So every directory created
> +inside pci_ep represents a EPC device and every directory created inside
> +epf directory represents EPF device.
> +
> +/sys/kernel/config/pci_ep/
> +			 | <dir>/ --------------------------------------> [2]
> +				| epc
> +				| epf/
> +				     | <dir>/ --------------------------> [3]
> +					    | vendorid
> +					    | deviceid
> +					    | revid
> +					    | progif_code
> +					    | subclass_code
> +					    | baseclass_code
> +					    | cache_line_size
> +					    | subsys_vendor_id
> +					    | subsys_id
> +					    | interrupt_pin
> +					    | function
> +
> +*) Creating configfs entry for EPC
> +
> +Any directory created inside *pci_ep* represents an EPC device. In the above
> +directory structure [2] represents an EPC device. It consists of
> +
> +	*) epc: Use it to associate the configfs entry to an actual EPC device.
> +		The list of valid entries for this field can be obtained from
> +			ls /sys/class/pci_epc/
> +
> +	*) epf: Directory that contains all the endpoint functions. The name
> +		of the created directory determines the driver this particular
> +		epf device will be bound to. The name can be obtained either
> +		from the function binding documentation [4] or
> +			ls /sys/bus/pci-epf/drivers
> +
> +		If more than one endpoint function device has to be bound to
> +		the same driver, then the directory should be created using
> +		the following notation
> +			mkdir <name>.<num>
> +
> +*) Creating configfs entry for EPF
> +
> +Any directory created inside *epf* directory represents an EPF device. In the
> +above directory structure, [3] represents an EPF device. It consists of the
> +following entries that can be used to configure the standard configuration
> +header of the endpoint function. (These entries are created by the
> +framework when any new directory is created inside epf directory.)
> +
> +        | vendorid
> +        | deviceid
> +        | revid
> +        | progif_code
> +        | subclass_code
> +        | baseclass_code
> +        | cache_line_size
> +        | subsys_vendor_id
> +        | subsys_id
> +        | interrupt_pin
> +
> +The following entry identifies the function driver that is bound to the
> +function device
> +	| function
> +
> +[1] -> Documentation/PCI/endpoint/pci-endpoint.txt
> +[4] -> Documentation/PCI/endpoint/function/binding/
> 

Good content.

Acked-By: Joao Pinto <jpinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
