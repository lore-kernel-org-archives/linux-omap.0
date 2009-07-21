From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [RESUBMIT][PATCH][RFC] OMAP4: I2C Support for OMAP4430
Date: Tue, 21 Jul 2009 20:49:46 +0530 (IST)
Message-ID: <53314.192.168.10.89.1248189586.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50306 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbZGUPUU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jul 2009 11:20:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

This patch adds OMAP4 support to the I2C driver. All I2C register addresses
are different between OMAP1/2/3 and OMAP4. In order to not have #ifdef's at
various places in code, as well as to support multi-OMAP build, Array's are
created to hold the register addresses.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
---
 arch/arm/plat-omap/i2c.c      |   22 ++++-
 drivers/i2c/busses/i2c-omap.c |  156 +++++++++++++++++++++++++++++++++---------
 2 files changed, 142 insertions(+), 36 deletions(-)

Index: kernel-omap4-base/arch/arm/plat-omap/i2c.c
===================================================================
--- kernel-omap4-base.orig/arch/arm/plat-omap/i2c.c
+++ kernel-omap4-base/arch/arm/plat-omap/i2c.c
@@ -53,9 +53,16 @@ static struct resource i2c_resources[][2
 #if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_24XX_I2C2_IRQ) },
 #endif
+#if     defined(CONFIG_ARCH_OMAP4)
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_44XX_I2C2_IRQ) },
+#endif
+
 #if	defined(CONFIG_ARCH_OMAP34XX)
 	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_34XX_I2C3_IRQ) },
 #endif
+#if     defined(CONFIG_ARCH_OMAP4)
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_44XX_I2C3_IRQ) },
+#endif
 };

 #define I2C_DEV_BUILDER(bus_id, res, data)		\
