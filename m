From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2] OMAP2PLUS: DSS2: Clean up omap_display_init()
Date: Mon, 18 Apr 2011 09:32:13 +0530
Message-ID: <1303099333-13327-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36376 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923Ab1DRD47 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 17 Apr 2011 23:56:59 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3I3ux4x007715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 17 Apr 2011 22:56:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, Archit Taneja <archit@ti.com>

Currently, omap_display_init() maintains arrays for hwmod name(oh_name) and the
correspnding platform_device name(dev_name) needed by omap_device_build().
A variable oh_count keeps a track of the number of devices to build from oh_name
based on what omap revision it is.

Clean this up by maintaining an array of omap_dss_hwmod_data struct which is
defined for each omap revision as suggested by Tomi Valkeinen. Assign the
corresponding omap_dss_hwmod_data array struct to the pointer curr_dss_hwmod in
omap_display_init().

Signed-off-by: Archit Taneja <archit@ti.com>
---
v2:
-Remove unnecessary extra struct
-add __intdata in array definitions

Tested on OMAP 3430sdp and OMAP4430 sdp.

Can be applied over:
https://gitorious.org/linux-omap-dss2/linux/commits/master

 arch/arm/mach-omap2/display.c |   75 ++++++++++++++++++++++++++--------------
 1 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 256d23f..fa83eb3 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -56,37 +56,58 @@ static bool opt_clock_available(const char *clk_role)
 	return false;
 }
 
+struct omap_dss_hwmod_data {
+	const char *oh_name;
+	const char *dev_name;
+	const int id;
+};
+
+static const struct omap_dss_hwmod_data omap2_dss_hwmod_data[] __initdata = {
+	{ "dss_core", "omapdss_dss", -1 },
+	{ "dss_dispc", "omapdss_dispc", -1 },
+	{ "dss_rfbi", "omapdss_rfbi", -1 },
+	{ "dss_venc", "omapdss_venc", -1 },
+};
+
+static const struct omap_dss_hwmod_data omap3_dss_hwmod_data[] __initdata = {
+	{ "dss_core", "omapdss_dss", -1 },
+	{ "dss_dispc", "omapdss_dispc", -1 },
+	{ "dss_rfbi", "omapdss_rfbi", -1 },
+	{ "dss_venc", "omapdss_venc", -1 },
+	{ "dss_dsi1", "omapdss_dsi1", -1 },
+};
+
+static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
+	{ "dss_core", "omapdss_dss", -1 },
+	{ "dss_dispc", "omapdss_dispc", -1 },
+	{ "dss_rfbi", "omapdss_rfbi", -1 },
+	{ "dss_venc", "omapdss_venc", -1 },
+	{ "dss_dsi1", "omapdss_dsi1", -1 },
+	{ "dss_dsi2", "omapdss_dsi2", -1 },
+	{ "dss_hdmi", "omapdss_hdmi", -1 },
+};
+
 int __init omap_display_init(struct omap_dss_board_info *board_data)
 {
 	int r = 0;
 	struct omap_hwmod *oh;
 	struct omap_device *od;
-	int i;
+	int i, oh_count;
 	struct omap_display_platform_data pdata;
-
-	/*
-	 * omap: valid DSS hwmod names
-	 * omap2,3,4: dss_core, dss_dispc, dss_rfbi, dss_venc
-	 * omap3,4: dss_dsi1
-	 * omap4: dss_dsi2, dss_hdmi
-	 */
-	char *oh_name[] = { "dss_core", "dss_dispc", "dss_rfbi", "dss_venc",
-		"dss_dsi1", "dss_dsi2", "dss_hdmi" };
-	char *dev_name[] = { "omapdss_dss", "omapdss_dispc", "omapdss_rfbi",
-		"omapdss_venc", "omapdss_dsi1", "omapdss_dsi2",
-		"omapdss_hdmi" };
-	int oh_count;
+	const struct omap_dss_hwmod_data const *curr_dss_hwmod;
 
 	memset(&pdata, 0, sizeof(pdata));
 
-	if (cpu_is_omap24xx())
-		oh_count = ARRAY_SIZE(oh_name) - 3;
-		/* last 3 hwmod dev in oh_name are not available for omap2 */
-	else if (cpu_is_omap44xx())
-		oh_count = ARRAY_SIZE(oh_name);
-	else
-		oh_count = ARRAY_SIZE(oh_name) - 2;
-		/* last 2 hwmod dev in oh_name are not available for omap3 */
+	if (cpu_is_omap24xx()) {
+		curr_dss_hwmod = omap2_dss_hwmod_data;
+		oh_count = ARRAY_SIZE(omap2_dss_hwmod_data);
+	} else if (cpu_is_omap34xx()) {
+		curr_dss_hwmod = omap3_dss_hwmod_data;
+		oh_count = ARRAY_SIZE(omap3_dss_hwmod_data);
+	} else {
+		curr_dss_hwmod = omap4_dss_hwmod_data;
+		oh_count = ARRAY_SIZE(omap4_dss_hwmod_data);
+	}
 
 	/* opt_clks are always associated with dss hwmod */
 	oh_core = omap_hwmod_lookup("dss_core");
@@ -100,19 +121,21 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	pdata.opt_clock_available = opt_clock_available;
 
 	for (i = 0; i < oh_count; i++) {
-		oh = omap_hwmod_lookup(oh_name[i]);
+		oh = omap_hwmod_lookup(curr_dss_hwmod[i].oh_name);
 		if (!oh) {
-			pr_err("Could not look up %s\n", oh_name[i]);
+			pr_err("Could not look up %s\n",
+				curr_dss_hwmod[i].oh_name);
 			return -ENODEV;
 		}
 
-		od = omap_device_build(dev_name[i], -1, oh, &pdata,
+		od = omap_device_build(curr_dss_hwmod[i].dev_name,
+				curr_dss_hwmod[i].id, oh, &pdata,
 				sizeof(struct omap_display_platform_data),
 				omap_dss_latency,
 				ARRAY_SIZE(omap_dss_latency), 0);
 
 		if (WARN((IS_ERR(od)), "Could not build omap_device for %s\n",
-				oh_name[i]))
+				curr_dss_hwmod[i].oh_name))
 			return -ENODEV;
 	}
 	omap_display_device.dev.platform_data = board_data;
-- 
1.7.1

