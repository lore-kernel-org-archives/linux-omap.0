From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] OMAP4 PANDA register ethernet and wlan for
 automatic mac allocation
Date: Fri, 29 Jun 2012 04:55:11 -0700
Message-ID: <20120629115511.GC4202@atomide.com>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
 <20120629055524.11091.57217.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56722 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab2F2LzO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 07:55:14 -0400
Content-Disposition: inline
In-Reply-To: <20120629055524.11091.57217.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.pitre@linaro.org, s-jan@ti.com, arnd@arndb.de, patches@linaro.org, rostedt@goodmis.org

* Andy Green <andy.green@linaro.org> [120628 23:00]:
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -486,6 +486,15 @@ static void omap4_panda_init_rev(void)
>  	}
>  }
>  
> +/*
> + * These device paths represent onboard network devices which have
> + * no MAC address set at boot, and need synthetic ones assigning
> + */
> +static const char * const panda_fixup_mac_device_paths[] = {
> +	"usb1/1-1/1-1.1/1-1.1:1.0",	/* smsc USB <-> Ethernet bridge */
> +	"wl12xx",			/* wlan0 module */
> +};

I suspect the "usb1/1-1/1-1.1/1-1.1:1.0" naming is not valid
if you change the order of loading of musb_hdrc and ehci modules?
Might be worth checking..

Tony
