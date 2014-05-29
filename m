From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 03/18] PCI: designware: Configuration space should
 be specified in 'reg'
Date: Thu, 29 May 2014 12:32:22 -0400
Message-ID: <53876116.90504@ti.com>
References: <1401345500-20188-1-git-send-email-kishon@ti.com> <1401345500-20188-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401345500-20188-4-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mohit Kumar <mohit.kumar-qxv4g6HH51o@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 5/29/2014 2:38 AM, ABRAHAM, KISHON VIJAY wrote:
> The configuration address space has so far been specified in *ranges*,
> however it should be specified in *reg* making it a platform MEM resource.
> Hence used 'platform_get_resource_*' API to get configuration address
> space in the designware driver.
>
> Cc: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
> Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Cc: Mohit Kumar <mohit.kumar-qxv4g6HH51o@public.gmane.org>
> Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>   .../devicetree/bindings/pci/designware-pcie.txt    |    1 +
>   drivers/pci/host/pcie-designware.c                 |   17 +++++++++++++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index d6fae13..8314360 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -6,6 +6,7 @@ Required properties:
>   	as "samsung,exynos5440-pcie" or "fsl,imx6q-pcie".
>   - reg: base addresses and lengths of the pcie controller,
>   	the phy controller, additional register for the phy controller.
> +	The configuration address space should also be specified here.
Kishon,

I am working on the Keystone PCI driver for which v1 is already posted. 
Want to clarify
following.
1. Original text for reg states "base addresses and lengths of the pcie 
controller,
         the phy controller, additional register for the phy controller" 
and you added
         "The configuration address space should also be specified here"

    and the code below added resource name "config"

Does PCI designware follow some convention? Does it mean after applying 
this patch
config name is mandatory or optional? Below code you are not returning 
error. Can you
or author of PCI designware clarify what is expected to be present as 
mandatory and
what is optional.

Does config refers to RC's config space or EP's config space or both? 
The code below divide
the size by 2. So it appears to be RC's + EP's config space. Please clarify.

>   - interrupts: interrupt values for level interrupt,
>   	pulse interrupt, special interrupt.
>   - clocks: from common clock binding: handle to pci clock.
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index c4e3732..603b386 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -20,6 +20,7 @@
>   #include <linux/of_pci.h>
>   #include <linux/pci.h>
>   #include <linux/pci_regs.h>
> +#include <linux/platform_device.h>
>   #include <linux/types.h>
>   
>   #include "pcie-designware.h"
> @@ -392,11 +393,23 @@ static const struct irq_domain_ops msi_domain_ops = {
>   int __init dw_pcie_host_init(struct pcie_port *pp)
>   {
>   	struct device_node *np = pp->dev->of_node;
> +	struct platform_device *pdev = to_platform_device(pp->dev);
>   	struct of_pci_range range;
>   	struct of_pci_range_parser parser;
> +	struct resource *cfg_res;
>   	u32 val;
>   	int i;
>   
> +	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> +	if (cfg_res) {
> +		pp->config.cfg0_size = resource_size(cfg_res)/2;
> +		pp->config.cfg1_size = resource_size(cfg_res)/2;
> +		pp->cfg0_base = cfg_res->start;
> +		pp->cfg1_base = cfg_res->start + pp->config.cfg0_size;
> +	} else {
> +		dev_err(pp->dev, "missing *config* reg space\n");
This should return error -EINVAL.

> +	}
> +
>   	if (of_pci_range_parser_init(&parser, np)) {
>   		dev_err(pp->dev, "missing ranges property\n");
>   		return -EINVAL;
> @@ -429,6 +442,8 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>   			of_pci_range_to_resource(&range, np, &pp->cfg);
>   			pp->config.cfg0_size = resource_size(&pp->cfg)/2;
>   			pp->config.cfg1_size = resource_size(&pp->cfg)/2;
> +			pp->cfg0_base = pp->cfg.start;
> +			pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
>   		}
>   	}
>   
> @@ -441,8 +456,6 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>   		}
>   	}
>   
> -	pp->cfg0_base = pp->cfg.start;
> -	pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
>   	pp->mem_base = pp->mem.start;
>   
>   	pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
BTW, Please also review my Keystone series so that we could discuss this 
topic in that context
as well.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
