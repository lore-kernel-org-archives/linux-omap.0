From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH 1/4] OMAP: DSS2: Add dss_feature for variable DPLL fclk
Date: Thu,  3 Feb 2011 19:26:56 +0530
Message-ID: <1296741419-9037-2-git-send-email-raghuveer.murthy@ti.com>
References: <1296741419-9037-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36326 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932156Ab1BCOC1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 09:02:27 -0500
In-Reply-To: <1296741419-9037-1-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomba@iki.fi
Cc: linux-omap@vger.kernel.org

This patch adds dss_feature for OMAP chips to distinguish between
those having a variable DPLL_PER functional clock (fclk). Additionally,
a feature for distiguishing the number of available dividers, 16 or 32,
for these fclk is added.

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    9 ++++++---
 drivers/video/omap2/dss/dss_features.h |    3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index f3ef929..4630f0c 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -157,7 +157,8 @@ static struct omap_dss_features omap3430_dss_features = {
 	.has_feature	=
 		FEAT_GLOBAL_ALPHA | FEAT_LCDENABLEPOL |
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
-		FEAT_FUNCGATED | FEAT_COMMON_IRQ_DISPC_DSI,
+		FEAT_FUNCGATED | FEAT_COMMON_IRQ_DISPC_DSI |
+		FEAT_VAR_DPLL_FCK,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -173,7 +174,8 @@ static struct omap_dss_features omap3630_dss_features = {
 		FEAT_GLOBAL_ALPHA | FEAT_LCDENABLEPOL |
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
 		FEAT_PRE_MULT_ALPHA | FEAT_FUNCGATED |
-		FEAT_COMMON_IRQ_DISPC_DSI,
+		FEAT_COMMON_IRQ_DISPC_DSI | FEAT_VAR_DPLL_FCK |
+		FEAT_DPLL_FCK_32_DIV,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -188,7 +190,8 @@ static struct omap_dss_features omap4_dss_features = {
 
 	.has_feature	=
 		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
-		FEAT_MGR_LCD2,
+		FEAT_MGR_LCD2 | FEAT_VAR_DPLL_FCK |
+		FEAT_DPLL_FCK_32_DIV,
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 1c93a49..76b5fce 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -34,6 +34,9 @@ enum dss_feat_id {
 	FEAT_FUNCGATED			= 1 << 6,
 	FEAT_MGR_LCD2			= 1 << 7,
 	FEAT_COMMON_IRQ_DISPC_DSI	= 1 << 8,
+	FEAT_VAR_DPLL_FCK		= 1 << 9, /* Variable DPLL Func CLK */
+	/* DPLL FCLK has max divider value 32 */
+	FEAT_DPLL_FCK_32_DIV		= 1 << 10,
 };
 
 /* DSS register field id */
-- 
1.7.0.4

