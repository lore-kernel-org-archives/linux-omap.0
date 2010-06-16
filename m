From: Zygo Blaxell <vger-linux-omap-esightcorp@mailtoo.hungrycats.org>
Subject: [PATCH] OMAP FB code to set DISPC_TIMING_{H,V} doesn't match TRM
Date: Wed, 16 Jun 2010 17:43:40 -0400
Message-ID: <20100616214340.GA27198@gibbs.hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ip-70-38-54-39.static.privatedns.com ([70.38.54.39]:47728 "EHLO
	ginevra.hungrycats.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754749Ab0FPVnl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 17:43:41 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The TRM and the OMAP FB driver have different ideas about the widths
of various bit fields in the DISPC_TIMING_{H,V} registers.  This patch
is based on what the TRM (TI document SPRUF98G) says.

Note:  this patch changes the meanings of the vertical timing values
by one scan line.  It still works with my display, but it might break
things for other people.

---

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index c7c6455..e58574b 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -795,17 +795,17 @@ static void set_lcd_timings(void)
 	unsigned long fck;
 
 	l = dispc_read_reg(DISPC_TIMING_H);
-	l &= ~(FLD_MASK(0, 6) | FLD_MASK(8, 8) | FLD_MASK(20, 8));
-	l |= ( max(1, (min(64,  panel->hsw))) - 1 ) << 0;
-	l |= ( max(1, (min(256, panel->hfp))) - 1 ) << 8;
-	l |= ( max(1, (min(256, panel->hbp))) - 1 ) << 20;
+	l &= ~(FLD_MASK(0, 8) | FLD_MASK(8, 12) | FLD_MASK(20, 12));
+	l |= ( max(1, (min(256, panel->hsw))) - 1 ) << 0;
+	l |= ( max(1, (min(4096, panel->hfp))) - 1 ) << 8;
+	l |= ( max(1, (min(4096, panel->hbp))) - 1 ) << 20;
 	dispc_write_reg(DISPC_TIMING_H, l);
 
 	l = dispc_read_reg(DISPC_TIMING_V);
-	l &= ~(FLD_MASK(0, 6) | FLD_MASK(8, 8) | FLD_MASK(20, 8));
-	l |= ( max(1, (min(64,  panel->vsw))) - 1 ) << 0;
-	l |= ( max(0, (min(255, panel->vfp))) - 0 ) << 8;
-	l |= ( max(0, (min(255, panel->vbp))) - 0 ) << 20;
+	l &= ~(FLD_MASK(0, 8) | FLD_MASK(8, 12) | FLD_MASK(20, 12));
+	l |= ( max(1, (min(256, panel->vsw))) - 1 ) << 0;
+	l |= ( max(1, (min(4096, panel->vfp))) - 1 ) << 8;
+	l |= ( max(1, (min(4096, panel->vbp))) - 1 ) << 20;
 	dispc_write_reg(DISPC_TIMING_V, l);
 
 	l = dispc_read_reg(DISPC_POL_FREQ);
