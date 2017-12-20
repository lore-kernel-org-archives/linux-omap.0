From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] pci: dwc: pci-dra7xx: Make shutdown handler static
Date: Wed, 20 Dec 2017 11:11:34 +0000
Message-ID: <20171220111134.GA1709@red-moon>
References: <20171201050652.13998-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201050652.13998-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 01, 2017 at 10:36:52AM +0530, Vignesh R wrote:
> Declare dra7xx_pcie_shutdown() as a static function as its not used
> elsewhere.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/dwc for v4.16.

Thanks,
Lorenzo

> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 59e8de34cec6..b9db442af793 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -815,7 +815,7 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
>  }
>  #endif
>  
> -void dra7xx_pcie_shutdown(struct platform_device *pdev)
> +static void dra7xx_pcie_shutdown(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
> -- 
> 2.15.0
> 
