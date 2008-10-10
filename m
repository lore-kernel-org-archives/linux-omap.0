From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 4/7] Hook twl4030 power code into twl4030 core.
Date: Fri, 10 Oct 2008 19:56:13 +0300
Message-ID: <1223657776-16544-5-git-send-email-peter.de-schrijver@nokia.com>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-2-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-3-git-send-email-peter.de-schrijver@nokia.com>
 <1223657776-16544-4-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51893 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761447AbYJJQ4z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 12:56:55 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9AGui4u006162
	for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 19:56:53 +0300
In-Reply-To: <1223657776-16544-4-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch makes twl4030 core call the power code in case the scripts are present in the platform data.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 drivers/mfd/twl4030-core.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

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

