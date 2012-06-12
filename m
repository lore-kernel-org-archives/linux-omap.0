From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 07/20] ARM: OMAP4: secure: add support for device off
Date: Tue, 12 Jun 2012 18:31:22 +0300
Message-ID: <1339515095-9908-8-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45662 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752924Ab2FLPcA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 11:32:00 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

If omap4 chip enters device off, complete secure context must be saved.
This requires a separate secure HAL call. As device off mode is overloaded
on top of functional core_pwrdm state, the code checks if core_pwrdm is
entering off mode, and does the complete context save in that case.
Otherwise the GIC save context is enough.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-secure.c |   48 +++++++++++++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index 44905a5..340b11a 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -21,6 +21,7 @@
 
 #include <plat/omap-secure.h>
 #include <mach/omap-secure.h>
+#include <plat/omap_hwmod.h>
 
 #include "common.h"
 
@@ -28,6 +29,8 @@
 
 static phys_addr_t omap_secure_memblock_base;
 static struct clockdomain *l4_secure_clkdm;
+static struct powerdomain *core_pd;
+static struct omap_hwmod *l3_main_3_oh;
 
 /**
  * omap_sec_dispatcher: Routine to dispatch low power secure
@@ -97,6 +100,29 @@ static void save_secure_gic(void)
 		pr_err("GIC and Wakeupgen secure context save failed\n");
 }
 
+static void save_secure_all(void)
+{
+	u32 ret;
+
+	/*
+	 * l3_main_3 must be enabled before calling SAVEALL API,
+	 * as it is accessing firewall registers which require this
+	 * clock to be enabled. Otherwise secure ROM code will crash.
+	 */
+	omap_hwmod_enable(l3_main_3_oh);
+
+	ret = omap_secure_dispatcher(OMAP4_HAL_SAVEALL_INDEX,
+				     FLAG_START_CRITICAL,
+				     1, omap_secure_ram_mempool_base(),
+				     0, 0, 0);
+
+	/* Disable after save, not needed anymore */
+	omap_hwmod_idle(l3_main_3_oh);
+
+	if (ret != API_HAL_RET_VALUE_OK)
+		pr_err("Secure all context save failed\n");
+}
+
 static int secure_notifier(struct notifier_block *self, unsigned long cmd,
 			   void *v)
 {
@@ -113,7 +139,16 @@ static int secure_notifier(struct notifier_block *self, unsigned long cmd,
 				       0, 0, 0, 0, 0);
 		break;
 	case CPU_CLUSTER_PM_ENTER:
-		save_secure_gic();
+		/*
+		 * If device is entering off-mode (core_pd next functional
+		 * pwrst = OFF), we must save complete secure mode context.
+		 * Otherwise just saving GIC / wakeupgen context is enough.
+		 */
+		if (pwrdm_read_next_func_pwrst(core_pd) ==
+		    PWRDM_FUNC_PWRST_OFF)
+			save_secure_all();
+		else
+			save_secure_gic();
 		break;
 	}
 	return NOTIFY_OK;
@@ -125,8 +160,17 @@ static struct notifier_block secure_notifier_block = {
 
 static int __init secure_pm_init(void)
 {
-	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		cpu_pm_register_notifier(&secure_notifier_block);
+
+		l3_main_3_oh = omap_hwmod_lookup("l3_main_3");
+		if (!l3_main_3_oh)
+			pr_err("%s: failed to get l3_main_3_oh\n", __func__);
+
+		core_pd = pwrdm_lookup("core_pwrdm");
+		if (!core_pd)
+			pr_err("%s: failed to get core_pwrdm\n", __func__);
+	}
 	return 0;
 }
 early_initcall(secure_pm_init);
-- 
1.7.4.1

