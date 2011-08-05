From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv6 3/3] OMAP: I2C: Remove the SYSC register definition
Date: Fri, 5 Aug 2011 11:30:35 +0530
Message-ID: <1312524035-5549-3-git-send-email-shubhrajyoti@ti.com>
References: <1312524035-5549-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312524035-5549-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The SYSC register should not accessed in the driver removing the
define from the driver.
Also clean up the syscstate from the omap_i2c_dev struct.

Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d8f4470..d05efe7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -63,7 +63,6 @@ enum {
 	OMAP_I2C_BUF_REG,
 	OMAP_I2C_CNT_REG,
 	OMAP_I2C_DATA_REG,
-	OMAP_I2C_SYSC_REG,
 	OMAP_I2C_CON_REG,
 	OMAP_I2C_OA_REG,
 	OMAP_I2C_SA_REG,
@@ -187,7 +186,6 @@ struct omap_i2c_dev {
 	u16			scllstate;
 	u16			sclhstate;
 	u16			bufstate;
-	u16			syscstate;
 	u16			westate;
 	u16			errata;
 };
@@ -202,7 +200,6 @@ const static u8 reg_map_ip_v1[] = {
 	[OMAP_I2C_BUF_REG] = 0x05,
 	[OMAP_I2C_CNT_REG] = 0x06,
 	[OMAP_I2C_DATA_REG] = 0x07,
-	[OMAP_I2C_SYSC_REG] = 0x08,
 	[OMAP_I2C_CON_REG] = 0x09,
 	[OMAP_I2C_OA_REG] = 0x0a,
 	[OMAP_I2C_SA_REG] = 0x0b,
@@ -223,7 +220,6 @@ const static u8 reg_map_ip_v2[] = {
 	[OMAP_I2C_BUF_REG] = 0x94,
 	[OMAP_I2C_CNT_REG] = 0x98,
 	[OMAP_I2C_DATA_REG] = 0x9c,
-	[OMAP_I2C_SYSC_REG] = 0x20,
 	[OMAP_I2C_CON_REG] = 0xa4,
 	[OMAP_I2C_OA_REG] = 0xa8,
 	[OMAP_I2C_SA_REG] = 0xac,
@@ -264,7 +260,6 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 	}
-- 
1.7.1
