From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3] pci: dwc: dra7xx: Add shutdown handler to cleanly
 turn off clocks
Date: Tue, 19 Sep 2017 14:30:16 -0500
Message-ID: <20170919193016.GD22312@bhelgaas-glaptop.roam.corp.google.com>
References: <1504847694-23701-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504847694-23701-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: kishon@ti.com, bhelgaas@google.com, t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 08, 2017 at 10:44:54AM +0530, Keerthy wrote:
> Add shutdown handler to cleanly turn off clocks. This will help
> in cases of kexec where in a new kernel can boot abruptly.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> 
> Changes in v3:
> 
>   * Pushed the function outside #ifdef CONFIG_PM_SLEEP.
>   * Added more details to commit log.
> 
> Changes in v2:
> 
>   * used a local dev pointer instead of dereferencing dev at multiple places.
>   * dra7xx_pcie_stop_link before disabling clks in the shutdown path.

You lost both these changes in v3.  I assume you'll post a v4.

>  drivers/pci/dwc/pci-dra7xx.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 0f9adf2..ec8f842 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -794,6 +794,19 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
>  }
>  #endif
>  
> +void dra7xx_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct dra7xx_pcie *dra7xx = dev_get_drvdata(&pdev->dev);
> +	int ret;
> +
> +	ret = pm_runtime_put_sync(&pdev->dev);
> +	if (ret < 0)
> +		dev_dbg(&pdev->dev, "pm_runtime_put_sync failed\n");
> +
> +	pm_runtime_disable(&pdev->dev);
> +	dra7xx_pcie_disable_phy(dra7xx);
> +}
> +
>  static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(dra7xx_pcie_suspend, dra7xx_pcie_resume)
>  	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(dra7xx_pcie_suspend_noirq,
> @@ -807,5 +820,6 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
>  		.suppress_bind_attrs = true,
>  		.pm	= &dra7xx_pcie_pm_ops,
>  	},
> +	.shutdown = dra7xx_pcie_shutdown,
>  };
>  builtin_platform_driver_probe(dra7xx_pcie_driver, dra7xx_pcie_probe);
> -- 
> 1.9.1
> 
