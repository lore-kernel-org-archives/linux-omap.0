From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V4 1/3] rtc: omap: use module_platform_driver
Date: Tue, 28 Oct 2014 15:28:50 +0530
Message-ID: <1414490332-14856-2-git-send-email-lokeshvutla@ti.com>
References: <1414490332-14856-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59470 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754667AbaJ1KAg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Oct 2014 06:00:36 -0400
In-Reply-To: <1414490332-14856-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com, linux-omap@vger.kernel.org
Cc: johan@kernel.org, tony@atomide.com, balbi@ti.com, akpm@linux-foundation.org, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, nm@ti.com, lokeshvutla@ti.com

module_platform_driver_probe() prevents driver from requesting probe deferral.
So using module_platform_drive() to support probe deferral.
And also removing .owner field which is set by module_platform_driver.

Reviewed-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/rtc/rtc-omap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index e74750f..d9bb5e7 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -477,7 +477,7 @@ static const struct of_device_id omap_rtc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, omap_rtc_of_match);
 
-static int __init omap_rtc_probe(struct platform_device *pdev)
+static int omap_rtc_probe(struct platform_device *pdev)
 {
 	struct omap_rtc	*rtc;
 	struct resource	*res;
@@ -708,18 +708,18 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_rtc_driver = {
+	.probe		= omap_rtc_probe,
 	.remove		= __exit_p(omap_rtc_remove),
 	.shutdown	= omap_rtc_shutdown,
 	.driver		= {
 		.name	= "omap_rtc",
-		.owner	= THIS_MODULE,
 		.pm	= &omap_rtc_pm_ops,
 		.of_match_table = omap_rtc_of_match,
 	},
 	.id_table	= omap_rtc_id_table,
 };
 
-module_platform_driver_probe(omap_rtc_driver, omap_rtc_probe);
+module_platform_driver(omap_rtc_driver);
 
 MODULE_ALIAS("platform:omap_rtc");
 MODULE_AUTHOR("George G. Davis (and others)");
-- 
1.9.1

