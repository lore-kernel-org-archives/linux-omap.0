From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v8 3/6] ARM: OMAP2+: gpmc: handle additional timings
Date: Fri, 5 Oct 2012 21:09:28 +0530
Message-ID: <f229aba0202eae1311ddab462b11d8dea7a855b7.1349444936.git.afzal@ti.com>
References: <cover.1349444935.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51699 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab2JEPji (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 11:39:38 -0400
In-Reply-To: <cover.1349444935.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Configure busturnaround, cycle2cycledelay, waitmonitoringtime,
clkactivationtime in gpmc_cs_set_timings(). This is done so
that boards can configure these parameters of gpmc in Kernel
instead of relying on bootloader. Also configure bool type
timings like extradelay.

This needed change to the existing users that were configuring
clk activation time and extra delay by directly writing to
registers. Thanks to Tony for making me aware of users of clk
activation and being kind enough to test the modified one.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c     | 28 +++++---------------
 arch/arm/mach-omap2/gpmc.c             | 48 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/usb-tusb6010.c     |  3 ++-
 arch/arm/plat-omap/include/plat/gpmc.h | 19 ++++++++++++++
 4 files changed, 75 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 916716e..3b61544 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -284,27 +284,10 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 					sync_read, sync_write, hf, vhf);
 
 	if (div == 1) {
-		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
-		reg |= (1 << 7);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG2, reg);
-		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG3);
-		reg |= (1 << 7);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG3, reg);
-		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG4);
-		reg |= (1 << 7);
-		reg |= (1 << 23);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG4, reg);
-	} else {
-		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
-		reg &= ~(1 << 7);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG2, reg);
-		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG3);
-		reg &= ~(1 << 7);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG3, reg);
-		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG4);
-		reg &= ~(1 << 7);
-		reg &= ~(1 << 23);
-		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG4, reg);
+		t.bool_timings.cs_extra_delay = true;
+		t.bool_timings.adv_extra_delay = true;
+		t.bool_timings.oe_extra_delay = true;
+		t.bool_timings.we_extra_delay = true;
 	}
 
 	/* Set synchronous read timings */
@@ -329,6 +312,8 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	t.rd_cycle = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div +
 		     ticks_cez);
 
+	t.clk_activation = fclk_offset_ns;
+
 	/* Write */
 	if (sync_write) {
 		t.adv_wr_off = t.adv_rd_off;
@@ -362,7 +347,6 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 			  (sync_read ? GPMC_CONFIG1_READTYPE_SYNC : 0) |
 			  (sync_write ? GPMC_CONFIG1_WRITEMULTIPLE_SUPP : 0) |
 			  (sync_write ? GPMC_CONFIG1_WRITETYPE_SYNC : 0) |
-			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
 			  GPMC_CONFIG1_PAGE_LEN(2) |
 			  (cpu_is_omap34xx() ? 0 :
 				(GPMC_CONFIG1_WAIT_READ_MON |
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 8ab1e1b..c2d90f6 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -73,6 +73,13 @@
 #define GPMC_ECC_CTRL_ECCREG8		0x008
 #define GPMC_ECC_CTRL_ECCREG9		0x009
 
+#define	GPMC_CONFIG2_CSEXTRADELAY		BIT(7)
+#define	GPMC_CONFIG3_ADVEXTRADELAY		BIT(7)
+#define	GPMC_CONFIG4_OEEXTRADELAY		BIT(7)
+#define	GPMC_CONFIG4_WEEXTRADELAY		BIT(23)
+#define	GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN	BIT(6)
+#define	GPMC_CONFIG6_CYCLE2CYCLESAMECSEN	BIT(7)
+
 #define GPMC_CS0_OFFSET		0x60
 #define GPMC_CS_SIZE		0x30
 
@@ -238,6 +245,39 @@ unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
 	return ticks * gpmc_get_fclk_period() / 1000;
 }
 
+static inline void gpmc_cs_modify_reg(int cs, int reg, u32 mask, bool value)
+{
+	u32 l;
+
+	l = gpmc_cs_read_reg(cs, reg);
+	if (value)
+		l |= mask;
+	else
+		l &= ~mask;
+	gpmc_cs_write_reg(cs, reg, l);
+}
+
+static void gpmc_cs_bool_timings(int cs, const struct gpmc_bool_timings *p)
+{
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG1,
+			   GPMC_CONFIG1_TIME_PARA_GRAN,
+			   p->time_para_granularity);
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG2,
+			   GPMC_CONFIG2_CSEXTRADELAY, p->cs_extra_delay);
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG3,
+			   GPMC_CONFIG3_ADVEXTRADELAY, p->adv_extra_delay);
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG4,
+			   GPMC_CONFIG4_OEEXTRADELAY, p->oe_extra_delay);
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG4,
+			   GPMC_CONFIG4_OEEXTRADELAY, p->we_extra_delay);
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG6,
+			   GPMC_CONFIG6_CYCLE2CYCLESAMECSEN,
+			   p->cycle2cyclesamecsen);
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG6,
+			   GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN,
+			   p->cycle2cyclediffcsen);
+}
+
 #ifdef DEBUG
 static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 			       int time, const char *name)
