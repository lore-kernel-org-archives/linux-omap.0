From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 03/20] Build omap_device for each DSS HW IP
Date: Mon, 23 Aug 2010 21:27:52 +0530
Message-ID: <1282579089-10487-4-git-send-email-svadivu@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
 <1282579089-10487-3-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55693 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217Ab0HWP6W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:22 -0400
In-Reply-To: <1282579089-10487-3-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Looks up the HWMOD database for each of the given DSS HW IP
and builds omap_device which inturn does the platform device
register for each of DSS HW IP

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/devices.c             |   46 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h |   10 ++++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 523ce27..8faac13 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -29,6 +29,8 @@
 #include <plat/mmc.h>
 #include <plat/dma.h>
 #include <plat/display.h>
+#include <plat/omap_device.h>
+#include <plat/omap_hwmod.h>
 
 #include "mux.h"
 
@@ -824,9 +826,53 @@ static struct platform_device omap_display_device = {
 	},
 };
 
+static struct omap_device_pm_latency omap_dss_latency[] = {
+       [0] = {
+		.deactivate_func        = omap_device_idle_hwmods,
+		.activate_func          = omap_device_enable_hwmods,
+       },
+};
+
 void __init omap_display_init(struct omap_dss_board_info
 					*board_data)
 {
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	int l, i;
+	struct omap_display_platform_data pdata;
+	char oh_name[5][MAX_OMAP_DSS_HWMOD_NAME_LEN] = {
+			"dss",
+			"dss_dispc",
+			"dss_dsi1",
+			"dss_rfbi",
+			"dss_venc"
+			};
+
+	for (i = 0; i < 5; i++) {
+		l = snprintf(oh_name[i], MAX_OMAP_DSS_HWMOD_NAME_LEN,
+				 oh_name[i]);
+		WARN(l >= MAX_OMAP_DSS_HWMOD_NAME_LEN,
+			"String buffer overflow in DSS device setup\n");
+
+		oh = omap_hwmod_lookup(oh_name[i]);
+		if (!oh) {
+			pr_err("Could not look up %s\n", oh_name[i]);
+			return ;
+		}
+		strcpy(pdata.name, oh_name[i]);
+		pdata.board_data		=       board_data;
+		pdata.board_data->get_last_off_on_transaction_id = NULL;
+		pdata.device_enable    =       omap_device_enable;
+		pdata.device_idle      =       omap_device_idle;
+		pdata.device_shutdown  =       omap_device_shutdown;
+		od = omap_device_build(oh_name[i], -1, oh, &pdata,
+				sizeof(struct omap_display_platform_data),
+				omap_dss_latency,
+				ARRAY_SIZE(omap_dss_latency), 0);
+
+		WARN((IS_ERR(od)), "Could not build omap_device for %s\n",
+				oh_name[i]);
+	}
 
 	omap_display_device.dev.platform_data = board_data;
 
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index f5da4ae..996964a 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -26,6 +26,8 @@
 #include <linux/platform_device.h>
 #include <asm/atomic.h>
 
+#define MAX_OMAP_DSS_HWMOD_NAME_LEN 16
+
 #define DISPC_IRQ_FRAMEDONE		(1 << 0)
 #define DISPC_IRQ_VSYNC			(1 << 1)
 #define DISPC_IRQ_EVSYNC_EVEN		(1 << 2)
@@ -255,6 +257,14 @@ struct omap_dss_board_info {
 /* Init with the board info */
 extern void omap_display_init(struct omap_dss_board_info *board_data);
 
+struct omap_display_platform_data{
+	char name[MAX_OMAP_DSS_HWMOD_NAME_LEN];
+	struct omap_dss_board_info *board_data;
+	int (*device_enable)(struct platform_device *pdev);
+	int (*device_shutdown)(struct platform_device *pdev);
+	int (*device_idle)(struct platform_device *pdev);
+};
+
 struct omap_video_timings {
 	/* Unit: pixels */
 	u16 x_res;
-- 
1.6.3.3

