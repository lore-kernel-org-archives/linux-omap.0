From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rft/rfc/patch-2.6.32-omap1+ 2/6] cbus: NULL global variable on exit
Date: Wed, 16 Dec 2009 01:44:09 +0200
Message-ID: <1260920653-18503-3-git-send-email-felipe.balbi@nokia.com>
References: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19861 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbZLOXpP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 18:45:15 -0500
In-Reply-To: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

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
1.6.6.rc0

