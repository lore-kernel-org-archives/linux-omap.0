From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in HYP
 mode
Date: Fri, 5 Oct 2012 21:32:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1210052124380.16518@xanadu.home>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com> <1347036934-8519-3-git-send-email-marc.zyngier@arm.com> <20121005200822.GQ3874@atomide.com> <20121005230908.GC15246@n2100.arm.linux.org.uk> <20121005232325.GV3874@atomide.com>
 <20121005235046.GW3874@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42640 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab2JFBcM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 21:32:12 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so1539112qch.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Oct 2012 18:32:11 -0700 (PDT)
In-Reply-To: <20121005235046.GW3874@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 5 Oct 2012, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [121005 16:27]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [121005 16:10]:
> > > On Fri, Oct 05, 2012 at 01:08:22PM -0700, Tony Lindgren wrote:
> > > > Just bisected this down in linux-next for breaking booting of
> > > > my omap2420 ARMv6 based n8x0..
> > > > 
> > > > > --- a/arch/arm/kernel/head.S
> > > > > +++ b/arch/arm/kernel/head.S
> > > > > @@ -83,8 +83,12 @@ ENTRY(stext)
> > > > >   THUMB(	.thumb			)	@ switch to Thumb now.
> > > > >   THUMB(1:			)
> > > > >  
> > > > > -	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
> > > > > -						@ and irqs disabled
> > > > > +#ifdef CONFIG_ARM_VIRT_EXT
> > > > > +	bl	__hyp_stub_install
> > > > > +#endif
> > > > > +	@ ensure svc mode and all interrupts masked
> > > > > +	safe_svcmode_maskall r9
> > > > > +
> > > > >  	mrc	p15, 0, r9, c0, c0		@ get processor id
> > > > >  	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
> > > > >  	movs	r10, r5				@ invalid processor (r5=0)?
> > > > 
> > > > ..and looks like undoing this part fixes it. Any ideas?
> > > > 
> > > > I quickly tried disabling ARCH_OMAP3 and ARCH_OMAP4 so it's
> > > > ARMv6 but that does not help.
> 
> The same kernel boots on 2430sdp, which is the same ARMv6 core
> as 2430 if I remember correctly. So this hints that it has something
> to do with the bits set differently by the bootloader?

Possibly.

What if you apply this on top:

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 683a1e6b60..b276c26e19 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -254,8 +254,7 @@
 	mov	lr , \reg
 	and	lr , lr , #MODE_MASK
 	cmp	lr , #HYP_MODE
-	orr	\reg , \reg , #PSR_A_BIT | PSR_I_BIT | PSR_F_BIT
-	bic	\reg , \reg , #MODE_MASK
+	mov	\reg , #PSR_A_BIT | PSR_I_BIT | PSR_F_BIT
 	orr	\reg , \reg , #SVC_MODE
 THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	msr	spsr_cxsf, \reg



Nicolas
