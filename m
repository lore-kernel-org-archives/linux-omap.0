From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 3/4] I2C: RADIO: TEA5761: Add i2c_device_id
Date: Tue, 13 May 2008 15:22:09 +0300
Message-ID: <1210681330-1442-4-git-send-email-felipe.balbi@nokia.com>
References: <1210681330-1442-1-git-send-email-felipe.balbi@nokia.com>
 <1210681330-1442-2-git-send-email-felipe.balbi@nokia.com>
 <1210681330-1442-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41397 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409AbYEMMXZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 08:23:25 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DCNIp0012944
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 15:23:23 +0300
In-Reply-To: <1210681330-1442-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Add i2c_device_id to tea5761.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/media/radio/radio-tea5761.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/media/radio/radio-tea5761.c b/drivers/media/radio/radio-tea5761.c
index 0fb0cdc..8a0cf42 100644
--- a/drivers/media/radio/radio-tea5761.c
+++ b/drivers/media/radio/radio-tea5761.c
@@ -413,7 +413,8 @@ static struct video_device tea5761_video_device = {
 	.release       = video_device_release
 };
 
-static int tea5761_i2c_driver_probe(struct i2c_client *client)
+static int tea5761_i2c_driver_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
 {
 	struct video_device *video_dev;
 	int err = 0;
@@ -472,6 +473,12 @@ static int tea5761_i2c_driver_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct i2c_device_id tea5761_id[] = {
+	{ DRIVER_NAME, 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, tea5761_id);
+
 static struct i2c_driver tea5761_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
-- 
1.5.5.1.125.gc697a

