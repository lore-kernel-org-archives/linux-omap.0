From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [Patch v3 1/2] OMAP2PLUS:DSS2: add opt_clock_available in pdata
Date: Tue,  1 Mar 2011 14:12:13 +0530
Message-ID: <1298968934-22697-2-git-send-email-sumit.semwal@ti.com>
References: <1298968934-22697-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38462 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844Ab1CAImd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 03:42:33 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p218gXBs004117
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 02:42:33 -0600
In-Reply-To: <1298968934-22697-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>

Provide a function in pdata to allow dss submodules to check if a given
clock is available on a platform as an optional clock.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
(based on implementation from Senthil)

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 arch/arm/mach-omap2/display.c             |   22 ++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h |    2 ++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 5ab6a74..6b1efc5 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -42,6 +42,20 @@ static struct omap_device_pm_latency omap_dss_latency[] = {
 	},
 };
 
+/* oh_core is used for getting opt-clocks */
+static struct omap_hwmod	*oh_core;
+
+static bool opt_clock_available(const char *clk_role)
+{
+	int i;
+
+	for (i = 0; i < oh_core->opt_clks_cnt; i++) {
+		if (!strcmp(oh_core->opt_clks[i].role, clk_role))
+			return true;
+	}
+	return false;
+}
+
 int __init omap_display_init(struct omap_dss_board_info *board_data)
 {
 	int r = 0;
@@ -73,9 +87,16 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		oh_count = ARRAY_SIZE(oh_name) - 2;
 		/* last 2 hwmod dev in oh_name are not available for omap3 */
 
+	/* opt_clks are always associated with dss hwmod */
+	oh_core = omap_hwmod_lookup("dss_core");
+	if (!oh_core) {
+		pr_err("Could not look up dss_core.\n");
+		return -ENODEV;
+	}
 
 	pdata.board_data = board_data;
 	pdata.board_data->get_last_off_on_transaction_id = NULL;
+	pdata.opt_clock_available = opt_clock_available;
 
 	for (i = 0; i < oh_count; i++) {
 		oh = omap_hwmod_lookup(oh_name[i]);
@@ -83,6 +104,7 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 			pr_err("Could not look up %s\n", oh_name[i]);
 			return -ENODEV;
 		}
+
 		od = omap_device_build(dev_name[i], -1, oh, &pdata,
 				sizeof(struct omap_display_platform_data),
 				omap_dss_latency,
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 2fb057e..4101bcd 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -240,6 +240,8 @@ static inline int omap_display_init(struct omap_dss_board_info *board_data)
 struct omap_display_platform_data {
 	struct omap_dss_board_info *board_data;
 	/* TODO: Additional members to be added when PM is considered */
+
+	bool (*opt_clock_available)(const char *clk_role);
 };
 
 struct omap_video_timings {
-- 
1.7.1

