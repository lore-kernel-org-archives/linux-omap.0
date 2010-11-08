From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP: DSS2: Fix: Read correct bit in dispc_enable_alpha_blending()
Date: Mon,  8 Nov 2010 17:26:21 +0530
Message-ID: <1289217381-601-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38007 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab0KHLzZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 06:55:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Read correct DISPC_CONFIG bit when the channel is DIGIT, remove extra line
at the end of the function.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 2179618..54ba8d3
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2017,13 +2017,12 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		enabled = REG_GET(DISPC_CONFIG, 18, 18);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-		enabled = REG_GET(DISPC_CONFIG, 18, 18);
+		enabled = REG_GET(DISPC_CONFIG, 19, 19);
 	else
 		BUG();
 	enable_clocks(0);
 
 	return enabled;
-
 }
 
 
-- 
1.7.0.4

