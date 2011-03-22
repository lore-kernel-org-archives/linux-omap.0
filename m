From: Heikki Krogerus <heikki.krogerus@nokia.com>
Subject: Re: [PATCH 2/2] OMAP3: rx51: specify phy_power for usb tranceiver
Date: Tue, 22 Mar 2011 11:13:14 +0200
Message-ID: <20110322091314.GB4286@esdhcp034230>
References: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1300715420-25602-3-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:34218 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824Ab1CVJNv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Mar 2011 05:13:51 -0400
Content-Disposition: inline
In-Reply-To: <1300715420-25602-3-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, tony@atomide.com, jhnikula@gmail.com, ilkka.koskinen@nokia.com

Hi,

On Mon, Mar 21, 2011 at 03:50:20PM +0200, Kalle Jokiniemi wrote:
> This patch allows the ISP1707 USB tranceiver on Nokia
> N900 to be disabled when usb cable is disconnected.
> This saves approximately 14mA of battery current.
> 
> Patch based on work done by Heikki Krogerus on N900
> maemo kernel.
> 
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
> Cc: Heikki Krogerus <heikki.krogerus@nokia.com>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   32 ++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)

<snip>

> +static void __init rx51_xceiv_init(void)
> +{
> +	if (gpio_request(RX51_USB_TRANSCEIVER_RST_GPIO, NULL) < 0)
> +		BUG();
> +	gpio_direction_output(RX51_USB_TRANSCEIVER_RST_GPIO, 1);
> +}
> +
> +static int rx51_xceiv_power(struct device *dev, int iD, int on)
> +{
> +	unsigned long	timeout;
> +
> +	if (!on) {
> +		/* Let musb go stdby before powering down the transceiver */
> +		timeout = jiffies + msecs_to_jiffies(100);
> +		while (!time_after(jiffies, timeout))
> +			if (omap2_cm_read_mod_reg(CORE_MOD, CM_IDLEST1)
> +				& OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK)
> +				break;
> +		if (!(omap2_cm_read_mod_reg(CORE_MOD, CM_IDLEST1)
> +			& OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK))
> +			WARN(1, "could not put musb to sleep\n");
> +	}
> +	gpio_set_value(RX51_USB_TRANSCEIVER_RST_GPIO, on);
> +
> +	return 0;
> +}

The busy loop is not needed, and not what we want. We need to be able
to toggle the CHIP_SEL even if the USB block is not IDLE or STDBY.

The guys have already pointed out some issues with this code, so
please rework these functions.

>  static struct twl4030_usb_data rx51_usb_data = {
>  	.usb_mode		= T2_USB_MODE_ULPI,
> +	.phy_power		= rx51_xceiv_power,
>  };

This is not the right place for this. The gpio controls isp1707, not
the twl4030_usb. You have the rx51_charger_device platform device for
isp1707. Add them there.

-- 
heikki
