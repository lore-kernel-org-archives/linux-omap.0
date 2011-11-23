From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/6] cbus: fix very old compile warning
Date: Wed, 23 Nov 2011 16:00:45 +0200
Message-ID: <1322056848-1188-4-git-send-email-balbi@ti.com>
References: <1322056848-1188-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40161 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755408Ab1KWOA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 09:00:57 -0500
Received: by mail-gx0-f170.google.com with SMTP id k1so2794745ggn.1
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 06:00:56 -0800 (PST)
In-Reply-To: <1322056848-1188-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

platform_driver.remove returns an 'int'.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/cbus.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index c7ed881..45b01fd 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -296,7 +296,7 @@ exit1:
 	return ret;
 }
 
-static void __devexit cbus_bus_remove(struct platform_device *pdev)
+static int __devexit cbus_bus_remove(struct platform_device *pdev)
 {
 	struct cbus_host	*chost = platform_get_drvdata(pdev);
 
@@ -305,6 +305,8 @@ static void __devexit cbus_bus_remove(struct platform_device *pdev)
 	gpio_free(chost->clk_gpio);
 
 	kfree(chost);
+
+	return 0;
 }
 
 static struct platform_driver cbus_driver = {
-- 
1.7.8.rc3

