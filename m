From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 07/13] rtc: rtc-twl: Add DT support for RTC inside twl4030/twl6030
Date: Mon, 26 Sep 2011 18:50:15 +0200
Message-ID: <1317055821-20652-8-git-send-email-b-cousson@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49871 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab1IZQvO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 12:51:14 -0400
In-Reply-To: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Add the DT support for the TI rtc-twl present in the twl4030
and twl6030 devices.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Alessandro Zummo <a.zummo@towertech.it>
---
 Documentation/devicetree/bindings/rtc/twl-rtc.txt |   12 ++++++++++++
 drivers/rtc/rtc-twl.c                             |   10 ++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/twl-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/twl-rtc.txt b/Documentation/devicetree/bindings/rtc/twl-rtc.txt
new file mode 100644
index 0000000..596e0c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/twl-rtc.txt
@@ -0,0 +1,12 @@
+* TI twl RTC
+
+The TWL family (twl4030/6030) contains a RTC.
+
+Required properties:
+- compatible : Should be twl4030-rtc
+
+Examples:
+
+rtc@0 {
+    compatible = "ti,twl4030-rtc";
+};
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 20687d5..d43b4f6 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -550,6 +550,11 @@ static int twl_rtc_resume(struct platform_device *pdev)
 #define twl_rtc_resume  NULL
 #endif
 
+static const struct of_device_id twl_rtc_of_match[] = {
+	{.compatible = "ti,twl4030-rtc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, twl_rtc_of_match);
 MODULE_ALIAS("platform:twl_rtc");
 
 static struct platform_driver twl4030rtc_driver = {
@@ -559,8 +564,9 @@ static struct platform_driver twl4030rtc_driver = {
 	.suspend	= twl_rtc_suspend,
 	.resume		= twl_rtc_resume,
 	.driver		= {
-		.owner	= THIS_MODULE,
-		.name	= "twl_rtc",
+		.owner		= THIS_MODULE,
+		.name		= "twl_rtc",
+		.of_match_table = twl_rtc_of_match,
 	},
 };
 
-- 
1.7.0.4

