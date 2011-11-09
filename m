From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP: PM: only register TWL with voltage layer when device is present
Date: Tue,  8 Nov 2011 16:14:30 -0800
Message-ID: <1320797670-21460-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:33953 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754063Ab1KIAOB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 19:14:01 -0500
Received: by ywm19 with SMTP id 19so1489394ywm.23
        for <linux-omap@vger.kernel.org>; Tue, 08 Nov 2011 16:13:59 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Abhilash K V <abhilash.kv@ti.com>

Current code registers voltage layer details for TWL PMIC even when a TWL
has not been registered.  Fix this to only register the TWL with voltage
layer when the TWL PMIC is initialized by board-level code.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Barring any objections, will be queued as a fix for v3.2-rc cycle.

Originally posted here: http://marc.info/?l=linux-omap&m=131831996730420&w=2,
but posting again since it was buried inside this thread.

 arch/arm/mach-omap2/pm.c         |    6 ++----
 arch/arm/mach-omap2/twl-common.c |   11 +++++++++++
 arch/arm/mach-omap2/twl-common.h |    3 +++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 1e79bdf..00bff46 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -24,6 +24,7 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include "pm.h"
+#include "twl-common.h"
 
 static struct omap_device_pm_latency *pm_lats;
 
@@ -226,11 +227,8 @@ postcore_initcall(omap2_common_pm_init);
 
 static int __init omap2_common_pm_late_init(void)
 {
-	/* Init the OMAP TWL parameters */
-	omap3_twl_init();
-	omap4_twl_init();
-
 	/* Init the voltage layer */
+	omap_pmic_late_init();
 	omap_voltage_late_init();
 
 	/* Initialize the voltages */
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 52243577..10b20c6 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -30,6 +30,7 @@
 #include <plat/usb.h>
 
 #include "twl-common.h"
+#include "pm.h"
 
 static struct i2c_board_info __initdata pmic_i2c_board_info = {
 	.addr		= 0x48,
@@ -48,6 +49,16 @@ void __init omap_pmic_init(int bus, u32 clkrate,
 	omap_register_i2c_bus(bus, clkrate, &pmic_i2c_board_info, 1);
 }
 
+void __init omap_pmic_late_init(void)
+{
+	/* Init the OMAP TWL parameters (if PMIC has been registerd) */
+	if (!pmic_i2c_board_info.irq)
+		return;
+
+	omap3_twl_init();
+	omap4_twl_init();
+}
+
 #if defined(CONFIG_ARCH_OMAP3)
 static struct twl4030_usb_data omap3_usb_pdata = {
 	.usb_mode	= T2_USB_MODE_ULPI,
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index 5e83a5b..275dde8 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -1,6 +1,8 @@
 #ifndef __OMAP_PMIC_COMMON__
 #define __OMAP_PMIC_COMMON__
 
+#include <plat/irqs.h>
+
 #define TWL_COMMON_PDATA_USB		(1 << 0)
 #define TWL_COMMON_PDATA_BCI		(1 << 1)
 #define TWL_COMMON_PDATA_MADC		(1 << 2)
@@ -30,6 +32,7 @@ struct twl4030_platform_data;
 
 void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int pmic_irq,
 		    struct twl4030_platform_data *pmic_data);
+void omap_pmic_late_init(void);
 
 static inline void omap2_pmic_init(const char *pmic_type,
 				   struct twl4030_platform_data *pmic_data)
-- 
1.7.6

