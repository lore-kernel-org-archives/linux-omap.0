From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] omapdss: dss: Fix clocks on OMAP363x
Date: Thu, 25 Oct 2012 20:42:10 +0200
Message-ID: <1351190530-16863-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:53019 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760027Ab2JYSlX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 14:41:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Commit 185bae1095188aa199c9be64d6030d8dbfc65e0a ("OMAPDSS: DSS: Cleanup
cpu_is_xxxx checks") broke the DSS clocks configuration by erroneously
using the clock parameters applicable to all other OMAP34xx SoCs for the
OMAP363x. This went unnoticed probably because the cpu_is_omap34xx()
class check wasn't seen as matching the OMAP363x subclass.

Fix it by checking for the OMAP363x subclass before checking for the
OMAP34xx class.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/omap2/dss/dss.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Hi Tomi,

The patch has been tested on the Beagleboard-xM and restores the DVI output
operation. This is a regression fix that should be pushed to v3.7.

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 2ab1c3e..0bb7406 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -805,10 +805,10 @@ static int __init dss_init_features(struct device *dev)
 
 	if (cpu_is_omap24xx())
 		src = &omap24xx_dss_feats;
-	else if (cpu_is_omap34xx())
-		src = &omap34xx_dss_feats;
 	else if (cpu_is_omap3630())
 		src = &omap3630_dss_feats;
+	else if (cpu_is_omap34xx())
+		src = &omap34xx_dss_feats;
 	else if (cpu_is_omap44xx())
 		src = &omap44xx_dss_feats;
 	else if (soc_is_omap54xx())
-- 
Regards,

Laurent Pinchart

