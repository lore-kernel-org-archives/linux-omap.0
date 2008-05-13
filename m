From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/4] I2C: TSL2563: Add i2c_device_id
Date: Tue, 13 May 2008 15:22:07 +0300
Message-ID: <1210681330-1442-2-git-send-email-felipe.balbi@nokia.com>
References: <1210681330-1442-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34020 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbYEMMXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 08:23:20 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DCNDLX020865
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 07:23:16 -0500
In-Reply-To: <1210681330-1442-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Add i2c_device_id to tsl2563.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/tsl2563.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/tsl2563.c b/drivers/i2c/chips/tsl2563.c
index cf2e313..b39b65c 100644
--- a/drivers/i2c/chips/tsl2563.c
+++ b/drivers/i2c/chips/tsl2563.c
@@ -595,7 +595,8 @@ static void tsl2563_unregister_sysfs(struct i2c_client *client)
 /*--------------------------------------------------------------*/
 static struct i2c_driver tsl2563_i2c_driver;
 
-static int tsl2563_probe(struct i2c_client *client)
+static int tsl2563_probe(struct i2c_client *client,
+		const struct i2c_device_id *device_id)
 {
 	struct tsl2563_chip *chip;
 	int err = 0;
@@ -703,6 +704,12 @@ out:
 	return ret;
 }
 
+static const struct i2c_device_id tsl2563_id[] = {
+	{ DRIVER_NAME, 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, tsl2563_id);
+
 static struct i2c_driver tsl2563_i2c_driver = {
 	.driver = {
 		.name	 = DRIVER_NAME,
-- 
1.5.5.1.125.gc697a

