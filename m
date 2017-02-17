From: Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 02/22] Documentation: PCI: Guide to use PCI Endpoint
 Core Layer
Date: Fri, 17 Feb 2017 11:43:17 +0000
Message-ID: <c7b32fa3-0b69-8ffe-ab0a-581e4e784c12@synopsys.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487325042-28227-3-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Às 9:50 AM de 2/17/2017, Kishon Vijay Abraham I escreveu:
> Add Documentation to help users use endpoint library to enable endpoint
> mode in the PCI controller and add new PCI endpoint functions.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/PCI/00-INDEX                  |    2 +
>  Documentation/PCI/endpoint/pci-endpoint.txt |  190 +++++++++++++++++++++++++++
>  2 files changed, 192 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-endpoint.txt
> 
> diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
> index 147231f..ba950b2 100644
> --- a/Documentation/PCI/00-INDEX
> +++ b/Documentation/PCI/00-INDEX
> @@ -12,3 +12,5 @@ pci.txt
>  	- info on the PCI subsystem for device driver authors
>  pcieaer-howto.txt
>  	- the PCI Express Advanced Error Reporting Driver Guide HOWTO
> +endpoint/pci-endpoint.txt
> +	- guide to add endpoint controller driver and endpoint function driver.
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.txt b/Documentation/PCI/endpoint/pci-endpoint.txt
> new file mode 100644
> index 0000000..68a7839
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/pci-endpoint.txt
> @@ -0,0 +1,190 @@
> +			    PCI ENDPOINT FRAMEWORK
> +		    Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> +
> +This document is a guide to use the PCI Endpoint Framework in order to create
> +endpoint controller driver, endpoint function driver and using configfs
> +interface to bind the function driver to the controller driver.
> +
> +1. Introduction
> +
> +*Linux* has a comprehensive PCI subsystem to support PCI controllers that
> +operates in Root Complex mode. The subsystem has capability to scan PCI bus,
> +assign memory resources and irq resources, load PCI driver (based on
> +vendorid, deviceid), support other services like hot-plug, power management,
> +advanced error reporting and virtual channels.
> +
> +However PCI controller IPs integrated in certain SoC is capable of operating
> +either in Root Complex mode or Endpoint mode. PCI Endpoint Framework will
> +add endpoint mode support in *Linux*. This will help to run Linux in an
> +EP system which can have a wide variety of use cases from testing or
> +validation, co-processor accelerator etc..
> +
> +2. PCI Endpoint Core
> +
> +The PCI Endpoint Core layer comprises of 3 components: the Endpoint Controller
> +library, the Endpoint Function library and the configfs layer to bind the
> +endpoint function with the endpoint controller.
> +
> +2.1 PCI Endpoint Controller(EPC) Library
> +
> +The EPC library provides APIs to be used by the controller that can operate
> +in endpoint mode. It also provides APIs to be used by function driver/library
> +in order to implement a particular endpoint function.
> +
> +2.1.1 APIs for the PCI controller Driver
> +
> +This section lists the APIs that the PCI Endpoint core provides to be used
> +by the PCI controller driver.
> +
> +*) devm_pci_epc_create()/pci_epc_create()
> +
> +   The PCI controller driver should implement the following ops:
> +	 * write_header: ops to populate configuration space header
> +	 * set_bar: ops to configure the BAR
> +	 * clear_bar: ops to reset the BAR
> +	 * alloc_addr_space: ops to allocate *in* PCI controller address space
> +	 * free_addr_space: ops to free the allocated address space
> +	 * raise_irq: ops to raise a legacy or MSI interrupt
> +	 * start: ops to start the PCI link
> +	 * stop: ops to stop the PCI link
> +
> +   The PCI controller driver can then create a new EPC device by invoking
> +   devm_pci_epc_create/pci_epc_create.
> +
> +*) devm_pci_epc_destroy()/pci_epc_destroy()
> +
> +   The PCI controller driver can destroy the EPC device created by either
> +   devm_pci_epc_create or pci_epc_create using devm_pci_epc_destroy() or
> +   /pci_epc_destroy()
> +
> +2.1.2 APIs for the PCI Endpoint Function Driver
> +
> +This section lists the APIs that the PCI Endpoint core provides to be used
> +by the PCI endpoint function driver.
> +
> +*) pci_epc_write_header()
> +
> +   The PCI endpoint function driver should use pci_epc_write_header() to
> +   write the standard configuration header to the endpoint controller.
> +
> +*) pci_epc_set_bar()
> +
> +   The PCI endpoint function driver should use pci_epc_set_bar() to configure
> +   the Base Address Register in order for the host to assign PCI addr space.
> +   Register space of the function driver is usually configured
> +   using this API.
> +
> +*) pci_epc_clear_bar()
> +
> +   The PCI endpoint function driver should use pci_epc_clear_bar() to reset
> +   the BAR.
> +
> +*) pci_epc_raise_irq()
> +
> +   The PCI endpoint function driver should use pci_epc_raise_irq() to raise
> +   Legacy Interrupt or MSI Interrupt.
> +
> +*) pci_epc_start()
> +
> +   The PCI endpoint function driver should invoke pci_epc_start() once it
> +   has configured the endpoint function and wants to start the PCI link.
> +
> +*) pci_epc_stop()
> +
> +   The PCI endpoint function driver should invoke pci_epc_stop() to stop
> +   the PCI LINK.
> +
> +2.1.3 Other APIs
> +
> +There are other APIs provided by the EPC library. These are used for binding
> +the epf device with epc device. pci-ep-cfs.c can be used as reference for
> +using these APIs.
> +
> +*) pci_epc_get()
> +
> +   Get a reference to the pci endpoint controller based on the device name of
> +   the controller.
> +
> +*) pci_epc_put()
> +
> +   Release the reference to the pci endpoint controller obtained using
> +   pci_epc_get()
> +
> +*) pci_epc_add_epf()
> +
> +   Add a pci endpoint function to a pci endpoint controller. A pcie device
> +   can have upto 8 functions according to the specification.
> +
> +*) pci_epc_remove_epf()
> +
> +   Remove the pci endpoint function from pci endpoint controller.
> +
> +2.2 PCI Endpoint Function(EPF) Library
> +
> +The EPF library provides APIs to be used by the function driver and the EPC
> +library in order to provide endpoint mode functionality.
> +
> +2.2.1 APIs for the PCI Endpoint Function Driver
> +
> +This section lists the APIs that the PCI Endpoint core provides to be used
> +by the PCI endpoint function driver.
> +
> +*) pci_epf_register_driver()
> +
> +   The PCI Endpoint Function driver should implement the following ops:
> +	 * bind: ops to perform when a EPC device has been bound to EPF device
> +	 * unbind: ops to perform when a binding has been lost between a EPC
> +	   device and EPF device
> +	 * linkup: ops to perform when the EPC device has established a
> +	   connection with a host system
> +
> +  The PCI Function driver can then register the PCI EPF driver by using
> +  pci_epf_register_driver().
> +
> +*) pci_epf_unregister_driver()
> +
> +  The PCI Function driver can unregister the PCI EPF driver by using
> +  pci_epf_unregister_driver().
> +
> +*) pci_epf_alloc_space()
> +
> +  The PCI Function driver can allocate space for a particular BAR using
> +  pci_epf_alloc_space().
> +
> +*) pci_epf_free_space()
> +
> +  The PCI Function driver can free the allocated space
> +  (using pci_epf_alloc_space) by invoking pci_epf_free_space().
> +
> +2.2.2 APIs for the PCI Endpoint Controller Library
> +This section lists the APIs that the PCI Endpoint core provides to be used
> +by the PCI endpoint controller library.
> +
> +*) pci_epf_linkup()
> +
> +   The PCI endpoint controller library invokes pci_epf_linkup() when the
> +   EPC device has established the connection to the host.
> +
> +2.2.2 Other APIs
> +There are other APIs provided by the EPF library. These are used to notify
> +the function driver when the EPF device is bound to the EPC device.
> +pci-ep-cfs.c can be used as reference for using these APIs.
> +
> +*) pci_epf_create()
> +
> +   Create a new PCI EPF device by passing the name of the PCI EPF device.
> +   This name will be used to bind the the EPF device to a EPF driver.
> +
> +*) pci_epf_destroy()
> +
> +   Destroy the created PCI EPF device.
> +
> +*) pci_epf_bind()
> +
> +   pci_epf_bind() should be invoked when the EPF device has been bound to
> +   a EPC device.
> +
> +*) pci_epf_unbind()
> +
> +   pci_epf_unbind() should be invoked when the binding between EPC device
> +   and EPF device is lost.
> 

Good initial reference guide.

Acked-By: Joao Pinto <jpinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
