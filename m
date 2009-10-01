From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 15/28] OMAP3: PM: save secure RAM only during init
Date: Thu,  1 Oct 2009 16:58:45 -0700
Message-ID: <1254441538-9257-16-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-4-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-5-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-6-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-9-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-10-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-11-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-12-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-13-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-14-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-15-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:51872 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774AbZJAX7W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:22 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so694314pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:26 -0700 (PDT)
In-Reply-To: <1254441538-9257-15-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

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

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3c26cab..8541512 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -113,6 +113,12 @@ static void omap3_core_restore_context(void)
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
@@ -336,7 +342,6 @@ static void omap_sram_idle(void)
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_prcm_save_context();
-			omap3_save_secure_ram_context(mpu_next_state);
 		}
 		/* Enable IO-PAD wakeup */
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
@@ -1000,6 +1005,18 @@ static int __init omap3_pm_init(void)
 	}
 	omap3_save_scratchpad_contents();
 
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+		local_irq_disable();
+		local_fiq_disable();
+
+		omap_dma_global_context_save();
+		omap3_save_secure_ram_context(PWRDM_POWER_ON);
+		omap_dma_global_context_restore();
+
+		local_irq_enable();
+		local_fiq_enable();
+	}
+
 err1:
 	return ret;
 err2:
-- 
1.6.4.3

