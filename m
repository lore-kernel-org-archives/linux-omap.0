From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 3/3] ARM: OMAP: Update OneNAND support
Date: Wed, 06 Aug 2008 09:57:37 +0300
Message-ID: <48994B61.5070109@nokia.com>
References: <4892C533.50904@nokia.com> <20080804140243.GG8885@atomide.com> <48994A83.8040904@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25452 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbYHFG4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 02:56:14 -0400
In-Reply-To: <48994A83.8040904@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-n800-flash.c |  241 +++++++++++++++++++++++---------
 include/asm-arm/arch-omap/onenand.h    |    3 +
 include/linux/mtd/onenand_regs.h       |    2 +
 3 files changed, 182 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-flash.c b/arch/arm/mach-omap2/board-n800-flash.c
index f7403b9..fbf83b3 100644
--- a/arch/arm/mach-omap2/board-n800-flash.c
+++ b/arch/arm/mach-omap2/board-n800-flash.c
@@ -19,13 +19,12 @@
 #include <asm/arch/board.h>
 #include <asm/arch/gpmc.h>
 
-static struct mtd_partition n800_partitions[8];
+struct mtd_partition n800_partitions[ONENAND_MAX_PARTITIONS];
 
-static int n800_onenand_setup(void __iomem *, int freq);
+int n800_onenand_setup(void __iomem *, int freq);
 
 static struct omap_onenand_platform_data n800_onenand_data = {
 	.cs = 0,
-	.gpio_irq = 26,
 	.parts = n800_partitions,
 	.nr_parts = 0, /* filled later */
 	.onenand_setup = n800_onenand_setup,
@@ -39,6 +38,55 @@ static struct platform_device n800_onenand_device = {
 	},
 };
 
+static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
+{
+	struct gpmc_timings t;
+
+	const int t_cer = 15;
+	const int t_avdp = 12;
+	const int t_aavdh = 7;
+	const int t_ce = 76;
+	const int t_aa = 76;
+	const int t_oe = 20;
+	const int t_cez = 20; /* max of t_cez, t_oez */
+	const int t_ds = 30;
+	const int t_wpl = 40;
+	const int t_wph = 30;
+
+	memset(&t, 0, sizeof(t));
+	t.sync_clk = 0;
+	t.cs_on = 0;
+	t.adv_on = 0;
+
+	/* Read */
+	t.adv_rd_off = gpmc_round_ns_to_ticks(max_t(int, t_avdp, t_cer));
+	t.oe_on  = t.adv_rd_off + gpmc_round_ns_to_ticks(t_aavdh);
+	t.access = t.adv_on + gpmc_round_ns_to_ticks(t_aa);
+	t.access = max_t(int, t.access, t.cs_on + gpmc_round_ns_to_ticks(t_ce));
+	t.access = max_t(int, t.access, t.oe_on + gpmc_round_ns_to_ticks(t_oe));
+	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
+	t.cs_rd_off = t.oe_off;
+	t.rd_cycle  = t.cs_rd_off + gpmc_round_ns_to_ticks(t_cez);
+
+	/* Write */
+	t.adv_wr_off = t.adv_rd_off;
+	t.we_on  = t.oe_on;
+	if (cpu_is_omap34xx()) {
+		t.wr_data_mux_bus = t.we_on;
+		t.wr_access = t.we_on + gpmc_round_ns_to_ticks(t_ds);
+	}
+	t.we_off = t.we_on + gpmc_round_ns_to_ticks(t_wpl);
+	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(t_wph);
+	t.wr_cycle  = t.cs_wr_off + gpmc_round_ns_to_ticks(t_cez);
+
+	/* Configure GPMC for asynchronous read */
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
+			  GPMC_CONFIG1_DEVICESIZE_16 |
+			  GPMC_CONFIG1_MUXADDDATA);
+
+	return gpmc_cs_set_timings(cs, &t);
+}
+
 static unsigned short omap2_onenand_readw(void __iomem *addr)
 {
 	return readw(addr);
@@ -49,54 +97,121 @@ static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
 	writew(value, addr);
 }
 
