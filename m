From: "Pais, Allen" <allen.pais@ti.com>
Subject: [PATCH 1/2] omap: Disable GAIA I2C1/I2C4 internal pull-ups
Date: Thu, 21 Jan 2010 16:03:16 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026B4CBDEA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56834 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674Ab0AUKdU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 05:33:20 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0LAXHcs001346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 21 Jan 2010 04:33:20 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o0LAXHQo025806
	for <linux-omap@vger.kernel.org>; Thu, 21 Jan 2010 16:03:17 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 4044fcc9c517e86fbea9f7d3b15d5cf75a767476 Mon Sep 17 00:00:00 2001
From: Allen Pais <allen.pais@ti.com>
Date: Thu, 21 Jan 2010 21:00:04 +0530
Subject: [PATCH 1/2] omap: Disable GAIA I2C1/I2C4 internal pull-ups

This patch disables GAIA I2C1 adn I2C4(SR) internal pull-up, to
use only the external HW resistor >=470 Ohm for the assured
functionality in HS mode.

While testing the I2C in High Speed mode, it was discovered that
without a proper pull-up resistor, there is data corruption during
multi-byte transfer. RTC(time_set) test case was used for testing.

>From the analysis done, it was concluded that ideally we need a
pull-up of 1.6k Ohm(recomended) or atleast 470 Ohm or greater for
assured performance in HS mode.

Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
Signed-off-by: Allen Pais <allen.pais@ti.com>
---
 drivers/mfd/twl-core.c  |   10 ++++++++++
 include/linux/i2c/twl.h |   13 +++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 2a76065..7dcb5e9 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -965,6 +965,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int				status;
 	unsigned			i;
 	struct twl4030_platform_data	*pdata = client->dev.platform_data;
+	u8 temp;
 
 	if (!pdata) {
 		dev_dbg(&client->dev, "no platform data?\n");
@@ -1031,6 +1032,15 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (status < 0)
 			goto fail;
 	}
+	/* Disable GAIA I2C Pull-up on I2C1 and I2C4(SR) interface
+	 * program I2C_SCL_CTRL_PU(bit 0)=0, I2C_SDA_CTRL_PU (bit 2)=0,
+	 * SR_I2C_SCL_CTRL_PU(bit 4)=0 and SR_I2C_SDA_CTRL_PU(bit 6)=0.
+	 */
+
+	twl_i2c_read_u8(TWL4030_MODULE_INTBR, &temp, REG_GPPUPDCTR1);
+	temp &= ~(SR_I2C_SDA_CTRL_PU | SR_I2C_SCL_CTRL_PU | \
+				I2C_SDA_CTRL_PU | I2C_SCL_CTRL_PU);
+	twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
 
 	status = add_children(pdata, id->driver_data);
 fail:
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index bf1c5be..2f4faf9 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -168,6 +168,19 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
 int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
 
+/*Interface Bit Register (INTBR) offsets
+ *(Use TWL_4030_MODULE_INTBR)
+ */
+
+#define REG_GPPUPDCTR1			0x0F
+
+/*I2C1 and I2C4(SR) SDA/SCL pull-up control bits */
+
+#define I2C_SCL_CTRL_PU			BIT(0)
+#define I2C_SDA_CTRL_PU			BIT(2)
+#define SR_I2C_SCL_CTRL_PU		BIT(4)
+#define SR_I2C_SDA_CTRL_PU		BIT(6)
+
 /*----------------------------------------------------------------------*/
 
 /*
-- 
1.6.3.3
