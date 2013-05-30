From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 32/32] OMAPFB: use EPROBE_DEFER if default display is not present
Date: Thu, 30 May 2013 12:34:53 +0300
Message-ID: <1369906493-27538-33-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49849 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030380Ab3E3JgE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:36:04 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently omapfb returns EPROBE_DEFER if no displays have been probed at
the time omapfb is probed. However, sometimes some of the displays have
been probed at that time, but not all. We can't return EPROBE_DEFER in
that case, because then one missing driver would cause omapfb to defer
always, preventing any display from working.

However, if the user has defined a default display, we can presume that
the driver for that display is eventually loaded. Thus, this patch
changes omapfb to return EPROBE_DEFER in case default display is not
found.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index eacbafa..0c0d078 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2500,7 +2500,7 @@ static int omapfb_probe(struct platform_device *pdev)
 
 	if (def_display == NULL) {
 		dev_err(fbdev->dev, "failed to find default display\n");
-		r = -EINVAL;
+		r = -EPROBE_DEFER;
 		goto cleanup;
 	}
 
-- 
1.8.1.2

