From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] I2C: Fix twl4030 timeouts on omap3430
Date: Fri, 28 Mar 2008 10:41:39 +0200
Message-ID: <20080328084139.GJ24896@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5I6of5zJg18YgZEa"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:52451 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbYC1Ill (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 04:41:41 -0400
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-02-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1JfA9b-000K4W-V4
	for linux-omap@vger.kernel.org; Fri, 28 Mar 2008 08:41:40 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

This helps with the annoying I2C timeouts. Does anybody have an idea
why the twl4030 chip does not like doing multiple transfers in a row?

To me the only difference seems to be that clocks are idled between
writing the twl4030 register and reading the register value.

Regards,

Tony

--5I6of5zJg18YgZEa
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="i2c-twl4030-timeout.patch"

>From 25c4c8f449819cb6f40b59ed1a9b25ebcc7cd72e Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 27 Mar 2008 19:05:30 +0200
Subject: [PATCH] I2C: Fix twl4030 timeouts on omap3430

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
 

--5I6of5zJg18YgZEa--
