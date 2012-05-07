From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/6] OMAPDSS: APPLY: Remove an unnecessary omap_dss_device pointer
Date: Mon, 7 May 2012 16:51:32 +0530
Message-ID: <1336389696-21636-3-git-send-email-archit@ti.com>
References: <1336389696-21636-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46600 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567Ab2EGLW3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 07:22:29 -0400
In-Reply-To: <1336389696-21636-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The omap_dss_device pointer declared in dss_ovl_setup_fifo() isn't used. Remove
the pointer variable declaration and it's assignment.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 052d9a2..756c31a 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -977,14 +977,11 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl,
 		bool use_fifo_merge)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
-	struct omap_dss_device *dssdev;
 	u32 fifo_low, fifo_high;
 
 	if (!op->enabled && !op->enabling)
 		return;
 
-	dssdev = ovl->manager->device;
-
 	dispc_ovl_compute_fifo_thresholds(ovl->id, &fifo_low, &fifo_high,
 			use_fifo_merge);
 
-- 
1.7.5.4

