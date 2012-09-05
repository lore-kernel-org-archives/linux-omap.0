From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix array size for irq_target_cpu
Date: Wed, 5 Sep 2012 13:41:27 +0200
Message-ID: <50473A67.6000805@ti.com>
References: <20120905000309.GW1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48715 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464Ab2IELli (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 07:41:38 -0400
In-Reply-To: <20120905000309.GW1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Tony,

On 09/05/2012 02:03 AM, Tony Lindgren wrote:
> If NR_IRQS is less than MAX_IRQS, we end up writing past the
> irq_target_cpu array in omap_wakeupgen_init():
> 
> /* Associate all the IRQs to boot CPU like GIC init does. */
> for (i = 0; i < max_irqs; i++)
> 	irq_target_cpu[i] = boot_cpu;
> 
> This can happen if SPARSE_IRQ is enabled as by default NR_IRQS is
> set to 16. Without this patch we're overwriting other data during
> the boot.

In fact I already sent a patch to fix that when I started my SPARSE_IRQ cleanup, but it looks like it was never merged :-(
I guess I forgot a little bit that series.

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086076.html


Author: Benoit Cousson <b-cousson@ti.com>
Date:   Thu Feb 23 18:44:27 2012 +0100

    ARM: OMAP2+: wakeupgen: Fix wrong array size for irq_target_cpu
    
    The wakeupgen was wrongly allocating an array based on the
    NR_IRQS value (410 on OMAP4) whereas it is just capable of handling 128
    entries.
    Moreover with SPARSE_IRQ, the NR_IRQS number might be 16, and thus
    cannot handle the proper number of entries. It will generate an oops as
    soon a driver will request an IRQ > 16.
    
    Allocate the array using the fixed MAX_IRQS value (128).
    
    Signed-off-by: Benoit Cousson <b-cousson@ti.com>
    Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wak
index d3d8971..bec55e1 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -45,7 +45,7 @@ static void __iomem *wakeupgen_base;
 static void __iomem *sar_base;
 static DEFINE_PER_CPU(u32 [NR_REG_BANKS], irqmasks);
 static DEFINE_SPINLOCK(wakeupgen_lock);
-static unsigned int irq_target_cpu[NR_IRQS];
+static unsigned int irq_target_cpu[MAX_IRQS];
 
 /*
  * Static helper functions.
@@ -379,7 +379,7 @@ int __init omap_wakeupgen_init(void)
         */
 
        /* Associate all the IRQs to boot CPU like GIC init does. */
-       for (i = 0; i < NR_IRQS; i++)
+       for (i = 0; i < MAX_IRQS; i++)
                irq_target_cpu[i] = boot_cpu;
 
        irq_hotplug_init();


My original series was doing a little bit more:

0cc3fdc ARM: OMAP: irqs: Set NR_IRQS to NR_IRQS_LEGACY for CONFIG_SPARSE_IRQ
116263d ARM: OMAP2+: gpmc: Use irq_alloc_descs instead of static IRQ range
47b6c8c ARM: OMAP2+: wakeupgen: Fix wrong array size for irq_target_cpu
9017329 ARM: OMAP: irqs: Delete irqs-44xx.h file
b9bb0df ARM: OMAP2+: l3_noc: Remove references to static IRQ defines

But I guess that all of that is now gone with your latest series.

Regards,
Benoit

