From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap4: Add i2c support on omap4 platform
Date: Tue, 16 Feb 2010 21:11:28 +0530
Message-ID: <1266334896-30686-16-git-send-email-santosh.shilimkar@ti.com>
References: <1266334896-30686-1-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-2-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-3-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-4-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-5-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-6-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-7-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-8-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-9-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-10-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-11-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-12-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-13-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-14-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-15-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49309 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932765Ab0BPPmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 10:42:24 -0500
In-Reply-To: <1266334896-30686-15-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Syed Rafiuddin <rafiuddin.syed@ti.com>, Ben Dooks <ben-linux@fluff.org>

This patch is rebased version of earlier post to add I2C
driver support to OMAP4 platform. On OMAP4, all
I2C register address offsets are changed from OMAP1/2/3 I2C.
In order to not have #ifdef's at various places in code,
as well as to support multi-OMAP build, an array is created
to hold the register addresses with it's offset.

This patch was submitted, reviewed and acked on mailing list
already. For more details refer below link
http://www.mail-archive.com/linux-i2c@vger.kernel.org/msg02281.html

This version updated on top of 16 bit support added as part of
the commit "8bb209278e555a626f9637e844fe4c1b90e849f6"

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-omap/i2c.c      |   17 ++++-
 drivers/i2c/busses/i2c-omap.c |  148 ++++++++++++++++++++++++++++++++---------
 2 files changed, 131 insertions(+), 34 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 96d2781..f18d757 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -53,9 +53,15 @@ static struct resource i2c_resources[][2] = {
 #if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_24XX_I2C2_IRQ) },
 #endif
+#if	defined(CONFIG_ARCH_OMAP4)
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_44XX_I2C2_IRQ) },
+#endif
 #if	defined(CONFIG_ARCH_OMAP3)
 	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_34XX_I2C3_IRQ) },
 #endif
+#if	defined(CONFIG_ARCH_OMAP4)
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_44XX_I2C3_IRQ) },
+#endif
 };
 
 #define I2C_DEV_BUILDER(bus_id, res, data)		\
@@ -72,10 +78,11 @@ static struct resource i2c_resources[][2] = {
 static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
 static struct platform_device omap_i2c_devices[] = {
 	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
-#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
 	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
 #endif
-#if	defined(CONFIG_ARCH_OMAP3)
+#if	defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
 #endif
 };
@@ -90,7 +97,7 @@ static int __init omap_i2c_nr_ports(void)
 		ports = 1;
 	else if (cpu_is_omap24xx())
 		ports = 2;
-	else if (cpu_is_omap34xx())
+	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
 		ports = 3;
 
 	return ports;
@@ -112,6 +119,10 @@ static int __init omap_i2c_add_bus(int bus_id)
 			base = OMAP2_I2C_BASE1;
 			irq = INT_24XX_I2C1_IRQ;
 		}
+		if (cpu_is_omap44xx()) {
+			base = OMAP2_I2C_BASE1;
+			irq = INT_44XX_I2C1_IRQ;
+		}
 		res[0].start = base;
 		res[0].end = base + OMAP_I2C_SIZE;
 		res[1].start = irq;
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9c3ce4d..89a156a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -44,29 +44,37 @@
 /* I2C controller revisions present on specific hardware */
 #define OMAP_I2C_REV_ON_2430		0x36
 #define OMAP_I2C_REV_ON_3430		0x3C
+#define OMAP_I2C_REV_ON_4430		0x40
 
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
 
-#define OMAP_I2C_REV_REG		0x00
-#define OMAP_I2C_IE_REG			0x01
-#define OMAP_I2C_STAT_REG		0x02
-#define OMAP_I2C_IV_REG			0x03
 /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
