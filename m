From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] I2C: TSL2563, LP5521, TEA5761: Refer to id_table in i2c_driver structures
Date: Thu, 15 May 2008 16:48:08 +0300
Message-ID: <1210859288-15657-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25332 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbYEONrl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 09:47:41 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4FDlXSB028094
	for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 08:47:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Jarkko Nikula <jarkko.nikula@nokia.com>

Continue following commits since otherwise probe functions are not called.

11f26b681796e5f40d83321ea66e6fafa8f121d7
5744c1ebdd713c68fc3f1a93942d2baa8d139e79
0b80905e9c1f81085069c502662ba122437d6a7c

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/i2c/chips/lp5521.c          |    1 +
 drivers/i2c/chips/tsl2563.c         |    1 +
 drivers/media/radio/radio-tea5761.c |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/lp5521.c b/drivers/i2c/chips/lp5521.c
index 254d555..32664c0 100644
--- a/drivers/i2c/chips/lp5521.c
+++ b/drivers/i2c/chips/lp5521.c
@@ -564,6 +564,7 @@ static struct i2c_driver lp5521_driver = {
 	},
 	.probe		= lp5521_probe,
 	.remove		= __devexit_p(lp5521_remove),
+	.id_table	= lp5521_id,
 };
 
 static int __init lp5521_init(void)
diff --git a/drivers/i2c/chips/tsl2563.c b/drivers/i2c/chips/tsl2563.c
index bc58106..ddca5e3 100644
--- a/drivers/i2c/chips/tsl2563.c
+++ b/drivers/i2c/chips/tsl2563.c
@@ -718,6 +718,7 @@ static struct i2c_driver tsl2563_i2c_driver = {
 	.resume		= tsl2563_resume,
 	.probe		= tsl2563_probe,
 	.remove		= __devexit_p(tsl2563_remove),
+	.id_table	= tsl2563_id,
 };
 
 static int __init tsl2563_init(void)
diff --git a/drivers/media/radio/radio-tea5761.c b/drivers/media/radio/radio-tea5761.c
index 34fcd3a..e8ccf29 100644
--- a/drivers/media/radio/radio-tea5761.c
+++ b/drivers/media/radio/radio-tea5761.c
@@ -485,6 +485,7 @@ static struct i2c_driver tea5761_driver = {
 	},
 	.probe	= tea5761_i2c_driver_probe,
 	.remove = __devexit_p(tea5761_i2c_driver_remove),
+	.id_table = tea5761_id,
 };
 
 static int __init tea5761_init(void)
-- 
1.5.5.1

