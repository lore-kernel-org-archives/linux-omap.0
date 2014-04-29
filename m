From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and probably 3630
Date: Tue, 29 Apr 2014 16:52:39 -0700
Message-ID: <1398815562-24113-2-git-send-email-tony@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38193 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbaD2Xwt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 19:52:49 -0400
In-Reply-To: <1398815562-24113-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com

Otherwise we can get often errors like the following and the
display won't come on:

omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
omapdss APPLY error: SYNC_LOST on channel lcd, restarting
the output with video overlays disabled

There are some earlier references to this issue:

http://www.spinics.net/lists/linux-omap/msg59511.html
http://www.spinics.net/lists/linux-omap/msg59724.html

It seems that it's safe to set the lower values even for 3630.
If we can confirm that 3630 works with the higher values
reliably we can add further detection.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/video/fbdev/omap2/dss/dss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index d55266c..ad6561f 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -707,9 +707,10 @@ static const struct dss_features omap34xx_dss_feats __initconst = {
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
 };
 
+/* Supposedly 3630 can use div 32 mult 2, but that needs to be rechecked */
 static const struct dss_features omap3630_dss_feats __initconst = {
-	.fck_div_max		=	32,
-	.dss_fck_multiplier	=	1,
+	.fck_div_max		=	16,
+	.dss_fck_multiplier	=	2,
 	.parent_clk_name	=	"dpll4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
 };
-- 
1.8.1.1