-#define OMAP_I2C_WE_REG			0x03
-#define OMAP_I2C_SYSS_REG		0x04
-#define OMAP_I2C_BUF_REG		0x05
-#define OMAP_I2C_CNT_REG		0x06
-#define OMAP_I2C_DATA_REG		0x07
-#define OMAP_I2C_SYSC_REG		0x08
-#define OMAP_I2C_CON_REG		0x09
-#define OMAP_I2C_OA_REG			0x0a
-#define OMAP_I2C_SA_REG			0x0b
-#define OMAP_I2C_PSC_REG		0x0c
-#define OMAP_I2C_SCLL_REG		0x0d
-#define OMAP_I2C_SCLH_REG		0x0e
-#define OMAP_I2C_SYSTEST_REG		0x0f
-#define OMAP_I2C_BUFSTAT_REG		0x10
+enum {
+	OMAP_I2C_REV_REG = 0,
+	OMAP_I2C_IE_REG,
+	OMAP_I2C_STAT_REG,
+	OMAP_I2C_IV_REG,
+	OMAP_I2C_WE_REG,
+	OMAP_I2C_SYSS_REG,
+	OMAP_I2C_BUF_REG,
+	OMAP_I2C_CNT_REG,
+	OMAP_I2C_DATA_REG,
+	OMAP_I2C_SYSC_REG,
+	OMAP_I2C_CON_REG,
+	OMAP_I2C_OA_REG,
+	OMAP_I2C_SA_REG,
+	OMAP_I2C_PSC_REG,
+	OMAP_I2C_SCLL_REG,
+	OMAP_I2C_SCLH_REG,
+	OMAP_I2C_SYSTEST_REG,
+	OMAP_I2C_BUFSTAT_REG,
+	OMAP_I2C_REVNB_LO,
+	OMAP_I2C_REVNB_HI,
+	OMAP_I2C_IRQSTATUS_RAW,
+	OMAP_I2C_IRQENABLE_SET,
+	OMAP_I2C_IRQENABLE_CLR,
+};
 
 /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
 #define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
@@ -169,6 +177,7 @@ struct omap_i2c_dev {
 	u32			speed;		/* Speed of bus in Khz */
 	u16			cmd_err;
 	u8			*buf;
+	u8			*regs;
 	size_t			buf_len;
 	struct i2c_adapter	adapter;
 	u8			fifo_size;	/* use as flag and value
@@ -187,15 +196,64 @@ struct omap_i2c_dev {
 	u16			westate;
 };
 
+const static u8 reg_map[] = {
+	[OMAP_I2C_REV_REG] = 0x00,
+	[OMAP_I2C_IE_REG] = 0x01,
+	[OMAP_I2C_STAT_REG] = 0x02,
+	[OMAP_I2C_IV_REG] = 0x03,
+	[OMAP_I2C_WE_REG] = 0x03,
+	[OMAP_I2C_SYSS_REG] = 0x04,
+	[OMAP_I2C_BUF_REG] = 0x05,
+	[OMAP_I2C_CNT_REG] = 0x06,
+	[OMAP_I2C_DATA_REG] = 0x07,
+	[OMAP_I2C_SYSC_REG] = 0x08,
+	[OMAP_I2C_CON_REG] = 0x09,
+	[OMAP_I2C_OA_REG] = 0x0a,
+	[OMAP_I2C_SA_REG] = 0x0b,
+	[OMAP_I2C_PSC_REG] = 0x0c,
+	[OMAP_I2C_SCLL_REG] = 0x0d,
+	[OMAP_I2C_SCLH_REG] = 0x0e,
+	[OMAP_I2C_SYSTEST_REG] = 0x0f,
+	[OMAP_I2C_BUFSTAT_REG] = 0x10,
+};
+
+const static u8 omap4_reg_map[] = {
+	[OMAP_I2C_REV_REG] = 0x04,
+	[OMAP_I2C_IE_REG] = 0x2c,
+	[OMAP_I2C_STAT_REG] = 0x28,
+	[OMAP_I2C_IV_REG] = 0x34,
+	[OMAP_I2C_WE_REG] = 0x34,
+	[OMAP_I2C_SYSS_REG] = 0x90,
+	[OMAP_I2C_BUF_REG] = 0x94,
+	[OMAP_I2C_CNT_REG] = 0x98,
+	[OMAP_I2C_DATA_REG] = 0x9c,
+	[OMAP_I2C_SYSC_REG] = 0x20,
+	[OMAP_I2C_CON_REG] = 0xa4,
+	[OMAP_I2C_OA_REG] = 0xa8,
+	[OMAP_I2C_SA_REG] = 0xac,
+	[OMAP_I2C_PSC_REG] = 0xb0,
+	[OMAP_I2C_SCLL_REG] = 0xb4,
+	[OMAP_I2C_SCLH_REG] = 0xb8,
+	[OMAP_I2C_SYSTEST_REG] = 0xbC,
+	[OMAP_I2C_BUFSTAT_REG] = 0xc0,
+	[OMAP_I2C_REVNB_LO] = 0x00,
+	[OMAP_I2C_REVNB_HI] = 0x04,
+	[OMAP_I2C_IRQSTATUS_RAW] = 0x24,
+	[OMAP_I2C_IRQENABLE_SET] = 0x2c,
+	[OMAP_I2C_IRQENABLE_CLR] = 0x30,
+};
+
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
 				      int reg, u16 val)
 {
-	__raw_writew(val, i2c_dev->base + (reg << i2c_dev->reg_shift));
+	__raw_writew(val, i2c_dev->base +
+			(i2c_dev->regs[reg] << i2c_dev->reg_shift));
 }
 
 static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 {
-	return __raw_readw(i2c_dev->base + (reg << i2c_dev->reg_shift));
+	return __raw_readw(i2c_dev->base +
+				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
 }
 
 static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
@@ -264,7 +322,11 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	WARN_ON(dev->idle);
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
+	if (dev->rev >= OMAP_I2C_REV_ON_4430)
+		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 1);
+	else
+		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
+
 	if (dev->rev < OMAP_I2C_REV_2) {
 		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
 	} else {
@@ -329,7 +391,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			 * REVISIT: Some wkup sources might not be needed.
 			 */
 			dev->westate = OMAP_I2C_WE_ALL;
-			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+			if (dev->rev < OMAP_I2C_REV_ON_4430)
+				omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
+								dev->westate);
 		}
 	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
