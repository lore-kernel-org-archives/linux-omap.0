From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/3] OMAP: DSS2: Zorder enum in display.h
Date: Mon, 19 Jul 2010 17:40:05 +0530
Message-ID: <1279541407-17711-2-git-send-email-archit@ti.com>
References: <1279541407-17711-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47250 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760638Ab0GSMKR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 08:10:17 -0400
In-Reply-To: <1279541407-17711-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Samreen <samreen@ti.com>, Archit Taneja <archit@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Add Zorder enum in display.h

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index d1da317..197ce8c
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -206,6 +206,13 @@ enum omap_overlay_manager_caps {
 	OMAP_DSS_OVL_MGR_CAP_DISPC = 1 << 0,
 };
 
+enum omap_overlay_zorder {
+	OMAP_DSS_OVL_ZORDER_0	= 0x0,
+	OMAP_DSS_OVL_ZORDER_1	= 0x1,
+	OMAP_DSS_OVL_ZORDER_2	= 0x2,
+	OMAP_DSS_OVL_ZORDER_3	= 0x3,
+};
+
 /* RFBI */
 
 struct rfbi_timings {
@@ -308,6 +315,7 @@ struct omap_overlay_info {
 	u16 out_width;	/* if 0, out_width == width */
 	u16 out_height;	/* if 0, out_height == height */
 	u8 global_alpha;
+	enum omap_overlay_zorder zorder;
 };
 
 struct omap_overlay {
-- 
1.6.3.3

