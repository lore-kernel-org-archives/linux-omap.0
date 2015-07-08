From: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: omap: fix bus recovery setup
Date: Wed,  8 Jul 2015 16:35:27 +0200
Message-ID: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

At least on the AM335x, enabling OMAP_I2C_SYSTEST_ST_EN is not enough to
allow direct access to the SCL and SDA pins. In addition to ST_EN, we
need to set the TMODE to 0b11 (Loop back & SDA/SCL IO mode select).
Also, as the reset values of SCL_O and SDA_O are 0 (which means "drive
low level"), we need to set them to 1 (which means "high-impedance") to
avoid unwanted changes on the pins.

As a precaution, reset all these bits to their default values after
recovery is complete.

Signed-off-by: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d1c22e3fdd14..fc9bf7f30e35 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1247,7 +1247,14 @@ static void omap_i2c_prepare_recovery(struct i2c_adapter *adap)
 	u32 reg;
 
 	reg = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+	/* enable test mode */
 	reg |= OMAP_I2C_SYSTEST_ST_EN;
+	/* select SDA/SCL IO mode */
+	reg |= 3 << OMAP_I2C_SYSTEST_TMODE_SHIFT;
+	/* set SCL to high-impedance state (reset value is 0) */
+	reg |= OMAP_I2C_SYSTEST_SCL_O;
+	/* set SDA to high-impedance state (reset value is 0) */
+	reg |= OMAP_I2C_SYSTEST_SDA_O;
 	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
 }
 
@@ -1257,7 +1264,11 @@ static void omap_i2c_unprepare_recovery(struct i2c_adapter *adap)
 	u32 reg;
 
 	reg = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+	/* restore reset values */
 	reg &= ~OMAP_I2C_SYSTEST_ST_EN;
+	reg &= ~OMAP_I2C_SYSTEST_TMODE_MASK;
+	reg &= ~OMAP_I2C_SYSTEST_SCL_O;
+	reg &= ~OMAP_I2C_SYSTEST_SDA_O;
 	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
 }
 
-- 
2.1.4