@@ -72,10 +79,11 @@ static struct resource i2c_resources[][2
 static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
 static struct platform_device omap_i2c_devices[] = {
 	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
-#if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+	defined(CONFIG_ARCH_OMAP4)
 	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
 #endif
-#if	defined(CONFIG_ARCH_OMAP34XX)
+#if	defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
 #endif
 };
@@ -88,7 +96,7 @@ static const int omap24xx_pins[][2] = {
 #else
 static const int omap24xx_pins[][2] = {};
 #endif
-#if defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 static const int omap34xx_pins[][2] = {
 	{ K21_34XX_I2C1_SCL, J21_34XX_I2C1_SDA},
 	{ AF15_34XX_I2C2_SCL, AE15_34XX_I2C2_SDA},
@@ -110,7 +118,7 @@ static void __init omap_i2c_mux_pins(int
 	} else if (cpu_is_omap24xx()) {
 		scl = omap24xx_pins[bus][0];
 		sda = omap24xx_pins[bus][1];
-	} else if (cpu_is_omap34xx()) {
+	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		scl = omap34xx_pins[bus][0];
 		sda = omap34xx_pins[bus][1];
 	} else {
@@ -129,7 +137,7 @@ static int __init omap_i2c_nr_ports(void
 		ports = 1;
 	else if (cpu_is_omap24xx())
 		ports = 2;
-	else if (cpu_is_omap34xx())
+	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
 		ports = 3;

 	return ports;
@@ -151,6 +159,10 @@ static int __init omap_i2c_add_bus(int b
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
Index: kernel-omap4-base/drivers/i2c/busses/i2c-omap.c
===================================================================
--- kernel-omap4-base.orig/drivers/i2c/busses/i2c-omap.c
+++ kernel-omap4-base/drivers/i2c/busses/i2c-omap.c
@@ -45,28 +45,34 @@
 #define OMAP_I2C_REV_ON_2430		0x36
 #define OMAP_I2C_REV_ON_3430		0x3C

+#define OMAP_I2C_REV_ON_4430		0x40
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))

-#define OMAP_I2C_REV_REG		0x00
-#define OMAP_I2C_IE_REG			0x04
-#define OMAP_I2C_STAT_REG		0x08
-#define OMAP_I2C_IV_REG			0x0c
-/* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
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
+	OMAP_I2C_IRQSTATUS_RAW,
+	OMAP_I2C_IRQENABLE_SET,
+	OMAP_I2C_IRQENABLE_CLR,
+};

 /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
 #define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
@@ -156,6 +162,12 @@
 #define SYSC_IDLEMODE_SMART		0x2
 #define SYSC_CLOCKACTIVITY_FCLK		0x2

+#define maxvalue(x, y)	(x > y ? x : y)
+
+struct reg_type {
+	u32 reg;
+	u32 offset;
+};

 struct omap_i2c_dev {
 	struct device		*dev;
@@ -165,6 +177,7 @@ struct omap_i2c_dev {
 	struct clk		*fclk;		/* Functional clock */
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
+	struct reg_type		*regs;
 	u32			speed;		/* Speed of bus in Khz */
 	u16			cmd_err;
 	u8			*buf;
@@ -180,15 +193,61 @@ struct omap_i2c_dev {
 	u16			iestate;	/* Saved interrupt register */
 };

+static struct  __initdata reg_type reg_map[] = {
+	{OMAP_I2C_REV_REG, 0x00},
+	{OMAP_I2C_IE_REG, 0x04},
+	{OMAP_I2C_STAT_REG, 0x08},
+	{OMAP_I2C_IV_REG, 0x0c},
+	{OMAP_I2C_WE_REG, 0x0c},
+	{OMAP_I2C_SYSS_REG, 0x10},
+	{OMAP_I2C_BUF_REG, 0x14},
+	{OMAP_I2C_CNT_REG, 0x18},
+	{OMAP_I2C_DATA_REG, 0x1c},
+	{OMAP_I2C_SYSC_REG, 0x20},
+	{OMAP_I2C_CON_REG, 0x24},
+	{OMAP_I2C_OA_REG, 0x28},
+	{OMAP_I2C_SA_REG, 0x2c},
+	{OMAP_I2C_PSC_REG, 0x30},
+	{OMAP_I2C_SCLL_REG, 0x34},
+	{OMAP_I2C_SCLH_REG, 0x38},
+	{OMAP_I2C_SYSTEST_REG, 0x3C},
+	{OMAP_I2C_BUFSTAT_REG, 0x40},
+};
+
+static struct  __initdata reg_type omap4_reg_map[] = {
+	{OMAP_I2C_REV_REG, 0x04},
+	{OMAP_I2C_IE_REG, 0x2c},
+	{OMAP_I2C_STAT_REG, 0x28},
+	{OMAP_I2C_IV_REG, 0x34},
+	{OMAP_I2C_WE_REG, 0x34},
+	{OMAP_I2C_SYSS_REG, 0x90},
+	{OMAP_I2C_BUF_REG, 0x94},
+	{OMAP_I2C_CNT_REG, 0x98},
+	{OMAP_I2C_DATA_REG, 0x9c},
+	{OMAP_I2C_SYSC_REG, 0x20},
+	{OMAP_I2C_CON_REG, 0xa4},
+	{OMAP_I2C_OA_REG, 0xa8},
+	{OMAP_I2C_SA_REG, 0xac},
+	{OMAP_I2C_PSC_REG, 0xb0},
+	{OMAP_I2C_SCLL_REG, 0xb4},
+	{OMAP_I2C_SCLH_REG, 0xb8},
+	{OMAP_I2C_SYSTEST_REG, 0xbC},
+	{OMAP_I2C_BUFSTAT_REG, 0xc0},
+	{OMAP_I2C_REVNB_LO, 0x00},
+	{OMAP_I2C_IRQSTATUS_RAW, 0x24},
+	{OMAP_I2C_IRQENABLE_SET, 0x2c},
+	{OMAP_I2C_IRQENABLE_CLR, 0x30},
+};
+
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
 				      int reg, u16 val)
 {
-	__raw_writew(val, i2c_dev->base + reg);
+	__raw_writew(val, i2c_dev->base + i2c_dev->regs[reg].offset);
 }

 static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 {
-	return __raw_readw(i2c_dev->base + reg);
+	return __raw_readw(i2c_dev->base + i2c_dev->regs[reg].offset);
 }

 static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
@@ -242,7 +301,11 @@ static void omap_i2c_idle(struct omap_i2
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
@@ -302,6 +365,7 @@ static int omap_i2c_init(struct omap_i2c
 			 * WFI instruction.
 			 * REVISIT: Some wkup sources might not be needed.
 			 */
+		if (dev->rev < OMAP_I2C_REV_ON_4430)
 			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
 							OMAP_I2C_WE_ALL);

@@ -331,7 +395,7 @@ static int omap_i2c_init(struct omap_i2c
 			psc = fclk_rate / 12000000;
 	}

-	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {

 		/*
 		 * HSI2C controller internal clk rate should be 19.2 Mhz for
@@ -345,7 +409,11 @@ static int omap_i2c_init(struct omap_i2c
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
@@ -702,9 +770,12 @@ omap_i2c_isr(int this_irq, void *dev_id)
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
@@ -741,9 +812,12 @@ omap_i2c_isr(int this_irq, void *dev_id)
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
@@ -839,11 +913,25 @@ omap_i2c_probe(struct platform_device *p
 	if ((r = omap_i2c_get_clocks(dev)) != 0)
 		goto err_iounmap;

+	if (dev->regs == NULL) {
+		dev->regs = kmalloc(maxvalue(sizeof(omap4_reg_map),
+				sizeof(reg_map)), GFP_KERNEL);
+		if (dev->regs == NULL) {
+			r = -ENOMEM;
+			goto err_free_mem;
+		}
+	}
+
+	if (cpu_is_omap44xx())
+		memcpy(dev->regs, omap4_reg_map, sizeof(omap4_reg_map));
+	else
+		memcpy(dev->regs, reg_map, sizeof(reg_map));
+
 	omap_i2c_unidle(dev);

 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;

-	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		u16 s;

 		/* Set up the fifo size - Get total size */
@@ -855,8 +943,13 @@ omap_i2c_probe(struct platform_device *p
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
+			dev->b_hw = 1; /* Enable hardware fixes */
+		}
 	}

 	/* reset ASAP, clearing any IRQs */
@@ -923,6 +1016,7 @@ omap_i2c_remove(struct platform_device *
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 	omap_i2c_put_clocks(dev);
 	iounmap(dev->base);
+	kfree(dev->regs);
 	kfree(dev);
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, (mem->end - mem->start) + 1);


