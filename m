From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Sat, 4 Feb 2012 15:09:16 -0800
Message-ID: <20120204230916.GN20333@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120204205303.GA23248@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:32149 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab2BDXJT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 18:09:19 -0500
Content-Disposition: inline
In-Reply-To: <20120204205303.GA23248@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 12:22]:
> On Sat, Feb 04, 2012 at 08:34:53PM +0000, Russell King - ARM Linux wrote:
> > And OMAP4 doesn't build.  Fixing the build error in prm44xx.c (which is
> > virtually the same as the OMAP3 build error in its prm file) gets us to
> > a buildable state, but... it silently fails to boot.
> > 
> > arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undeclared here (not in a function)
> 
> BTW, I can tell you why you don't see this error - you're building with
> DT enabled, which gives you this header path to those definitions:
> 
> arch/arm/mach-omap2/prm44xx.c
>  arch/arm/mach-omap2/common.h
>   plat/common.h    
>    plat/i2c.h
>     linux/i2c.h
>      linux/of.h
>       asm/prom.h
>        asm/irq.h
>         mach/irqs.h
>          plat/irqs.h
>           plat/irqs-44xx.h
> 
> which, I think you'll agree, is a recipe for disaster if any one of those
> decides not to include its child at some point either via configuration
> or via mere deletion of an include.

OK. Sounds like the solution here is to include irqs.h directly
in prmx44xx.c.

Regards,

Tony
