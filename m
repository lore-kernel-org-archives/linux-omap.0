From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 2/2] PCI: dra7xx: Iterate over INTx status bits
Date: Thu, 4 Jan 2018 11:39:36 +0530
Message-ID: <7b62e14f-9571-82a2-76eb-8cad44103fde@ti.com>
References: <20171229114131.22296-1-vigneshr@ti.com>
 <20171229114131.22296-3-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171229114131.22296-3-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Friday 29 December 2017 05:11 PM, Vignesh R wrote:
> It is possible that more than one legacy IRQ may be set at the same
> time, therefore iterate and handle all the pending INTx interrupts
> before clearing the status and exiting the IRQ handler. Otherwise, some
> interrupts would be lost.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 892f93910012..48c6ae535847 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -257,7 +257,8 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>  	struct dra7xx_pcie *dra7xx = arg;
>  	struct dw_pcie *pci = dra7xx->pci;
>  	struct pcie_port *pp = &pci->pp;
> -	u32 reg;
> +	unsigned long reg;
> +	u32 virq, bit;
>  
>  	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
>  
> @@ -269,8 +270,11 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>  	case INTB:
>  	case INTC:
>  	case INTD:
> -		generic_handle_irq(irq_find_mapping(dra7xx->irq_domain,
> -						    ffs(reg) - 1));
> +		for_each_set_bit(bit, &reg, PCI_NUM_INTX) {
> +			virq = irq_find_mapping(dra7xx->irq_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +		}
>  		break;
>  	}
>  
> 
