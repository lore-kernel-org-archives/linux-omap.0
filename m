From: Moiz Sonasath <m-sonasath@ti.com>
Subject: [PATCH 1/2] omap: Disable TWL4030/5030 I2C1/I2C4 internal pull-ups
Date: Tue, 16 Feb 2010 18:57:21 -0600
Message-ID: <1266368241-10459-2-git-send-email-m-sonasath@ti.com>
References: <1266368241-10459-1-git-send-email-m-sonasath@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47366 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933760Ab0BQArB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 19:47:01 -0500
In-Reply-To: <1266368241-10459-1-git-send-email-m-sonasath@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sameo@linux.intel.com, tony@atomide.com, Moiz Sonasath <m-sonasath@ti.com>, Allen Pais <allen.pais@ti.com>

This patch disables TWL4030/5030 I2C1 adn I2C4(SR) internal pull-up, to
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
 drivers/mfd/twl-core.c  |   13 +++++++++++++
 include/linux/i2c/twl.h |   15 +++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 2a76065..35ae2ee 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -965,6 +965,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int				status;
 	unsigned			i;
 	struct twl4030_platform_data	*pdata = client->dev.platform_data;
+	u8 temp;
 
 	if (!pdata) {
 		dev_dbg(&client->dev, "no platform data?\n");
@@ -1032,6 +1033,18 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			goto fail;
 	}
 
+	/* Disable TWL4030/TWL5030 I2C Pull-up on I2C1 and I2C4(SR) interface.
+	 * Program I2C_SCL_CTRL_PU(bit 0)=0, I2C_SDA_CTRL_PU (bit 2)=0,
+	 * SR_I2C_SCL_CTRL_PU(bit 4)=0 and SR_I2C_SDA_CTRL_PU(bit 6)=0.
+	 */
+
+	if (twl_class_is_4030()) {
+		twl_i2c_read_u8(TWL4030_MODULE_INTBR, &temp, REG_GPPUPDCTR1);
+		temp &= ~(SR_I2C_SDA_CTRL_PU | SR_I2C_SCL_CTRL_PU | \
+		I2C_SDA_CTRL_PU | I2C_SCL_CTRL_PU);
+		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
+	}
+
 	status = add_children(pdata, id->driver_data);
 fail:
 	if (status < 0)
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index bf1c5be..fd95eca 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -239,6 +239,21 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
 
 /*----------------------------------------------------------------------*/
 
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
+/*----------------------------------------------------------------------*/
+
 /*
  * Keypad register offsets (use TWL4030_MODULE_KEYPAD)
  * ... SIH/interrupt only
-- 
1.5.6.3

