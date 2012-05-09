From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 7/9] OMAPDSS: APPLY: Remove an unnecessary omap_dss_device pointer
Date: Wed, 9 May 2012 15:40:54 +0530
Message-ID: <1336558256-26140-8-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
 <1336558256-26140-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39792 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755178Ab2EIKMK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 06:12:10 -0400
In-Reply-To: <1336558256-26140-1-git-send-email-archit@ti.com>
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
index 0ffe4e1..15c070c 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -960,14 +960,11 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl,
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

