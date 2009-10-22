From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 14/32] OMAP3: PM: save secure RAM only during init
Date: Thu, 22 Oct 2009 16:09:35 -0700
Message-ID: <1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:37878 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbZJVXKp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:10:45 -0400
Received: by mail-qy0-f194.google.com with SMTP id 32so5544712qyk.4
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:10:50 -0700 (PDT)
In-Reply-To: <1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>, Roger Quadros <ext-roger.quadros@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

The function omap3_save_secure_ram() is now called only once during
the initialization of the device and consequent sleep cycles will
re-use the same saved contents for secure RAM. Users who need secure
services should do secure RAM saving before entering off-mode, if a
secure service has been accessed after last save.

There are both latency and reliability issues with saving secure RAM
context in the idle path. The context save uses a hardware resource
which takes an order of hundreds of milliseconds to initialize after a
wake up from off-mode, and also there is no way of checking whether it
is ready from kernel side or not. It just crashes if you use it too
quickly

Additional fix to ensure scratchpad save is done after secure
RAM by Roger Quadros.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ebb88f3..310c189 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -112,6 +112,12 @@ static void omap3_core_restore_context(void)
 	omap_dma_global_context_restore();
 }
 
+/*
+ * FIXME: This function should be called before entering off-mode after
+ * OMAP3 secure services have been accessed. Currently it is only called
+ * once during boot sequence, but this works as we are not using secure
+ * services.
+ */
 static void omap3_save_secure_ram_context(u32 target_mpu_state)
 {
 	u32 ret;
@@ -337,7 +343,6 @@ static void omap_sram_idle(void)
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_prcm_save_context();
-			omap3_save_secure_ram_context(mpu_next_state);
 		}
 		/* Enable IO-PAD wakeup */
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
@@ -999,9 +1004,19 @@ static int __init omap3_pm_init(void)
 		if (!omap3_secure_ram_storage)
 			printk(KERN_ERR "Memory allocation failed when"
 					"allocating for secure sram context\n");
+
+		local_irq_disable();
+		local_fiq_disable();
+
+		omap_dma_global_context_save();
+		omap3_save_secure_ram_context(PWRDM_POWER_ON);
+		omap_dma_global_context_restore();
+
+		local_irq_enable();
+		local_fiq_enable();
 	}
-	omap3_save_scratchpad_contents();
 
+	omap3_save_scratchpad_contents();
 err1:
 	return ret;
 err2:
-- 
1.6.4.3

