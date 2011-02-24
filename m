From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/4] OMAP: DSS2: Check for SDI HW before accessing SDI registers
Date: Thu, 24 Feb 2011 15:34:21 +0200
Message-ID: <1298554461-9879-4-git-send-email-tomi.valkeinen@ti.com>
References: <1298554461-9879-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47116 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab1BXNeg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 08:34:36 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1ODYahx009556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:34:36 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1ODYZjn013524
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:34:35 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1ODYZjB009325
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:34:35 -0600 (CST)
In-Reply-To: <1298554461-9879-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Only OMAP 3430 hardware has SDI support. The availability of SDI HW can
be found out by checking if the LCD channel supports SDI displays.

This patch checks for SDI HW support before accessing SDI registers,
which fixes a crash on OMAP4 when SDI SW support is compiled in.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c |   10 ++++++++++
 drivers/video/omap2/dss/dss.c     |   29 ++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 3f4fa0b..58459f4 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -30,6 +30,7 @@
 
 #include <plat/display.h>
 #include "dss.h"
+#include "dss_features.h"
 
 static LIST_HEAD(display_list);
 
@@ -392,6 +393,15 @@ void dss_init_device(struct platform_device *pdev,
 	struct device_attribute *attr;
 	int i;
 	int r;
+	enum omap_display_type supported;
+
+	supported = dss_feat_get_supported_displays(dssdev->channel);
+
+	if (!(supported & dssdev->type)) {
+		DSSERR("Unsupported display interface for display '%s'.\n",
+				dssdev->name);
+		return;
+	}
 
 	switch (dssdev->type) {
 #ifdef CONFIG_OMAP2_DSS_DPI
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 5a93e66..b3e9dd1 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -32,6 +32,7 @@
 #include <plat/display.h>
 #include <plat/clock.h>
 #include "dss.h"
+#include "dss_features.h"
 
 #define DSS_SZ_REGS			SZ_512
 
@@ -110,10 +111,11 @@ void dss_save_context(void)
 	SR(SYSCONFIG);
 	SR(CONTROL);
 
-#ifdef CONFIG_OMAP2_DSS_SDI
-	SR(SDI_CONTROL);
-	SR(PLL_CONTROL);
-#endif
+	if (dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_LCD) &
+			OMAP_DISPLAY_TYPE_SDI) {
+		SR(SDI_CONTROL);
+		SR(PLL_CONTROL);
+	}
 }
 
 void dss_restore_context(void)
@@ -124,10 +126,11 @@ void dss_restore_context(void)
 	RR(SYSCONFIG);
 	RR(CONTROL);
 
-#ifdef CONFIG_OMAP2_DSS_SDI
-	RR(SDI_CONTROL);
-	RR(PLL_CONTROL);
-#endif
+	if (dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_LCD) &
+			OMAP_DISPLAY_TYPE_SDI) {
+		RR(SDI_CONTROL);
+		RR(PLL_CONTROL);
+	}
 }
 
 #undef SR
@@ -259,9 +262,13 @@ void dss_dump_regs(struct seq_file *s)
 	DUMPREG(DSS_SYSSTATUS);
 	DUMPREG(DSS_IRQSTATUS);
 	DUMPREG(DSS_CONTROL);
-	DUMPREG(DSS_SDI_CONTROL);
-	DUMPREG(DSS_PLL_CONTROL);
-	DUMPREG(DSS_SDI_STATUS);
+
+	if (dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_LCD) &
+			OMAP_DISPLAY_TYPE_SDI) {
+		DUMPREG(DSS_SDI_CONTROL);
+		DUMPREG(DSS_PLL_CONTROL);
+		DUMPREG(DSS_SDI_STATUS);
+	}
 
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 #undef DUMPREG
-- 
1.7.1

