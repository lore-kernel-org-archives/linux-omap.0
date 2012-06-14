From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fix issues.
Date: Thu, 14 Jun 2012 15:59:42 +0300
Message-ID: <4FD9E03E.8030102@compulab.co.il>
References: <1339673500-5218-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:55902 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682Ab2FNM7w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:59:52 -0400
In-Reply-To: <1339673500-5218-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, Partha Basak <parthab@india.ti.com>, Samuel Ortiz <sameo@linux.intel.com>, mantesh@ti.com, s-sapna1@ti.com, Russ Dill <Russ.Dill@gmail.com>

Hi Russ,

On 06/14/12 14:31, Russ Dill wrote:
> 'ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue' (1fcb57d0) fixes
> an issue where the ULPI PHYs were not held in reset while initializing
> the EHCI controller. However, it also changes behavior in
> omap-usb-host.c omap_usbhs_init by releasing reset while the
> configuration in that function was done.
> 
> This change caused a regression on BB-xM where USB would not function
> if 'usb start' had been run from u-boot before booting. A change was
> made to release reset a little bit earlier which fixed the issue on
> BB-xM and did not cause any regressions on 3430 sdp, the board for
> which the fix was originally made.
> 
> This new fix, 'USB: EHCI: OMAP: Finish ehci omap phy reset cycle
> before adding hcd.', (3aa2ae74) caused a regression on OMAP5.
> 
> The original fix to hold the EHCI controller in reset during
> initialization was correct, however it appears that changing
> omap_usbhs_init to not hold the PHYs in reset during it's
> configuration was incorrect. This patch first reverts both fixes, and
> then changes ehci_hcd_omap_probe in ehci-omap.c to hold the PHYs in
> reset as the original patch had done. It also is sure to incorporate
> the _cansleep change that has been made in the meantime.
> 
> I've tested this on Beagleboard xM, I'd really like to get an ack from
> the 3430 sdp and OMAP5 guys before getting this merged.
> 
> Signed-off-by: Russ Dill <Russ.Dill@gmail.com>
> ---
>  drivers/mfd/omap-usb-host.c  |   45 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/host/ehci-omap.c |   18 ++++++++---------
>  2 files changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 7e96bb2..10984e2 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -25,6 +25,7 @@
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/spinlock.h>
> +#include <linux/gpio.h>
>  #include <plat/cpu.h>
>  #include <plat/usb.h>
>  #include <linux/pm_runtime.h>
> @@ -502,6 +503,19 @@ static void omap_usbhs_init(struct device *dev)
>  	pm_runtime_get_sync(dev);
>  	spin_lock_irqsave(&omap->lock, flags);
>  
> +	if (pdata->ehci_data->phy_reset) {
> +		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
> +			gpio_request_one(pdata->ehci_data->reset_gpio_port[0],
> +					 GPIOF_OUT_INIT_LOW, "USB1 PHY reset");
> +
> +		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
> +			gpio_request_one(pdata->ehci_data->reset_gpio_port[1],
> +					 GPIOF_OUT_INIT_LOW, "USB2 PHY reset");
> +
> +		/* Hold the PHY in RESET for enough time till DIR is high */
> +		udelay(10);
> +	}

Hmmm.... I think this hunk should come before the spin_lock_irqsave() call,
as it might sleep with I2C GPIO extenders...

> +
>  	omap->usbhs_rev = usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
>  	dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->usbhs_rev);
>  
> @@ -580,10 +594,39 @@ static void omap_usbhs_init(struct device *dev)
>  			usbhs_omap_tll_init(dev, OMAP_TLL_CHANNEL_COUNT);
>  	}
>  
> +	if (pdata->ehci_data->phy_reset) {
> +		/* Hold the PHY in RESET for enough time till
> +		 * PHY is settled and ready
> +		 */
> +		udelay(10);
> +
> +		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
> +			gpio_set_value_cansleep
> +				(pdata->ehci_data->reset_gpio_port[0], 1);
> +
> +		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
> +			gpio_set_value_cansleep
> +				(pdata->ehci_data->reset_gpio_port[1], 1);
> +	}

Same here, after the the spin_unlock_irqrestore() call?

> +
>  	spin_unlock_irqrestore(&omap->lock, flags);
>  	pm_runtime_put_sync(dev);
>  }
>  
> +static void omap_usbhs_deinit(struct device *dev)
> +{
> +	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
> +	struct usbhs_omap_platform_data	*pdata = &omap->platdata;
> +
> +	if (pdata->ehci_data->phy_reset) {
> +		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[0]))
> +			gpio_free(pdata->ehci_data->reset_gpio_port[0]);
> +
> +		if (gpio_is_valid(pdata->ehci_data->reset_gpio_port[1]))
> +			gpio_free(pdata->ehci_data->reset_gpio_port[1]);
> +	}
> +}
> +
>  
>  /**
>   * usbhs_omap_probe - initialize TI-based HCDs
> @@ -767,6 +810,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>  	goto end_probe;
>  
>  err_alloc:
> +	omap_usbhs_deinit(&pdev->dev);
>  	iounmap(omap->tll_base);
>  
>  err_tll:
> @@ -818,6 +862,7 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
>  {
>  	struct usbhs_hcd_omap *omap = platform_get_drvdata(pdev);
>  
> +	omap_usbhs_deinit(&pdev->dev);
>  	iounmap(omap->tll_base);
>  	iounmap(omap->uhh_base);
>  	clk_put(omap->init_60m_fclk);
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index a44294d..d0815b6 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -192,14 +192,13 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/* Hold PHYs in reset while initializing EHCI controller */
>  	if (pdata->phy_reset) {
>  		if (gpio_is_valid(pdata->reset_gpio_port[0]))
> -			gpio_request_one(pdata->reset_gpio_port[0],
> -					 GPIOF_OUT_INIT_LOW, "USB1 PHY reset");
> +			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 0);
>  
>  		if (gpio_is_valid(pdata->reset_gpio_port[1]))
> -			gpio_request_one(pdata->reset_gpio_port[1],
> -					 GPIOF_OUT_INIT_LOW, "USB2 PHY reset");
> +			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 0);
>  
>  		/* Hold the PHY in RESET for enough time till DIR is high */
>  		udelay(10);
> @@ -241,6 +240,11 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>  	omap_ehci->hcs_params = readl(&omap_ehci->caps->hcs_params);
>  
>  	ehci_reset(omap_ehci);
> +	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
> +	if (ret) {
> +		dev_err(dev, "failed to add hcd with err %d\n", ret);
> +		goto err_add_hcd;
> +	}
>  
>  	if (pdata->phy_reset) {
>  		/* Hold the PHY in RESET for enough time till
> @@ -255,12 +259,6 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>  			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
>  	}
>  
> -	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
> -	if (ret) {
> -		dev_err(dev, "failed to add hcd with err %d\n", ret);
> -		goto err_add_hcd;
> -	}
> -
>  	/* root ports should always stay powered */
>  	ehci_port_power(omap_ehci, 1);
>  

-- 
Regards,
Igor.
