From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] Move N800 specific OneNand setup to N800 platform file, was:
 Basic N800 support
Date: Sun, 04 Mar 2007 11:05:04 +0100
Message-ID: <45EA99D0.8010103@googlemail.com>
References: <13020905.97851169452503947.JavaMail.weblogic@ep_ml23>	<20070122171254.GD7382@atomide.com>	<20070206213648.GH9311@atomide.com>	<000101c74a77$39e94120$c7a3580a@swcenter.sec.samsung.co.kr>	<20070301134533.GA15801@angel.research.nokia.com>	<00a901c75c64$01b1e830$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070302164855.GA313@angel.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020301070109060300060106"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070302164855.GA313@angel.research.nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap-open-source@linux.omap.com
Cc: Kyungmin Park <kmpark@infradead.org>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------020301070109060300060106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jarkko Lavinen wrote:
>>If you don't need async mode settings, it also don't need it.
> 
> Yes. It is obvious. Removed async part. New patch attached.

Are there any dependencies to apply this patch I missed? I
tried to apply it on top of  01-onenand.patch posted by Tony
[1] but got rejects.

If not, sligthly modified patch that cleanly applies on top
of [1] in attachment. I additionally removed duplication of
omap2_onenand_readw and writew. Can you please test if it is
still okay? ;)

Dirk

[1]
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008958.html


--------------020301070109060300060106
Content-Type: text/plain;
	name="0001-Move-N800-specific-OneNand-setup-to-N800-platform-file.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0001-Move-N800-specific-OneNand-setup-to-N800-platform-file.txt"

>From 5b99cf491a1105cde1f766bb760e1f39d964dc1a Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Fri, 2 Mar 2007 17:02:09 +0200
Subject: [PATCH] Move N800 specific OneNand setup to N800 platform file.
Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 arch/arm/mach-omap2/board-n800-flash.c |   97 ++++++++++++++++++++++++-
 drivers/mtd/onenand/omap2.c            |  124 ++------------------------------
 include/asm-arm/arch-omap/onenand.h    |    1 +
 3 files changed, 104 insertions(+), 118 deletions(-)

Index: linux-osk/arch/arm/mach-omap2/board-n800-flash.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap2/board-n800-flash.c
+++ linux-osk/arch/arm/mach-omap2/board-n800-flash.c
@@ -12,16 +12,100 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <asm/mach/flash.h>
+#include <linux/mtd/onenand_regs.h>
+
+#include <asm/io.h>
 #include <asm/arch/onenand.h>
 #include <asm/arch/board.h>
+#include <asm/arch/gpmc.h>
 
 static struct mtd_partition n800_partitions[8];
 
