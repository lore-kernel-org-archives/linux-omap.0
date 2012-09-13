From: Raphael Assenat <raph@8d.com>
Subject: [PATCH] mtd: nand: omap2: Fix the nand-disk led trigger
Date: Thu, 13 Sep 2012 11:06:15 -0400
Message-ID: <20120913150614.GC22993@renkinjitsu.usine.8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:49279 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753628Ab2IMPGS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 11:06:18 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

When the omap2 nand flash driver is used, the nand-disk led trigger does not
work due to nand_wait_ready not being called.

This patch exports the trigger from nand_base.c, letting specific drivers
such omap2 control the led as appropriate.

Signed-off-by: Raphael Assenat <raph@8d.com>

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index a11253a..b967c45 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -103,7 +103,7 @@ static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
  * For devices which display every fart in the system on a separate LED. Is
  * compiled away when LED support is disabled.
  */
-DEFINE_LED_TRIGGER(nand_led_trigger);
+DEFINE_LED_TRIGGER_GLOBAL(nand_led_trigger);
 
 static int check_offs_len(struct mtd_info *mtd,
 					loff_t ofs, uint64_t len)
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index ac4fd75..6aa683f 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -19,6 +19,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/leds.h>
 #include <linux/omap-dma.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -254,6 +255,8 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 	int ret = 0;
 	u32 *p = (u32 *)buf;
 
+	led_trigger_event(nand_led_trigger, LED_FULL);
+
 	/* take care of subpage reads */
 	if (len % 4) {
 		if (info->nand.options & NAND_BUSWIDTH_16)
@@ -284,6 +287,8 @@ static void omap_read_buf_pref(struct mtd_info *mtd, u_char *buf, int len)
 		/* disable and stop the PFPW engine */
 		gpmc_prefetch_reset(info->gpmc_cs);
 	}
+
+	led_trigger_event(nand_led_trigger, LED_OFF);
 }
 
 /**
@@ -302,6 +307,8 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 	u16 *p = (u16 *)buf;
 	unsigned long tim, limit;
 
+	led_trigger_event(nand_led_trigger, LED_FULL);
+
 	/* take care of subpage writes */
 	if (len % 2 != 0) {
 		writeb(*buf, info->nand.IO_ADDR_W);
@@ -335,6 +342,8 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
 		/* disable and stop the PFPW engine */
 		gpmc_prefetch_reset(info->gpmc_cs);
 	}
+
+	led_trigger_event(nand_led_trigger, LED_OFF);
 }
 
 /*
@@ -366,6 +375,8 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	unsigned n;
 	int ret;
 
+	led_trigger_event(nand_led_trigger, LED_FULL);
+
 	if (addr >= high_memory) {
 		struct page *p1;
 
@@ -417,6 +428,8 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	gpmc_prefetch_reset(info->gpmc_cs);
 
 	dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
+	
+	led_trigger_event(nand_led_trigger, LED_OFF);
 	return 0;
 
 out_copy_unmap:
@@ -428,6 +441,9 @@ out_copy:
 	else
 		is_write == 0 ? omap_read_buf8(mtd, (u_char *) addr, len)
 			: omap_write_buf8(mtd, (u_char *) addr, len);
+	
+	led_trigger_event(nand_led_trigger, LED_OFF);
+
 	return 0;
 }
 
@@ -886,6 +902,8 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 	else
 		timeo += (HZ * 20) / 1000;
 
+	led_trigger_event(nand_led_trigger, LED_FULL);
+
 	gpmc_nand_write(info->gpmc_cs,
 			GPMC_NAND_COMMAND, (NAND_CMD_STATUS & 0xFF));
 	while (time_before(jiffies, timeo)) {
@@ -894,6 +912,7 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
 			break;
 		cond_resched();
 	}
+	led_trigger_event(nand_led_trigger, LED_OFF);
 
 	status = gpmc_nand_read(info->gpmc_cs, GPMC_NAND_DATA);
 	return status;
@@ -909,6 +928,8 @@ static int omap_dev_ready(struct mtd_info *mtd)
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 							mtd);
 
+	led_trigger_event(nand_led_trigger, LED_FULL);
+
 	val = gpmc_read_status(GPMC_GET_IRQ_STATUS);
 	if ((val & 0x100) == 0x100) {
 		/* Clear IRQ Interrupt */
@@ -923,6 +944,8 @@ static int omap_dev_ready(struct mtd_info *mtd)
 			val = gpmc_read_status(GPMC_GET_IRQ_STATUS);
 		}
 	}
+	
+	led_trigger_event(nand_led_trigger, LED_OFF);
 
 	return 1;
 }
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 57977c6..321b7ef 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -23,6 +23,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/flashchip.h>
 #include <linux/mtd/bbm.h>
+#include <linux/leds.h>
 
 struct mtd_info;
 struct nand_flash_dev;
@@ -48,6 +49,9 @@ extern int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
 /* unlocks specified locked blocks */
 extern int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
 
+/* LED trigger for NAND drivers not using nand_wait_ready. */
+extern DEFINE_LED_TRIGGER_GLOBAL(nand_led_trigger);
+
 /* The maximum number of NAND chips in an array */
 #define NAND_MAX_CHIPS		8
 
