From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] i2c: omap: implement bus recovery
Date: Thu, 19 Feb 2015 12:06:49 -0600
Message-ID: <1424369209-26735-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

If either SCL or SDA are stuck low, we need to
recover the bus using the procedure described
on section 3.1.16 of the I2C specification.

Note that we're trying to implement the procedure
exactly as described by that section. First we
check which line is stuck low, then implement
one or the other procedure. If SDA recovery procedure
fails, we reset our IP in an attempt to make it work.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---

Tested with AM437x IDK, AM437x SK, BeagleBoneBlack and Beagle X15 with
1000 iterations of i2cdetect on all available buses.

That said, I couldn't get any device to hold the bus busy so I could
see this working. If anybody has any good way of forcing a condition
so that we need bus recovery, I'd be glad to look at.

cheers

 drivers/i2c/busses/i2c-omap.c | 71 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0e894193accf..c3e4da751adf 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -472,6 +472,73 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	return 0;
 }
 
+static void omap_i2c_clock_pulse(struct omap_i2c_dev *dev)
+{
+	u32 reg;
+	int i;
+
+	/* Enable testmode */
+	reg = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+	reg |= OMAP_I2C_SYSTEST_ST_EN;
+	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
+
+	for (i = 0; i < 9; i++) {
+		reg |= OMAP_I2C_SYSTEST_SCL_O;
+		omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
+		mdelay(100);
+		reg &= ~OMAP_I2C_SYSTEST_SCL_O;
+		omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
+		mdelay(100);
+	}
+
+	/* Disable testmode */
+	reg &= ~OMAP_I2C_SYSTEST_ST_EN;
+	omap_i2c_write_reg(dev, OMAP_I2C_SYSTEST_REG, reg);
+}
+
+static void omap_i2c_bus_recover(struct omap_i2c_dev *dev)
+{
+	u32 reg1;
+	u32 reg2;
+
+	/*
+	 * First differentiate SCL stuck low from SDA stuck low using our
+	 * SYSTEST register. Depending on which line is stuck low, we will
+	 * either Reset our I2C IP (SCL stuck low) or drive 9 clock pulses on
+	 * SCL (SDA stuck low) to tell the device to release the bus.
+	 *
+	 * If, after 9 clock pulses on SCL device still doesn't release the
+	 * bus, there's nothing more we can do; we will still try to Reset
+	 * our I2C IP anyway.
+	 */
+
+	reg1 = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+	msleep(1);
+	reg2 = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+
+	if (!(reg1 & OMAP_I2C_SYSTEST_SCL_I_FUNC) &&
+			!(reg2 & OMAP_I2C_SYSTEST_SCL_I_FUNC)) {
+		dev_err(dev->dev, "SCL is stuck low, resetting\n");
+		omap_i2c_reset(dev);
+	}
+
+	if (!(reg1 & OMAP_I2C_SYSTEST_SDA_I_FUNC) &&
+			!(reg2 & OMAP_I2C_SYSTEST_SDA_I_FUNC)) {
+		dev_err(dev->dev, "SDA is stuck low, driving 9 pulses on SCL\n");
+		omap_i2c_clock_pulse(dev);
+
+		reg1 = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+		msleep(1);
+		reg2 = omap_i2c_read_reg(dev, OMAP_I2C_SYSTEST_REG);
+
+		if ((reg1 & OMAP_I2C_SYSTEST_SDA_I_FUNC) &&
+				(reg2 & OMAP_I2C_SYSTEST_SDA_I_FUNC)) {
+			dev_err(dev->dev, "SDA still stuck, resetting\n");
+			omap_i2c_reset(dev);
+		}
+	}
+}
+
 /*
  * Waiting on Bus Busy
  */
@@ -482,8 +549,8 @@ static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
 	timeout = jiffies + OMAP_I2C_TIMEOUT;
 	while (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
 		if (time_after(jiffies, timeout)) {
-			dev_warn(dev->dev, "timeout waiting for bus ready\n");
-			return -ETIMEDOUT;
+			omap_i2c_bus_recover(dev);
+			return 0;
 		}
 		msleep(1);
 	}
-- 
2.3.0
