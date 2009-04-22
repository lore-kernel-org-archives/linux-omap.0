From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] TWL4030: add function to send PB messages
Date: Wed, 22 Apr 2009 16:43:52 +0300
Message-ID: <1240407833-28060-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35834 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbZDVNoX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 09:44:23 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3MDi6pR004790
	for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 16:44:17 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch moves sending of powerbus messages to a separate function. It also
makes sure I2C access to the powerbus is enabled.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 drivers/regulator/twl4030-regulator.c |   72 +++++++++++++++++++++++++++++---
 1 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/twl4030-regulator.c b/drivers/regulator/twl4030-regulator.c
index 472c35a..df9a94b 100644
--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl4030-regulator.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/delay.h>
 
 
 /*
@@ -81,6 +82,69 @@ twl4030reg_write(struct twlreg_info *info, unsigned offset, u8 value)
 			value, info->base + offset);
 }
 
+static int twl4030_wait_pb_ready(void)
+{
+
+	u8 pb_status;
+	int status, timeout = 10;
+
+	do {
+		status = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER,
+						&pb_status, 0x14);
+		if (status < 0)
+			return status;
+
+		if (!(pb_status & 1))
+			return 0;
+
+		mdelay(1);
+		timeout--;
+
+	} while (timeout);
+
+	return -ETIMEDOUT;
+}
+
+static int twl4030_send_pb_msg(unsigned msg)
+{
+
+	u8 pb_state;
+	int status;
+
+	/* save powerbus configuration */
+	status = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER,
+					&pb_state, 0x14);
+	if (status < 0)
+		return status;
+
+	/* Enable I2C access to powerbus */
+	status = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER,
+					pb_state | (1<<1));
+	if (status < 0)
+		return status;
+
+	status = twl4030_wait_pb_ready();
+	if (status < 0)
+		return status;
+
+	status = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, msg >> 8,
+			0x15 /* PB_WORD_MSB */);
+	if (status < 0)
+		return status;
+
+	status = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, msg & 0xff,
+			0x16 /* PB_WORD_LSB */);
+	if (status < 0)
+		return status;
+
+	status = twl4030_wait_pb_ready();
+	if (status < 0)
+		return status;
+
+	/* Restore powerbus configuration */
+	return twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, pb_state, 0x14);
+}
+
 /*----------------------------------------------------------------------*/
 
 /* generic power resource operations, which work on all regulators */
@@ -177,13 +241,7 @@ static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
 	if (!(status & (P3_GRP | P2_GRP | P1_GRP)))
 		return -EACCES;
 
-	status = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER,
-			message >> 8, 0x15 /* PB_WORD_MSB */ );
-	if (status >= 0)
-		return status;
-
-	return twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER,
-			message, 0x16 /* PB_WORD_LSB */ );
+	return twl4030_send_pb_msg(message);
 }
 
 /*----------------------------------------------------------------------*/
-- 
1.5.6.3

