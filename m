From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] [I2C-OMAP] Add support for 16-bit registers
Date: Sat, 12 Dec 2009 17:54:02 -0800
Message-ID: <1260669242-29865-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The current i2c-omap driver is set up for 32-bit registers, which
corresponds to most OMAP devices.  However, OMAP730/850 based
devices use a 16-bit register size.

This change modifies the driver to perform a runtime CPU type check
to determine the register sizes, and uses a bit shift of either 1
or 2 bits to compute the proper register sizes for all registers.

Signed-off-by: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   44 +++++++++++++++++++++++-----------------
 1 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 827da08..4f8e2f5 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -49,24 +49,24 @@
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
 
 #define OMAP_I2C_REV_REG		0x00
-#define OMAP_I2C_IE_REG			0x04
-#define OMAP_I2C_STAT_REG		0x08
-#define OMAP_I2C_IV_REG			0x0c
+#define OMAP_I2C_IE_REG			0x01
+#define OMAP_I2C_STAT_REG		0x02
+#define OMAP_I2C_IV_REG			0x03
 /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
-#define OMAP_I2C_WE_REG			0x0c
-#define OMAP_I2C_SYSS_REG		0x10
-#define OMAP_I2C_BUF_REG		0x14
-#define OMAP_I2C_CNT_REG		0x18
-#define OMAP_I2C_DATA_REG		0x1c
-#define OMAP_I2C_SYSC_REG		0x20
-#define OMAP_I2C_CON_REG		0x24
-#define OMAP_I2C_OA_REG			0x28
-#define OMAP_I2C_SA_REG			0x2c
-#define OMAP_I2C_PSC_REG		0x30
-#define OMAP_I2C_SCLL_REG		0x34
-#define OMAP_I2C_SCLH_REG		0x38
-#define OMAP_I2C_SYSTEST_REG		0x3c
-#define OMAP_I2C_BUFSTAT_REG		0x40
+#define OMAP_I2C_WE_REG			0x03
+#define OMAP_I2C_SYSS_REG		0x04
+#define OMAP_I2C_BUF_REG		0x05
+#define OMAP_I2C_CNT_REG		0x06
+#define OMAP_I2C_DATA_REG		0x07
+#define OMAP_I2C_SYSC_REG		0x08
+#define OMAP_I2C_CON_REG		0x09
+#define OMAP_I2C_OA_REG			0x0a
+#define OMAP_I2C_SA_REG			0x0b
+#define OMAP_I2C_PSC_REG		0x0c
+#define OMAP_I2C_SCLL_REG		0x0d
+#define OMAP_I2C_SCLH_REG		0x0e
+#define OMAP_I2C_SYSTEST_REG		0x0f
+#define OMAP_I2C_BUFSTAT_REG		0x10
 
 /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
 #define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
@@ -161,6 +161,7 @@ struct omap_i2c_dev {
 	struct device		*dev;
 	void __iomem		*base;		/* virtual */
 	int			irq;
+	int			reg_shift;      /* bit shift for I2C register addresses */
 	struct clk		*iclk;		/* Interface clock */
 	struct clk		*fclk;		/* Functional clock */
 	struct completion	cmd_complete;
@@ -183,12 +184,12 @@ struct omap_i2c_dev {
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
 				      int reg, u16 val)
 {
-	__raw_writew(val, i2c_dev->base + reg);
+	__raw_writew(val, i2c_dev->base + (reg << i2c_dev->reg_shift));
 }
 
 static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 {
-	return __raw_readw(i2c_dev->base + reg);
+	return __raw_readw(i2c_dev->base + (reg << i2c_dev->reg_shift));
 }
 
 static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
@@ -895,6 +896,11 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->b_hw = 1; /* Enable hardware fixes */
 	}
 
+	if (cpu_is_omap7xx())
+		dev->reg_shift = 1;
+	else
+		dev->reg_shift = 2;
+
 	/* reset ASAP, clearing any IRQs */
 	omap_i2c_init(dev);
 
-- 
1.6.3.3
