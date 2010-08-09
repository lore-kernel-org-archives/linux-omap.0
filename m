From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH V2 4/8]usb : musb:Using omap_device_build for musb device
 registration
Date: Mon, 09 Aug 2010 14:45:10 +0200
Message-ID: <4C5FF856.4020301@ti.com>
References: <1281110270-4185-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35079 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755983Ab0HIMpU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Aug 2010 08:45:20 -0400
In-Reply-To: <1281110270-4185-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

On 8/6/2010 5:57 PM, Kalliguddi, Hema wrote:
> From: Hema HK<hemahk@ti.com>

<snip>

>   void __init usb_musb_init(struct omap_musb_board_data *board_data)
>   {
> -	if (cpu_is_omap243x()) {
> -		musb_resources[0].start = OMAP243X_HS_BASE;
> -	} else if (cpu_is_omap34xx()) {
> -		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
> -	} else if (cpu_is_omap44xx()) {
> -		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
> -		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
> -		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
> +	char oh_name[MAX_OMAP_MUSB_HWMOD_NAME_LEN];
> +	struct omap_hwmod *oh;
> +	struct omap_device *od;
> +	struct platform_device *pdev;
> +	struct device	*dev;
> +	int l, bus_id = -1;
> +	struct musb_hdrc_platform_data *pdata;
> +
> +	l = snprintf(oh_name, MAX_OMAP_MUSB_HWMOD_NAME_LEN,
> +						"usb_otg_hs");
> +	WARN(l>= MAX_OMAP_MUSB_HWMOD_NAME_LEN,
> +			"String buffer overflow in MUSB device setup\n");

This is not needed in your case. Just use a const char*, and you will 
avoid the useless snprintf and test.

> +
> +	oh = omap_hwmod_lookup(oh_name);
> +
> +	if (!oh) {
> +		pr_err("Could not look up %s\n", oh_name);
> +	} else {

You can avoid that indentation be returning in case of failure.

> +		/*
> +		 * REVISIT: This line can be removed once all the platforms
> +		 * using musb_core.c have been converted to use use clkdev.
> +		 */
> +		musb_plat.clock = "ick";
> +		musb_plat.board_data = board_data;
> +		musb_plat.power = board_data->power>>  1;
> +		musb_plat.mode = board_data->mode;
> +		pdata =&musb_plat;
> +
> +		od = omap_device_build(name, bus_id, oh, pdata,
> +				       sizeof(struct musb_hdrc_platform_data),
> +							omap_musb_latency,
> +				       ARRAY_SIZE(omap_musb_latency), false);
> +		if (IS_ERR(od)) {
> +			pr_err("Could not build omap_device for %s %s\n",
> +						name, oh_name);
 > +		} else {

You can avoid that second level of indentation be returning in case of 
failure as well.

Benoit
