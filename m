From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] I2C: Fix twl4030 timeouts on omap3430
Date: Fri, 28 Mar 2008 13:46:39 +0200
Message-ID: <1206704800-6768-5-git-send-email-tony@atomide.com>
References: <1206704800-6768-1-git-send-email-tony@atomide.com>
 <1206704800-6768-2-git-send-email-tony@atomide.com>
 <1206704800-6768-3-git-send-email-tony@atomide.com>
 <1206704800-6768-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64627 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbYC1Lqz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 07:46:55 -0400
In-Reply-To: <1206704800-6768-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

For some reason doing a twl4030 write-read cycle can hang the I2C bus
on omap3430. And doing the write and read separately in twl4030_i2c_read()
seems to fix the problem...

Not intended for applying, just a temporary workaround.

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index ded86e7..62868b0 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -327,6 +327,7 @@ int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8 num_bytes)
 		return -EPERM;
 	}
 	mutex_lock(&twl->xfer_lock);
+
 	/* [MSG1] fill the register address data */
 	msg = &twl->xfer_msg[0];
 	msg->addr = twl->address;
@@ -334,18 +335,25 @@ int twl4030_i2c_read(u8 mod_no, u8 * value, u8 reg, u8 num_bytes)
 	msg->flags = 0;	/* Read the register value */
 	val = twl4030_map[mod_no].base + reg;
 	msg->buf = &val;
+	ret = i2c_transfer(twl->client.adapter, twl->xfer_msg, 1);
+	if (ret < 0)
+		goto out;
+ 
 	/* [MSG2] fill the data rx buffer */
 	msg = &twl->xfer_msg[1];
 	msg->addr = twl->address;
 	msg->flags = I2C_M_RD;	/* Read the register value */
 	msg->len = num_bytes;	/* only n bytes */
 	msg->buf = value;
-	ret = i2c_transfer(twl->client.adapter, twl->xfer_msg, 2);
+	ret = i2c_transfer(twl->client.adapter, twl->xfer_msg, 1);
+
+out:
 	mutex_unlock(&twl->xfer_lock);
 
 	/* i2cTransfer returns num messages.translate it pls.. */
 	if (ret >= 0)
 		ret = 0;
+
 	return ret;
 }
 
