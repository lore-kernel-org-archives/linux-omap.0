From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/4] OMAPDSS: DISPC: Add MFLAG defines
Date: Mon, 18 Nov 2013 14:44:09 +0200
Message-ID: <1384778649-9396-4-git-send-email-tomi.valkeinen@ti.com>
References: <1384778649-9396-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51991 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab3KRMoW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 07:44:22 -0500
In-Reply-To: <1384778649-9396-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP5 has MFLAG feature in DISPC. Add the register definition and dump
it. The register is not used yet, though.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |  4 ++++
 drivers/video/omap2/dss/dispc.h        | 20 ++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.c |  1 +
 drivers/video/omap2/dss/dss_features.h |  1 +
 4 files changed, 26 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index aa95ba5..d39a4e3 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3213,6 +3213,8 @@ static void dispc_dump_regs(struct seq_file *s)
 		DUMPREG(DISPC_CONTROL3);
 		DUMPREG(DISPC_CONFIG3);
 	}
+	if (dss_has_feature(FEAT_MFLAG))
+		DUMPREG(DISPC_GLOBAL_MFLAG_ATTRIBUTE);
 
 #undef DUMPREG
 
@@ -3287,6 +3289,8 @@ static void dispc_dump_regs(struct seq_file *s)
 			DUMPREG(i, DISPC_OVL_ATTRIBUTES2);
 		if (dss_has_feature(FEAT_PRELOAD))
 			DUMPREG(i, DISPC_OVL_PRELOAD);
+		if (dss_has_feature(FEAT_MFLAG))
+			DUMPREG(i, DISPC_OVL_MFLAG_THRESHOLD);
 	}
 
 #undef DISPC_REG
diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index de4863d..78edb44 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -40,6 +40,7 @@
 #define DISPC_CONTROL3                  0x0848
 #define DISPC_CONFIG3                   0x084C
 #define DISPC_MSTANDBY_CTRL		0x0858
+#define DISPC_GLOBAL_MFLAG_ATTRIBUTE	0x085C
 
 /* DISPC overlay registers */
 #define DISPC_OVL_BA0(n)		(DISPC_OVL_BASE(n) + \
@@ -100,6 +101,8 @@
 					DISPC_FIR_COEF_V2_OFFSET(n, i))
 #define DISPC_OVL_PRELOAD(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_PRELOAD_OFFSET(n))
+#define DISPC_OVL_MFLAG_THRESHOLD(n)	(DISPC_OVL_BASE(n) + \
+					DISPC_MFLAG_THRESHOLD_OFFSET(n))
 
 /* DISPC up/downsampling FIR filter coefficient structure */
 struct dispc_coef {
@@ -894,4 +897,21 @@ static inline u16 DISPC_PRELOAD_OFFSET(enum omap_plane plane)
 		return 0;
 	}
 }
+
+static inline u16 DISPC_MFLAG_THRESHOLD_OFFSET(enum omap_plane plane)
+{
+	switch (plane) {
+	case OMAP_DSS_GFX:
+		return 0x0860;
+	case OMAP_DSS_VIDEO1:
+		return 0x0864;
+	case OMAP_DSS_VIDEO2:
+		return 0x0868;
+	case OMAP_DSS_VIDEO3:
+		return 0x086c;
+	default:
+		BUG();
+		return 0;
+	}
+}
 #endif
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index f8fd6db..7f89691 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -613,6 +613,7 @@ static const enum dss_feat_id omap5_dss_feat_list[] = {
 	FEAT_DSI_PLL_SELFREQDCO,
 	FEAT_DSI_PLL_REFSEL,
 	FEAT_DSI_PHY_DCC,
+	FEAT_MFLAG,
 };
 
 /* OMAP2 DSS Features */
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 10b0556..e3ef3b7 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -64,6 +64,7 @@ enum dss_feat_id {
 	FEAT_DSI_PLL_SELFREQDCO,
 	FEAT_DSI_PLL_REFSEL,
 	FEAT_DSI_PHY_DCC,
+	FEAT_MFLAG,
 };
 
 /* DSS register field id */
-- 
1.8.3.2

