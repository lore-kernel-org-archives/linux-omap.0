From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/4] PCI: dwc: pci-dra7xx: Fix legacy IRQ handling
Date: Fri, 8 Dec 2017 18:35:23 +0000
Message-ID: <20171208183523.GB1885@e107981-ln.cambridge.arm.com>
References: <20171201061311.16691-1-vigneshr@ti.com>
 <20171201061311.16691-5-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171201061311.16691-5-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Chris Welch <Chris.Welch-ojoHHoaXhABCkLs28/y7ANBPR1lH4CV8@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 01, 2017 at 11:43:11AM +0530, Vignesh R wrote:
> Legacy INTD IRQ handling is broken on dra7xx due to fact that driver
> uses hwirq in range of 1-4 for INTA, INTD whereas IRQ domain is of size
> 4 which is numbered 0-3. Therefore when INTD IRQ line is used with
> pci-dra7xx driver following warning is seen:
> 
>        WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:342 irq_domain_associate+0x12c/0x1c4
>        error: hwirq 0x4 is too large for dummy
> 
> Fix this by using pci_irqd_intx_xlate() helper to translate the INTx 1-4
> range into the 0-3 as done in other PCIe drivers.
> 
> Also, iterate over all the INTx bits and call their respective IRQ
> handlers before clearing the status register.

It seems to me that you are fixing two bugs with one patch and therefore
I would ask you to split it in two or explain to me why we should
consider lumping them together.

Thanks,
Lorenzo

> Suggested-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Reported-by: Chris Welch <Chris.Welch-ojoHHoaXhABCkLs28/y7ANBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 53f721d1cc40..59e8de34cec6 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -226,6 +226,7 @@ static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>  
>  static const struct irq_domain_ops intx_domain_ops = {
>  	.map = dra7xx_pcie_intx_map,
> +	.xlate = pci_irqd_intx_xlate,
>  };
>  
>  static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
> @@ -256,7 +257,8 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>  	struct dra7xx_pcie *dra7xx = arg;
>  	struct dw_pcie *pci = dra7xx->pci;
>  	struct pcie_port *pp = &pci->pp;
> -	u32 reg;
> +	unsigned long reg;
> +	u32 virq, bit;
>  
>  	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
>  
> @@ -268,8 +270,11 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>  	case INTB:
>  	case INTC:
>  	case INTD:
> -		generic_handle_irq(irq_find_mapping(dra7xx->irq_domain,
> -						    ffs(reg)));
> +		for_each_set_bit(bit, &reg, PCI_NUM_INTX) {
> +			virq = irq_find_mapping(dra7xx->irq_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +		}
>  		break;
>  	}
>  
> -- 
> 2.15.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