@@ -331,6 +371,12 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
 
+	GPMC_SET_ONE(GPMC_CS_CONFIG6, 0, 3, bus_turnaround);
+	GPMC_SET_ONE(GPMC_CS_CONFIG6, 8, 11, cycle2cycle_delay);
+
+	GPMC_SET_ONE(GPMC_CS_CONFIG1, 18, 19, wait_monitoring);
+	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
+
 	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
 	if (gpmc_capability & GPMC_HAS_WR_ACCESS)
@@ -350,6 +396,8 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
 	}
 
+	gpmc_cs_bool_timings(cs, &t->bool_timings);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 805bea6..7a85ebe 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -174,6 +174,8 @@ static int tusb_set_sync_mode(unsigned sysclk_ps, unsigned fclk_ps)
 	tmp = t.cs_wr_off * 1000 + 7000 /* t_scsn_rdy_z */;
 	t.wr_cycle = next_clk(t.cs_wr_off, tmp, fclk_ps);
 
+	t.clk_activation = gpmc_ticks_to_ns(1);
+
 	return gpmc_cs_set_timings(sync_cs, &t);
 }
 
@@ -283,7 +285,6 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 			| GPMC_CONFIG1_READTYPE_SYNC
 			| GPMC_CONFIG1_WRITEMULTIPLE_SUPP
 			| GPMC_CONFIG1_WRITETYPE_SYNC
-			| GPMC_CONFIG1_CLKACTIVATIONTIME(1)
 			| GPMC_CONFIG1_PAGE_LEN(2)
 			| GPMC_CONFIG1_WAIT_READ_MON
 			| GPMC_CONFIG1_WAIT_WRITE_MON
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 2e6e259..b7c9ea6 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -96,6 +96,17 @@ enum omap_ecc {
 	OMAP_ECC_BCH8_CODE_HW, /* 8-bit BCH ecc code */
 };
 
+/* bool type time settings */
+struct gpmc_bool_timings {
+	bool cycle2cyclediffcsen;
+	bool cycle2cyclesamecsen;
+	bool we_extra_delay;
+	bool oe_extra_delay;
+	bool adv_extra_delay;
+	bool cs_extra_delay;
+	bool time_para_granularity;
+};
+
 /*
  * Note that all values in this struct are in nanoseconds except sync_clk
  * (which is in picoseconds), while the register values are in gpmc_fck cycles.
@@ -128,9 +139,17 @@ struct gpmc_timings {
 	u16 rd_cycle;		/* Total read cycle time */
 	u16 wr_cycle;		/* Total write cycle time */
 
+	u16 bus_turnaround;
+	u16 cycle2cycle_delay;
+
+	u16 wait_monitoring;
+	u16 clk_activation;
+
 	/* The following are only on OMAP3430 */
 	u16 wr_access;		/* WRACCESSTIME */
 	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
+
+	struct gpmc_bool_timings bool_timings;
 };
 
 struct gpmc_nand_regs {
-- 
1.7.12

