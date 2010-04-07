From: felipe.balbi@nokia.com
Subject: [RFC PATCH 02/37] cbus: NULL global variable on exit
Date: Wed,  7 Apr 2010 19:03:53 +0300
Message-ID: <1270656268-7034-3-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62299 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758049Ab0DGQEp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:04:45 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G4hCj006792
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 11:04:44 -0500
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

just to be sure, let's set it to NULL.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index c0b4248..f454e77 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -279,7 +279,9 @@ static void __exit cbus_bus_remove(struct platform_device *pdev)
 
 	gpio_free(chost->dat_gpio);
 	gpio_free(chost->clk_gpio);
+
 	kfree(chost);
+	cbus_host = NULL;
 }
 
 static struct platform_driver cbus_driver = {
-- 
1.7.0.rc0.33.g7c3932

