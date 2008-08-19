From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 14/16] ARM: OMAP2: Misc updates from linux-omap tree
Date: Tue, 19 Aug 2008 22:08:07 +0100
Message-ID: <20080819210807.GE17034@flint.arm.linux.org.uk>
References: <1212804762-18413-4-git-send-email-tony@atomide.com> <1212804762-18413-5-git-send-email-tony@atomide.com> <1212804762-18413-6-git-send-email-tony@atomide.com> <1212804762-18413-7-git-send-email-tony@atomide.com> <1212804762-18413-8-git-send-email-tony@atomide.com> <1212804762-18413-9-git-send-email-tony@atomide.com> <1212804762-18413-10-git-send-email-tony@atomide.com> <1212804762-18413-11-git-send-email-tony@atomide.com> <1212804762-18413-12-git-send-email-tony@atomide.com> <1212804762-18413-13-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50179 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbYHSVIW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 17:08:22 -0400
Content-Disposition: inline
In-Reply-To: <1212804762-18413-13-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Jun 06, 2008 at 07:12:40PM -0700, Tony Lindgren wrote:
> @@ -208,10 +365,12 @@ static int __init omap2_init_devices(void)
>  	/* please keep these calls, and their implementations above,
>  	 * in alphabetical order so they're easier to sort through.
>  	 */
> -	omap_init_i2c();
> +	omap_init_camera();
>  	omap_init_mbox();
>  	omap_init_mcspi();
> +	omap_hdq_init();
>  	omap_init_sti();
> +	omap_init_sha1_md5();
>  
>  	return 0;
>  }

Hmm, looking through this file, looking at:
1. the conditionals on the machine type
2. the CONFIG_ dependencies for CPU driver versions

and then considering... what if a platform only supports one mcspi,
should we be registering all mcspi's...

Wouldn't it be better to let the platforms themselves decide which
devices should be registered, just like AT91 does and now PXA?

> +#ifndef __ASM_ARCH_CONTROL_H
> +#define __ASM_ARCH_CONTROL_H
> +
>  #include <asm/arch/io.h>
>  
> +#ifndef __ASSEMBLY__
>  #define OMAP242X_CTRL_REGADDR(reg)					\
> -	(void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
> +	(__force void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
>  #define OMAP243X_CTRL_REGADDR(reg)					\
> -	(void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
> +	(__force void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
>  #define OMAP343X_CTRL_REGADDR(reg)					\
> -	(void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
> +	(__force void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))

There's those big warning casts again.  If you moved that inside
IO_ADDRESS() then you wouldn't need all these #ifndef __ASSEMBLY__
stuff whereever you use that macro.
