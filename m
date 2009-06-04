From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 13/20] omapfb: dispc: Various typo fixes
Date: Thu,  4 Jun 2009 20:52:38 +0300
Message-ID: <d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
 <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
 <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
 <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com>
 <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com>
 <5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com>
 <646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
 <b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com>
 <9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com>
 <08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com>
 <057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com>
 <310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com>
 <5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21367 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbZFDRzz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:55:55 -0400
In-Reply-To: <5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
In-Reply-To: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
References: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, Imre Deak <imre.deak@nokia.com>

- value and register offset was swapped in a dispc write
- DISPC_CONTROL register was used instead of DISPC_SYSCONFIG
- FIFO size bit field had incorrect length for OMAP3

Signed-off-by: Tony Lindgren <tony@atomide.com>
Fixed-by: arun <arunedarath@mistralsolutions.com>
Fixed-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Fixed-by: Andrzej Zaborowski <balrog@zabor.org>
Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 drivers/video/omap/dispc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 148cbcc..2db8fbb 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -286,7 +286,7 @@ static void setup_plane_fifo(int plane, int ext_mode)
 	BUG_ON(plane > 2);
 
 	l = dispc_read_reg(fsz_reg[plane]);
-	l &= FLD_MASK(0, 9);
+	l &= FLD_MASK(0, 11);
 	if (ext_mode) {
 		low = l * 3 / 4;
 		high = l;
@@ -294,7 +294,7 @@ static void setup_plane_fifo(int plane, int ext_mode)
 		low = l / 4;
 		high = l * 3 / 4;
 	}
-	MOD_REG_FLD(ftrs_reg[plane], FLD_MASK(16, 9) | FLD_MASK(0, 9),
+	MOD_REG_FLD(ftrs_reg[plane], FLD_MASK(16, 12) | FLD_MASK(0, 12),
 			(high << 16) | low);
 }
 
@@ -1397,7 +1397,7 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	}
 
 	/* Enable smart idle and autoidle */
-	l = dispc_read_reg(DISPC_CONTROL);
+	l = dispc_read_reg(DISPC_SYSCONFIG);
 	l &= ~((3 << 12) | (3 << 3));
 	l |= (2 << 12) | (2 << 3) | (1 << 0);
 	dispc_write_reg(DISPC_SYSCONFIG, l);
@@ -1409,7 +1409,7 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	dispc_write_reg(DISPC_CONFIG, l);
 
 	l = dispc_read_reg(DISPC_IRQSTATUS);
-	dispc_write_reg(l, DISPC_IRQSTATUS);
+	dispc_write_reg(DISPC_IRQSTATUS, l);
 
 	/* Enable those that we handle always */
 	omap_dispc_enable_irqs(DISPC_IRQ_FRAMEMASK);
-- 
1.6.3.1

