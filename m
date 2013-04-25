From: Sergey Kibrik <sergiikibrik@ti.com>
Subject: [RESEND PATCH] OMAPDSS: gracefully disable overlay at error
Date: Thu, 25 Apr 2013 11:28:15 +0300
Message-ID: <1366878495-14431-1-git-send-email-sergiikibrik@ti.com>
References: <5178BDB1.1020200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47779 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab3DYI2T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Apr 2013 04:28:19 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id r3P8SIfV000875
	for <linux-omap@vger.kernel.org>; Thu, 25 Apr 2013 03:28:18 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id r3P8SIx8017938
	for <linux-omap@vger.kernel.org>; Thu, 25 Apr 2013 03:28:18 -0500
In-Reply-To: <5178BDB1.1020200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Disable overlay via ovl->disable() interface, which will
properly set flags in cache and GO bits for managers.
This allows overlay user to re-enable it on next frame,
thus recovering from FIFO underflows.

Signed-off-by: Sergey Kibrik <sergiikibrik@ti.com>
---
 drivers/video/omap2/dss/dispc-compat.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc-compat.c b/drivers/video/omap2/dss/dispc-compat.c
index 928884c..83779c2 100644
--- a/drivers/video/omap2/dss/dispc-compat.c
+++ b/drivers/video/omap2/dss/dispc-compat.c
@@ -360,8 +360,7 @@ static void dispc_error_worker(struct work_struct *work)
 		if (bit & errors) {
 			DSSERR("FIFO UNDERFLOW on %s, disabling the overlay\n",
 					ovl->name);
-			dispc_ovl_enable(ovl->id, false);
-			dispc_mgr_go(ovl->manager->id);
+			ovl->disable(ovl);
 			msleep(50);
 		}
 	}
-- 
1.7.9.5

