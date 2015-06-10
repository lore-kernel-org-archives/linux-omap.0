From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/3] ARM: DRA: hwmod: RTC: Add lock and unlock functions
Date: Wed, 10 Jun 2015 14:56:25 +0530
Message-ID: <1433928386-24891-3-git-send-email-lokeshvutla@ti.com>
References: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43831 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013AbbFJJ3a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Jun 2015 05:29:30 -0400
In-Reply-To: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, t-kristo@ti.com, lokeshvutla@ti.com

RTC IP have kicker feature which prevents spurious writes to its registers.
In order to write into any of the RTC registers, KICK values has to be
written to KICK registers.

Introduce omap_hwmod_rtc_unlock/lock functions, which  writes into these
KICK registers inorder to lock and unlock RTC registers.
Also hook these functions to RTC hwmod.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.h          |  2 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  2 ++
 arch/arm/mach-omap2/omap_hwmod_reset.c    | 47 +++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 44c7db9..04855ab 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -742,6 +742,8 @@ const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh);
  */
 
 extern int omap_hwmod_aess_preprogram(struct omap_hwmod *oh);
+void omap_hwmod_rtc_unlock(struct omap_hwmod *oh);
+void omap_hwmod_rtc_lock(struct omap_hwmod *oh);
 
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 0e64c2f..983042f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1548,6 +1548,8 @@ static struct omap_hwmod_class_sysconfig dra7xx_rtcss_sysc = {
 static struct omap_hwmod_class dra7xx_rtcss_hwmod_class = {
 	.name	= "rtcss",
 	.sysc	= &dra7xx_rtcss_sysc,
+	.unlock	= &omap_hwmod_rtc_unlock,
+	.lock	= &omap_hwmod_rtc_lock,
 };
 
 /* rtcss */
diff --git a/arch/arm/mach-omap2/omap_hwmod_reset.c b/arch/arm/mach-omap2/omap_hwmod_reset.c
index 65e186c..1fb106d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_reset.c
+++ b/arch/arm/mach-omap2/omap_hwmod_reset.c
@@ -25,11 +25,20 @@
  */
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/delay.h>
 
 #include <sound/aess.h>
 
 #include "omap_hwmod.h"
 
+#define OMAP_RTC_STATUS_REG	0x44
+#define OMAP_RTC_KICK0_REG	0x6c
+#define OMAP_RTC_KICK1_REG	0x70
+
+#define OMAP_RTC_KICK0_VALUE	0x83E70B13
+#define OMAP_RTC_KICK1_VALUE	0x95A4F1E0
+#define OMAP_RTC_STATUS_BUSY	BIT(0)
+
 /**
  * omap_hwmod_aess_preprogram - enable AESS internal autogating
  * @oh: struct omap_hwmod *
@@ -51,3 +60,41 @@ int omap_hwmod_aess_preprogram(struct omap_hwmod *oh)
 
 	return 0;
 }
+
+static void omap_rtc_wait_not_busy(struct omap_hwmod *oh)
+{
+	int count;
+	u8 status;
+
+	/* BUSY may stay active for 1/32768 second (~30 usec) */
+	for (count = 0; count < 50; count++) {
+		status = omap_hwmod_read(oh, OMAP_RTC_STATUS_REG);
+		if (!(status & OMAP_RTC_STATUS_BUSY))
+			break;
+		udelay(1);
+	}
+	/* now we have ~15 usec to read/write various registers */
+}
+
+/**
+ * omap_hwmod_rtc_unlock - Reset and unlock the Kicker mechanism.
+ * @oh: struct omap_hwmod *
+ *
+ * RTC IP have kicker feature.  This prevents spurious writes to its registers.
+ * In order to write into any of the RTC registers, KICK values has te be
+ * written in respective KICK registers. This is needed for hwmod to write into
+ * sysconfig register.
+ */
+void omap_hwmod_rtc_unlock(struct omap_hwmod *oh)
+{
+	omap_rtc_wait_not_busy(oh);
+	omap_hwmod_write(OMAP_RTC_KICK0_VALUE, oh, OMAP_RTC_KICK0_REG);
+	omap_hwmod_write(OMAP_RTC_KICK1_VALUE, oh, OMAP_RTC_KICK1_REG);
+}
+
+void omap_hwmod_rtc_lock(struct omap_hwmod *oh)
+{
+	omap_rtc_wait_not_busy(oh);
+	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK0_REG);
+	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK1_REG);
+}
-- 
1.9.1

