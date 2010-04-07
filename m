From: felipe.balbi@nokia.com
Subject: [RFC PATCH 09/37] cbus: fix a resource leakage
Date: Wed,  7 Apr 2010 19:04:00 +0300
Message-ID: <1270656268-7034-10-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42744 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932825Ab0DGQFT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:19 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G598w030675
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:16 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

sel_gpio was never freed on previous code, free it.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 06ab81f..c219d54 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -198,6 +198,7 @@ static void __exit cbus_bus_remove(struct platform_device *pdev)
 {
 	struct cbus_host	*chost = platform_get_drvdata(pdev);
 
+	gpio_free(chost->sel_gpio);
 	gpio_free(chost->dat_gpio);
 	gpio_free(chost->clk_gpio);
 
-- 
1.7.0.rc0.33.g7c3932

