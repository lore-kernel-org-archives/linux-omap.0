From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] pci: dwc: pci-dra7xx: Make shutdown handler static
Date: Fri, 1 Dec 2017 10:43:53 +0530
Message-ID: <12f94b3d-5192-d53a-8390-812fe9b7b229@ti.com>
References: <20171201050652.13998-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20171201050652.13998-1-vigneshr@ti.com>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Friday 01 December 2017 10:36 AM, Vignesh R wrote:
> Declare dra7xx_pcie_shutdown() as a static function as its not used
> elsewhere.

Seems like the below version that had static version was not taken:

https://patchwork.kernel.org/patch/10052579/

So for this patch:

Reviewed-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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
> 
