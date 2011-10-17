From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/4] cbus: add of_match_table
Date: Mon, 17 Oct 2011 23:50:40 +0300
Message-ID: <1318884643-4137-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:43202 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753486Ab1JQUus (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Oct 2011 16:50:48 -0400
Received: by mail-bw0-f50.google.com with SMTP id q10so8273067bka.37
        for <linux-omap@vger.kernel.org>; Mon, 17 Oct 2011 13:50:46 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

then we can make DeviceTree conversion happen.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c  |    9 +++++++++
 drivers/cbus/tahvo.c |   10 ++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 35bcb50..464fc0c 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -522,11 +522,20 @@ static int __devexit retu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id retu_match_table[] __devinitconst = {
+	{
+		.compatible = "nokia,retu",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, retu_match);
+
 static struct platform_driver retu_driver = {
 	.probe		= retu_probe,
 	.remove		= __devexit_p(retu_remove),
 	.driver		= {
 		.name	= "retu",
+		.of_match_table = retu_match_table,
 	},
 };
 
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 6119d19..0387721 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -395,11 +395,21 @@ static int __devexit tahvo_remove(struct platform_device *pdev)
 	return 0;
 }
 
+
+static const struct of_device_id tahvo_match_table[] __devinitconst = {
+	{
+		.compatible = "nokia,tahvo",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, tahvo_match);
+
 static struct platform_driver tahvo_driver = {
 	.probe		= tahvo_probe,
 	.remove		= __devexit_p(tahvo_remove),
 	.driver		= {
 		.name	= "tahvo",
+		.of_match_table = tahvo_match_table,
 	},
 };
 
-- 
1.7.7