+static unsigned short n800_onenand_readw(void __iomem *addr)
+{
+	return readw(addr);
+}
+
+static void n800_onenand_writew(unsigned short value, void __iomem *addr)
+{
+	writew(value, addr);
+}
+
+static int n800_onenand_set_sync_mode(int cs, void __iomem *onenand_base)
+{
+	const int min_gpmc_clk_period = 18;
+	struct gpmc_timings t;
+	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
+	u32 reg;
+
+	tick_ns = gpmc_round_ns_to_ticks(1);
+	div = gpmc_cs_calc_divider(cs, min_gpmc_clk_period);
+	gpmc_clk_ns = div * tick_ns;
+	if (gpmc_clk_ns >= 24)
+		latency = 3;
+	else
+		latency = 4;
+
+	/* Configure OneNAND for sync read */
+	reg = n800_onenand_readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
+	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
+		ONENAND_SYS_CFG1_SYNC_READ |
+		ONENAND_SYS_CFG1_BL_16;
+	n800_onenand_writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
+
+	/* FIXME: Get timings from platform data */
+	/* Set syncronous read timings */
+	memset(&t, 0, sizeof(t));
+	t.sync_clk = min_gpmc_clk_period;
+	t.cs_on = 0;
+	t.adv_on = gpmc_round_ns_to_ticks(7);
+	fclk_offset_ns = t.adv_on + gpmc_round_ns_to_ticks(7);
+	fclk_offset = fclk_offset_ns / gpmc_round_ns_to_ticks(1);
+	t.page_burst_access = gpmc_clk_ns;
+
+	/* Read */
+	t.adv_rd_off = fclk_offset_ns + gpmc_round_ns_to_ticks(7);
+	t.oe_on = t.adv_rd_off;
+	t.access = fclk_offset_ns + (latency + 1) * gpmc_clk_ns;
+	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
+	t.cs_rd_off = t.oe_off;
+	t.rd_cycle = t.cs_rd_off + gpmc_round_ns_to_ticks(17);
+
+	/* Write */
+	t.adv_wr_off = t.adv_on + gpmc_round_ns_to_ticks(12);
+	t.we_on = t.adv_wr_off + gpmc_round_ns_to_ticks(1);
+	t.we_off = t.we_on + gpmc_round_ns_to_ticks(40);
+	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(1);
+	t.wr_cycle = t.cs_wr_off + gpmc_round_ns_to_ticks(1);
+
+	/* Configure GPMC for synchronous read */
+	fclk_offset %= div;
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
+			  GPMC_CONFIG1_WRAPBURST_SUPP |
+			  GPMC_CONFIG1_READMULTIPLE_SUPP |
+			  GPMC_CONFIG1_READTYPE_SYNC |
+			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
+			  GPMC_CONFIG1_PAGE_LEN(2) |
+			  GPMC_CONFIG1_WAIT_READ_MON |
+			  GPMC_CONFIG1_WAIT_PIN_SEL(0) |
+			  GPMC_CONFIG1_DEVICESIZE_16 |
+			  GPMC_CONFIG1_DEVICETYPE_NOR |
+			  GPMC_CONFIG1_MUXADDDATA);
+
+	return gpmc_cs_set_timings(cs, &t);
+}
+
+static int n800_onenand_setup(void __iomem *);
+
 static struct omap_onenand_platform_data n800_onenand_data = {
 	.cs = 0,
 	.gpio_irq = 26,
 	.parts = n800_partitions,
-	.nr_parts = 0 /* filled later */
+	.nr_parts = 0, /* filled later */
+	.onenand_setup = n800_onenand_setup,
+	.onenand_readw = n800_onenand_readw,
+	.onenand_writew = n800_onenand_writew
 };
 
 static struct platform_device n800_onenand_device = {
@@ -32,6 +116,19 @@ static struct platform_device n800_onena
 	},
 };
 
