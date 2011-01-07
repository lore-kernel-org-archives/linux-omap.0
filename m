From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v4 08/17] OMAP2,3: DSS2: Build omap_device for each DSS HWIP
Date: Fri,  7 Jan 2011 08:49:02 +0530
Message-ID: <1294370351-8654-9-git-send-email-sumit.semwal@ti.com>
References: <1294370351-8654-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59650 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459Ab1AGDUN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jan 2011 22:20:13 -0500
In-Reply-To: <1294370351-8654-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>, Sumit Semwal <sumit.semwal@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Looks up the hwmod database for each of the given DSS HW IP and builds
omap_device which inturn does the platform device register for each of DSS HW IP

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 arch/arm/mach-omap2/display.c             |   44 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h |    6 ++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 26d3feb..276b800 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -36,10 +36,54 @@ static struct platform_device omap_display_device = {
 	},
 };
 
+static struct omap_device_pm_latency omap_dss_latency[] = {
+	[0] = {
+		.deactivate_func        = omap_device_idle_hwmods,
+		.activate_func          = omap_device_enable_hwmods,
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
+	char *oh_name[] = { 	"dss_dss",	/* omap2,3 */
+				"dss_dispc",	/* omap2,3 */
+				"dss_rfbi",	/* omap2,3 */
+				"dss_venc",	/* omap2,3 */
+				"dss_dsi1" };	/* omap3 */
+	char *dev_name[] = { "omap_dss", "omap_dispc", "omap_rfbi",
+				"omap_venc", "omap_dsi1" };
+	int oh_count;
+
+	if (cpu_is_omap24xx()) {
+		oh_count = ARRAY_SIZE(oh_name) - 1;
+		/* last hwmod dev in oh_name is not available for omap2 */
+	} else {
+		oh_count = ARRAY_SIZE(oh_name);
+	}
+
+	pdata.board_data	=	board_data;
+	pdata.board_data->get_last_off_on_transaction_id = NULL;
+
+	for (i = 0; i < oh_count; i++) {
+		oh = omap_hwmod_lookup(oh_name[i]);
+		if (!oh) {
+			pr_err("Could not look up %s\n", oh_name[i]);
+			return r;
+		}
+		od = omap_device_build(dev_name[i], -1, oh, &pdata,
+				sizeof(struct omap_display_platform_data),
+				omap_dss_latency,
+				ARRAY_SIZE(omap_dss_latency), 0);
+
+		WARN((IS_ERR(od)), "Could not build omap_device for %s\n",
+				oh_name[i]);
+	}
 	omap_display_device.dev.platform_data = board_data;
 
 	r = platform_device_register(&omap_display_device);
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 871bbae..23afd6d 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <asm/atomic.h>
 
+
 #define DISPC_IRQ_FRAMEDONE		(1 << 0)
 #define DISPC_IRQ_VSYNC			(1 << 1)
 #define DISPC_IRQ_EVSYNC_EVEN		(1 << 2)
@@ -224,6 +225,11 @@ struct omap_dss_board_info {
 /* Init with the board info */
 extern int omap_display_init(struct omap_dss_board_info *board_data);
 
+struct omap_display_platform_data {
+	struct omap_dss_board_info *board_data;
+	/* TODO: Additional members to be added when PM is considered */
+};
+
 struct omap_video_timings {
 	/* Unit: pixels */
 	u16 x_res;
-- 
1.7.0.4

