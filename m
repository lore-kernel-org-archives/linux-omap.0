From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [4/7 v2] usb: otg: OMAP4430: Add phy_suspend function pointer
 to
Date: Tue, 15 Feb 2011 15:18:40 +0300
Message-ID: <4D5A6F20.5060109@ru.mvista.com>
References: <1297762958-26199-1-git-send-email-hemahk@ti.com> <1297762958-26199-4-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36406 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab1BOMT5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 07:19:57 -0500
In-Reply-To: <1297762958-26199-4-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Hello.

On 15-02-2011 12:42, Hema HK wrote:

    The subject seems incomplete.

> From: Kalliguddi, Hema<hemahk@ti.com>

> Introduce the .phy_suspend function pointer to twl4030_usb_data structure.
> assign the function to it for both sdp board and panda boards.
> This will be used by the twl6030-usb transceiver driver.

> Signed-off-by: Hema HK<hemahk@ti.com>
> Cc: Felipe Balbi<balbi@ti.com>
> Cc: Tony Lindgren<tony@atomide.com>

[...]

> Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c
> +++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
> @@ -272,6 +272,7 @@ static struct twl4030_usb_data omap4_usb
>   	.phy_exit	= omap4430_phy_exit,
>   	.phy_power	= omap4430_phy_power,
>   	.phy_set_clock	= omap4430_phy_set_clk,
> +	.phy_suspend	= omap4430_phy_suspend,
>   };
>
>   static struct omap2_hsmmc_info mmc[] = {
> Index: linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/board-omap4panda.c
> +++ linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
> @@ -153,6 +153,7 @@ static struct twl4030_usb_data omap4_usb
>   	.phy_exit	= omap4430_phy_exit,
>   	.phy_power	= omap4430_phy_power,
>   	.phy_set_clock	= omap4430_phy_set_clk,
> +	.phy_suspend	= omap4430_phy_suspend,
>   };
>
>   static struct omap2_hsmmc_info mmc[] = {
> Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
> ===================================================================
> --- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
> +++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
> @@ -88,6 +88,7 @@ extern int omap4430_phy_power(struct dev
>   extern int omap4430_phy_set_clk(struct device *dev, int on);
>   extern int omap4430_phy_init(struct device *dev);
>   extern int omap4430_phy_exit(struct device *dev);
> +extern int omap4430_phy_suspend(struct device *dev, int suspend);

    I think this *extern* declaration should be a part of the previous patch.

>   #endif
>
> Index: linux-2.6/include/linux/i2c/twl.h
> ===================================================================
> --- linux-2.6.orig/include/linux/i2c/twl.h
> +++ linux-2.6/include/linux/i2c/twl.h
> @@ -600,6 +600,8 @@ struct twl4030_usb_data {
>   	int		(*phy_power)(struct device *dev, int iD, int on);
>   	/* enable/disable  phy clocks */
>   	int		(*phy_set_clock)(struct device *dev, int on);
> +	/* suspend/resume of phy */
> +	int		(*phy_suspend)(struct device *dev, int suspend);
>   };

    I'd make the above the only change in this patch, and add all the other 
changes into the previous patch (which then I'd change places with that one).

WBR, Sergei
