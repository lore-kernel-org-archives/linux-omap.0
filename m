From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/3] pci: dra7xx: use pdata callbacks to perform reset
Date: Wed, 27 Jan 2016 09:31:04 -0800
Message-ID: <20160127173104.GQ19432@atomide.com>
References: <1452780672-14339-1-git-send-email-kishon@ti.com>
 <1452780672-14339-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452780672-14339-4-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com, Russell King <linux@arm.linux.org.uk>, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [160114 06:12]:
> Use assert/deassert callbacks populated in the platform data to
> to perform reset of PCIe.
> 
> Use these callbacks until a reset controller driver is
> is available in the kernel to reset PCIe.
...

> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -347,6 +404,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	enum of_gpio_flags flags;
>  	unsigned long gpio_flags;
>  
> +	ret = dra7xx_pcie_reset(pdev);
> +	if (ret)
> +		return ret;
> +
>  	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
>  	if (!dra7xx)
>  		return -ENOMEM;

With the hwmod data properly configured the reset already happens
for the device by the bus driver, the hwmod code in this case?

> @@ -457,6 +518,7 @@ static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
>  	struct pcie_port *pp = &dra7xx->pp;
>  	struct device *dev = &pdev->dev;
>  	int count = dra7xx->phy_count;
> +	int ret;
>  
>  	if (pp->irq_domain)
>  		irq_domain_remove(pp->irq_domain);
> @@ -467,6 +529,10 @@ static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
>  		phy_exit(dra7xx->phy[count]);
>  	}
>  
> +	ret = dra7xx_pcie_assert_reset(pdev);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  }

Why do you need another reset here? Can't you just implement PM runtime
in the driver and do the usual pm_runtime_put_sync followed by
pm_runtime_disable?

Basically I'm wondering how come we need these platform data callbacks
at all.

Regards,

Tony
