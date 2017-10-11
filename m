From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] of: Devices with pci_epf_bus_type require DMA
 configuration
Date: Wed, 11 Oct 2017 17:45:55 +0100
Message-ID: <cae4b8e9-9944-6482-c12c-8ce87aea1487@arm.com>
References: <20171011080041.12918-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171011080041.12918-1-kishon-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/10/17 09:00, Kishon Vijay Abraham I wrote:
> pci-epc-core.c invokes of_dma_configure in order to configure
> the coherent_dma_mask/dma_mask of endpoint function device. This is
> required for dma_alloc_coherent to succeed in pci function driver
> (pci-epf-test.c). However after
> commit 723288836628bc1c08 ("of: restrict DMA configuration"),
> of_dma_configure doesn't configure the coherent_dma_mask/dma_mask
> of endpoint function device (since it doesn't have dma-ranges
> property), resulting in dma_alloc_coherent in pci endpoint function
> driver to to fail. Fix it by making sure of_dma_configure configures
> coherent_dma_mask/dma_mask irrespective of whether the node has
> dma-ranges property or not.

Frankly, what the endpoint stuff is doing looks wrong anyway. As I
understand it, the endpoint functions aren't real devices, just a
partitioning of resources - the only piece of hardware actually doing
DMA is the EPC itself, which should already have been configured
appropriately as a platform device.

It seems to me that the EPF BAR allocations should just be using the EPC
device directly, rather than trying to pretend the EPFs are distinct DMA
masters.

Furthermore, now that I've looked:

> 	dma_addr_t phys_addr;

please no :(

(I can easily think of more than one system with an EP-capable DWC PCIe
block integrated behind an IOMMU)

Robin.

> 
> Fixes: 723288836628bc1c08 ("of: restrict DMA configuration")
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/of/device.c                 | 4 +++-
>  drivers/pci/endpoint/pci-epf-core.c | 3 +--
>  include/linux/pci-epf.h             | 1 +
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 64b710265d39..881cf80a3d69 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -10,6 +10,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> +#include <linux/pci-epf.h>
>  #include <linux/platform_device.h>
>  #include <linux/amba/bus.h>
>  
> @@ -105,7 +106,8 @@ int of_dma_configure(struct device *dev, struct device_node *np)
>  #ifdef CONFIG_ARM_AMBA
>  		    dev->bus != &amba_bustype &&
>  #endif
> -		    dev->bus != &platform_bus_type)
> +		    dev->bus != &platform_bus_type &&
> +		    dev->bus != &pci_epf_bus_type)
>  			return ret == -ENODEV ? 0 : ret;
>  
>  		dma_addr = offset = 0;
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index ae1611a62808..6f354ec6be71 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -26,7 +26,6 @@
>  #include <linux/pci-epf.h>
>  #include <linux/pci-ep-cfs.h>
>  
> -static struct bus_type pci_epf_bus_type;
>  static const struct device_type pci_epf_type;
>  
>  /**
> @@ -344,7 +343,7 @@ static int pci_epf_device_remove(struct device *dev)
>  	return ret;
>  }
>  
> -static struct bus_type pci_epf_bus_type = {
> +struct bus_type pci_epf_bus_type = {
>  	.name		= "pci-epf",
>  	.match		= pci_epf_device_match,
>  	.probe		= pci_epf_device_probe,
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 60d551a9a1ba..83a3fb7e6ac1 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -16,6 +16,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/pci.h>
>  
> +extern struct bus_type pci_epf_bus_type;
>  struct pci_epf;
>  
>  enum pci_barno {
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