+static void set_onenand_cfg(void __iomem *onenand_base, int latency,
+			    int sync_write, int hf)
+{
+	u32 reg;
+
+	reg = omap2_onenand_readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
+	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
+		ONENAND_SYS_CFG1_SYNC_READ |
+		ONENAND_SYS_CFG1_BL_16;
+	if (sync_write)
+		reg |= ONENAND_SYS_CFG1_SYNC_WRITE;
+	else
+		reg &= ~ONENAND_SYS_CFG1_SYNC_WRITE;
+	if (hf)
+		reg |= ONENAND_SYS_CFG1_HF;
+	else
+		reg &= ~ONENAND_SYS_CFG1_HF;
+	omap2_onenand_writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
+}
+
 static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 				       int freq)
 {
 	struct gpmc_timings t;
-	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_avdp, t_wpl, t_wea;
+	const int t_cer  = 15;
+	const int t_avdp = 12;
+	const int t_cez  = 20; /* max of t_cez, t_oez */
+	const int t_ds   = 30;
+	const int t_wpl  = 40;
+	const int t_wph  = 30;
+	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
 	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
-	int err;
+	int err, ticks_cez, sync_write = 0, first_time = 0, hf = 0;
 	u32 reg;
 
-again:
+	if (!freq) {
+		/* Very first call freq is not known */
+		err = omap2_onenand_set_async_mode(cs, onenand_base);
+		if (err)
+			return err;
+		reg = omap2_onenand_readw(onenand_base +
+					  ONENAND_REG_VERSION_ID);
+		switch ((reg >> 4) & 0xf) {
+		case 0:
+			freq = 40;
+			break;
+		case 1:
+			freq = 54;
+			break;
+		case 2:
+			freq = 66;
+			break;
+		case 3:
+			freq = 83;
+			break;
+		case 4:
+			freq = 104;
+			break;
+		default:
+			freq = 54;
+			break;
+		}
+		first_time = 1;
+	}
+
 	switch (freq) {
 	case 83:
 		min_gpmc_clk_period = 12; /* 83 MHz */
-		t_ces  = 5;
-		t_avds = 5;
-		t_avdh = 6;
-		t_avdp = 12;
-		t_wpl  = 40;
-		t_wea  = 15;
+		t_ces   = 5;
+		t_avds  = 4;
+		t_avdh  = 2;
+		t_ach   = 6;
+		t_aavdh = 6;
+		t_rdyo  = 9;
+		if (cpu_is_omap34xx())
+			sync_write = 1;
 		break;
 	case 66:
 		min_gpmc_clk_period = 15; /* 66 MHz */
-		t_ces  = 6;
-		t_avds = 5;
-		t_avdh = 6;
-		t_avdp = 12;
-		t_wpl  = 40;
-		t_wea  = 15;
+		t_ces   = 6;
+		t_avds  = 5;
+		t_avdh  = 2;
+		t_ach   = 6;
+		t_aavdh = 6;
+		t_rdyo  = 11;
+		if (cpu_is_omap34xx())
+			sync_write = 1;
 		break;
 	default:
 		min_gpmc_clk_period = 18; /* 54 MHz */
-		t_ces  = 7;
-		t_avds = 7;
-		t_avdh = 7;
-		t_avdp = 12;
-		t_wpl  = 40;
-		t_wea  = 15;
+		t_ces   = 7;
+		t_avds  = 7;
+		t_avdh  = 7;
+		t_ach   = 9;
+		t_aavdh = 7;
+		t_rdyo  = 15;
 		break;
 	}
 
 	tick_ns = gpmc_ticks_to_ns(1);
 	div = gpmc_cs_calc_divider(cs, min_gpmc_clk_period);
 	gpmc_clk_ns = gpmc_ticks_to_ns(div);
-	if (gpmc_clk_ns >= 25) /* 40 MHz*/
+	if (gpmc_clk_ns < 15) /* >66Mhz */
+		hf = 1;
+	if (hf)
+		latency = 6;
+	else if (gpmc_clk_ns >= 25) /* 40 MHz*/
 		latency = 3;
 	else
 		latency = 4;
 
+	if (first_time)
+		set_onenand_cfg(onenand_base, latency, sync_write, hf);
+
 	if (div == 1) {
 		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
 		reg |= (1 << 7);
@@ -121,7 +236,7 @@ again:
 		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG4, reg);
 	}
 
-	/* Set syncronous read timings */
+	/* Set synchronous read timings */
 	memset(&t, 0, sizeof(t));
 	t.sync_clk = min_gpmc_clk_period;
 	t.cs_on = 0;
@@ -132,28 +247,51 @@ again:
 
 	/* Read */
 	t.adv_rd_off = gpmc_ticks_to_ns(fclk_offset + gpmc_ns_to_ticks(t_avdh));
-	t.oe_on = t.adv_rd_off;
+	t.oe_on = gpmc_ticks_to_ns(fclk_offset + gpmc_ns_to_ticks(t_ach));
 	t.access = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div);
 	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
 	t.cs_rd_off = t.oe_off;
-	t.rd_cycle = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div + div);
+	ticks_cez = ((gpmc_ns_to_ticks(t_cez) + div - 1) / div) * div;
+	t.rd_cycle = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div +
+		     ticks_cez);
 
 	/* Write */
