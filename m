From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 3/3] arm: omap: convert omap boot_lock to raw
Date: Thu, 1 Aug 2013 15:12:45 +0300
Message-ID: <1375359165-8411-4-git-send-email-balbi@ti.com>
References: <1375359165-8411-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51362 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754641Ab3HAMOM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 08:14:12 -0400
In-Reply-To: <1375359165-8411-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Frank Rowand <frank.rowand@am.sony.com>, Thomas Gleixner <tglx@linutronix.de>

From: Frank Rowand <frank.rowand@am.sony.com>

The omap boot_lock is used by the secondary processor startup code.  The locking
task is the idle thread, which has idle->sched_class == &idle_sched_class.
idle_sched_class->enqueue_task == NULL, so if the idle task blocks on the
lock, the attempt to wake it when the lock becomes available will fail:

try_to_wake_up()
   ...
      activate_task()
         enqueue_task()
            p->sched_class->enqueue_task(rq, p, flags)

Fix by converting boot_lock to a raw spin lock.

[ balbi@ti.com: taken from RT v3.10.4-rt1 patchset ]

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/mach-omap2/omap-smp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 8708b2a..c4caa18 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -44,7 +44,7 @@ u16 pm44xx_errata;
 /* SCU base address */
 static void __iomem *scu_base;
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 void __iomem *omap4_get_scu_base(void)
 {
@@ -68,8 +68,8 @@ static void omap4_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -83,7 +83,7 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * Update the AuxCoreBoot0 with boot state for secondary core.
@@ -160,7 +160,7 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return 0;
 }
-- 
1.8.3.4.840.g6a90778

