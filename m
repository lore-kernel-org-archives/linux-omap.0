From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: Re: Basic N800 support
Date: Fri, 2 Mar 2007 18:48:55 +0200
Message-ID: <20070302164855.GA313@angel.research.nokia.com>
References: <13020905.97851169452503947.JavaMail.weblogic@ep_ml23>
	<20070122171254.GD7382@atomide.com>
	<20070206213648.GH9311@atomide.com>
	<000101c74a77$39e94120$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070301134533.GA15801@angel.research.nokia.com>
	<00a901c75c64$01b1e830$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <00a901c75c64$01b1e830$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kyungmin

> If you don't need async mode settings, it also don't need it.
Yes. It is obvious. Removed async part. New patch attached.

Best Regards
Jarkko Lavinen

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
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

diff --git a/arch/arm/mach-omap2/board-n800-flash.c b/arch/arm/mach-omap2/board-n800-flash.c
index 3a4c52a..84ba984 100644
--- a/arch/arm/mach-omap2/board-n800-flash.c
+++ b/arch/arm/mach-omap2/board-n800-flash.c
@@ -12,16 +12,23 @@
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
 
+static int n800_onenand_setup(void __iomem *);
+
 static struct omap_onenand_platform_data n800_onenand_data = {
 	.cs = 0,
 	.gpio_irq = 26,
 	.parts = n800_partitions,
-	.nr_parts = 0 /* filled later */
+	.nr_parts = 0, /* filled later */
+	.onenand_setup = n800_onenand_setup
 };
 
 static struct platform_device n800_onenand_device = {
@@ -32,6 +39,94 @@ static struct platform_device n800_onenand_device = {
 	},
 };
 
+static unsigned short omap2_onenand_readw(void __iomem *addr)
+{
+	return readw(addr);
+}
+
+static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
+{
+	writew(value, addr);
+}
+
+static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base)
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
+	reg = omap2_onenand_readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
+	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
+		ONENAND_SYS_CFG1_SYNC_READ |
+		ONENAND_SYS_CFG1_BL_16;
+	omap2_onenand_writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
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
+static int n800_onenand_setup(void __iomem *onenand_base)
+{
+	struct omap_onenand_platform_data *datap = &n800_onenand_data;
+	struct device *dev = &n800_onenand_device.dev;
+
+	/* Set sync timings in GPMC */
+	if (omap2_onenand_set_sync_mode(datap->cs, onenand_base) < 0) {
+		dev_err(dev, "Unable to set synchronous mode\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 void __init n800_flash_init(void)
 {
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 79640b5..bbc9beb 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -286,107 +286,6 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
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
 static void __devexit omap2_onenand_shutdown(struct platform_device *pdev)
 {
 	struct omap2_onenand *info = dev_get_drvdata(&pdev->dev);
@@ -438,16 +337,13 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
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
@@ -490,12 +386,6 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
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
diff --git a/include/asm-arm/arch-omap/onenand.h b/include/asm-arm/arch-omap/onenand.h
index b8a19be..3e8ab2f 100644
--- a/include/asm-arm/arch-omap/onenand.h
+++ b/include/asm-arm/arch-omap/onenand.h
@@ -16,4 +16,5 @@ struct omap_onenand_platform_data {
 	int			gpio_irq;
 	struct mtd_partition	*parts;
 	int			nr_parts;
+	int                     (*onenand_setup)(void __iomem *);
 };
-- 
1.4.4.4


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z--
