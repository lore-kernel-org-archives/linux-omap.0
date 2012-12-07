From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: omap: make wakeupgen_lock raw
Date: Fri, 7 Dec 2012 16:49:47 +0200
Message-ID: <1354891787-24119-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50813 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755131Ab2LGO5A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Dec 2012 09:57:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <balbi@ti.com>

From: Thomas Gleixner <tglx@linutronix.de>

When applying RT patch on top of Linux, spinlocks are
implemented as RT-mutexes, which means they are preemptable.

Current GIC implementation on OMAP is using a spinlock
to protect against preemption. As it turns out, we need
to convert that lock into a raw_spinlock so that OMAP's
interrupt controller works as expected after RT-patch
is applied.

This patch is simply to decrease the amount of changes
RT-team needs to carry out of tree. It doesn't cause any
changes in behavior.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Thomas, all I did here was take the patch from v3.6.2-rt21
patchset, apply to current Linus' tree (v3.7-rc8) and compile
test with our omap2plus_defconfig.

If you think the commit log I wrong is lacking, please suggest
changes and I will fix it up. Just thought this is the kind of
patch which can go to mainline today and decrease the amount of
patches out-of-tree regarding RT support.

cheers

 arch/arm/mach-omap2/omap-wakeupgen.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 5d3b4f4..8633a43 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -46,7 +46,7 @@
 
 static void __iomem *wakeupgen_base;
 static void __iomem *sar_base;
-static DEFINE_SPINLOCK(wakeupgen_lock);
+static DEFINE_RAW_SPINLOCK(wakeupgen_lock);
 static unsigned int irq_target_cpu[MAX_IRQS];
 static unsigned int irq_banks = MAX_NR_REG_BANKS;
 static unsigned int max_irqs = MAX_IRQS;
@@ -134,9 +134,9 @@ static void wakeupgen_mask(struct irq_data *d)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&wakeupgen_lock, flags);
+	raw_spin_lock_irqsave(&wakeupgen_lock, flags);
 	_wakeupgen_clear(d->irq, irq_target_cpu[d->irq]);
-	spin_unlock_irqrestore(&wakeupgen_lock, flags);
+	raw_spin_unlock_irqrestore(&wakeupgen_lock, flags);
 }
 
 /*
@@ -146,9 +146,9 @@ static void wakeupgen_unmask(struct irq_data *d)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&wakeupgen_lock, flags);
+	raw_spin_lock_irqsave(&wakeupgen_lock, flags);
 	_wakeupgen_set(d->irq, irq_target_cpu[d->irq]);
-	spin_unlock_irqrestore(&wakeupgen_lock, flags);
+	raw_spin_unlock_irqrestore(&wakeupgen_lock, flags);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -189,7 +189,7 @@ static void wakeupgen_irqmask_all(unsigned int cpu, unsigned int set)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&wakeupgen_lock, flags);
+	raw_spin_lock_irqsave(&wakeupgen_lock, flags);
 	if (set) {
 		_wakeupgen_save_masks(cpu);
 		_wakeupgen_set_all(cpu, WKG_MASK_ALL);
@@ -197,7 +197,7 @@ static void wakeupgen_irqmask_all(unsigned int cpu, unsigned int set)
 		_wakeupgen_set_all(cpu, WKG_UNMASK_ALL);
 		_wakeupgen_restore_masks(cpu);
 	}
-	spin_unlock_irqrestore(&wakeupgen_lock, flags);
+	raw_spin_unlock_irqrestore(&wakeupgen_lock, flags);
 }
 #endif
 
-- 
1.8.0.1