@@ -356,7 +420,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			psc = fclk_rate / 12000000;
 	}
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
 
 		/*
 		 * HSI2C controller internal clk rate should be 19.2 Mhz for
@@ -370,7 +434,11 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			internal_clk = 9600;
 		else
 			internal_clk = 4000;
-		fclk_rate = clk_get_rate(dev->fclk) / 1000;
+		/* FIXME: Remove this once clock framework is available*/
+		if (dev->rev >= OMAP_I2C_REV_ON_4430)
+			fclk_rate = 96000;
+		else
+			fclk_rate = clk_get_rate(dev->fclk) / 1000;
 
 		/* Compute prescaler divisor */
 		psc = fclk_rate / internal_clk;
@@ -746,9 +814,12 @@ complete:
 				if (dev->buf_len) {
 					*dev->buf++ = w;
 					dev->buf_len--;
-					/* Data reg from 2430 is 8 bit wide */
+					/* Data reg in 2430, omap3 and
+					 * omap4 is 8 bit wide
+					 */
 					if (!cpu_is_omap2430() &&
-							!cpu_is_omap34xx()) {
+							!cpu_is_omap34xx() &&
+							!cpu_is_omap44xx()) {
 						if (dev->buf_len) {
 							*dev->buf++ = w >> 8;
 							dev->buf_len--;
@@ -786,9 +857,12 @@ complete:
 				if (dev->buf_len) {
 					w = *dev->buf++;
 					dev->buf_len--;
-					/* Data reg from  2430 is 8 bit wide */
+					/* Data reg in 2430, omap3 and
+					 * omap4 is 8 bit wide
+					 */
 					if (!cpu_is_omap2430() &&
-							!cpu_is_omap34xx()) {
+							!cpu_is_omap34xx() &&
+							!cpu_is_omap44xx()) {
 						if (dev->buf_len) {
 							w |= *dev->buf++ << 8;
 							dev->buf_len--;
@@ -897,6 +971,8 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	if (cpu_is_omap7xx())
 		dev->reg_shift = 1;
+	else if (cpu_is_omap44xx())
+		dev->reg_shift = 0;
 	else
 		dev->reg_shift = 2;
 
@@ -911,11 +987,16 @@ omap_i2c_probe(struct platform_device *pdev)
 	if ((r = omap_i2c_get_clocks(dev)) != 0)
 		goto err_iounmap;
 
+	if (cpu_is_omap44xx())
+		dev->regs = (u8 *) omap4_reg_map;
+	else
+		dev->regs = (u8 *) reg_map;
+
 	omap_i2c_unidle(dev);
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		u16 s;
 
 		/* Set up the fifo size - Get total size */
@@ -927,8 +1008,13 @@ omap_i2c_probe(struct platform_device *pdev)
 		 * size. This is to ensure that we can handle the status on int
 		 * call back latencies.
 		 */
-		dev->fifo_size = (dev->fifo_size / 2);
-		dev->b_hw = 1; /* Enable hardware fixes */
+		if (dev->rev >= OMAP_I2C_REV_ON_4430) {
+			dev->fifo_size = 0;
+			dev->b_hw = 0; /* Enable hardware fixes */
+		} else {
+			dev->fifo_size = (dev->fifo_size / 2);
+			dev->b_hw = 1; /* Disable hardware fixes */
+		}
 	}
 
 	/* reset ASAP, clearing any IRQs */
-- 
1.6.0.4

