From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [Patch v2 1/2] OMAP2PLUS:DSS2: add opt_clock_available in pdata
Date: Mon, 28 Feb 2011 20:32:42 +0530
Message-ID: <1298905363-28871-2-git-send-email-sumit.semwal@ti.com>
References: <1298905363-28871-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50294 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab1B1PDR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 10:03:17 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1SF3HMS029725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 09:03:17 -0600
In-Reply-To: <1298905363-28871-1-git-send-email-sumit.semwal@ti.com>
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
 arch/arm/mach-omap2/display.c             |   20 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/display.h |    2 ++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 5ab6a74..9f4f862 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -42,6 +42,25 @@ static struct omap_device_pm_latency omap_dss_latency[] = {
 	},
 };
 
+static bool opt_clock_available(const char *clk_role)
+{
+	int i;
+	struct omap_hwmod *oh;
+
+	/* opt_clks are always associated with dss hwmod */
+	oh = omap_hwmod_lookup("dss_core");
+	if (!oh) {
+		pr_err("Could not look up dss_core.\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < oh->opt_clks_cnt; i++) {
+		if (!strcmp(oh->opt_clks[i].role, clk_role))
+			return true;
+	}
+	return false;
+}
+
 int __init omap_display_init(struct omap_dss_board_info *board_data)
 {
 	int r = 0;
@@ -76,6 +95,7 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 
 	pdata.board_data = board_data;
 	pdata.board_data->get_last_off_on_transaction_id = NULL;
+	pdata.opt_clock_available = opt_clock_available;
 
 	for (i = 0; i < oh_count; i++) {
 		oh = omap_hwmod_lookup(oh_name[i]);
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

