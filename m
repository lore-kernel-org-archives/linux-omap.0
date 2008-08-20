From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 14/16] ARM: OMAP2: Misc updates from linux-omap tree
Date: Wed, 20 Aug 2008 10:42:44 +0300
Message-ID: <20080820074242.GE28862@atomide.com>
References: <1212804762-18413-5-git-send-email-tony@atomide.com> <1212804762-18413-6-git-send-email-tony@atomide.com> <1212804762-18413-7-git-send-email-tony@atomide.com> <1212804762-18413-8-git-send-email-tony@atomide.com> <1212804762-18413-9-git-send-email-tony@atomide.com> <1212804762-18413-10-git-send-email-tony@atomide.com> <1212804762-18413-11-git-send-email-tony@atomide.com> <1212804762-18413-12-git-send-email-tony@atomide.com> <1212804762-18413-13-git-send-email-tony@atomide.com> <20080819210807.GE17034@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53747 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYHTHmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 03:42:50 -0400
Content-Disposition: inline
In-Reply-To: <20080819210807.GE17034@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080820 00:08]:
> On Fri, Jun 06, 2008 at 07:12:40PM -0700, Tony Lindgren wrote:
> > @@ -208,10 +365,12 @@ static int __init omap2_init_devices(void)
> >  	/* please keep these calls, and their implementations above,
> >  	 * in alphabetical order so they're easier to sort through.
> >  	 */
> > -	omap_init_i2c();
> > +	omap_init_camera();
> >  	omap_init_mbox();
> >  	omap_init_mcspi();
> > +	omap_hdq_init();
> >  	omap_init_sti();
> > +	omap_init_sha1_md5();
> >  
> >  	return 0;
> >  }
> 
> Hmm, looking through this file, looking at:
> 1. the conditionals on the machine type
> 2. the CONFIG_ dependencies for CPU driver versions
> 
> and then considering... what if a platform only supports one mcspi,
> should we be registering all mcspi's...
> 
> Wouldn't it be better to let the platforms themselves decide which
> devices should be registered, just like AT91 does and now PXA?

Yes, the struct omap2_mcspi_device_config is already coming from
board-*.c files. But the mach-omap2/board-*.c files will be coming
after the core code has been merged.

> > +#ifndef __ASM_ARCH_CONTROL_H
> > +#define __ASM_ARCH_CONTROL_H
> > +
> >  #include <asm/arch/io.h>
> >  
> > +#ifndef __ASSEMBLY__
> >  #define OMAP242X_CTRL_REGADDR(reg)					\
> > -	(void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
> > +	(__force void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
> >  #define OMAP243X_CTRL_REGADDR(reg)					\
> > -	(void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
> > +	(__force void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
> >  #define OMAP343X_CTRL_REGADDR(reg)					\
> > -	(void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
> > +	(__force void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
> 
> There's those big warning casts again.  If you moved that inside
> IO_ADDRESS() then you wouldn't need all these #ifndef __ASSEMBLY__
> stuff whereever you use that macro.

Will remove these. I have some mach/io.h clean up patches coming up for
the next merge window that should take care of this.

Ton
