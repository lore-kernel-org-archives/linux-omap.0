From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 3/8] i2c: lp5521: simplify mode setting
Date: Tue, 10 Feb 2009 14:16:00 +0200
Message-ID: <1234268165-23573-4-git-send-email-felipe.balbi@nokia.com>
References: <1234268165-23573-1-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-2-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62448 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbZBJMaY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 07:30:24 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1ACU28f003644
	for <linux-omap@vger.kernel.org>; Tue, 10 Feb 2009 14:30:21 +0200
In-Reply-To: <1234268165-23573-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Avoid using string magic and use integer for comparisson

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/lp5521.c |   52 ++++++++++++++++++++++++++++++++-----------
 1 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/chips/lp5521.c b/drivers/i2c/chips/lp5521.c
index e040c4d..9e94ff8 100644
--- a/drivers/i2c/chips/lp5521.c
+++ b/drivers/i2c/chips/lp5521.c
@@ -46,10 +46,6 @@
 #define LP5521_REG_G_PROG_MEM		0x30
 #define LP5521_REG_B_PROG_MEM		0x50
 
-#define LP5521_MODE_LOAD		"load"
-#define LP5521_MODE_RUN			"run"
-#define LP5521_MODE_DIRECT_CONTROL	"direct"
-
 #define LP5521_CURRENT_1m5		0x0f
 #define LP5521_CURRENT_3m1		0x1f
 #define LP5521_CURRENT_4m7		0x2f
@@ -69,17 +65,23 @@
 
 #define LP5521_PROGRAM_LENGTH		32	/* in bytes */
 
+enum lp5521_mode {
+	LP5521_MODE_LOAD,
+	LP5521_MODE_RUN,
+	LP5521_MODE_DIRECT_CONTROL,
+};
+
 struct lp5521_chip {
 	/* device lock */
 	struct mutex		lock;
 	struct i2c_client	*client;
-	char			*mode;
+	enum lp5521_mode	mode;
 	int			red;
 	int			green;
 	int			blue;
 };
 
-static int lp5521_set_mode(struct lp5521_chip *chip, char *mode);
+static int lp5521_set_mode(struct lp5521_chip *chip, enum lp5521_mode mode);
 
 static inline int lp5521_write(struct i2c_client *client, u8 reg, u8 value)
 {
@@ -313,8 +315,25 @@ static ssize_t show_mode(struct device *dev,
 		char *buf)
 {
 	struct lp5521_chip *chip = dev_get_drvdata(dev);
+	char *mode;
+
+	mutex_lock(&chip->lock);
+	switch (chip->mode) {
+	case LP5521_MODE_RUN:
+		mode = "run";
+		break;
+	case LP5521_MODE_LOAD:
+		mode = "load";
+		break;
+	case LP5521_MODE_DIRECT_CONTROL:
+		mode = "direct";
+		break;
+	default:
+		mode = "undefined";
+	}
+	mutex_unlock(&chip->lock);
 
-	return sprintf(buf, "%s\n", chip->mode);
+	return sprintf(buf, "%s\n", mode);
 }
 
 static ssize_t store_mode(struct device *dev,
@@ -442,23 +461,28 @@ static void lp5521_unregister_sysfs(struct i2c_client *client)
 /*			Set chip operating mode			*/
 /*--------------------------------------------------------------*/
 
-static int lp5521_set_mode(struct lp5521_chip *chip, char *mode)
+static int lp5521_set_mode(struct lp5521_chip *chip, enum lp5521_mode mode)
 {
 	struct i2c_client *client = chip->client ;
 	int ret = 0;
 
 	/* if in that mode already do nothing, except for run */
-	if (!strcmp(mode, chip->mode) && strcmp(mode, LP5521_MODE_RUN))
+	if (chip->mode == mode && mode != LP5521_MODE_RUN)
 		return 0;
 
-	if (!strcmp(mode, LP5521_MODE_RUN))
+	switch (mode) {
+	case LP5521_MODE_RUN:
 		ret = lp5521_run_program(chip);
-
-	if (!strcmp(mode, LP5521_MODE_LOAD))
+		break;
+	case LP5521_MODE_LOAD:
 		ret |= lp5521_write(client, LP5521_REG_OP_MODE, 0x15);
-
-	if (!strcmp(mode, LP5521_MODE_DIRECT_CONTROL))
+		break;
+	case LP5521_MODE_DIRECT_CONTROL:
 		ret |= lp5521_write(client, LP5521_REG_OP_MODE, 0x3F);
+		break;
+	default:
+		dev_dbg(&client->dev, "unsupported mode %d\n", mode);
+	}
 
 	chip->mode = mode;
 
-- 
1.6.1.265.g9a013

