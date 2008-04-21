From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] Adding support for OMAP3 Beagle Board
Date: Mon, 21 Apr 2008 11:04:14 -0700
Message-ID: <20080421180414.GV12099@atomide.com>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8B09@dbde01.ent.ti.com> <00ea279c69175024d58bdd7a58be8f58@felipebalbi.com> <20080418190554.GI12099@atomide.com> <20080419125130.GC9755@kedavra.cpe.vivax.com.br> <7EAD1AEEA7621C45899FE99123E124A0018C8F2D@dbde01.ent.ti.com> <20080419201412.GA11475@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:61836 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbYDUSEU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2008 14:04:20 -0400
Content-Disposition: inline
In-Reply-To: <20080419201412.GA11475@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, linux-omap@vger.kernel.org, discussion@beagleboard.org

* Felipe Balbi <me@felipebalbi.com> [080419 13:12]:
> On Sat, Apr 19, 2008 at 09:24:50PM +0530, Syed Mohammed, Khasim wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Felipe Balbi [mailto:me@felipebalbi.com]
> > > Sent: Saturday, April 19, 2008 6:22 PM
> > > To: Tony Lindgren
> > > Cc: Felipe Balbi; Syed Mohammed, Khasim; linux-omap@vger.kernel.org;
> > > discussion@beagleboard.org
> > > Subject: Re: [PATCH 3/4] Adding support for OMAP3 Beagle Board
> > > 
> > > On Fri, Apr 18, 2008 at 12:05:54PM -0700, Tony Lindgren wrote:
> > > > > > +#ifndef __ASM_ARCH_OMAP3_BEAGLE_H
> > > > > > +#define __ASM_ARCH_OMAP3_BEAGLE_H
> > > > > > +
> > > > > > +#ifdef CONFIG_TWL4030_CORE
> > > > > > +
> > > > > > +#define TWL4030_IRQNUM		INT_34XX_SYS_NIRQ
> > > > > > +
> > > > > > +/* TWL4030 Primary Interrupt Handler (PIH) interrupts */
> > > > > > +#define	IH_TWL4030_BASE		IH_BOARD_BASE
> > > > > > +#define	IH_TWL4030_END		(IH_TWL4030_BASE+8)
> > > > > > +#define IH_TWL4030_PWRBASE	(IH_TWL4030_END)
> > > > > > +#define IH_TWL4030_PWRBASE_END	(IH_TWL4030_PWRBASE+8)
> > > > > > +
> > > > > > +#ifdef CONFIG_TWL4030_GPIO
> > > > > > +/* TWL4030 GPIO Interrupts */
> > > > > > +#define IH_TWL4030_GPIO_BASE	(IH_TWL4030_PWRBASE_END)
> > > > > > +#define IH_TWL4030_GPIO_END	(IH_TWL4030_GPIO_BASE+18)
> > > > > > +#define NR_IRQS			(IH_TWL4030_GPIO_END)
> > > > > > +#else
> > > > > > +#define NR_IRQS			(IH_TWL4030_PWRBASE_END)
> > > > > > +#endif /* CONFIG_I2C_TWL4030_GPIO */
> > > > >
> > > > > shouldn't you consider the power base as the other boards ?
> > > >
> > > > Felipe, can you clarify what you mean here?
> > > 
> > > Just check board-3430sdp.h
> > > 
> > > #ifdef CONFIG_TWL4030_CORE
> > > 
> > > #define TWL4030_IRQNUM INT_34XX_SYS_NIRQ
> > > 
> > > /* TWL4030 Primary Interrupt Handler (PIH) interrupts */
> > > #define	IH_TWL4030_BASE		IH_BOARD_BASE
> > > #define	IH_TWL4030_END		(IH_TWL4030_BASE+8)
> > > 
> > > #define IH_TWL4030_PWRBASE     (IH_TWL4030_END)
> > > #define IH_TWL4030_PWRBASE_END (IH_TWL4030_PWRBASE+8)
> > > 
> > > #ifdef CONFIG_TWL4030_GPIO
> > > 
> > > /* TWL4030 GPIO Interrupts */
> > > #define IH_TWL4030_GPIO_BASE	(IH_TWL4030_PWRBASE_END)
> > > #define IH_TWL4030_GPIO_END	(IH_TWL4030_GPIO_BASE+18)
> > > #define NR_IRQS			(IH_TWL4030_GPIO_END)
> > > #else
> > > #define NR_IRQS			(IH_TWL4030_PWRBASE_END)
> > > #endif /* CONFIG_I2C_TWL4030_GPIO */
> > > #endif /* End of support for TWL4030 */
> > > #endif /*  __ASM_ARCH_OMAP_3430SDP_H */
> > > 
> > > if there are no such defines for power base, it will break compilation
> > > of twl4030-pwrirq.c which is always built whenever we enable twl4030
> > > support.
> > >
> > 
> > At present I have enabled TWL4030 support in both EVM and beagle patches and it is tested booting on both beagle and evm boards, "with out these defines".   
> > 
> > So, these defines are not required now. They will be added when necessary along with relevant functionality. I could have added but then your comment might have been, why to add these defines when they are not used :)
> 
> I can't see how can you possibly build twl4030 support without those
> defines. Looking at
> drivers/i2c/chips/twl4030-pwrirq.c:twl4030_pwrirq_enableint():
> 
> static void twl4030_pwrirq_enableint(unsigned int irq)
> {
> 	twl4030_pwrirq_pending_unmask |= 1 << (irq - IH_TWL4030_PWRBASE);
> 	if (twl4030_pwrirq_unmask_thread &&
> 		twl4030_pwrirq_unmask_thread->state != TASK_RUNNING)
> 		wake_up_process(twl4030_pwrirq_unmask_thread);
> }
> 
> I clearly see the use of IH_TWL4030_PWRBASE and looking at
> drivers/i2c/chips/Makefile:
> 
> obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o twl4030-pwrirq.o
> 
> I also clearly see that compilation it will always fail whenever you enable
> CONFIG_TWL4030_CORE.
> 
> But you already put such defines anyway :-p

OK, PWRBASE is now defined, pushing these today.

Tony
