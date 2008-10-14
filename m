From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] OMAP2/3 I2C: reprogram OCP_SYSCONFIG register after reset
Date: Tue, 14 Oct 2008 06:19:48 -0600
Message-ID: <20081014121926.1210.11681.stgit@localhost.localdomain>
References: <20081014121031.1210.96214.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38058 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375AbYJNMVb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 08:21:31 -0400
In-Reply-To: <20081014121031.1210.96214.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Richard Woodruff <r-woodruff2@ti.com>

The I2C controller clears its OCP_SYSCONFIG register after an OCP soft reset.
Reprogram OCP_SYSCONFIG for maximum power savings on rev3.6 controllers
and beyond.  On 2430, this involves setting the module AUTOIDLE bit.
On 3430, this includes module AUTOIDLE, wakeup enable, slave smart-idle,
and considers only the module functional clock state for idle-ack.

Boot-tested on 2430SDP and 3430SDP.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   40 ++++++++++++++++++++++++++++++++++------
 1 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 12bdb69..d012ad7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -123,11 +123,19 @@
 #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
 #endif
 
-/* I2C System Status register (OMAP_I2C_SYSS): */
-#define OMAP_I2C_SYSS_RDONE		(1 << 0)	/* Reset Done */
+/* OCP_SYSSTATUS bit definitions */
+#define SYSS_RESETDONE_MASK		(1 << 0)
+
+/* OCP_SYSCONFIG bit definitions */
+#define SYSC_CLOCKACTIVITY_MASK		(0x3 << 8)
+#define SYSC_SIDLEMODE_MASK		(0x3 << 3)
+#define SYSC_ENAWAKEUP_MASK		(1 << 2)
+#define SYSC_SOFTRESET_MASK		(1 << 1)
+#define SYSC_AUTOIDLE_MASK		(1 << 0)
+
+#define SYSC_IDLEMODE_SMART		0x2
+#define SYSC_CLOCKACTIVITY_FCLK		0x2
 
-/* I2C System Configuration Register (OMAP_I2C_SYSC): */
-#define OMAP_I2C_SYSC_SRST		(1 << 1)	/* Soft Reset */
 
 struct omap_i2c_dev {
 	struct device		*dev;
@@ -252,13 +260,13 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	unsigned long internal_clk = 0;
 
 	if (dev->rev >= OMAP_I2C_REV_2) {
-		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SRST);
+		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, SYSC_SOFTRESET_MASK);
 		/* For some reason we need to set the EN bit before the
 		 * reset done bit gets set. */
 		timeout = jiffies + OMAP_I2C_TIMEOUT;
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 		while (!(omap_i2c_read_reg(dev, OMAP_I2C_SYSS_REG) &
-			 OMAP_I2C_SYSS_RDONE)) {
+			 SYSS_RESETDONE_MASK)) {
 			if (time_after(jiffies, timeout)) {
 				dev_warn(dev->dev, "timeout waiting "
 						"for controller reset\n");
@@ -266,6 +274,26 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			}
 			msleep(1);
 		}
+
+		/* SYSC register is cleared by the reset; rewrite it */
+		if (dev->rev == OMAP_I2C_REV_ON_2430) {
+
+			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
+					   SYSC_AUTOIDLE_MASK);
+
+		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
+			u32 v;
+
+			v = SYSC_AUTOIDLE_MASK;
+			v |= SYSC_ENAWAKEUP_MASK;
+			v |= (SYSC_IDLEMODE_SMART <<
+			      __ffs(SYSC_SIDLEMODE_MASK));
+			v |= (SYSC_CLOCKACTIVITY_FCLK <<
+			      __ffs(SYSC_CLOCKACTIVITY_MASK));
+
+			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, v);
+
+		}
 	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 


