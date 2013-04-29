From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/10] OMAPFB: defer probe if no displays
Date: Mon, 29 Apr 2013 13:22:30 +0300
Message-ID: <1367230957-32337-4-git-send-email-tomi.valkeinen@ti.com>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40928 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036Ab3D2KXG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Apr 2013 06:23:06 -0400
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb requires the panel drivers to have been probed when omapfb is
initialized. omapfb does not support insertion of new panels after its
probe. This causes a problem in case omapdss or the panel probes have
been deferred due to EPROBE_DEFER error, as omapfb won't find any
displays.

As a quick fix, this patch changes the omapfb probe so that if omapfb
does not find any displays, it'll return EPROBE_DEFER. This is not
perfect, as with a board with no displays, omapfb will get deferred
forever. Also, if the board has multiple displays, but only some of them
have been probed, omapfb will start and leave the unprobed displays out.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 808f6af..ff00d1d 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2484,7 +2484,7 @@ static int omapfb_probe(struct platform_device *pdev)
 
 	if (fbdev->num_displays == 0) {
 		dev_err(&pdev->dev, "no displays\n");
-		r = -EINVAL;
+		r = -EPROBE_DEFER;
 		goto cleanup;
 	}
 
-- 
1.7.10.4

