From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 3/3] OMAP3: OFF command integration
Date: Thu, 28 Aug 2008 16:25:59 +0300
Message-ID: <1219929959-6611-3-git-send-email-ext-kalle.jokiniemi@nokia.com>
References: <>
 <1219929959-6611-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
 <1219929959-6611-2-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22391 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbYH1NWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 09:22:34 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7SDM39n016818
	for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 08:22:33 -0500
In-Reply-To: <1219929959-6611-2-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

This patch detects wether device is going into off mode and sets the
appropriate off command to be sent to voltage controller on WFI. By default
only I2C voltage lowering is used, but if user has enabled the
voltage_off_while_idle sysfs switch, SYS_OFFMODE signal is used.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/pm.c     |   12 ++++++++++--
 arch/arm/mach-omap2/pm34xx.c |   17 ++++++++++++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 05fbb9c..bf761c5 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -29,6 +29,7 @@
 #include <asm/atomic.h>
 
 #include <mach/pm.h>
+#include "prm-regbits-34xx.h"
 #include "pm.h"
 
 unsigned short enable_dyn_sleep;
@@ -77,9 +78,16 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 		enable_dyn_sleep = value;
 	else if (attr == &clocks_off_while_idle_attr)
 		clocks_off_while_idle = value;
-	else if (attr == &voltage_off_while_idle_attr)
+	else if (attr == &voltage_off_while_idle_attr) {
 		voltage_off_while_idle = value;
-	else
+		if (voltage_off_while_idle)
+			prm_set_mod_reg_bits(OMAP3430_SEL_OFF, OMAP3430_GR_MOD,
+					OMAP3_PRM_VOLTCTRL_OFFSET);
+		else
+			prm_clear_mod_reg_bits(OMAP3430_SEL_OFF,
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VOLTCTRL_OFFSET);
+	} else
 		return -EINVAL;
 
 	return n;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5633753..ac76112 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -52,6 +52,7 @@ static void (*_omap_sram_idle)(u32 *addr, int save_state);
 static void (*saved_idle)(void);
 
 static struct powerdomain *mpu_pwrdm;
+static struct powerdomain *core_pwrdm;
 
 /* PRCM Interrupt Handler for wakeups */
 static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
@@ -150,7 +151,7 @@ static void omap_sram_idle(void)
 	/* save_state = 1 => Only L1 and logic lost */
 	/* save_state = 2 => Only L2 lost */
 	/* save_state = 3 => L1, L2 and logic lost */
-	int save_state = 0, mpu_next_state;
+	int save_state = 0, mpu_next_state, core_sleep_state;
 
 	if (!_omap_sram_idle)
 		return;
@@ -166,12 +167,21 @@ static void omap_sram_idle(void)
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
 		return;
 	}
+	core_sleep_state = pwrdm_read_next_pwrst(core_pwrdm);
+
+	if (core_sleep_state == PWRDM_POWER_OFF)
+		prm_set_mod_reg_bits(OMAP3430_AUTO_OFF, OMAP3430_GR_MOD,
+					OMAP3_PRM_VOLTCTRL_OFFSET);
 
 	omap2_gpio_prepare_for_retention();
 
 	_omap_sram_idle(NULL, save_state);
 
 	omap2_gpio_resume_after_retention();
+
+	if (core_sleep_state == PWRDM_POWER_OFF)
+		prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF, OMAP3430_GR_MOD,
+					OMAP3_PRM_VOLTCTRL_OFFSET);
 }
 
 /*
@@ -572,6 +582,11 @@ int __init omap3_pm_init(void)
 		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
 		goto err2;
 	}
+	core_pwrdm = pwrdm_lookup("core_pwrdm");
+	if (core_pwrdm == NULL) {
+		printk(KERN_ERR "Failed to get core_pwrdm\n");
+		goto err2;
+	}
 
 	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
 					omap34xx_cpu_suspend_sz);
-- 
1.5.4.3

