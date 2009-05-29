From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [PATCH][RFC] OMAP4: I2C Support for OMAP_4430SDP
Date: Fri, 29 May 2009 20:08:25 +0530 (IST)
Message-ID: <55272.192.168.10.89.1243607905.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45835 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758466AbZE2Oin (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2009 10:38:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ben-linux@fluff.org, linux-i2c@vger.kernel.org

This patch Updates I2C register offset addresses and adds support for OMAP4430
development platform.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    9 +++-
 arch/arm/plat-omap/i2c.c            |   21 +++++++--
 drivers/i2c/busses/i2c-omap.c       |   78 +++++++++++++++++++++++++-----------
 3 files changed, 80 insertions(+), 28 deletions(-)

Index: omap4_dev/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- omap4_dev.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ omap4_dev/arch/arm/mach-omap2/board-4430sdp.c
@@ -66,10 +66,17 @@ static void __init omap_4430sdp_init_irq
 	gic_init_irq();
 	omap_gpio_init();
 }
-
+static int __init omap4_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 2600, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+	return 0;
+}

 static void __init omap_4430sdp_init(void)
 {
+	omap4_i2c_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_board_config = sdp4430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
Index: omap4_dev/arch/arm/plat-omap/i2c.c
===================================================================
--- omap4_dev.orig/arch/arm/plat-omap/i2c.c
+++ omap4_dev/arch/arm/plat-omap/i2c.c
@@ -53,9 +53,15 @@ static struct resource i2c_resources[][2
 #if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_24XX_I2C2_IRQ) },
 #endif
+#if	defined(CONFIG_ARCH_OMAP4)
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_44XX_I2C2_IRQ) },
+#endif
 #if	defined(CONFIG_ARCH_OMAP34XX)
 	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_34XX_I2C3_IRQ) },
 #endif
+#if	defined(CONFIG_ARCH_OMAP4)
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_44XX_I2C3_IRQ) },
+#endif
 };

 #define I2C_DEV_BUILDER(bus_id, res, data)		\
