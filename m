From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 27/29] OMAP3: OFF command integration
Date: Thu, 11 Sep 2008 15:34:11 +0300
Message-ID: <1221136453-16697-27-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-12-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-13-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-14-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-15-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-16-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-17-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-18-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-19-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-20-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-21-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-22-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-23-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-24-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-25-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-26-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43109 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341AbYIKMe5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:57 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BCYJUn022824
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 07:34:56 -0500
In-Reply-To: <1221136453-16697-26-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

This patch detects wether device is going into off mode and sets the
appropriate off command to be sent to voltage controller on WFI. By default
only I2C voltage lowering is used, but if user has enabled the
voltage_off_while_idle sysfs switch, SYS_OFFMODE signal is used.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/pm.c     |   12 ++++++++++--
 arch/arm/mach-omap2/pm34xx.c |    7 +++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index c89de1e..386e6c6 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -31,6 +31,7 @@
 #include <mach/powerdomain.h>
 
 #include <mach/pm.h>
+#include "prm-regbits-34xx.h"
 #include "pm.h"
 
 unsigned short enable_dyn_sleep;
@@ -87,9 +88,16 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 		gpio_clocks_off_while_idle = value;
 	else if (attr == &uart_clocks_off_while_idle_attr)
 		uart_clocks_off_while_idle = value;
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
index 0267959..5242ba0 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -297,6 +297,9 @@ void omap_sram_idle(void)
 			omap_serial_enable_clocks(0, 2);
 		}
 		if (core_next_state == PWRDM_POWER_OFF) {
+			prm_set_mod_reg_bits(OMAP3430_AUTO_OFF,
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VOLTCTRL_OFFSET);
 			omap3_save_core_ctx();
 			omap3_save_prcm_ctx();
 			omap_save_uart_ctx(0);
@@ -334,6 +337,10 @@ void omap_sram_idle(void)
 			omap_restore_uart_ctx(0);
 			omap_restore_uart_ctx(1);
 		}
+		if (core_next_state == PWRDM_POWER_OFF)
+			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
+					OMAP3430_GR_MOD,
+					OMAP3_PRM_VOLTCTRL_OFFSET);
 		if (per_next_state < PWRDM_POWER_ON) {
 			per_gpio_clk_enable();
 			/* This would be actually more effective */
-- 
1.6.0

