From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.28-rc6-omap-git] twl4030 usb regulator support
	tweaks
Date: Mon, 15 Dec 2008 11:31:48 -0800
Message-ID: <20081215193148.GH10664@atomide.com>
References: <200812011324.21516.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64556 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbYLOTbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 14:31:52 -0500
Content-Disposition: inline
In-Reply-To: <200812011324.21516.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081201 13:55]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> This contains two bugfixes to the initial twl4030 regulator
> support patch related to USB:
> 
>  (a) always overwrite the old list of consumers ... else
>      the regulators all share the same "usb1v5" name;
>  (b) don't set up the "usbcp" regulator, which turns out
>      to be managed through separate controls, usually ULPI
>      directly from the OTG controller.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> NOTE:  the version of this patch going to mainline doesn't
> include the twl4030-regulator.c fragment, since that driver
> has not yet gone to mainline.

Pushing this to l-o tree today.

Tony

> 
>  drivers/mfd/twl4030-core.c            |   11 +----------
>  drivers/regulator/twl4030-regulator.c |    2 +-
>  include/linux/i2c/twl4030.h           |    1 -
>  3 files changed, 2 insertions(+), 12 deletions(-)
> 
> --- a/drivers/mfd/twl4030-core.c
> +++ b/drivers/mfd/twl4030-core.c
> @@ -441,7 +441,7 @@ add_regulator_linked(int num, struct reg
>  	if (!pdata)
>  		return NULL;
>  
> -	if (consumers && !pdata->consumer_supplies) {
> +	if (consumers) {
>  		pdata->consumer_supplies = consumers;
>  		pdata->num_consumer_supplies = num_consumers;
>  	}
> @@ -564,9 +564,6 @@ add_children(struct twl4030_platform_dat
>  		static struct regulator_consumer_supply usb3v1 = {
>  			.supply =	"usb3v1",
>  		};
> -		static struct regulator_consumer_supply usbcp = {
> -			.supply =	"usbcp",
> -		};
>  
>  		/* this is a template that gets copied */
>  		struct regulator_init_data usb_fixed = {
> @@ -581,7 +578,6 @@ add_children(struct twl4030_platform_dat
>  		usb1v5.dev = usb_transceiver;
>  		usb1v8.dev = usb_transceiver;
>  		usb3v1.dev = usb_transceiver;
> -		usbcp.dev = usb_transceiver;
>  
>  		child = add_regulator_linked(TWL4030_REG_VUSB1V5, &usb_fixed,
>  				&usb1v5, 1);
> @@ -597,11 +593,6 @@ add_children(struct twl4030_platform_dat
>  				&usb3v1, 1);
>  		if (IS_ERR(child))
>  			return PTR_ERR(child);
> -
> -		child = add_regulator_linked(TWL4030_REG_VUSBCP, &usb_fixed,
> -				&usbcp, 1);
> -		if (IS_ERR(child))
> -			return PTR_ERR(child);
>  	}
>  
>  	/* maybe add LDOs that are omitted on cost-reduced parts */
> --- a/drivers/regulator/twl4030-regulator.c
> +++ b/drivers/regulator/twl4030-regulator.c
> @@ -391,7 +391,7 @@ static struct twlreg_info twl4030_regs[]
>  	TWL_FIXED_LDO(VUSB1V5, 0x71, 1500, 17),
>  	TWL_FIXED_LDO(VUSB1V8, 0x74, 1800, 18),
>  	TWL_FIXED_LDO(VUSB3V1, 0x77, 3100, 19),
> -	TWL_FIXED_LDO(VUSBCP, 0x7a, 4800, 21),
> +	/* VUSBCP is managed *only* by the USB subchip */
>  };
>  
>  static int twl4030reg_probe(struct platform_device *pdev)
> --- a/include/linux/i2c/twl4030.h
> +++ b/include/linux/i2c/twl4030.h
> @@ -417,6 +417,5 @@ int twl4030_sih_setup(int module);
>  #define TWL4030_REG_VUSB1V5	17
>  #define TWL4030_REG_VUSB1V8	18
>  #define TWL4030_REG_VUSB3V1	19
> -#define TWL4030_REG_VUSBCP	20
>  
>  #endif /* End of __TWL4030_H */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
