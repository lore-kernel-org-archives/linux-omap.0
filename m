From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RFC/PATCH 1/3] i2c: Add SCCB support
Date: Tue, 26 Jun 2012 16:17:07 +0200
Message-ID: <1340720229-30356-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:41561 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757243Ab2FZORJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 10:17:09 -0400
In-Reply-To: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

SCCB is a serial communication bus developed by Omnivision. Its 2-wire
mode is very similar to SMBus byte data transactions, but requires the
controller to ignore the ACK bit and to insert a stop condition after
each message.

Add a device SCCB flag and a message stop flag to be passed to
controller drivers.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/i2c/i2c-core.c |   13 ++++++++++++-
 include/linux/i2c.h    |    2 ++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index feb7dc3..8cfa660 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1939,6 +1939,12 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 	u8 partial_pec = 0;
 	int status;
 
+	if (unlikely(flags & I2C_CLIENT_SCCB) && size != I2C_SMBUS_BYTE_DATA) {
+		dev_err(&adapter->dev,
+			"SCCB devices only support I2C_SMBUS_BYTE_DATA\n");
+		return -EINVAL;
+	}
+
 	msgbuf0[0] = command;
 	switch (size) {
 	case I2C_SMBUS_QUICK:
@@ -1956,6 +1962,11 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 		}
 		break;
 	case I2C_SMBUS_BYTE_DATA:
+		if (unlikely(flags & I2C_CLIENT_SCCB)) {
+			msg[0].flags |= I2C_M_IGNORE_NAK | I2C_M_STOP;
+			msg[1].flags |= I2C_M_IGNORE_NAK | I2C_M_STOP;
+		}
+
 		if (read_write == I2C_SMBUS_READ)
 			msg[1].len = 1;
 		else {
@@ -2105,7 +2116,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
 	int try;
 	s32 res;
 
-	flags &= I2C_M_TEN | I2C_CLIENT_PEC;
+	flags &= I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB;
 
 	if (adapter->algo->smbus_xfer) {
 		i2c_lock_adapter(adapter);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 195d8b3..bd42914 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -420,6 +420,7 @@ void i2c_lock_adapter(struct i2c_adapter *);
 void i2c_unlock_adapter(struct i2c_adapter *);
 
 /*flags for the client struct: */
+#define I2C_CLIENT_SCCB	0x02		/* Use Omnivision SCCB protocol */
 #define I2C_CLIENT_PEC	0x04		/* Use Packet Error Checking */
 #define I2C_CLIENT_TEN	0x10		/* we have a ten bit chip address */
 					/* Must equal I2C_M_TEN below */
@@ -540,6 +541,7 @@ struct i2c_msg {
 	__u16 flags;
 #define I2C_M_TEN		0x0010	/* this is a ten bit chip address */
 #define I2C_M_RD		0x0001	/* read data, from slave to master */
+#define I2C_M_STOP		0x8000	/* if I2C_FUNC_PROTOCOL_MANGLING */
 #define I2C_M_NOSTART		0x4000	/* if I2C_FUNC_PROTOCOL_MANGLING */
 #define I2C_M_REV_DIR_ADDR	0x2000	/* if I2C_FUNC_PROTOCOL_MANGLING */
 #define I2C_M_IGNORE_NAK	0x1000	/* if I2C_FUNC_PROTOCOL_MANGLING */
-- 
1.7.3.4

