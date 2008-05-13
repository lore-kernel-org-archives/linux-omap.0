From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/4] I2C: LP5521: Add i2c_device_id
Date: Tue, 13 May 2008 15:22:08 +0300
Message-ID: <1210681330-1442-3-git-send-email-felipe.balbi@nokia.com>
References: <1210681330-1442-1-git-send-email-felipe.balbi@nokia.com>
 <1210681330-1442-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52389 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbYEMMXT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 08:23:19 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DCN7PE006748
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 15:23:17 +0300
In-Reply-To: <1210681330-1442-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Add i2c_device_id to lp5521 driver.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/lp5521.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/lp5521.c b/drivers/i2c/chips/lp5521.c
index d1803a9..4d869f9 100644
--- a/drivers/i2c/chips/lp5521.c
+++ b/drivers/i2c/chips/lp5521.c
@@ -503,7 +503,8 @@ static int lp5521_set_mode(struct lp5521_chip *chip, char *mode)
 /*--------------------------------------------------------------*/
 static struct i2c_driver lp5521_driver;
 
-static int lp5521_probe(struct i2c_client *client)
+static int lp5521_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
 {
 	struct lp5521_chip *chip;
 	int ret = 0;
@@ -551,6 +552,12 @@ static int lp5521_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id lp5521_id[] = {
+	{ LP5521_DRIVER_NAME, 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, lp5521_id);
+
 static struct i2c_driver lp5521_driver = {
 	.driver = {
 		.name	= LP5521_DRIVER_NAME,
-- 
1.5.5.1.125.gc697a

