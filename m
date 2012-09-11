From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: Enable pinctrl dummy states
Date: Tue, 11 Sep 2012 11:03:06 -0700
Message-ID: <20120911180306.GI23092@atomide.com>
References: <1347385599-27558-1-git-send-email-mporter@ti.com>
 <1347385599-27558-3-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48398 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753183Ab2IKSDJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 14:03:09 -0400
Content-Disposition: inline
In-Reply-To: <1347385599-27558-3-git-send-email-mporter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, AnilKumar <anilkumar@ti.com>

* Matt Porter <mporter@ti.com> [120911 10:46]:
> Enable pinctrl dummy states for all OMAP platforms. This allows
> drivers to be converted to pinctrl while still running on
> platforms that do not provide pinctrl data.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index c00c689..577cd04 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -17,6 +17,7 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/machine.h>
>  #include <linux/platform_data/omap4-keypad.h>
>  
>  #include <mach/hardware.h>
> @@ -631,6 +632,9 @@ static inline void omap_init_vout(void) {}
>  
>  static int __init omap2_init_devices(void)
>  {
> +	/* Enable dummy states for those platforms without pinctrl support */
> +	pinctrl_provide_dummies();
> +
>  	/*
>  	 * please keep these calls, and their implementations above,
>  	 * in alphabetical order so they're easier to sort through.

Hmm I think this may need to be board specific. And may need to
be board specific and depend on unpopulated device tree?

For board-generic.c we always want to see the warnings. And some boards
insist on doing all the muxing only in the bootloader.

Regards,

Tony
