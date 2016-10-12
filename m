From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 3/7] PCI: dra7xx: Set drvdata at end of probe function
Date: Wed, 12 Oct 2016 14:48:02 -0500
Message-ID: <84f6a4b4-d900-844d-545f-cae1aed299e2@ti.com>
References: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161012133258.27714.51056.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20161012133258.27714.51056.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/12/2016 08:32 AM, Bjorn Helgaas wrote:
> Set the drvdata pointer at the end of probe function for consistency with
> other drivers. 

I've seen it done the current way many places.

> We don't need the drvdata until after the probe completes,
> and we don't need it at all if the probe fails. 

Are you sure this will always be true? Why not set it as soon as we have
the ability to, what do we gain by waiting till the end, something like
one less instruction in the failure case?

> No functional change
> intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-dra7xx.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 1c24f34..3d184f6 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -418,12 +418,11 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	reg &= ~LTSSM_EN;
>  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
>  
> -	platform_set_drvdata(pdev, dra7xx);
> -
>  	ret = dra7xx_add_pcie_port(dra7xx, pdev);
>  	if (ret < 0)
>  		goto err_gpio;
>  
> +	platform_set_drvdata(pdev, dra7xx);

Space here.

>  	return 0;
>  
>  err_gpio:
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
