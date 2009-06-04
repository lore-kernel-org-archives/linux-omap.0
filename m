From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 15/20] omapfb: dispc: Enable wake up capability
Date: Thu,  4 Jun 2009 20:52:40 +0300
Message-ID: <36ddd74a50b8c225b2c571035c67dbff4686b881.1244131952.git.imre.deak@nokia.com>
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
 <d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
 <d83034cc97924164ca9949fee84bfb480ad5c806.1244131952.git.imre.deak@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38818 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbZFDR5N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:57:13 -0400
In-Reply-To: <d83034cc97924164ca9949fee84bfb480ad5c806.1244131952.git.imre.deak@nokia.com>
In-Reply-To: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
References: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, Jouni Hogander <jouni.hogander@nokia.com>, Imre Deak <imre.deak@nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

Without wakeup enable omap doesn't wake up on dispc interrupts. This
causes problems in a case where mpu is in sleep state and dispc
interrupt fires.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 drivers/video/omap/dispc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index cc3c817..9adf54e 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -1395,10 +1395,10 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 		enable_digit_clocks(0);
 	}
 
-	/* Enable smart idle and autoidle */
+	/* Enable smart standby/idle, autoidle and wakeup */
 	l = dispc_read_reg(DISPC_SYSCONFIG);
 	l &= ~((3 << 12) | (3 << 3));
-	l |= (2 << 12) | (2 << 3) | (1 << 0);
+	l |= (2 << 12) | (2 << 3) | (1 << 2) | (1 << 0);
 	dispc_write_reg(DISPC_SYSCONFIG, l);
 	omap_writel(1 << 0, DSS_BASE + DSS_SYSCONFIG);
 
-- 
1.6.3.1

