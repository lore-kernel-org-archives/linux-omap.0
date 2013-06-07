From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 4/5] i2c: omap: query STP always when NACK is received
Date: Fri, 7 Jun 2013 21:46:07 +0300
Message-ID: <1370630768-4077-5-git-send-email-grygorii.strashko@ti.com>
References: <1370630768-4077-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370630768-4077-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

According to I2C specification the NACK should be handled as folowing:
"When SDA remains HIGH during this ninth clock pulse, this is defined as the Not
Acknowledge signal. The master can then gene rate either a STOP condition to
abort the transfer, or a repeated START condition to start a new transfer."
[http://www.nxp.com/documents/user_manual/UM10204.pdf]

The same is recomened by TI I2C wiki:
 http://processors.wiki.ti.com/index.php/I2C_Tips

Currently, the OMAP I2C driver interrupts I2C trunsfer in case of NACK, but
It queries Stop condition OMAP_I2C_CON_REG.STP=1 only if NACK has been received
during the last message transmitting/recieving.
This may lead to stuck Bus in "Bus Busy" until I2C IP reset (idle/enable).

Hence, fix it by querying Stop condition (STP) always when NACK is received.

CC: Kevin Hilman <khilman@linaro.org>
CC: Felipe Balbi <balbi@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 46fb8a5..b3daf3f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -618,11 +618,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return 0;
-		if (stop) {
-			w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
-			w |= OMAP_I2C_CON_STP;
-			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
-		}
+
+		w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
+		w |= OMAP_I2C_CON_STP;
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 		return -EREMOTEIO;
 	}
 	return -EIO;
-- 
1.7.9.5
