From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH 4/4] i2c: omap: add notes related to i2c multimaster mode
Date: Fri, 21 Nov 2014 01:28:45 +0400
Message-ID: <1416518925-20679-5-git-send-email-al.kochet@gmail.com>
References: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416518925-20679-1-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, al.kochet@gmail.com
Cc: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

No functional changes.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 47103e7..4e3642c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -304,6 +304,12 @@ static void __omap_i2c_init(struct omap_i2c_dev *dev)
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 
 	/*
+	 * NOTE: right after setting CON_EN, STAT_BB could be 0 while the
+	 * bus is busy. It will be changed to 1 on the next IP FCLK clock.
+	 * udelay(1) will be enough to fix that.
+	 */
+
+	/*
 	 * Don't write to this register if the IE state is 0 as it can
 	 * cause deadlock.
 	 */
@@ -664,7 +670,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 
 	if (!dev->b_hw && stop)
 		w |= OMAP_I2C_CON_STP;
-
+	/*
+	 * NOTE: STAT_BB bit could became 1 here if another master occupy
+	 * the bus. IP successfully complete transfer when the bus will be
+	 * free again (BB reset to 0).
+	 */
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
 
 	/*
-- 
1.7.9.5
