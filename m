From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 06/20] ARM: OMAP4: secure: move GIC / wakeupgen save restore to secure CPU PM notifier
Date: Tue, 12 Jun 2012 18:31:21 +0300
Message-ID: <1339515095-9908-7-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45661 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752922Ab2FLPcA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 11:32:00 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

As secure driver now has CPU PM notifier, move the security involved
tweaks from wakeupgen to here. This allows us to drop some runtime
omap chip type checks away also, as wakeupgen CPU PM notifier is no
longer needed at all on secure devices.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-secure.c    |   14 ++++++++++++++
 arch/arm/mach-omap2/omap-wakeupgen.c |   31 +++++++++----------------------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index eeb8114..44905a5 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -86,6 +86,17 @@ phys_addr_t omap_secure_ram_mempool_base(void)
 }
 
 #ifdef CONFIG_CPU_PM
+static void save_secure_gic(void)
+{
+	u32 ret;
+
+	ret = omap_secure_dispatcher(OMAP4_HAL_SAVEGIC_INDEX,
+				     FLAG_START_CRITICAL,
+				     0, 0, 0, 0, 0);
+	if (ret != API_HAL_RET_VALUE_OK)
+		pr_err("GIC and Wakeupgen secure context save failed\n");
+}
+
 static int secure_notifier(struct notifier_block *self, unsigned long cmd,
 			   void *v)
 {
@@ -101,6 +112,9 @@ static int secure_notifier(struct notifier_block *self, unsigned long cmd,
 				       FLAG_START_CRITICAL,
 				       0, 0, 0, 0, 0);
 		break;
+	case CPU_CLUSTER_PM_ENTER:
+		save_secure_gic();
+		break;
 	}
 	return NOTIFY_OK;
 }
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index d811c77..1cffb3a 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -28,7 +28,6 @@
 #include <asm/hardware/gic.h>
 
 #include <mach/omap-wakeupgen.h>
-#include <mach/omap-secure.h>
 
 #include "omap4-sar-layout.h"
 #include "common.h"
@@ -266,20 +265,6 @@ static void irq_sar_clear(void)
 	val &= ~SAR_BACKUP_STATUS_WAKEUPGEN;
 	__raw_writel(val, sar_base + SAR_BACKUP_STATUS_OFFSET);
 }
-
-/*
- * Save GIC and Wakeupgen interrupt context using secure API
- * for HS/EMU devices.
- */
-static void irq_save_secure_context(void)
-{
-	u32 ret;
-	ret = omap_secure_dispatcher(OMAP4_HAL_SAVEGIC_INDEX,
-				FLAG_START_CRITICAL,
-				0, 0, 0, 0, 0);
-	if (ret != API_HAL_RET_VALUE_OK)
-		pr_err("GIC and Wakeupgen context save failed\n");
-}
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -317,14 +302,10 @@ static int irq_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
 {
 	switch (cmd) {
 	case CPU_CLUSTER_PM_ENTER:
-		if (omap_type() == OMAP2_DEVICE_TYPE_GP)
-			irq_save_context();
-		else
-			irq_save_secure_context();
+		irq_save_context();
 		break;
 	case CPU_CLUSTER_PM_EXIT:
-		if (omap_type() == OMAP2_DEVICE_TYPE_GP)
-			irq_sar_clear();
+		irq_sar_clear();
 		break;
 	}
 	return NOTIFY_OK;
@@ -336,7 +317,13 @@ static struct notifier_block irq_notifier_block = {
 
 static void __init irq_pm_init(void)
 {
-	cpu_pm_register_notifier(&irq_notifier_block);
+	/*
+	 * Register CPU_PM notifier only on GP devices, as saving
+	 * GIC context will involve secure API calls on secure
+	 * devices. Secure driver will handle these.
+	 */
+	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
+		cpu_pm_register_notifier(&irq_notifier_block);
 }
 #else
 static void __init irq_pm_init(void)
-- 
1.7.4.1

