From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/4] Adding support for OMAP3 Beagle Board
Date: Sat, 19 Apr 2008 15:51:31 +0300
Message-ID: <20080419125130.GC9755@kedavra.cpe.vivax.com.br>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8B09@dbde01.ent.ti.com> <00ea279c69175024d58bdd7a58be8f58@felipebalbi.com> <20080418190554.GI12099@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33420 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbYDSMtx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Apr 2008 08:49:53 -0400
Content-Disposition: inline
In-Reply-To: <20080418190554.GI12099@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "Syed Mohammed, Khasim" <khasim@ti.com>, linux-omap@vger.kernel.org, discussion@beagleboard.org

On Fri, Apr 18, 2008 at 12:05:54PM -0700, Tony Lindgren wrote:
> > > +#ifndef __ASM_ARCH_OMAP3_BEAGLE_H
> > > +#define __ASM_ARCH_OMAP3_BEAGLE_H
> > > +
> > > +#ifdef CONFIG_TWL4030_CORE
> > > +
> > > +#define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
> > > +
> > > +/* TWL4030 Primary Interrupt Handler (PIH) interrupts */
> > > +#define	IH_TWL4030_BASE		IH_BOARD_BASE
> > > +#define	IH_TWL4030_END		(IH_TWL4030_BASE+8)
> > > +#define IH_TWL4030_PWRBASE	(IH_TWL4030_END)
> > > +#define IH_TWL4030_PWRBASE_END	(IH_TWL4030_PWRBASE+8)
> > > +
> > > +#ifdef CONFIG_TWL4030_GPIO
> > > +/* TWL4030 GPIO Interrupts */
> > > +#define IH_TWL4030_GPIO_BASE	(IH_TWL4030_PWRBASE_END)
> > > +#define IH_TWL4030_GPIO_END	(IH_TWL4030_GPIO_BASE+18)
> > > +#define NR_IRQS			(IH_TWL4030_GPIO_END)
> > > +#else
> > > +#define NR_IRQS			(IH_TWL4030_PWRBASE_END)
> > > +#endif /* CONFIG_I2C_TWL4030_GPIO */
> > 
> > shouldn't you consider the power base as the other boards ?
> 
> Felipe, can you clarify what you mean here?

Just check board-3430sdp.h

#ifdef CONFIG_TWL4030_CORE

#define TWL4030_IRQNUM INT_34XX_SYS_NIRQ

/* TWL4030 Primary Interrupt Handler (PIH) interrupts */
#define	IH_TWL4030_BASE		IH_BOARD_BASE
#define	IH_TWL4030_END		(IH_TWL4030_BASE+8)

#define IH_TWL4030_PWRBASE     (IH_TWL4030_END)
#define IH_TWL4030_PWRBASE_END (IH_TWL4030_PWRBASE+8)

#ifdef CONFIG_TWL4030_GPIO

/* TWL4030 GPIO Interrupts */
#define IH_TWL4030_GPIO_BASE	(IH_TWL4030_PWRBASE_END)
#define IH_TWL4030_GPIO_END	(IH_TWL4030_GPIO_BASE+18)
#define NR_IRQS			(IH_TWL4030_GPIO_END)
#else
#define NR_IRQS			(IH_TWL4030_PWRBASE_END)
#endif /* CONFIG_I2C_TWL4030_GPIO */
#endif /* End of support for TWL4030 */
#endif /*  __ASM_ARCH_OMAP_3430SDP_H */

if there are no such defines for power base, it will break compilation
of twl4030-pwrirq.c which is always built whenever we enable twl4030
support.

> > #define	IH_TWL4030_BASE		IH_BOARD_BASE
> > #define	IH_TWL4030_END		(IH_TWL4030_BASE+8)
> > 
> > #define IH_TWL4030_PWRBASE     (IH_TWL4030_END)
> > #define IH_TWL4030_PWRBASE_END (IH_TWL4030_PWRBASE+8)
> > 
> > #ifdef CONFIG_TWL4030_GPIO
> > 
> > /* TWL4030 GPIO Interrupts */
> > #define IH_TWL4030_GPIO_BASE	(IH_TWL4030_PWRBASE_END)
> > #define IH_TWL4030_GPIO_END	(IH_TWL4030_GPIO_BASE+18)
> > #define NR_IRQS			(IH_TWL4030_GPIO_END)
> > #else
> > #define NR_IRQS			(IH_TWL4030_PWRBASE_END)
> > 
> > > +
> > > +#endif /* End of support for TWL4030 */
> > > +#endif /*  __ASM_ARCH_OMAP3_BEAGLE_H */
> > > +
> > > 
> > > Index: my_branch/include/asm-arm/arch-omap/hardware.h
> > > ===================================================================
> > > --- my_branch.orig/include/asm-arm/arch-omap/hardware.h	2008-04-16
> > > 14:44:09.000000000 +0530
> > > +++ my_branch/include/asm-arm/arch-omap/hardware.h	2008-04-16
> > > 14:47:14.000000000 +0530
> > > @@ -339,6 +339,10 @@
> > >  #include "board-omap3evm.h"
> > >  #endif
> > > 
> > > +#ifdef CONFIG_MACH_OMAP3_BEAGLE
> > > +#include "board-omap3beagle.h"
> > > +#endif
> > > +
> > >  #ifdef CONFIG_MACH_OMAP_APOLLON
> > >  #include "board-apollon.h"
> > >  #endif
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > -- 
> > Best Regards,
> > 
> > Felipe Balbi
> > http://felipebalbi.com
> > me@felipebalbi.com
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
