From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 3/7] I2C: TWL4030: General cleanup in twl4030-core.c
Date: Wed, 19 Mar 2008 15:42:31 +0200
Message-ID: <1205934155-24070-4-git-send-email-felipe.balbi@nokia.com>
References: <1205934155-24070-1-git-send-email-felipe.balbi@nokia.com>
 <1205934155-24070-2-git-send-email-felipe.balbi@nokia.com>
 <1205934155-24070-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-fb01.nokia.com ([192.100.122.235]:48582 "EHLO
	mgw-fb01.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765839AbYCSURh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 16:17:37 -0400
Received: from mgw-mx09.nokia.com ([192.100.105.134])
	by mgw-fb01.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2JEGQ1P029633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 16:16:28 +0200
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2JDhsR6031069
	for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 08:46:44 -0500
In-Reply-To: <1205934155-24070-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

General cleanup in twl4030-core.c

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c |   78 ++++++++++++++++++++------------------
 1 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 4f0f465..c979241 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -32,6 +32,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
 #include <linux/time.h>
+#include <linux/mutex.h>
 #include <linux/interrupt.h>
 #include <linux/random.h>
 #include <linux/syscalls.h>
@@ -158,7 +159,7 @@ struct twl4030_client {
 	struct i2c_msg xfer_msg[2];
 
 	/* To lock access to xfer_msg */
-	struct semaphore xfer_lock;
+	struct mutex xfer_lock;
 };
 
 /* Module Mapping */
@@ -218,7 +219,10 @@ static struct twl4030_client twl4030_modules[TWL4030_NUM_SLAVES] = {
 
 /* One Client Driver , 4 Clients */
 static struct i2c_driver twl4030_driver = {
-	.driver.name	= "TWL4030 I2C",
+	.driver	= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
 	.attach_adapter	= twl4030_attach_adapter,
 	.detach_client	= twl4030_detach_client,
 };
@@ -256,7 +260,7 @@ int twl4030_i2c_write(u8 mod_no, u8 * value, u8 reg, u8 num_bytes)
 {
 	int ret;
 	int sid;
-	struct twl4030_client *client;
+	struct twl4030_client *twl;
 	struct i2c_msg *msg;
 
 	if (unlikely(mod_no > TWL4030_MODULE_LAST)) {
@@ -264,27 +268,27 @@ int twl4030_i2c_write(u8 mod_no, u8 * value, u8 reg, u8 num_bytes)
 		return -EPERM;
 	}
 	sid = twl4030_map[mod_no].sid;
-	client = &(twl4030_modules[sid]);
+	twl = &twl4030_modules[sid];
 
-	if (unlikely(client->inuse != TWL_CLIENT_USED)) {
+	if (unlikely(twl->inuse != TWL_CLIENT_USED)) {
 		pr_err("I2C Client[%d] is not initialized[%d]\n",
 		       sid, __LINE__);
 		return -EPERM;
 	}
-	down(&(client->xfer_lock));
+	mutex_lock(&twl->xfer_lock);
 	/*
 	 * [MSG1]: fill the register address data
 	 * fill the data Tx buffer
 	 */
-	msg = &(client->xfer_msg[0]);
-	msg->addr = client->address;
+	msg = &twl->xfer_msg[0];
+	msg->addr = twl->address;
 	msg->len = num_bytes + 1;
 	msg->flags = 0;
 	msg->buf = value;
 	/* over write the first byte of buffer with the register address */
 	*value = twl4030_map[mod_no].base + reg;
-	ret = i2c_transfer(client->client.adapter, client->xfer_msg, 1);
-	up(&(client->xfer_lock));
+	ret = i2c_transfer(twl->client.adapter, twl->xfer_msg, 1);
+	mutex_unlock(&twl->xfer_lock);
 
 	/* i2cTransfer returns num messages.translate it pls.. */
 	if (ret >= 0)
@@ -307,7 +311,7 @@ int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8 num_bytes)
 	int ret;
 	u8 val;
 	int sid;
-	struct twl4030_client *client;
+	struct twl4030_client *twl;
 	struct i2c_msg *msg;
 
 	if (unlikely(mod_no > TWL4030_MODULE_LAST)) {
@@ -315,29 +319,29 @@ int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8 num_bytes)
 		return -EPERM;
 	}
 	sid = twl4030_map[mod_no].sid;
-	client = &(twl4030_modules[sid]);
+	twl = &twl4030_modules[sid];
 
-	if (unlikely(client->inuse != TWL_CLIENT_USED)) {
+	if (unlikely(twl->inuse != TWL_CLIENT_USED)) {
 		pr_err("I2C Client[%d] is not initialized[%d]\n", sid,
 		       __LINE__);
 		return -EPERM;
 	}
-	down(&(client->xfer_lock));
+	mutex_lock(&twl->xfer_lock);
 	/* [MSG1] fill the register address data */
-	msg = &(client->xfer_msg[0]);
-	msg->addr = client->address;
+	msg = &twl->xfer_msg[0];
+	msg->addr = twl->address;
 	msg->len = 1;
 	msg->flags = 0;	/* Read the register value */
 	val = twl4030_map[mod_no].base + reg;
 	msg->buf = &val;
 	/* [MSG2] fill the data rx buffer */
-	msg = &(client->xfer_msg[1]);
-	msg->addr = client->address;
+	msg = &twl->xfer_msg[1];
+	msg->addr = twl->address;
 	msg->flags = I2C_M_RD;	/* Read the register value */
 	msg->len = num_bytes;	/* only n bytes */
 	msg->buf = value;
-	ret = i2c_transfer(client->client.adapter, client->xfer_msg, 2);
-	up(&(client->xfer_lock));
+	ret = i2c_transfer(twl->client.adapter, twl->xfer_msg, 2);
+	mutex_unlock(&twl->xfer_lock);
 
 	/* i2cTransfer returns num messages.translate it pls.. */
 	if (ret >= 0)
@@ -530,7 +534,7 @@ static void do_twl4030_irq(unsigned int irq, irq_desc_t *desc)
 static int twl4030_detect_client(struct i2c_adapter *adapter, unsigned char sid)
 {
 	int err = 0;
-	struct twl4030_client *client;
+	struct twl4030_client *twl;
 
 	if (unlikely(sid >= TWL4030_NUM_SLAVES)) {
 		pr_err("sid[%d] > MOD_LAST[%d]\n", sid, TWL4030_NUM_SLAVES);
@@ -543,30 +547,30 @@ static int twl4030_detect_client(struct i2c_adapter *adapter, unsigned char sid)
 		pr_err("SlaveID=%d functionality check failed\n", sid);
 		return err;
 	}
-	client = &(twl4030_modules[sid]);
-	if (unlikely(client->inuse)) {
-		pr_err("Client %s is already in use\n", client->client_name);
+	twl = &twl4030_modules[sid];
+	if (unlikely(twl->inuse)) {
+		pr_err("Client %s is already in use\n", twl->client_name);
 		return -EPERM;
 	}
 
-	memset(&(client->client), 0, sizeof(struct i2c_client));
+	memset(&twl->client, 0, sizeof(struct i2c_client));
 
-	client->client.addr	= client->address;
-	client->client.adapter	= adapter;
-	client->client.driver	= &twl4030_driver;
+	twl->client.addr	= twl->address;
+	twl->client.adapter	= adapter;
+	twl->client.driver	= &twl4030_driver;
 
-	memcpy(&(client->client.name), client->client_name,
+	memcpy(&twl->client.name, twl->client_name,
 			sizeof(TWL_CLIENT_STRING) + 1);
 
 	pr_info("TWL4030: TRY attach Slave %s on Adapter %s [%x]\n",
-				client->client_name, adapter->name, err);
+				twl->client_name, adapter->name, err);
 
-	if ((err = i2c_attach_client(&(client->client)))) {
+	if ((err = i2c_attach_client(&twl->client))) {
 		pr_err("Couldn't attach Slave %s on Adapter"
-		       "%s [%x]\n", client->client_name, adapter->name, err);
+		       "%s [%x]\n", twl->client_name, adapter->name, err);
 	} else {
-		client->inuse = TWL_CLIENT_USED;
-		init_MUTEX(&client->xfer_lock);
+		twl->inuse = TWL_CLIENT_USED;
+		mutex_init(&twl->xfer_lock);
 	}
 
 	return err;
@@ -607,17 +611,17 @@ free_client:
 	while (i >= 0) {
 		/* now remove all those from the current adapter... */
 		if (twl4030_modules[i].adapter_index == twl_i2c_adapter)
-			(void)twl4030_detach_client(&(twl4030_modules[i].client));
+			(void)twl4030_detach_client(&twl4030_modules[i].client);
 		i--;
 	}
 	return ret;
 }
 
 /* adapter's callback */
-static int twl4030_detach_client(struct i2c_client *iclient)
+static int twl4030_detach_client(struct i2c_client *client)
 {
 	int err;
-	if ((err = i2c_detach_client(iclient))) {
+	if ((err = i2c_detach_client(client))) {
 		pr_err("Client detach failed\n");
 		return err;
 	}
-- 
1.5.5.rc0.16.g02b00

