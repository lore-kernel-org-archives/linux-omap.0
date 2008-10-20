From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 3/6] Hook twl4030 power code into twl4030 core.
Date: Mon, 20 Oct 2008 11:37:53 +0300
Message-ID: <1224491876-4353-4-git-send-email-peter.de-schrijver@nokia.com>
References: <1224491876-4353-1-git-send-email-peter.de-schrijver@nokia.com>
 <1224491876-4353-2-git-send-email-peter.de-schrijver@nokia.com>
 <1224491876-4353-3-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23059 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbYJTIi1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Oct 2008 04:38:27 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9K8c1Q3003004
	for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 11:38:25 +0300
In-Reply-To: <1224491876-4353-3-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch makes twl4030 core call the power code in case the scripts are present in the platform data.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 drivers/mfd/Kconfig        |    9 +++++++++
 drivers/mfd/Makefile       |    1 +
 drivers/mfd/twl4030-core.c |   11 +++++++++++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e643f6b..91c0417 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -64,6 +64,15 @@ config TWL4030_CORE
 	  high speed USB OTG transceiver, an audio codec (on most
 	  versions) and many other features.
 
+config TWL4030_POWER
+	bool "Support power sequencing scripts on TWL4030/TPS659x0"
+	depends on TWL4030_CORE
+	help
+	  Say yes here if you want to use the power sequencing scripts on
+	  the TWL4030/TPS659x0. These scripts control which regulators or
+	  oscillators are switched off or on or reset when a sleep, wakeup
+	  or warm reset event occurs.
+
 config MFD_TMIO
 	bool
 	default n
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 92531f0..baa15bd 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MFD_TC6387XB)	+= tc6387xb.o
 obj-$(CONFIG_MFD_TC6393XB)	+= tc6393xb.o
 
 obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o twl4030-irq.o
+obj-$(CONFIG_TWL4030_POWER)    += twl4030-power.o
 
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index dd843c4..3fc54bf 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -77,6 +77,12 @@
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
@@ -209,6 +215,8 @@ static struct twl4030mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
 	{ 3, TWL4030_BASEADD_SECURED_REG },
 };
 
+extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts);
+
 /*----------------------------------------------------------------------*/
 
 /* Exported Functions */
@@ -514,6 +522,9 @@ static int add_children(struct twl4030_platform_data *pdata)
 		}
 	}
 
+	if (twl_has_power() && pdata->power)
+		twl4030_power_init(pdata->power);
+
 	if (twl_has_rtc()) {
 		twl = &twl4030_modules[3];
 
-- 
1.5.6.3

