From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH resend] omap: Fix linker error in
 drivers/video/omap/lcd_2430sdp.c
Date: Thu, 24 Feb 2011 13:26:44 -0800
Message-ID: <20110224212644.GN20560@atomide.com>
References: <1298193466-29534-1-git-send-email-jhnikula@gmail.com>
 <1298232248-347-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:22304 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571Ab1BXV0r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 16:26:47 -0500
Content-Disposition: inline
In-Reply-To: <1298232248-347-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

* Jarkko Nikula <jhnikula@gmail.com> [110220 12:13]:
> There is a linker error from lcd_2430sdp.c if CONFIG_TWL4030_CORE is not
> set. This can be triggered on OMAP2 builds where OMAP3 or OMAP4 are not set.
> 
> drivers/built-in.o: In function `sdp2430_panel_disable':
> drivers/video/omap/lcd_2430sdp.c:123: undefined reference to `twl_i2c_write_u8'
> drivers/video/omap/lcd_2430sdp.c:124: undefined reference to `twl_i2c_write_u8'
> drivers/built-in.o: In function `sdp2430_panel_enable':
> drivers/video/omap/lcd_2430sdp.c:110: undefined reference to `twl_i2c_write_u8'
> drivers/video/omap/lcd_2430sdp.c:112: undefined reference to `twl_i2c_write_u8'
> 
> Fix this by adding TWL4030_CORE dependency to CONFIG_MACH_OMAP_2430SDP as
> there is no own entry in drivers/video/omap/Kconfig.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> Resend = forgot to cc LAKML.
> Quite old issue most probably. Can be triggered in mainline anyway.
> ---
>  arch/arm/mach-omap2/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index b9d8a7b..bfdf240 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -132,6 +132,7 @@ config MACH_OMAP_2430SDP
>  	depends on SOC_OMAP2430
>  	default y
>  	select OMAP_PACKAGE_ZAC
> +	select TWL4030_CORE
>  
>  config MACH_OMAP3_BEAGLE
>  	bool "OMAP3 BEAGLE board"

We should avoid selecting driver related things, otherwise we can never
build a tiny kernel with initramfs with everything as modules.

Can you see if adding depends to the LCD panel option does the trick
instead?

Thanks,

Tony
