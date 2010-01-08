From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 15/15] OMAP: DSS2: OMAPFB: fix crash when panel driver was not loaded
Date: Fri,  8 Jan 2010 15:22:49 +0200
Message-ID: <1262956969-1664-16-git-send-email-tomi.valkeinen@nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-7-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-8-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-9-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-10-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-11-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-12-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-13-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-14-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-15-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25350 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab0AHNWj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 08:22:39 -0500
In-Reply-To: <1262956969-1664-15-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

If the panel's probe had failed, omapfb would still go on, eventually
crashing.

A better fix would be to handle each display properly, and leaving just
the failed display out. But that is a bigger change.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index e61a75c..d17caef 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2115,6 +2115,11 @@ static int omapfb_probe(struct platform_device *pdev)
 	dssdev = NULL;
 	for_each_dss_dev(dssdev) {
 		omap_dss_get_device(dssdev);
+		if (!dssdev->driver) {
+			dev_err(&pdev->dev, "no driver for display\n");
+			r = -EINVAL;
+			goto cleanup;
+		}
 		fbdev->displays[fbdev->num_displays++] = dssdev;
 	}
 
-- 
1.6.5

