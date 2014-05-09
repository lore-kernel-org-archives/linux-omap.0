From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 2/3] rtc: omap: use BIT() macro
Date: Fri, 9 May 2014 17:39:02 +0530
Message-ID: <33a80baca85cca7415524ccb54562287f4d22b56.1399635871.git.nsekhar@ti.com>
References: <cover.1399635871.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49538 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754101AbaEIMKX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 08:10:23 -0400
In-Reply-To: <cover.1399635871.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux RTC Mailing List <rtc-linux@googlegroups.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>

Use BIT() macro for RTC_HAS_<FEATURE> defines
instead of hand-writing bit masks.

Use BIT() macros for register bit field
definitions.

While at it, fix indentation done using spaces.

No functional change in this patch.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/rtc/rtc-omap.c |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 70f5149..734e408 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -73,43 +73,43 @@
 #define OMAP_RTC_IRQWAKEEN		0x7c
 
 /* OMAP_RTC_CTRL_REG bit fields: */
-#define OMAP_RTC_CTRL_SPLIT		(1<<7)
-#define OMAP_RTC_CTRL_DISABLE		(1<<6)
-#define OMAP_RTC_CTRL_SET_32_COUNTER	(1<<5)
-#define OMAP_RTC_CTRL_TEST		(1<<4)
-#define OMAP_RTC_CTRL_MODE_12_24	(1<<3)
-#define OMAP_RTC_CTRL_AUTO_COMP		(1<<2)
-#define OMAP_RTC_CTRL_ROUND_30S		(1<<1)
-#define OMAP_RTC_CTRL_STOP		(1<<0)
+#define OMAP_RTC_CTRL_SPLIT		BIT(7)
+#define OMAP_RTC_CTRL_DISABLE		BIT(6)
+#define OMAP_RTC_CTRL_SET_32_COUNTER	BIT(5)
+#define OMAP_RTC_CTRL_TEST		BIT(4)
+#define OMAP_RTC_CTRL_MODE_12_24	BIT(3)
+#define OMAP_RTC_CTRL_AUTO_COMP		BIT(2)
+#define OMAP_RTC_CTRL_ROUND_30S		BIT(1)
+#define OMAP_RTC_CTRL_STOP		BIT(0)
 
 /* OMAP_RTC_STATUS_REG bit fields: */
-#define OMAP_RTC_STATUS_POWER_UP        (1<<7)
-#define OMAP_RTC_STATUS_ALARM           (1<<6)
-#define OMAP_RTC_STATUS_1D_EVENT        (1<<5)
-#define OMAP_RTC_STATUS_1H_EVENT        (1<<4)
-#define OMAP_RTC_STATUS_1M_EVENT        (1<<3)
-#define OMAP_RTC_STATUS_1S_EVENT        (1<<2)
-#define OMAP_RTC_STATUS_RUN             (1<<1)
-#define OMAP_RTC_STATUS_BUSY            (1<<0)
+#define OMAP_RTC_STATUS_POWER_UP	BIT(7)
+#define OMAP_RTC_STATUS_ALARM		BIT(6)
+#define OMAP_RTC_STATUS_1D_EVENT	BIT(5)
+#define OMAP_RTC_STATUS_1H_EVENT	BIT(4)
+#define OMAP_RTC_STATUS_1M_EVENT	BIT(3)
+#define OMAP_RTC_STATUS_1S_EVENT	BIT(2)
+#define OMAP_RTC_STATUS_RUN		BIT(1)
+#define OMAP_RTC_STATUS_BUSY		BIT(0)
 
 /* OMAP_RTC_INTERRUPTS_REG bit fields: */
-#define OMAP_RTC_INTERRUPTS_IT_ALARM    (1<<3)
-#define OMAP_RTC_INTERRUPTS_IT_TIMER    (1<<2)
+#define OMAP_RTC_INTERRUPTS_IT_ALARM	BIT(3)
+#define OMAP_RTC_INTERRUPTS_IT_TIMER	BIT(2)
 
 /* OMAP_RTC_IRQWAKEEN bit fields: */
-#define OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN    (1<<1)
+#define OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN	BIT(1)
 
 /* OMAP_RTC_KICKER values */
 #define	KICK0_VALUE			0x83e70b13
 #define	KICK1_VALUE			0x95a4f1e0
 
-#define	OMAP_RTC_HAS_KICKER		0x1
+#define	OMAP_RTC_HAS_KICKER		BIT(0)
 
 /*
  * Few RTC IP revisions has special WAKE-EN Register to enable Wakeup
  * generation for event Alarm.
  */
-#define	OMAP_RTC_HAS_IRQWAKEEN		0x2
+#define	OMAP_RTC_HAS_IRQWAKEEN		BIT(1)
 
 static void __iomem	*rtc_base;
 
-- 
1.7.10.1

