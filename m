From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v3 2/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Thu, 21 Jun 2012 18:09:06 +0530
Message-ID: <29d083cdd1179f62dc3a8de83c382b77dbe782d1.1340281127.git.afzal@ti.com>
References: <cover.1340281127.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49265 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759546Ab2FUMy3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jun 2012 08:54:29 -0400
In-Reply-To: <cover.1340281127.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Configure busturnaround, cycle2cycledelay, waitmonitoringtime,
clkactivationtime in gpmc_cs_set_timings(). This is done so
that boards can configure these parameters of gpmc in Kernel
instead of relying on bootloader. Also configure bool type
timings like extradelay.

This needed change to two existing users that were configuring
clk activation time by directly writing to registers. Thanks to
Tony for making me aware of the issue & being kind enough to
test this change.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

v3:
Handle bool type timings too
v2:
Make use of timing api for setting clock activation time, and
 remove direct writing to register for clock activation. Peripherals
 making use of it were tusb6010 & onenand

 arch/arm/mach-omap2/gpmc-onenand.c     |    3 ++-
 arch/arm/mach-omap2/gpmc.c             |   45 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/usb-tusb6010.c     |    3 ++-
 arch/arm/plat-omap/include/plat/gpmc.h |   19 ++++++++++++++
 4 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 71d7c07..8863e0a 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -329,6 +329,8 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	t.rd_cycle = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div +
 		     ticks_cez);
 
+	t.clk_activation = fclk_offset_ns;
+
 	/* Write */
 	if (sync_write) {
 		t.adv_wr_off = t.adv_rd_off;
@@ -362,7 +364,6 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 			  (sync_read ? GPMC_CONFIG1_READTYPE_SYNC : 0) |
 			  (sync_write ? GPMC_CONFIG1_WRITEMULTIPLE_SUPP : 0) |
 			  (sync_write ? GPMC_CONFIG1_WRITETYPE_SYNC : 0) |
-			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
 			  GPMC_CONFIG1_PAGE_LEN(2) |
 			  (cpu_is_omap34xx() ? 0 :
 				(GPMC_CONFIG1_WAIT_READ_MON |
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 578fd4c..8b0978f 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -64,6 +64,13 @@
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
 
@@ -220,6 +227,36 @@ unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
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
+		GPMC_CONFIG1_TIME_PARA_GRAN, p->time_para_granularity);
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG2,
+		GPMC_CONFIG2_CSEXTRADELAY, p->cs_extra_delay);
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG3,
+		GPMC_CONFIG3_ADVEXTRADELAY, p->adv_extra_delay);
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG4,
+		GPMC_CONFIG4_OEEXTRADELAY, p->oe_extra_delay);
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG4,
+		GPMC_CONFIG4_OEEXTRADELAY, p->we_extra_delay);
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG6,
+		GPMC_CONFIG6_CYCLE2CYCLESAMECSEN, p->cycle2cyclesamecsen);
+	gpmc_cs_modify_reg(cs, GPMC_CS_CONFIG6,
+		GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN, p->cycle2cyclediffcsen);
+}
+
 #ifdef DEBUG
 static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 			       int time, const char *name)
@@ -313,6 +350,12 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
 
+	GPMC_SET_ONE(GPMC_CS_CONFIG6, 0, 3, bus_turnaround);
+	GPMC_SET_ONE(GPMC_CS_CONFIG6, 8, 11, cycle2cycle_delay);
+
+	GPMC_SET_ONE(GPMC_CS_CONFIG1, 18, 19, wait_monitoring);
+	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
+
 	if (cpu_is_omap34xx()) {
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
@@ -332,6 +375,8 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
 	}
 
+	gpmc_cs_bool_timings(cs, &t->bool_timings);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index db84a46..5c98755 100644
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
1.7.10.2

