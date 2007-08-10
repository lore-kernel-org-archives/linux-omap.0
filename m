From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH] MENELAUS: Remove unnecessary pr_err definition
Date: Fri, 10 Aug 2007 08:01:51 -0400
Message-ID: <11867473111943-git-send-email-felipe.lima@indt.org.br>
References: <20070810100130.GQ8658@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070810100130.GQ8658@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Instead of defining a pr_err() macro, we can use dev_err() macro.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 drivers/i2c/chips/menelaus.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/chips/menelaus.c b/drivers/i2c/chips/menelaus.c
index 48a7e2f..1c4d8ab 100644
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/menelaus.c
@@ -1,4 +1,3 @@
-#define DEBUG
 /*
  * Copyright (C) 2004 Texas Instruments, Inc.
  *
@@ -50,8 +49,6 @@
 
 #define DRIVER_NAME			"menelaus"
 
-#define pr_err(fmt, arg...)	printk(KERN_ERR DRIVER_NAME ": ", ## arg);
-
 #define MENELAUS_I2C_ADDRESS		0x72
 
 #define MENELAUS_REV			0x01
@@ -156,7 +153,7 @@ static int menelaus_write_reg(int reg, u8 value)
 	int val = i2c_smbus_write_byte_data(the_menelaus->client, reg, value);
 
 	if (val < 0) {
-		pr_err("write error");
+		dev_err(&the_menelaus->client->dev, "write error");
 		return val;
 	}
 
@@ -168,7 +165,7 @@ static int menelaus_read_reg(int reg)
 	int val = i2c_smbus_read_byte_data(the_menelaus->client, reg);
 
 	if (val < 0)
-		pr_err("read error");
+		dev_err(&the_menelaus->client->dev, "read error");
 
 	return val;
 }
@@ -1178,7 +1175,7 @@ static int menelaus_probe(struct i2c_client *client)
 	/* If a true probe check the device */
 	rev = menelaus_read_reg(MENELAUS_REV);
 	if (rev < 0) {
-		pr_err("device not found");
+		dev_err(&client->dev, "device not found");
 		err = -ENODEV;
 		goto fail1;
 	}
@@ -1207,7 +1204,7 @@ static int menelaus_probe(struct i2c_client *client)
 	mutex_init(&menelaus->lock);
 	INIT_WORK(&menelaus->work, menelaus_work);
 
-	pr_info("Menelaus rev %d.%d\n", rev >> 4, rev & 0x0f);
+	dev_info(&client->dev, "Menelaus rev %d.%d\n", rev >> 4, rev & 0x0f);
 
 	val = menelaus_read_reg(MENELAUS_VCORE_CTRL1);
 	if (val < 0)
@@ -1259,7 +1256,7 @@ static int __init menelaus_init(void)
 
 	res = i2c_add_driver(&menelaus_i2c_driver);
 	if (res < 0) {
-		pr_err("driver registration failed\n");
+		dev_err(&the_menelaus->client->dev, "driver registration failed\n");
 		return res;
 	}
 
-- 
1.5.3.rc4.24.g5b56a
