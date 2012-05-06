From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4-alt 3/6] ARM: OMAP3: hwmod data: add gpmc
Date: Sat, 5 May 2012 20:04:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205051949290.20926@utopia.booyaka.com>
References: <cover.1335941443.git.afzal@ti.com> <99ffbbcc634022ed3c781c37e03989f1d898003e.1335941444.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40203 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab2EFCEI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 May 2012 22:04:08 -0400
In-Reply-To: <99ffbbcc634022ed3c781c37e03989f1d898003e.1335941444.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Hello Afzal

a few comments

On Wed, 2 May 2012, Afzal Mohammed wrote:

> Add gpmc hwmod and associated interconnect data
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

Did you notice the warning that this patch generates on boot?

omap_hwmod: gpmc: cannot be enabled for reset (3)

The HWMOD_NO_IDLEST hwmod flag is needed, since there is no GPMC IDLEST 
bit.

...

Also, the OMAP2xxx GPMC hwmod data is missing.  It can be combined 
with this patch.

...

Also:

> +static struct omap_hwmod omap3xxx_gpmc_hwmod = {
> +	.name		= "gpmc",
> +	.class		= &omap3xxx_gpmc_hwmod_class,
> +	.clkdm_name	= "l3_init_clkdm",
> +	.mpu_irqs	= omap3xxx_gpmc_irqs,
> +	.main_clk	= "gpmc_fck",
> +	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
> +};

Is there some reason why you are setting the HWMOD_INIT_NO_RESET flag 
here?  Seems to me that the kernel should not rely on the bootloader GPMC 
configuration, but should use a configuration from the board file or DT.


- Paul
