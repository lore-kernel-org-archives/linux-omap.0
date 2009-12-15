From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rft/rfc/patch-2.6.32-omap1+ 3/6] cbus: checkpatch.pl fix on cbus.c
Date: Wed, 16 Dec 2009 01:44:10 +0200
Message-ID: <1260920653-18503-4-git-send-email-felipe.balbi@nokia.com>
References: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19864 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756413AbZLOXpQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 18:45:16 -0500
In-Reply-To: <1260920653-18503-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

make checkpatch.pl (almost) happy.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/cbus.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index f454e77..e1be8c7 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -136,7 +136,7 @@ static u8 _cbus_receive_bit(struct cbus_host *host)
 	return ret;
 }
 
-#define cbus_send_bit(host, base, bit, set_to_input) _cbus_send_bit(host, bit, set_to_input)
+#define cbus_send_bit(h, b, bit, i) _cbus_send_bit(h, bit, i)
 #define cbus_receive_bit(host, base) _cbus_receive_bit(host)
 
 #endif
@@ -232,7 +232,7 @@ static int __init cbus_bus_probe(struct platform_device *pdev)
 	struct cbus_host_platform_data *pdata = pdev->dev.platform_data;
 	int ret;
 
-	chost = kzalloc(sizeof (*chost), GFP_KERNEL);
+	chost = kzalloc(sizeof(*chost), GFP_KERNEL);
 	if (chost == NULL)
 		return -ENOMEM;
 
@@ -242,13 +242,16 @@ static int __init cbus_bus_probe(struct platform_device *pdev)
 	chost->dat_gpio = pdata->dat_gpio;
 	chost->sel_gpio = pdata->sel_gpio;
 
-	if ((ret = gpio_request(chost->clk_gpio, "CBUS clk")) < 0)
+	ret = gpio_request(chost->clk_gpio, "CBUS clk");
+	if (ret < 0)
 		goto exit1;
 
-	if ((ret = gpio_request(chost->dat_gpio, "CBUS data")) < 0)
+	ret = gpio_request(chost->dat_gpio, "CBUS data");
+	if (ret < 0)
 		goto exit2;
 
-	if ((ret = gpio_request(chost->sel_gpio, "CBUS sel")) < 0)
+	ret = gpio_request(chost->sel_gpio, "CBUS sel");
+	if (ret < 0)
 		goto exit3;
 
 	gpio_direction_output(chost->clk_gpio, 0);
-- 
1.6.6.rc0

