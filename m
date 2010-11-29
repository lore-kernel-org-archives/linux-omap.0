From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v2 07/17] OMAP2,3: DSS: Build omap_device for each DSS HWIP
Date: Mon, 29 Nov 2010 17:21:33 +0530
Message-ID: <1291031503-21036-8-git-send-email-svadivu@ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48977 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609Ab0K2Lv7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 06:51:59 -0500
In-Reply-To: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Looks up the hwmod database for each of the given DSS HW IP
and builds omap_device which inturn does the platform device
register for each of DSS HW IP

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/devices.c             |   50 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h |    6 +++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 0f6eabe..9ae546e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -934,10 +934,60 @@ static struct platform_device omap_display_device = {
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
+	char *omap2_oh_name[] = { "dss_dss", "dss_dispc", "dss_rfbi",
+				"dss_venc" };
+	char *omap3_oh_name[] = { "dss_dss", "dss_dispc", "dss_rfbi",
+				"dss_venc", "dss_dsi1" };
+	char *omap2_dev_name[] = { "omap_dss", "omap_dispc", "omap_rfbi",
+				"omap_venc" };
+	char *omap3_dev_name[] = { "omap_dss", "omap_dispc", "omap_rfbi",
+				"omap_venc", "omap_dsi1" };
+	char *(*oh_name)[];
+	char *(*dev_name)[];
+	int oh_count;
+
+	if (cpu_is_omap24xx()) {
+		oh_name = &omap2_oh_name;
+		dev_name = &omap2_dev_name;
+		oh_count = ARRAY_SIZE(omap2_oh_name);
+	} else {
+		oh_name = &omap3_oh_name;
+		dev_name = &omap3_dev_name;
+		oh_count = ARRAY_SIZE(omap3_oh_name);
+	}
+
+	pdata.board_data	=	board_data;
+	pdata.board_data->get_last_off_on_transaction_id = NULL;
+
+	for (i = 0; i < oh_count; i++) {
+		oh = omap_hwmod_lookup((*oh_name)[i]);
+		if (!oh) {
+			pr_err("Could not look up %s\n", (*oh_name)[i]);
+			return r;
+		}
+		od = omap_device_build((*dev_name)[i], -1, oh, &pdata,
+				sizeof(struct omap_display_platform_data),
+				omap_dss_latency,
+				ARRAY_SIZE(omap_dss_latency), 0);
+
+		WARN((IS_ERR(od)), "Could not build omap_device for %s\n",
+				(*oh_name)[i]);
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
1.6.3.3

