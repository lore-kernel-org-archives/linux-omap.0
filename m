From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 4/7] Hook twl4030 power code into twl4030 core.
Date: Mon, 13 Oct 2008 18:44:09 +0300
Message-ID: <1223912652-24463-5-git-send-email-peter.de-schrijver@nokia.com>
References: <1223912652-24463-1-git-send-email-peter.de-schrijver@nokia.com>
 <1223912652-24463-2-git-send-email-peter.de-schrijver@nokia.com>
 <1223912652-24463-3-git-send-email-peter.de-schrijver@nokia.com>
 <1223912652-24463-4-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39559 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396AbYJMPos (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2008 11:44:48 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9DFi15q003617
	for <linux-omap@vger.kernel.org>; Mon, 13 Oct 2008 10:44:46 -0500
In-Reply-To: <1223912652-24463-4-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch makes twl4030 core call the power code in case the scripts are present in the platform data.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 drivers/mfd/Kconfig        |    7 +++++++
 drivers/mfd/Makefile       |    1 +
 drivers/mfd/twl4030-core.c |   11 +++++++++++
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e643f6b..f3a5f63 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -64,6 +64,13 @@ config TWL4030_CORE
 	  high speed USB OTG transceiver, an audio codec (on most
 	  versions) and many other features.
 
+config TWL4030_POWER
+	bool "Support power sequencing scripts on TWL4030/TPS659x0"
+	depends on TWL4030_CORE=y
+	help
+	  Say yes here if you want to use the power management features of
+	  the TWL4030/TPS659x0.
+
 config MFD_TMIO
 	bool
 	default n
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 5650e7b..08c5dfe 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MFD_TC6387XB)	+= tc6387xb.o
 obj-$(CONFIG_MFD_TC6393XB)	+= tc6393xb.o
 
 obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o
+obj-$(CONFIG_TWL4030_POWER)	+= twl4030-power.o
 
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index fd9a016..7a5c9d0 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -81,6 +81,12 @@
 #define twl_has_madc()	false
 #endif
 
+#ifdef CONFIG_TWL4030_POWER
+#define twl_has_power()        true
+#else
+#define twl_has_power()        false
+#endif
+
 #if defined(CONFIG_RTC_DRV_TWL4030) || defined(CONFIG_RTC_DRV_TWL4030_MODULE)
 #define twl_has_rtc()	true
 #else
@@ -106,6 +112,8 @@ static inline void activate_irq(int irq)
 #endif
 }
 
+extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts);
+
 /* Primary Interrupt Handler on TWL4030 Registers */
 
 /* Register Definitions */
@@ -794,6 +802,9 @@ static int add_children(struct twl4030_platform_data *pdata)
 		}
 	}
 
+	if (twl_has_power() && pdata->power)
+		twl4030_power_init(pdata->power);
+
 	if (twl_has_rtc()) {
 		twl = &twl4030_modules[3];
 
-- 
1.5.6.3

