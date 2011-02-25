From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [Patch 1/2] OMAP2PLUS: DSS2: Add dss_opt_clk_roles in pdata
Date: Fri, 25 Feb 2011 13:57:49 +0530
Message-ID: <1298622470-10558-2-git-send-email-sumit.semwal@ti.com>
References: <1298622470-10558-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50475 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302Ab1BYI2K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 03:28:10 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1P8SAx0000628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 02:28:10 -0600
In-Reply-To: <1298622470-10558-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>

Provide dss_opt_clks roles in pdata, so that it can be retrieved
in dss driver, thus avoiding the hardcoding of clock role names.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
(based on implementation from Senthil)

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 arch/arm/mach-omap2/display.c             |   41 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/display.h |    3 +-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index cc7b4f3..f189c07 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/slab.h>
 
 #include <plat/display.h>
 #include <plat/omap_hwmod.h>
@@ -48,6 +49,7 @@ int __init omap_display_init(struct omap_dss_board_info
 	int r = 0;
 	struct omap_hwmod *oh;
 	struct omap_device *od;
+	struct omap_hwmod_opt_clk *oc = NULL;
 	int i;
 	struct omap_display_platform_data pdata;
 
@@ -61,7 +63,7 @@ int __init omap_display_init(struct omap_dss_board_info
 				"dss_dsi2", "dss_hdmi"};
 	char *dev_name[] = {"omap_dss", "omap_dispc", "omap_rfbi", "omap_venc", "omap_dsi1",
 				"omap_dsi2", "omap_hdmi"};
-	int oh_count;
+	int oh_count, oc_count;
 
 	memset(&pdata, 0, sizeof(pdata));
 
@@ -74,7 +76,44 @@ int __init omap_display_init(struct omap_dss_board_info
 		oh_count = ARRAY_SIZE(oh_name) - 2;
 		/* last 2 hwmod dev in oh_name are not available for omap3 */
 
+	/* opt_clks are always associated with dss hwmod */
+	oh = omap_hwmod_lookup("dss_core");
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name[0]);
+		return -ENODEV;
+	}
+	oc = oh->opt_clks;
+	oc_count = oh->opt_clks_cnt;
+
+	/* copy roles of opt_clocks available from hwmod into pdata */
+	pdata.dss_opt_clk_roles = kzalloc(sizeof(char *) * oc_count,
+					  GFP_KERNEL);
+	if (!pdata.dss_opt_clk_roles) {
+		pr_err("could not allocate memory for dss_opt_clk_roles\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < oc_count; i++) {
+		int oc_length = strlen(oc[i].role);
+
+		pdata.dss_opt_clk_roles[i] = kzalloc(oc_length + 1,
+						     GFP_KERNEL);
+		if (!pdata.dss_opt_clk_roles[i]) {
+			int j = i - 1;
+
+			pr_err("kzalloc failed for dss_opt_clk[%i]\n", i);
+			for (; j >= 0; j--)
+				kfree(pdata.dss_opt_clk_roles[j]);
+
+			kfree(pdata.dss_opt_clk_roles);
+
+			return -ENOMEM;
+		}
+
+		strncpy(pdata.dss_opt_clk_roles[i], oc[i].role, oc_length+1);
+	}
 
+	pdata.dss_opt_clks_count = oc_count;
 	pdata.board_data = board_data;
 	pdata.board_data->get_last_off_on_transaction_id = NULL;
 
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 2fb057e..5f5fc0d 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -239,7 +239,8 @@ static inline int omap_display_init(struct omap_dss_board_info *board_data)
 
 struct omap_display_platform_data {
 	struct omap_dss_board_info *board_data;
-	/* TODO: Additional members to be added when PM is considered */
+	char **dss_opt_clk_roles;
+	int dss_opt_clks_count;
 };
 
 struct omap_video_timings {
-- 
1.7.1

