From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v9 09/18] OMAP2,3: DSS2: Build omap_device for each DSS HWIP
Date: Sat, 22 Jan 2011 15:35:49 +0530
Message-ID: <1295690758-5845-10-git-send-email-sumit.semwal@ti.com>
References: <1295690758-5845-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32911 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab1AVKLr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Jan 2011 05:11:47 -0500
In-Reply-To: <1295690758-5845-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Senthilvadivu Guruswamy <svadivu@ti.com>, Sumit Semwal <sumit.semwal@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Looks up the hwmod database for each of the given DSS HW IP and builds
omap_device which inturn does the platform device register for each of DSS HW IP

Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 arch/arm/mach-omap2/display.c             |   50 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h |    5 +++
 2 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 6e21cb8..5c0a78b 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -23,6 +23,8 @@
 #include <linux/err.h>
 
 #include <plat/display.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
 static struct platform_device omap_display_device = {
 	.name          = "omap_display",
@@ -32,10 +34,58 @@ static struct platform_device omap_display_device = {
 	},
 };
 
+static struct omap_device_pm_latency omap_dss_latency[] = {
+	[0] = {
+		.deactivate_func        = omap_device_idle_hwmods,
+		.activate_func          = omap_device_enable_hwmods,
+		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
 int __init omap_display_init(struct omap_dss_board_info
 					*board_data)
 {
 	int r = 0;
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	int i;
+	struct omap_display_platform_data pdata;
+
+	/*
+	 * omap: valid DSS hwmod names
+	 * omap2,3: dss_core, dss_dispc, dss_rfbi, dss_venc
+	 * omap3: dss_dsi1
+	 */
+	char *oh_name[] = {"dss_core", "dss_dispc", "dss_rfbi", "dss_venc", "dss_dsi1"};
+	char *dev_name[] = { "omap_dss", "omap_dispc", "omap_rfbi", "omap_venc", "omap_dsi1" };
+	int oh_count;
+
+	memset(&pdata, 0, sizeof(pdata));
+
+	if (cpu_is_omap24xx())
+		oh_count = ARRAY_SIZE(oh_name) - 1;
+		/* last hwmod dev in oh_name is not available for omap2 */
+	else
+		oh_count = ARRAY_SIZE(oh_name);
+
+	pdata.board_data = board_data;
+	pdata.board_data->get_last_off_on_transaction_id = NULL;
+
+	for (i = 0; i < oh_count; i++) {
+		oh = omap_hwmod_lookup(oh_name[i]);
+		if (!oh) {
+			pr_err("Could not look up %s\n", oh_name[i]);
+			return -ENODEV;
+		}
+		od = omap_device_build(dev_name[i], -1, oh, &pdata,
+				sizeof(struct omap_display_platform_data),
+				omap_dss_latency,
+				ARRAY_SIZE(omap_dss_latency), 0);
+
+		if (WARN((IS_ERR(od)), "Could not build omap_device for %s\n",
+				oh_name[i]))
+			return -ENODEV;
+	}
 	omap_display_device.dev.platform_data = board_data;
 
 	r = platform_device_register(&omap_display_device);
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 0f140ec..2fb057e 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -237,6 +237,11 @@ static inline int omap_display_init(struct omap_dss_board_info *board_data)
 }
 #endif
 
+struct omap_display_platform_data {
+	struct omap_dss_board_info *board_data;
+	/* TODO: Additional members to be added when PM is considered */
+};
+
 struct omap_video_timings {
 	/* Unit: pixels */
 	u16 x_res;
-- 
1.7.1

