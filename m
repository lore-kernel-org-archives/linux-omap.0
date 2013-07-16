From: Hein Tibosch <hein_tibosch@yahoo.es>
Subject: [PATCH] i2c-omap: always send stop after nack
Date: Tue, 16 Jul 2013 16:19:35 +0800
Message-ID: <51E50217.1000507@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Vikram,

On a OMAP4460, i2c-bus-3:

A driver (lm75) is causing many 'timeout waiting for bus ready' errors.
SDA remains high (as it should), but SCL remains low after a NACK.
The bus becomes _unusable for other clients_.

While probing, "lm75" writes a command, followed by a read + stop,
but the write command is NACK'd. The chip does accept other writes/reads,
it just refuses to ack invalid commands.

Can you tell me if the patch below would make any sense? Or is it the
responsibility of the client to reset the i2c_smbus?

In case of M_IGNORE_NAK there is no problem, a STOP will follow after the
last command.


Thanks, Hein

Signed-off-by: Hein Tibosch <hein_tibosch@yahoo.es>

---
 drivers/i2c/busses/i2c-omap.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e02f9e3..2f7a712 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -615,11 +615,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return 0;
-		if (stop) {
-			w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
-			w |= OMAP_I2C_CON_STP;
-			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
-		}
+		w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
+		w |= OMAP_I2C_CON_STP;
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 		return -EREMOTEIO;
 	}
 	return -EIO;
-- 
1.7.9.5
