From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/4] OMAP: OMAPFB: make omapfb start even when a display is missing a driver
Date: Mon, 22 Aug 2011 11:27:13 +0300
Message-ID: <1314001636-18036-2-git-send-email-tomi.valkeinen@ti.com>
References: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:34796 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755754Ab1HVI1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:27:33 -0400
In-Reply-To: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently omapfb wants that all the display devices have a driver,
otherwise omapfb refuses to start. There's no real requirement to act
like that, and this patch will make omapfb give a warning and skip that
device.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index e5a64b3..cd2cae8e 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2373,9 +2373,10 @@ static int omapfb_probe(struct platform_device *pdev)
 		omap_dss_get_device(dssdev);
 
 		if (!dssdev->driver) {
-			dev_err(&pdev->dev, "no driver for display: %s\n",
+			dev_warn(&pdev->dev, "no driver for display: %s\n",
 				dssdev->name);
-			r = -ENODEV;
+			omap_dss_put_device(dssdev);
+			continue;
 		}
 
 		d = &fbdev->displays[fbdev->num_displays++];
-- 
1.7.4.1

