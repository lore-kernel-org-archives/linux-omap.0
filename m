From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 5/5] OMAP: DSS2: Use a macro to declare size of the fifo_size array in dispc.c
Date: Fri, 5 Aug 2011 19:06:04 +0530
Message-ID: <1312551364-4828-6-git-send-email-archit@ti.com>
References: <1312551364-4828-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59282 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756529Ab1HEN1q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Aug 2011 09:27:46 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p75DRkl5025641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:46 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p75DRj05029476
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:45 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p75DRj2H022759
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:45 -0500 (CDT)
In-Reply-To: <1312551364-4828-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The array size of fifo_size array in the global dispc struct is currently
hardcoded to 3. Replace this with the MAX_DSS_OVERLAYS macro in dss_features.h,
use dss_features function to get the number of overlays instead of the
ARRAY_SIZE macro in dispc_read_plane_fifo_sizes().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 8cab996..d910373 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -106,7 +106,7 @@ static struct {
 	int irq;
 	struct clk *dss_clk;
 
-	u32	fifo_size[3];
+	u32	fifo_size[MAX_DSS_OVERLAYS];
 
 	spinlock_t irq_lock;
 	u32 irq_error_mask;
@@ -1024,7 +1024,7 @@ static void dispc_read_plane_fifo_sizes(void)
 
 	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
 
-	for (plane = 0; plane < ARRAY_SIZE(dispc.fifo_size); ++plane) {
+	for (plane = 0; plane < dss_feat_get_num_ovls(); ++plane) {
 		size = REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(plane), start, end);
 		size *= unit;
 		dispc.fifo_size[plane] = size;
-- 
1.7.1