-	t.adv_wr_off = t.adv_on + gpmc_round_ns_to_ticks(t_avdp);
-	t.we_on = t.adv_wr_off + gpmc_round_ns_to_ticks(t_avdh);
-	t.we_off = t.we_on + gpmc_round_ns_to_ticks(t_wpl);
-	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(1);
-	t.wr_cycle = t.we_off + gpmc_round_ns_to_ticks(t_wea);
+	if (sync_write) {
+		t.adv_wr_off = t.adv_rd_off;
+		t.we_on  = 0;
+		t.we_off = t.cs_rd_off;
+		t.cs_wr_off = t.cs_rd_off;
+		t.wr_cycle  = t.rd_cycle;
+		if (cpu_is_omap34xx()) {
+			t.wr_data_mux_bus = gpmc_ticks_to_ns(fclk_offset +
+					gpmc_ns_to_ticks(min_gpmc_clk_period +
+					t_rdyo));
+			t.wr_access = t.access;
+		}
+	} else {
+		t.adv_wr_off = gpmc_round_ns_to_ticks(max_t(int, t_avdp, t_cer));
+		t.we_on  = t.adv_wr_off + gpmc_round_ns_to_ticks(t_aavdh);
+		t.we_off = t.we_on + gpmc_round_ns_to_ticks(t_wpl);
+		t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(t_wph);
+		t.wr_cycle  = t.cs_wr_off + gpmc_round_ns_to_ticks(t_cez);
+		if (cpu_is_omap34xx()) {
+			t.wr_data_mux_bus = t.we_on;
+			t.wr_access = t.we_on + gpmc_round_ns_to_ticks(t_ds);
+		}
+	}
 
 	/* Configure GPMC for synchronous read */
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
 			  GPMC_CONFIG1_WRAPBURST_SUPP |
 			  GPMC_CONFIG1_READMULTIPLE_SUPP |
 			  GPMC_CONFIG1_READTYPE_SYNC |
+			  (sync_write ? GPMC_CONFIG1_WRITEMULTIPLE_SUPP : 0) |
+			  (sync_write ? GPMC_CONFIG1_WRITETYPE_SYNC : 0) |
 			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
 			  GPMC_CONFIG1_PAGE_LEN(2) |
-			  GPMC_CONFIG1_WAIT_READ_MON |
-			  GPMC_CONFIG1_WAIT_PIN_SEL(0) |
+			  (cpu_is_omap34xx() ? 0 :
+				(GPMC_CONFIG1_WAIT_READ_MON |
+				 GPMC_CONFIG1_WAIT_PIN_SEL(0))) |
 			  GPMC_CONFIG1_DEVICESIZE_16 |
 			  GPMC_CONFIG1_DEVICETYPE_NOR |
 			  GPMC_CONFIG1_MUXADDDATA);
@@ -162,39 +300,12 @@ again:
 	if (err)
 		return err;
 
-	if (!freq) {
-		/* Very first call freq is not known */
-		reg = omap2_onenand_readw(onenand_base + ONENAND_REG_VERSION_ID);
-		switch ((reg >> 4) & 0xf) {
-		case 0:
-			freq = 40;
-			break;
-		case 1:
-			freq = 54;
-			break;
-		case 2:
-			freq = 66;
-			break;
-		case 3:
-			freq = 83;
-			break;
-		}
-		if (freq && freq != 54)
-			goto again;
-	}
-
-	/* Configure OneNAND for sync read */
-	reg = omap2_onenand_readw(onenand_base + ONENAND_REG_SYS_CFG1);
-	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
-	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
-		ONENAND_SYS_CFG1_SYNC_READ |
-		ONENAND_SYS_CFG1_BL_16;
-	omap2_onenand_writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
+	set_onenand_cfg(onenand_base, latency, sync_write, hf);
 
 	return 0;
 }
 
-static int n800_onenand_setup(void __iomem *onenand_base, int freq)
+int n800_onenand_setup(void __iomem *onenand_base, int freq)
 {
 	struct omap_onenand_platform_data *datap = &n800_onenand_data;
 	struct device *dev = &n800_onenand_device.dev;
@@ -213,6 +324,8 @@ void __init n800_flash_init(void)
 	const struct omap_partition_config *part;
 	int i = 0;
 
+	n800_onenand_data.gpio_irq = cpu_is_omap34xx() ? 65 : 26;
+
 	while ((part = omap_get_nr_config(OMAP_TAG_PARTITION,
 				struct omap_partition_config, i)) != NULL) {
 		struct mtd_partition *mpart;
diff --git a/include/asm-arm/arch-omap/onenand.h b/include/asm-arm/arch-omap/onenand.h
index f0f28d3..e302371 100644
--- a/include/asm-arm/arch-omap/onenand.h
+++ b/include/asm-arm/arch-omap/onenand.h
@@ -21,3 +21,6 @@ struct omap_onenand_platform_data {
 };
 
 int omap2_onenand_rephase(void);
+
+#define ONENAND_MAX_PARTITIONS 8
+
diff --git a/include/linux/mtd/onenand_regs.h b/include/linux/mtd/onenand_regs.h
index d1b310c..0c6bbe2 100644
--- a/include/linux/mtd/onenand_regs.h
+++ b/include/linux/mtd/onenand_regs.h
@@ -152,6 +152,8 @@
 #define ONENAND_SYS_CFG1_INT		(1 << 6)
 #define ONENAND_SYS_CFG1_IOBE		(1 << 5)
 #define ONENAND_SYS_CFG1_RDY_CONF	(1 << 4)
+#define ONENAND_SYS_CFG1_HF		(1 << 2)
+#define ONENAND_SYS_CFG1_SYNC_WRITE	(1 << 1)
 
 /*
  * Controller Status Register F240h (R)
-- 
1.5.4.3

