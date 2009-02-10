From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: Re: [patch 2.6.29-rc3-git 2/2] USB: disable twl4030 USB regulators
	when cable unplugged
Date: Tue, 10 Feb 2009 15:08:14 +0200
Message-ID: <1234271294.17391.12.camel@ubuntu>
References: <200902081053.00255.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gate.edelkey.net ([213.138.147.140]:58341 "EHLO
	gate.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbZBJNIa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 08:08:30 -0500
In-Reply-To: <200902081053.00255.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org, OMAP <linux-omap@vger.kernel.org>

On Sun, 2009-02-08 at 10:52 -0800, David Brownell wrote:
> From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> 
> This patch disables LDO regulators VUSB1V5, VUSB1V8, and VUSB3V1
> when the USB cable is unplugged, to eliminate that source of power
> waste.  (Enabled LDOs consume power at all times.)

Please put this one on hold.

A bug has been discovered here. If the twl-regulator is not compiled in,
the twl4030-usb fails while trying to access the reg-fw interfaces (and
not checking error values). Also it's bit confusing how we get different
error values if reg_fw is not compiled (no error) vs. reg_fw is
compiled, but twl_regulator is not... (error)

Also problems with boot order were discovered.

I'll post a set that fixes this soon.

- Kalle


> 
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> Depends on the twl4030 regulator driver, so I'm suggesting this
> be merged (with that driver) through the regulator patch queue
> to simplify things.
> 
>  drivers/usb/otg/twl4030-usb.c |   30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> --- a/drivers/usb/otg/twl4030-usb.c
> +++ b/drivers/usb/otg/twl4030-usb.c
> @@ -34,6 +34,7 @@
>  #include <linux/delay.h>
>  #include <linux/usb/otg.h>
>  #include <linux/i2c/twl4030.h>
> +#include <linux/regulator/consumer.h>
>  
> 
>  /* Register defines */
> @@ -246,6 +247,11 @@ struct twl4030_usb {
>  	struct otg_transceiver	otg;
>  	struct device		*dev;
>  
> +	/* TWL4030 internal USB regulator supplies */
> +	struct regulator	*usb1v5;
> +	struct regulator	*usb1v8;
> +	struct regulator	*usb3v1;
> +
>  	/* for vbus reporting with irqs disabled */
>  	spinlock_t		lock;
>  
> @@ -434,6 +440,9 @@ static void twl4030_phy_power(struct twl
>  
>  	pwr = twl4030_usb_read(twl, PHY_PWR_CTRL);
>  	if (on) {
> +		regulator_enable(twl->usb1v5);
> +		regulator_enable(twl->usb1v8);
> +		regulator_enable(twl->usb3v1);
>  		pwr &= ~PHY_PWR_PHYPWD;
>  		WARN_ON(twl4030_usb_write_verify(twl, PHY_PWR_CTRL, pwr) < 0);
>  		twl4030_usb_write(twl, PHY_CLK_CTRL,
> @@ -443,6 +452,9 @@ static void twl4030_phy_power(struct twl
>  	} else  {
>  		pwr |= PHY_PWR_PHYPWD;
>  		WARN_ON(twl4030_usb_write_verify(twl, PHY_PWR_CTRL, pwr) < 0);
> +		regulator_disable(twl->usb1v5);
> +		regulator_disable(twl->usb1v8);
> +		regulator_disable(twl->usb3v1);
>  	}
>  }
>  
> @@ -480,16 +492,19 @@ static void twl4030_usb_ldo_init(struct 
>  	/* input to VUSB3V1 LDO is from VBAT, not VBUS */
>  	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x14, VUSB_DEDICATED1);
>  
> -	/* turn on 3.1V regulator */
> -	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, VUSB3V1_DEV_GRP);
> +	/* Initialize 3.1V regulator */
> +	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_DEV_GRP);
> +	twl->usb3v1 = regulator_get(twl->dev, "usb3v1");
>  	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_TYPE);
>  
> -	/* turn on 1.5V regulator */
> -	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, VUSB1V5_DEV_GRP);
> +	/* Initialize 1.5V regulator */
> +	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_DEV_GRP);
> +	twl->usb1v5 = regulator_get(twl->dev, "usb1v5");
>  	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_TYPE);
>  
> -	/* turn on 1.8V regulator */
> -	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, VUSB1V8_DEV_GRP);
> +	/* Initialize 1.8V regulator */
> +	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_DEV_GRP);
> +	twl->usb1v8 = regulator_get(twl->dev, "usb1v8");
>  	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_TYPE);
>  
>  	/* disable access to power configuration registers */
> @@ -688,6 +703,9 @@ static int __exit twl4030_usb_remove(str
>  	twl4030_usb_clear_bits(twl, POWER_CTRL, POWER_CTRL_OTG_ENAB);
>  
>  	twl4030_phy_power(twl, 0);
> +	regulator_put(twl->usb1v5);
> +	regulator_put(twl->usb1v8);
> +	regulator_put(twl->usb3v1);
>  
>  	kfree(twl);
>  
