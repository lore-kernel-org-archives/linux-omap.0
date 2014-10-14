From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/3] video: fbdev: omap2: omapfb: remove __exit annotation
Date: Tue, 14 Oct 2014 13:28:53 -0500
Message-ID: <1413311335-25083-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38642 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbaJNS3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2014 14:29:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>, Felipe Balbi <balbi@ti.com>

if we leave __exit annotation, driver can't be unbound
through sysfs.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index ec2d132..9cbf1ce 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -2619,7 +2619,7 @@ err0:
 	return r;
 }
 
-static int __exit omapfb_remove(struct platform_device *pdev)
+static int omapfb_remove(struct platform_device *pdev)
 {
 	struct omapfb2_device *fbdev = platform_get_drvdata(pdev);
 
@@ -2636,7 +2636,7 @@ static int __exit omapfb_remove(struct platform_device *pdev)
 
 static struct platform_driver omapfb_driver = {
 	.probe		= omapfb_probe,
-	.remove         = __exit_p(omapfb_remove),
+	.remove         = omapfb_remove,
 	.driver         = {
 		.name   = "omapfb",
 		.owner  = THIS_MODULE,
-- 
2.1.0.GIT

