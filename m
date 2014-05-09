From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 3/3] rtc: omap: add support for enabling 32khz clock
Date: Fri, 9 May 2014 17:39:03 +0530
Message-ID: <baae552198fae06c937be97721cbb2ae0efedbbe.1399635871.git.nsekhar@ti.com>
References: <cover.1399635871.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54280 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754101AbaEIMK0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 08:10:26 -0400
In-Reply-To: <cover.1399635871.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux RTC Mailing List <rtc-linux@googlegroups.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>

Newer versions of OMAP RTC IP such as those found
in AM335x and DRA7x need an explicit enable of
32khz functional clock which ticks the RTC.

AM335x support was working so far because of settings
done in U-Boot. However, the DRA7x U-Boot does no
such enable of 32khz clock and this patch is need
to get the RTC to work on DRA7x at least. In general,
it is better to not depend on settings done in U-Boot.

Thanks to Lokesh Vutla for noticing this.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/rtc/rtc-omap.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 734e408..03bce13 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -96,6 +96,9 @@
 #define OMAP_RTC_INTERRUPTS_IT_ALARM	BIT(3)
 #define OMAP_RTC_INTERRUPTS_IT_TIMER	BIT(2)
 
+/* OMAP_RTC_OSC_REG bit fields: */
+#define OMAP_RTC_OSC_32KCLK_EN		BIT(6)
+
 /* OMAP_RTC_IRQWAKEEN bit fields: */
 #define OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN	BIT(1)
 
@@ -111,6 +114,12 @@
  */
 #define	OMAP_RTC_HAS_IRQWAKEEN		BIT(1)
 
+/*
+ * Some RTC IP revisions (like those in AM335x and DRA7x) need
+ * the 32KHz clock to be explicitly enabled.
+ */
+#define OMAP_RTC_HAS_32KCLK_EN		BIT(2)
+
 static void __iomem	*rtc_base;
 
 #define rtc_read(addr)		readb(rtc_base + (addr))
@@ -319,7 +328,8 @@ static struct platform_device_id omap_rtc_devtype[] = {
 	},
 	[OMAP_RTC_DATA_AM3352_IDX] = {
 		.name	= "am3352-rtc",
-		.driver_data = OMAP_RTC_HAS_KICKER | OMAP_RTC_HAS_IRQWAKEEN,
+		.driver_data = OMAP_RTC_HAS_KICKER | OMAP_RTC_HAS_IRQWAKEEN |
+			       OMAP_RTC_HAS_32KCLK_EN,
 	},
 	[OMAP_RTC_DATA_DA830_IDX] = {
 		.name	= "da830-rtc",
@@ -398,6 +408,10 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 	 */
 	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
 
+	/* enable RTC functional clock */
+	if (id_entry->driver_data & OMAP_RTC_HAS_32KCLK_EN)
+		rtc_writel(OMAP_RTC_OSC_32KCLK_EN, OMAP_RTC_OSC_REG);
+
 	/* clear old status */
 	reg = rtc_read(OMAP_RTC_STATUS_REG);
 	if (reg & (u8) OMAP_RTC_STATUS_POWER_UP) {
-- 
1.7.10.1

