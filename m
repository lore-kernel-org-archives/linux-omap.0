From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] USB: twl4030: Enable USB regulators before enabling
 USB charging
Date: Mon, 23 Nov 2009 09:59:48 -0800
Message-ID: <20091123175948.GF22923@atomide.com>
References: <23D0CDE7C386D144A4F26EB0F427F8C074CF85B0@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61158 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZKWR7p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 12:59:45 -0500
Content-Disposition: inline
In-Reply-To: <23D0CDE7C386D144A4F26EB0F427F8C074CF85B0@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguilar Pena, Leed" <leed.aguilar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Aguilar Pena, Leed <leed.aguilar@ti.com> [091119 10:34]:
> For TWL family of power management ICs, USB charging works only
> when USB regulators are in enabled state: 3v1, 1v5, 1v8
> 
> On a USB cable attach, twl4030_phy_resume(twl) function enables
> the regulators. Enable USB charging, only after all regulators
> are enabled.
> 
> Its observed that enabling USB charging before regulators are
> enabled, causes USB charging to fail.
> 
> Tested on: Zoom2: omap3430: ES3.1 + TWL5030
> Needs T2-MADC and T2-BCI drivers which are still not upstreamed.

This should go to linux-usb list with linux-omap list Cc'd.

Regards,

Tony
 
> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
> Acked-by: Vikram Pandita <vikram.pandita@ti.com>
> Acked-by: Anand Gadiyar <gadiyar@ti.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> 
> ---
>  drivers/usb/otg/twl4030-usb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
> index 9e3e7a5..bd9883f 100644
> --- a/drivers/usb/otg/twl4030-usb.c
> +++ b/drivers/usb/otg/twl4030-usb.c
> @@ -598,12 +598,12 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
>  		 * USB_LINK_VBUS state.  musb_hdrc won't care until it
>  		 * starts to handle softconnect right.
>  		 */
> -		twl4030charger_usb_en(status == USB_LINK_VBUS);
> -
>  		if (status == USB_LINK_NONE)
>  			twl4030_phy_suspend(twl, 0);
>  		else
>  			twl4030_phy_resume(twl);
> +
> +		twl4030charger_usb_en(status == USB_LINK_VBUS);
>  	}
>  	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
>  
> -- 
> 1.6.0.4
