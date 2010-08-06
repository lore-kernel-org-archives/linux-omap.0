From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Use CONFIG_SMP for test_for_ipi and test_for_ltirq
 belong (Re: PM branch updated to v2.6.35, SRF dropped)
Date: Fri, 6 Aug 2010 10:03:01 +0300
Message-ID: <20100806070301.GA23778@atomide.com>
References: <8739uu9em0.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0323E6947D@dbde02.ent.ti.com>
 <87tyn8ptkl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61679 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560Ab0HFHCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 03:02:36 -0400
Content-Disposition: inline
In-Reply-To: <87tyn8ptkl.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Kevin Hilman <khilman@deeprootsystems.com> [100806 01:48]:
> 
> > Also with omap_4430sdp_defconfig, I see these compile errors
> > arch/arm/kernel/entry-armv.S: Assembler messages:
> > arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
> > arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
> > make[1]: *** [arch/arm/kernel/entry-armv.o] Error 1
> > make: *** [arch/arm/kernel] Error 2
> >
> > Doing a git log on entry-armv.S shows me a top commit which might
> > be an issue if conflicts are'nt resolved well.
> >
> > commit 7b70c4275f28702b76b273c8534c38f8313812e9
> > Merge: ceb0885... a20df56...
> > Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > Date:   Sat Jul 31 14:20:16 2010 +0100
> >
> >     Merge branch 'devel-stable' into devel
> >
> >     Conflicts:
> >         arch/arm/kernel/entry-armv.S
> >         arch/arm/kernel/setup.c
> >         arch/arm/mm/init.c
> >
> > Maybe this is an issue in Tony's for-next as well. Haven't tested
> > it though.
> 
> Yeah, I'm guessing this an issue in for-next, and probably l-o master
> too.

Noticed that with omap3_defconfig with CONFIG_SMP enabled. Does the
following work for you?

Tony

--9amGYk9869ThD9tj
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="test-for-ipi.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Thu, 5 Aug 2010 13:18:20 +0300
Subject: [PATCH] omap: Use CONFIG_SMP for test_for_ipi and test_for_ltirq belong

Otherwise we get the following error when enabling CONFIG_SMP
for omap3_defconfig:

arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ltirq r0,r6,r5,lr'
arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ltirq r0,r6,r5,lr'

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 50fd749..06e64e1 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -177,7 +177,10 @@ omap_irq_base:	.word	0
 		cmpne   \irqnr, \tmp
 		cmpcs   \irqnr, \irqnr
 		.endm
+#endif
+#endif	/* MULTI_OMAP2 */
 
+#ifdef CONFIG_SMP
 		/* We assume that irqstat (the raw value of the IRQ acknowledge
 		 * register) is preserved from the macro above.
 		 * If there is an IPI, we immediately signal end of interrupt
@@ -205,8 +208,7 @@ omap_irq_base:	.word	0
 		streq	\irqstat, [\base, #GIC_CPU_EOI]
 		cmp	\tmp, #0
 		.endm
-#endif
-#endif	/* MULTI_OMAP2 */
+#endif	/* CONFIG_SMP */
 
 		.macro	irq_prio_table
 		.endm

--9amGYk9869ThD9tj--