+static int n800_onenand_setup(void __iomem *onenand_base)
+{
+	struct omap_onenand_platform_data *datap = &n800_onenand_data;
+	struct device *dev = &n800_onenand_device.dev;
+
+	/* Set sync timings in GPMC */
+	if (n800_onenand_set_sync_mode(datap->cs, onenand_base) < 0) {
+		dev_err(dev, "Unable to set synchronous mode\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 void __init n800_flash_init(void)
 {
Index: linux-osk/drivers/mtd/onenand/omap2.c
===================================================================
--- linux-osk.orig/drivers/mtd/onenand/omap2.c
+++ linux-osk/drivers/mtd/onenand/omap2.c
@@ -62,16 +62,6 @@ struct omap2_onenand {
 	int dma_channel;
 };
 
-static unsigned short omap2_onenand_readw(void __iomem *addr)
-{
-	return readw(addr);
-}
-
-static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
-{
-	writew(value, addr);
-}
-
 static void omap2_onenand_dma_cb(int lch, u16 ch_status, void *data)
 {
 	struct omap2_onenand *info = data;
@@ -92,6 +82,7 @@ static int omap2_onenand_wait(struct mtd
 {
 	struct omap2_onenand *info = container_of(mtd, struct omap2_onenand, mtd);
 	struct onenand_chip *this = mtd->priv;
+	struct omap_onenand_platform_data *pdata = info->pdev->dev.platform_data;
 	unsigned int interrupt = 0;
 	unsigned int ctrl, ecc;
 	unsigned long timeout;
@@ -104,9 +95,9 @@ static int omap2_onenand_wait(struct mtd
 
 	if (state != FL_READING) {
 		/* Turn interrupts on */
-		syscfg = omap2_onenand_readw(info->onenand.base + ONENAND_REG_SYS_CFG1);
+		syscfg = pdata->onenand_readw(info->onenand.base + ONENAND_REG_SYS_CFG1);
 		syscfg |= ONENAND_SYS_CFG1_IOBE;
-		omap2_onenand_writew(syscfg, info->onenand.base + ONENAND_REG_SYS_CFG1);
+		pdata->onenand_writew(syscfg, info->onenand.base + ONENAND_REG_SYS_CFG1);
 
 		INIT_COMPLETION(info->irq_done);
 		if (!omap_get_gpio_datain(info->gpio_irq)) {
@@ -115,13 +106,13 @@ static int omap2_onenand_wait(struct mtd
 		}
 	} else {
 		/* Turn interrupts off */
-		syscfg = omap2_onenand_readw(info->onenand.base + ONENAND_REG_SYS_CFG1);
+		syscfg = pdata->onenand_readw(info->onenand.base + ONENAND_REG_SYS_CFG1);
 		syscfg &= ~ONENAND_SYS_CFG1_IOBE;
-		omap2_onenand_writew(syscfg, info->onenand.base + ONENAND_REG_SYS_CFG1);
+		pdata->onenand_writew(syscfg, info->onenand.base + ONENAND_REG_SYS_CFG1);
 
 		timeout = jiffies + msecs_to_jiffies(20);
 		while (time_before(jiffies, timeout)) {
-			if (omap2_onenand_readw(info->onenand.base + ONENAND_REG_INTERRUPT) &
+			if (pdata->onenand_readw(info->onenand.base + ONENAND_REG_INTERRUPT) &
 			    ONENAND_INT_MASTER)
 				break;
 		}
@@ -255,107 +246,6 @@ static int omap2_onenand_write_bufferram
 	return 0;
 }
 
-static int omap2_onenand_set_async_mode(struct omap2_onenand *info)
-{
-	struct gpmc_timings t;
-
-	memset(&t, 0, sizeof(t));
-	t.sync_clk = 0;
-	t.cs_on = 0;
-	t.adv_on = gpmc_round_ns_to_ticks(1);
-
-	/* FIXME: Get timings from platform data */
-	/* Read */
-	t.adv_rd_off = t.adv_on + gpmc_round_ns_to_ticks(12);
-	t.oe_on = t.adv_rd_off + gpmc_round_ns_to_ticks(1);
-	t.access = t.oe_on + gpmc_round_ns_to_ticks(35);
-	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
-	t.cs_rd_off = t.oe_off;
-	t.rd_cycle = t.cs_rd_off + gpmc_round_ns_to_ticks(15);
-
-	/* Write */
-	t.adv_wr_off = t.adv_on + gpmc_round_ns_to_ticks(12);
-	t.we_on = t.adv_wr_off + gpmc_round_ns_to_ticks(1);
-	t.we_off = t.we_on + gpmc_round_ns_to_ticks(30);
-	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(1);
-	t.wr_cycle = t.cs_wr_off + gpmc_round_ns_to_ticks(15);
-
-	/* Configure GPMC for asynchronous read */
-	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG1,
-			  GPMC_CONFIG1_READTYPE_ASYNC |
-			  GPMC_CONFIG1_DEVICESIZE_16 |
-			  GPMC_CONFIG1_DEVICETYPE_NOR |
-			  GPMC_CONFIG1_MUXADDDATA);
-
-	return gpmc_cs_set_timings(info->gpmc_cs, &t);
-}
-
-static int omap2_onenand_set_sync_mode(struct omap2_onenand *info)
-{
-	const int min_gpmc_clk_period = 18;
-	struct gpmc_timings t;
-	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency, cs;
-	u32 reg;
-
-	cs = info->gpmc_cs;
-	tick_ns = gpmc_round_ns_to_ticks(1);
-	div = gpmc_cs_calc_divider(cs, min_gpmc_clk_period);
-	gpmc_clk_ns = div * tick_ns;
-	if (gpmc_clk_ns >= 24)
-		latency = 3;
-	else
-		latency = 4;
-
-	/* Configure OneNAND for sync read */
-	reg = omap2_onenand_readw(info->onenand.base + ONENAND_REG_SYS_CFG1);
-	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
-	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
-		ONENAND_SYS_CFG1_SYNC_READ |
-		ONENAND_SYS_CFG1_BL_16;
-	omap2_onenand_writew(reg, info->onenand.base + ONENAND_REG_SYS_CFG1);
-
-	/* FIXME: Get timings from platform data */
-	/* Set syncronous read timings */
-	memset(&t, 0, sizeof(t));
-	t.sync_clk = min_gpmc_clk_period;
-	t.cs_on = 0;
-	t.adv_on = gpmc_round_ns_to_ticks(7);
-	fclk_offset_ns = t.adv_on + gpmc_round_ns_to_ticks(7);
-	fclk_offset = fclk_offset_ns / gpmc_round_ns_to_ticks(1);
-	t.page_burst_access = gpmc_clk_ns;
-
-	/* Read */
-	t.adv_rd_off = fclk_offset_ns + gpmc_round_ns_to_ticks(7);
-	t.oe_on = t.adv_rd_off;
-	t.access = fclk_offset_ns + (latency + 1) * gpmc_clk_ns;
-	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
-	t.cs_rd_off = t.oe_off;
-	t.rd_cycle = t.cs_rd_off + gpmc_round_ns_to_ticks(17);
-
-	/* Write */
-	t.adv_wr_off = t.adv_on + gpmc_round_ns_to_ticks(12);
-	t.we_on = t.adv_wr_off + gpmc_round_ns_to_ticks(1);
-	t.we_off = t.we_on + gpmc_round_ns_to_ticks(40);
-	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(1);
-	t.wr_cycle = t.cs_wr_off + gpmc_round_ns_to_ticks(1);
-
-	/* Configure GPMC for synchronous read */
-	fclk_offset %= div;
-	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
-			  GPMC_CONFIG1_WRAPBURST_SUPP |
-			  GPMC_CONFIG1_READMULTIPLE_SUPP |
-			  GPMC_CONFIG1_READTYPE_SYNC |
-			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
-			  GPMC_CONFIG1_PAGE_LEN(2) |
-			  GPMC_CONFIG1_WAIT_READ_MON |
-			  GPMC_CONFIG1_WAIT_PIN_SEL(0) |
-			  GPMC_CONFIG1_DEVICESIZE_16 |
-			  GPMC_CONFIG1_DEVICETYPE_NOR |
-			  GPMC_CONFIG1_MUXADDDATA);
-
-	return gpmc_cs_set_timings(cs, &t);
-}
-
 static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 {
 	struct omap_onenand_platform_data *pdata;
@@ -396,16 +286,13 @@ static int __devinit omap2_onenand_probe
 		goto err_release_mem_region;
 	}
 
-	/* Force OneNAND to async mode */
-	omap2_onenand_writew(ONENAND_SYS_CFG1_BRL_4 | ONENAND_SYS_CFG1_RDY |
-			     ONENAND_SYS_CFG1_INT, info->onenand.base + ONENAND_REG_SYS_CFG1);
-
-	/* Set async timings in GPMC */
-	if (omap2_onenand_set_async_mode(info) < 0) {
-		dev_err(&pdev->dev, "Unable to set async mode\n");
-		r = -EINVAL;
-		goto err_iounmap;
-	}
+	if (pdata->onenand_setup != NULL) {
+		r = pdata->onenand_setup(info->onenand.base);
+		if (r < 0) {
+			dev_err(&pdev->dev, "Onenand platform setup failed: %d\n", r);
+			goto err_iounmap;
+		}
+        }
 
 	if ((r = omap_request_gpio(info->gpio_irq)) < 0) {
 		dev_err(&pdev->dev,  "Failed to request GPIO%d for OneNAND\n",
@@ -448,12 +335,6 @@ static int __devinit omap2_onenand_probe
 	if ((r = onenand_scan(&info->mtd, 1)) < 0)
 		goto err_release_dma;
 
-	if (omap2_onenand_set_sync_mode(info) < 0) {
-		dev_err(&pdev->dev, "Unable to set sync mode\n");
-		r = -EINVAL;
-		goto err_release_onenand;
-	}
-
 #ifdef CONFIG_MTD_PARTITIONS
 	if (pdata->parts != NULL)
 		r = add_mtd_partitions(&info->mtd, pdata->parts, pdata->nr_parts);
Index: linux-osk/include/asm-arm/arch-omap/onenand.h
===================================================================
--- linux-osk.orig/include/asm-arm/arch-omap/onenand.h
+++ linux-osk/include/asm-arm/arch-omap/onenand.h
@@ -16,4 +16,7 @@ struct omap_onenand_platform_data {
 	int			gpio_irq;
 	struct mtd_partition	*parts;
 	int			nr_parts;
+	int                     (*onenand_setup)(void __iomem *);
+	unsigned short 		(*onenand_readw)(void __iomem *);
+	void 			(*onenand_writew)(unsigned short, void __iomem *);
 };


--------------020301070109060300060106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020301070109060300060106--
