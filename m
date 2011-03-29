From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: RE: [PATCH] mfd: Fix usbhs_enable error handling
Date: Tue, 29 Mar 2011 16:05:40 +0530
Message-ID: <50616adee81e0719b7b35884bfa194eb@mail.gmail.com>
References: <1301393275.2253.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1301393275.2253.7.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Axel Lin [mailto:axel.lin@gmail.com]
> Sent: Tuesday, March 29, 2011 3:38 PM
> To: linux-kernel@vger.kernel.org
> Cc: Keshava Munegowda; Samuel Ortiz
> Subject: [PATCH] mfd: Fix usbhs_enable error handling
>
> In the case of missing platform_data we do not hold a spin_lock,
> thus we should not call spin_unlock_irqrestore in the error path.
>
> Also simplify the error handling by separating the successful path
> from error path. I think this change improves readability.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/mfd/omap-usb-host.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index cb01209..4157d76 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -700,8 +700,7 @@ static int usbhs_enable(struct device *dev)
>  	dev_dbg(dev, "starting TI HSUSB Controller\n");
>  	if (!pdata) {
>  		dev_dbg(dev, "missing platform_data\n");
> -		ret =  -ENODEV;
> -		goto end_enable;
> +		return  -ENODEV;
>  	}
>
>  	spin_lock_irqsave(&omap->lock, flags);
> @@ -915,7 +914,8 @@ static int usbhs_enable(struct device *dev)
>
>  end_count:
>  	omap->count++;
> -	goto end_enable;
> +	spin_unlock_irqrestore(&omap->lock, flags);
> +	return 0;
>
>  err_tll:
>  	if (pdata->ehci_data->phy_reset) {
> @@ -931,8 +931,6 @@ err_tll:
>  	clk_disable(omap->usbhost_fs_fck);
>  	clk_disable(omap->usbhost_hs_fck);
>  	clk_disable(omap->usbhost_ick);
> -
> -end_enable:
>  	spin_unlock_irqrestore(&omap->lock, flags);
>  	return ret;
>  }
> --
> 1.7.1

Thanks Axel!
Acked-by: Keshava Munegowda < keshava_mgowda@ti.com>

>
