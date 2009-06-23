From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] OMAP: Rename OMAP_MPUIO_BASE to OMAP1_MPUIO_BASE
Date: Tue, 23 Jun 2009 17:53:14 +0300
Message-ID: <20090623145314.5476.19304.stgit@localhost>
References: <20090623145054.5476.64968.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55573 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbZFWOxN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 10:53:13 -0400
Received: from muru.com ([72.249.23.125] helo=[127.0.0.1])
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1MJ7N6-0001fA-18
	for linux-omap@vger.kernel.org; Tue, 23 Jun 2009 14:53:16 +0000
In-Reply-To: <20090623145054.5476.64968.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Rename OMAP_MPUIO_BASE to OMAP1_MPUIO_BASE

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c              |    4 ++--
 arch/arm/plat-omap/include/mach/gpio.h |    2 +-
 drivers/input/keyboard/omap-keypad.c   |   22 +++++++++++-----------
 drivers/mtd/nand/ams-delta.c           |    8 ++++----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 978b30e..555bab0 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -99,7 +99,7 @@
 #define OMAP850_GPIO_INT_MASK		0x10
 #define OMAP850_GPIO_INT_STATUS		0x14
 
-#define OMAP1_MPUIO_VBASE		OMAP1_IO_ADDRESS(OMAP_MPUIO_BASE)
+#define OMAP1_MPUIO_VBASE		OMAP1_IO_ADDRESS(OMAP1_MPUIO_BASE)
 
 /*
  * omap24xx specific GPIO registers
@@ -224,7 +224,7 @@ static struct gpio_bank gpio_bank_730[7] = {
 
 #ifdef CONFIG_ARCH_OMAP850
 static struct gpio_bank gpio_bank_850[7] = {
-	{ OMAP_MPUIO_BASE,     INT_850_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
+	{ OMAP1_MPUIO_BASE,     INT_850_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
 	{ OMAP850_GPIO1_BASE,  INT_850_GPIO_BANK1,  IH_GPIO_BASE,	METHOD_GPIO_850 },
 	{ OMAP850_GPIO2_BASE,  INT_850_GPIO_BANK2,  IH_GPIO_BASE + 32,	METHOD_GPIO_850 },
 	{ OMAP850_GPIO3_BASE,  INT_850_GPIO_BANK3,  IH_GPIO_BASE + 64,	METHOD_GPIO_850 },
diff --git a/arch/arm/plat-omap/include/mach/gpio.h b/arch/arm/plat-omap/include/mach/gpio.h
index 2b22a87..633ff68 100644
--- a/arch/arm/plat-omap/include/mach/gpio.h
+++ b/arch/arm/plat-omap/include/mach/gpio.h
@@ -29,7 +29,7 @@
 #include <linux/io.h>
 #include <mach/irqs.h>
 
-#define OMAP_MPUIO_BASE			0xfffb5000
+#define OMAP1_MPUIO_BASE			0xfffb5000
 
 #if (defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850))
 
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 87ec7b1..bba85ad 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -116,7 +116,7 @@ static irqreturn_t omap_kp_interrupt(int irq, void *dev_id)
 		}
 	} else
 		/* disable keyboard interrupt and schedule for handling */
-		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 	tasklet_schedule(&kp_tasklet);
 
@@ -143,20 +143,20 @@ static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char *state)
 
 	} else {
 		/* disable keyboard interrupt and schedule for handling */
-		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 		/* read the keypad status */
-		omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
+		omap_writew(0xff, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
 		for (col = 0; col < omap_kp->cols; col++) {
 			omap_writew(~(1 << col) & 0xff,
-				    OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
+				    OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
 
 			udelay(omap_kp->delay);
 
-			state[col] = ~omap_readw(OMAP_MPUIO_BASE +
+			state[col] = ~omap_readw(OMAP1_MPUIO_BASE +
 						 OMAP_MPUIO_KBR_LATCH) & 0xff;
 		}
-		omap_writew(0x00, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
+		omap_writew(0x00, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
 		udelay(2);
 	}
 }
@@ -234,7 +234,7 @@ static void omap_kp_tasklet(unsigned long data)
 			for (i = 0; i < omap_kp_data->rows; i++)
 				enable_irq(gpio_to_irq(row_gpios[i]));
 		} else {
-			omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+			omap_writew(0, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 			kp_cur_group = -1;
 		}
 	}
@@ -317,7 +317,7 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
 
 	/* Disable the interrupt for the MPUIO keyboard */
 	if (!cpu_is_omap24xx())
-		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
 	keymap = pdata->keymap;
 
@@ -391,7 +391,7 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->dbounce)
-		omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_GPIO_DEBOUNCING);
+		omap_writew(0xff, OMAP1_MPUIO_BASE + OMAP_MPUIO_GPIO_DEBOUNCING);
 
 	/* scan current status and enable interrupt */
 	omap_kp_scan_keypad(omap_kp, keypad_state);
@@ -402,7 +402,7 @@ static int __devinit omap_kp_probe(struct platform_device *pdev)
 					"omap-keypad", omap_kp) < 0)
 				goto err4;
 		}
-		omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		omap_writew(0, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 	} else {
 		for (irq_idx = 0; irq_idx < omap_kp->rows; irq_idx++) {
 			if (request_irq(gpio_to_irq(row_gpios[irq_idx]),
@@ -449,7 +449,7 @@ static int __devexit omap_kp_remove(struct platform_device *pdev)
 			free_irq(gpio_to_irq(row_gpios[i]), 0);
 		}
 	} else {
-		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 		free_irq(omap_kp->irq, 0);
 	}
 
diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index 782994e..005b91f 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -63,7 +63,7 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd->priv;
 
-	omap_writew(0, (OMAP_MPUIO_BASE + OMAP_MPUIO_IO_CNTL));
+	omap_writew(0, (OMAP1_MPUIO_BASE + OMAP_MPUIO_IO_CNTL));
 	omap_writew(byte, this->IO_ADDR_W);
 	ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NWE, 0);
 	ndelay(40);
@@ -78,7 +78,7 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
 
 	ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NRE, 0);
 	ndelay(40);
-	omap_writew(~0, (OMAP_MPUIO_BASE + OMAP_MPUIO_IO_CNTL));
+	omap_writew(~0, (OMAP1_MPUIO_BASE + OMAP_MPUIO_IO_CNTL));
 	res = omap_readw(this->IO_ADDR_R);
 	ams_delta_latch2_write(AMS_DELTA_LATCH2_NAND_NRE,
 			       AMS_DELTA_LATCH2_NAND_NRE);
@@ -178,8 +178,8 @@ static int __init ams_delta_init(void)
 	ams_delta_mtd->priv = this;
 
 	/* Set address of NAND IO lines */
-	this->IO_ADDR_R = (OMAP_MPUIO_BASE + OMAP_MPUIO_INPUT_LATCH);
-	this->IO_ADDR_W = (OMAP_MPUIO_BASE + OMAP_MPUIO_OUTPUT);
+	this->IO_ADDR_R = (OMAP1_MPUIO_BASE + OMAP_MPUIO_INPUT_LATCH);
+	this->IO_ADDR_W = (OMAP1_MPUIO_BASE + OMAP_MPUIO_OUTPUT);
 	this->read_byte = ams_delta_read_byte;
 	this->write_buf = ams_delta_write_buf;
 	this->read_buf = ams_delta_read_buf;

