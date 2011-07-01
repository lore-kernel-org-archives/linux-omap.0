From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] 4460sdp/blaze/panda: hwmod: Prevent gpio1 reset
 during hwmod init
Date: Thu, 30 Jun 2011 23:32:41 -0700
Message-ID: <20110701063241.GX23145@atomide.com>
References: <1309486081-8257-1-git-send-email-rnayak@ti.com>
 <1309486081-8257-2-git-send-email-rnayak@ti.com>
 <1309486081-8257-3-git-send-email-rnayak@ti.com>
 <1309486081-8257-4-git-send-email-rnayak@ti.com>
 <1309486081-8257-5-git-send-email-rnayak@ti.com>
 <1309486081-8257-6-git-send-email-rnayak@ti.com>
 <1309486081-8257-7-git-send-email-rnayak@ti.com>
 <1309486081-8257-8-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:20014 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753159Ab1GAGco (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 02:32:44 -0400
Content-Disposition: inline
In-Reply-To: <1309486081-8257-8-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, Nishanth Menon <nm@ti.com>, Moiz Sonasath <m-sonasath@ti.com>

* Rajendra Nayak <rnayak@ti.com> [110630 19:03]:
> For 4460sdp/blaze/panda, GPIO-7 of bank1 is used for controlling
> the TPS modes, hence GPIO1 should not be reset
> during init as reset will cause the TPS voltage to
> drop to 0.9 V preventing the system from continuing the boot.

NAK for this patch. We don't want any of this in init_early.

The problem is with hwmod core code that wrongly assumes it
can just reset all devices.

We should fix the hwmod code to lazily only reset devices as they
are enabled, and only reset unused devices with late_initcall
when we have decent debug output. And the reset of unused devices
should be possible to turn off with some kernel cmdline option.

Regards,

Tony


> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -36,6 +36,7 @@
>  #include <plat/usb.h>
>  #include <plat/mmc.h>
>  #include <plat/omap4-keypad.h>
> +#include <plat/omap_hwmod.h>
>  #include <video/omapdss.h>
>  
>  #include "mux.h"
> @@ -298,6 +299,19 @@ static void __init omap_4430sdp_init_early(void)
>  #ifdef CONFIG_OMAP_32K_TIMER
>  	omap2_gp_clockevent_set_gptimer(1);
>  #endif
> +	/*
> +	 * For 4460sdp/blaze, GPIO-7 of bank1 is used for controlling
> +	 * the TPS modes, hence GPIO1 should not be reset
> +	 * during init as reset will cause the TPS voltage to
> +	 * drop to 0.9 V  preventing the system from continuing the boot.
> +	 */
> +	if (cpu_is_omap446x()) {
> +		struct omap_hwmod *gpio1 = omap_hwmod_lookup("gpio1");
> +		if (gpio1)
> +			omap_hwmod_no_setup_reset(gpio1);
> +		else
> +			pr_err("%s: gpio1 hwmod lookup failed\n", __func__);
> +	}
>  }
>  
>  static struct omap_musb_board_data musb_board_data = {
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index 0cfe200..75a847c 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -40,6 +40,7 @@
>  #include <plat/common.h>
>  #include <plat/usb.h>
>  #include <plat/mmc.h>
> +#include <plat/omap_hwmod.h>
>  #include <video/omap-panel-generic-dpi.h>
>  #include "timer-gp.h"
>  
> @@ -100,6 +101,19 @@ static void __init omap4_panda_init_early(void)
>  {
>  	omap2_init_common_infrastructure();
>  	omap2_init_common_devices(NULL, NULL);
> +	/*
> +	 * For 4460panda, GPIO-7 of bank1 is used for controling
> +	 * the TPS modes, hence GPIO1 should not be reset
> +	 * during init as reset will cause the TPS voltage to
> +	 * drop to 0.9 V preventing the system from continuing the boot.
> +	 */
> +	if (cpu_is_omap446x()) {
> +		struct omap_hwmod *gpio1 = omap_hwmod_lookup("gpio1");
> +		if (gpio1)
> +			omap_hwmod_no_setup_reset(gpio1);
> +		else
> +			pr_err("%s: gpio1 hwmod lookup failed\n", __func__);
> +	}
>  }
>  
>  static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