@@ -72,10 +78,11 @@ static struct resource i2c_resources[][2
 static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
 static struct platform_device omap_i2c_devices[] = {
 	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
-#if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+defined(CONFIG_ARCH_OMAP4)
 	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
 #endif
-#if	defined(CONFIG_ARCH_OMAP34XX)
+#if	defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
 #endif
 };
@@ -88,7 +95,7 @@ static const int omap24xx_pins[][2] = {
 #else
 static const int omap24xx_pins[][2] = {};
 #endif
-#if defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP4)
 static const int omap34xx_pins[][2] = {
 	{ K21_34XX_I2C1_SCL, J21_34XX_I2C1_SDA},
 	{ AF15_34XX_I2C2_SCL, AE15_34XX_I2C2_SDA},
@@ -110,7 +117,7 @@ static void __init omap_i2c_mux_pins(int
 	} else if (cpu_is_omap24xx()) {
 		scl = omap24xx_pins[bus][0];
 		sda = omap24xx_pins[bus][1];
-	} else if (cpu_is_omap34xx()) {
+	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		scl = omap34xx_pins[bus][0];
 		sda = omap34xx_pins[bus][1];
 	} else {
@@ -129,7 +136,7 @@ static int __init omap_i2c_nr_ports(void
 		ports = 1;
 	else if (cpu_is_omap24xx())
 		ports = 2;
-	else if (cpu_is_omap34xx())
+	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
 		ports = 3;

 	return ports;
@@ -151,6 +158,10 @@ static int __init omap_i2c_add_bus(int b
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
Index: omap4_dev/drivers/i2c/busses/i2c-omap.c
===================================================================
--- omap4_dev.orig/drivers/i2c/busses/i2c-omap.c
+++ omap4_dev/drivers/i2c/busses/i2c-omap.c
@@ -27,7 +27,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
-
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -48,12 +47,36 @@
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))

+#define OMAP_I2C_WE_REG			0x0c
+#ifdef CONFIG_ARCH_OMAP4
+#define OMAP_I2C_REVNB_LO               0x00
+#define OMAP_I2C_REVNB_HI               0x04
+#define OMAP_I2C_IV_REG                 0x34
+#define OMAP_I2C_IRQSTATUS_RAW          0x24
+#define OMAP_I2C_STAT_REG               0x28
+#define OMAP_I2C_IRQENABLE_SET          0x2C
+#define OMAP_I2C_IRQENABLE_CLR          0x30
+#define OMAP_I2C_SYSS_REG               0x90
+#define OMAP_I2C_BUF_REG                0x94
+#define OMAP_I2C_CNT_REG                0x98
+#define OMAP_I2C_DATA_REG               0x9C
+#define OMAP_I2C_SYSC_REG               0x10
+#define OMAP_I2C_CON_REG                0xA4
+#define OMAP_I2C_OA_REG                 0xA8
+#define OMAP_I2C_SA_REG                 0xAC
+#define OMAP_I2C_PSC_REG                0xB0
+#define OMAP_I2C_SCLL_REG               0xB4
+#define OMAP_I2C_SCLH_REG               0xB8
+#define OMAP_I2C_SYSTEST_REG            0xBC
+#define OMAP_I2C_BUFSTAT_REG            0xC0
+#define OMAP_I2C_IE_REG                 OMAP_I2C_IRQENABLE_SET
+#define OMAP_I2C_REV_REG		OMAP_I2C_REVNB_HI
+#else
 #define OMAP_I2C_REV_REG		0x00
 #define OMAP_I2C_IE_REG			0x04
 #define OMAP_I2C_STAT_REG		0x08
 #define OMAP_I2C_IV_REG			0x0c
 /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
-#define OMAP_I2C_WE_REG			0x0c
 #define OMAP_I2C_SYSS_REG		0x10
 #define OMAP_I2C_BUF_REG		0x14
 #define OMAP_I2C_CNT_REG		0x18
@@ -67,7 +90,8 @@
 #define OMAP_I2C_SCLH_REG		0x38
 #define OMAP_I2C_SYSTEST_REG		0x3c
 #define OMAP_I2C_BUFSTAT_REG		0x40
-
+#define OMAP_I2C_IRQENABLE_CLR          OMAP_I2C_IE_REG
+#endif
 /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
 #define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
 #define OMAP_I2C_IE_RDR		(1 << 13)	/* RX Buffer drain int enable */
@@ -242,7 +266,10 @@ static void omap_i2c_idle(struct omap_i2
 	WARN_ON(dev->idle);

 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
+	if (cpu_is_omap44xx())
+		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 1);
+	else
+		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 	if (dev->rev < OMAP_I2C_REV_2) {
 		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
 	} else {
@@ -282,10 +309,8 @@ static int omap_i2c_init(struct omap_i2c

 		/* SYSC register is cleared by the reset; rewrite it */
 		if (dev->rev == OMAP_I2C_REV_ON_2430) {
-
 			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
 					   SYSC_AUTOIDLE_MASK);
-
 		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
 			u32 v;

@@ -302,6 +327,7 @@ static int omap_i2c_init(struct omap_i2c
 			 * WFI instruction.
 			 * REVISIT: Some wkup sources might not be needed.
 			 */
+			if (!cpu_is_omap44xx())
 			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
 							OMAP_I2C_WE_ALL);

@@ -331,11 +357,14 @@ static int omap_i2c_init(struct omap_i2c
 			psc = fclk_rate / 12000000;
 	}

-	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {

 		/* HSI2C controller internal clk rate should be 19.2 Mhz */
 		internal_clk = 19200;
-		fclk_rate = clk_get_rate(dev->fclk) / 1000;
+		if (cpu_is_omap44xx())
+			fclk_rate = 96000;
+		else
+			fclk_rate = clk_get_rate(dev->fclk) / 1000;

 		/* Compute prescaler divisor */
 		psc = fclk_rate / internal_clk;
@@ -650,14 +679,12 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			dev_warn(dev->dev, "Too much work in one IRQ\n");
 			break;
 		}
-
 		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat);
-
 		err = 0;
 		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
-					   OMAP_I2C_CON_STP);
+					OMAP_I2C_CON_STP);
 		}
 		if (stat & OMAP_I2C_STAT_AL) {
 			dev_err(dev->dev, "Arbitration lost\n");
@@ -683,7 +710,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
 					dev->buf_len--;
 					/* Data reg from 2430 is 8 bit wide */
 					if (!cpu_is_omap2430() &&
-							!cpu_is_omap34xx()) {
+						!cpu_is_omap34xx()
+							&& !cpu_is_omap44xx()) {
 						if (dev->buf_len) {
 							*dev->buf++ = w >> 8;
 							dev->buf_len--;
@@ -710,9 +738,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			if (dev->fifo_size) {
 				if (stat & OMAP_I2C_STAT_XRDY)
 					num_bytes = dev->fifo_size;
-				else
+				else {
 					num_bytes = omap_i2c_read_reg(dev,
 							OMAP_I2C_BUFSTAT_REG);
+				}
 			}
 			while (num_bytes) {
 				num_bytes--;
@@ -722,7 +751,8 @@ omap_i2c_isr(int this_irq, void *dev_id)
 					dev->buf_len--;
 					/* Data reg from  2430 is 8 bit wide */
 					if (!cpu_is_omap2430() &&
-							!cpu_is_omap34xx()) {
+						!cpu_is_omap34xx() &&
+							!cpu_is_omap44xx()) {
 						if (dev->buf_len) {
 							w |= *dev->buf++ << 8;
 							dev->buf_len--;
@@ -733,10 +763,10 @@ omap_i2c_isr(int this_irq, void *dev_id)
 						dev_err(dev->dev,
 							"XRDY IRQ while no "
 							"data to send\n");
-					if (stat & OMAP_I2C_STAT_XDR)
-						dev_err(dev->dev,
-							"XDR IRQ while no "
-							"data to send\n");
+						if (stat & OMAP_I2C_STAT_XDR)
+							dev_err(dev->dev,
+								"XDR IRQ while no "
+								"data to send\n");
 					break;
 				}
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
@@ -754,7 +784,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
 			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
 		}
 	}
-
 	return count ? IRQ_HANDLED : IRQ_NONE;
 }

@@ -822,7 +851,7 @@ omap_i2c_probe(struct platform_device *p

 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;

-	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx()) {
 		u16 s;

 		/* Set up the fifo size - Get total size */
@@ -834,8 +863,13 @@ omap_i2c_probe(struct platform_device *p
 		 * size. This is to ensure that we can handle the status on int
 		 * call back latencies.
 		 */
-		dev->fifo_size = (dev->fifo_size / 2);
-		dev->b_hw = 1; /* Enable hardware fixes */
+		if (cpu_is_omap44xx()) {
+			dev->fifo_size = 0;
+			dev->b_hw = 0; /* Enable hardware fixes */
+		} else {
+			dev->fifo_size = (dev->fifo_size / 2);
+			dev->b_hw = 1; /* Enable hardware fixes */
+		}
 	}

 	/* reset ASAP, clearing any IRQs */


---
Syed Rafiuddin

