From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 2/4] TI816X: Update common OMAP machine specific
 sources
Date: Wed, 9 Feb 2011 17:45:57 -0800
Message-ID: <20110210014557.GG20795@atomide.com>
References: <1297270570-32492-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42479 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab1BJBq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 20:46:26 -0500
Content-Disposition: inline
In-Reply-To: <1297270570-32492-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com

* Hemant Pedanekar <hemantp@ti.com> [110209 08:54]:
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -121,6 +121,16 @@ static struct map_desc omap243x_io_desc[] __initdata = {
>  #endif
>  
>  #ifdef	CONFIG_ARCH_OMAP3
> +#ifdef CONFIG_SOC_OMAPTI816X
> +static struct map_desc omap34xx_io_desc[] __initdata = {
> +	{
> +		.virtual	= L4_34XX_VIRT,
> +		.pfn		= __phys_to_pfn(L4_34XX_PHYS),
> +		.length		= L4_34XX_SIZE,
> +		.type		= MT_DEVICE
> +	},
> +};
> +#else

Ah maybe you mean this else here? This would certainly break things for other
omap3 processors..

>  static struct map_desc omap34xx_io_desc[] __initdata = {
>  	{
>  		.virtual	= L3_34XX_VIRT,
> @@ -175,6 +185,7 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
>  #endif
>  };
>  #endif
> +#endif
>  #ifdef	CONFIG_ARCH_OMAP4
>  static struct map_desc omap44xx_io_desc[] __initdata = {
>  	{

..because the omap34xx_io_desc[] will be missing all the other entries.

We should just have separate struct map_desc omapti816x_io_desc[] then.
Maybe have a common struct map_desc omap3_io_desc[] and then separate
omap3xxx_io_desc and omapti816x_io_desc?

Let me know if you know of other places where compiling in ti816x
and other omap3 processors would cause issues, sounds like these should
be very easy to sort out considering we already support quite a few
omap variants.

Regards,

Tony
