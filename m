From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest regressions
Date: Thu, 27 Jan 2011 16:24:47 -0800
Message-ID: <20110128002446.GQ23412@atomide.com>
References: <20110107115744.GL1198@n2100.arm.linux.org.uk>
 <20110107165626.GD880@atomide.com>
 <20110126085848.GB2698@n2100.arm.linux.org.uk>
 <20110126181215.GC23412@atomide.com>
 <20110127122245.GB26418@n2100.arm.linux.org.uk>
 <20110128001829.GN23412@atomide.com>
 <20110128002115.GO23412@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60491 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab1A1AY5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 19:24:57 -0500
Content-Disposition: inline
In-Reply-To: <20110128002115.GO23412@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [110127 16:20]:
> * Tony Lindgren <tony@atomide.com> [110127 16:17]:
> > 
> > Will also post a similar change for omap1.
> 
> And here's the omap1 related change.

> --- a/arch/arm/mach-omap1/irq.c
> +++ b/arch/arm/mach-omap1/irq.c
> @@ -57,6 +57,7 @@ struct omap_irq_bank {
>  	unsigned long wake_enable;
>  };
>  
> +void __iomem *omap_irq_flags;
>  static unsigned int irq_bank_count;
>  static struct omap_irq_bank *irq_banks;
>  

The omap_irq_flags here should not be void __iomem *, updated
patch below.

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 27 Jan 2011 15:52:16 -0800
Subject: [PATCH] omap1: Simplify use of omap_irq_flags

Commit 03a9e5126147c9f92aeba4b34f62b15b625087fb
(omap1: Use asm_irq_flags for entry-macro.S) added support
for multi-omap builds with addition of the omap_irq_flags.

Commit 9f9605c2eda9679e6f63c605cbd9cbf6a9a7f3fa
(omap2+: Fix unused variable warning for omap_irq_base)
simplified omap2+ entry-macro.S by moving omap_irq_flags
out of entry-macro.S.

Simplify omap1 entry-macro.S in a similar way to keep the
code consistent. Based on a similar earlier patch for omap2+
by Russell King <rmk+kernel@arm.linux.org.uk>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -14,19 +14,6 @@
 #include <mach/irqs.h>
 #include <asm/hardware/gic.h>
 
-/*
- * We use __glue to avoid errors with multiple definitions of
- * .globl omap_irq_flags as it's included from entry-armv.S but not
- * from entry-common.S.
- */
-#ifdef __glue
-		.pushsection .data
-		.globl	omap_irq_flags
-omap_irq_flags:
-		.word	0
-		.popsection
-#endif
-
  		.macro	disable_fiq
 		.endm
 
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -57,6 +57,7 @@ struct omap_irq_bank {
 	unsigned long wake_enable;
 };
 
+u32 omap_irq_flags;
 static unsigned int irq_bank_count;
 static struct omap_irq_bank *irq_banks;
 
@@ -176,7 +177,6 @@ static struct irq_chip omap_irq_chip = {
 
 void __init omap_init_irq(void)
 {
-	extern unsigned int omap_irq_flags;
 	int i, j;
 
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
