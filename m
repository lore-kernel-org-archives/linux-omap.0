From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 07/10] ARM: OMAP2+: gpmc: generic timing calculation
Date: Tue, 21 Aug 2012 16:15:47 +0530
Message-ID: <83b963e4ebcc1009a26a8c6419c785ac6d742c0b.1345524670.git.afzal@ti.com>
References: <cover.1345524670.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47663 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756606Ab2HUKqA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 06:46:00 -0400
In-Reply-To: <cover.1345524670.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, jon-hunter@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Presently there are three peripherals that gets it timing
by runtime calculation. Those peripherals can work with
frequency scaling that affects gpmc clock. But timing
calculation for them are in different ways.

Here a generic runtime calculation method is proposed. Input
to this function were selected so that they represent timing
variables that are present in peripheral datasheets. Motive
behind this was to achieve DT bindings for the inputs as is.
Even though a few of the tusb6010 timings could not be made
directly related to timings normally found on peripherals,
expressions used were translated to those that could be
justified.

There are possibilities of improving the calculations, like
calculating timing for read & write operations in a more
similar way. Expressions derived here were tested for async
onenand on omap3evm (as vanilla Kernel does not have omap3evm
onenand support, local patch was used). Other peripherals,
tusb6010, smc91x calculations were validated by simulating
on omap3evm.

Regarding "we_on" for onenand async, it was found that even
for muxed address/data, it need not be greater than
"adv_wr_off", but rather could be derived from write setup
time for peripheral from start of access time, hence would
more be in line with peripheral timings. With this method
it was working fine. If it is required in some cases to
have "we_on" same as "wr_data_mux_bus" (i.e. greater than
"adv_wr_off"), another variable could be added to indicate
it. But such a requirement is not expected though.

Whole of this exercise is being done to achieve driver and
DT conversion. If timings could not be calculated in a
peripheral agnostic way, either gpmc driver would have to
be peripheral gnostic or a wrapper arrangement over gpmc
driver would be required.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |  302 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |   61 +++++++
 2 files changed, 363 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index d005b3a..d8e5b08 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -233,6 +233,18 @@ unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
 	return ticks * gpmc_get_fclk_period() / 1000;
 }
 
+unsigned int gpmc_ticks_to_ps(unsigned int ticks)
+{
+	return ticks * gpmc_get_fclk_period();
+}
+
+unsigned int gpmc_round_ps_to_ticks(unsigned int time_ps)
+{
+	unsigned long ticks = gpmc_ps_to_ticks(time_ps);
+
+	return ticks * gpmc_get_fclk_period();
+}
+
 static inline void gpmc_cs_modify_reg(int cs, int reg, u32 mask, bool value)
 {
 	u32 l;
@@ -884,6 +896,296 @@ static void __init gpmc_mem_init(void)
 	}
 }
 
+static u32 gpmc_round_ps_to_sync_clk(u32 time_ps, u32 sync_clk)
+{
+	u32 temp;
+	int div;
+
+	div = gpmc_calc_divider(sync_clk);
+	temp = gpmc_ps_to_ticks(time_ps);
+	temp = (temp + div - 1) / div;
+	return gpmc_ticks_to_ps(temp * div);
+}
+
+/* can the cycles be avoided ? */
+static int gpmc_calc_sync_read_timings(struct gpmc_timings *gpmc_t,
+				struct gpmc_device_timings *dev_t)
+{
+	bool mux = dev_t->mux;
+	u32 temp;
+
+	/* adv_rd_off */
+	temp = dev_t->t_avdp_r;
+	/* mux check required ? */
+	if (mux) {
+		/* t_avdp not to be required for sync, only added for tusb this
+		 * indirectly necessitates requirement of t_avdp_r & t_avdp_w
+		 * instead of having a single t_avdp
+		 */
+		temp = max_t(u32, temp,	gpmc_t->clk_activation * 1000 +
+							dev_t->t_avdh);
+		temp = max_t(u32,
+			(gpmc_t->adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
+	}
+	gpmc_t->adv_rd_off = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	/* oe_on */
+	temp = dev_t->t_oeasu; /* remove this ? */
+	if (mux) {
+		temp = max_t(u32, temp,
+			gpmc_t->clk_activation * 1000 + dev_t->t_ach);
+		temp = max_t(u32, temp, (gpmc_t->adv_rd_off +
+				gpmc_ticks_to_ns(dev_t->cyc_aavdh_oe)) * 1000);
+	}
+	gpmc_t->oe_on = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	/* access */
+	/* any scope for improvement ?, by combining oe_on & clk_activation,
+	 * need to check whether access = clk_activation + round to sync clk ?
+	 */
+	temp = max_t(u32, dev_t->t_iaa,	dev_t->cyc_iaa * gpmc_t->sync_clk);
+	temp += gpmc_t->clk_activation * 1000;
+	if (dev_t->cyc_oe)
+		temp = max_t(u32, temp, (gpmc_t->oe_on +
+				gpmc_ticks_to_ns(dev_t->cyc_oe)) * 1000);
+	gpmc_t->access = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	gpmc_t->oe_off = gpmc_t->access + gpmc_ticks_to_ns(1);
+	gpmc_t->cs_rd_off = gpmc_t->oe_off;
+
+	/* rd_cycle */
+	temp = max_t(u32, dev_t->t_cez_r, dev_t->t_oez);
+	temp = gpmc_round_ps_to_sync_clk(temp, gpmc_t->sync_clk) +
+							gpmc_t->access * 1000;
+	/* barter t_ce_rdyz with t_cez_r ? */
+	if (dev_t->t_ce_rdyz)
+		temp = max_t(u32, temp,
+				gpmc_t->cs_rd_off * 1000 + dev_t->t_ce_rdyz);
+	gpmc_t->rd_cycle = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	return 0;
+}
+
+static int gpmc_calc_sync_write_timings(struct gpmc_timings *gpmc_t,
+				struct gpmc_device_timings *dev_t)
+{
+	bool mux = dev_t->mux;
+	u32 temp;
+
+	/* adv_wr_off */
+	temp = dev_t->t_avdp_w;
+	if (mux) {
+		temp = max_t(u32, temp,
+			gpmc_t->clk_activation * 1000 + dev_t->t_avdh);
+		temp = max_t(u32,
+			(gpmc_t->adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
+	}
+	gpmc_t->adv_wr_off = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	/* wr_data_mux_bus */
+	temp = max_t(u32, dev_t->t_weasu,
+			gpmc_t->clk_activation * 1000 + dev_t->t_rdyo);
+	/* shouldn't mux be kept as a whole for wr_data_mux_bus ?,
+	 * and in that case remember to handle we_on properly
+	 */
+	if (mux) {
+		temp = max_t(u32, temp,
+			gpmc_t->adv_wr_off * 1000 + dev_t->t_aavdh);
+		temp = max_t(u32, temp, (gpmc_t->adv_wr_off +
+				gpmc_ticks_to_ns(dev_t->cyc_aavdh_we)) * 1000);
+	}
+	gpmc_t->wr_data_mux_bus = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	/* we_on */
+	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
+		gpmc_t->we_on = gpmc_round_ps_to_ticks(dev_t->t_weasu) / 1000;
+	else
+		gpmc_t->we_on = gpmc_t->wr_data_mux_bus;
+
+	/* wr_access */
+	/* gpmc_capability check reqd ? , even if not, will not harm */
+	gpmc_t->wr_access = gpmc_t->access;
+
+	/* we_off */
+	temp = gpmc_t->we_on * 1000 + dev_t->t_wpl;
+	temp = max_t(u32, temp,
+			(gpmc_t->wr_access + gpmc_ticks_to_ns(1)) * 1000);
+	temp = max_t(u32, temp,
+		(gpmc_t->we_on + gpmc_ticks_to_ns(dev_t->cyc_wpl)) * 1000);
+	gpmc_t->we_off = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	gpmc_t->cs_wr_off = gpmc_round_ps_to_ticks(gpmc_t->we_off * 1000 +
+							dev_t->t_wph) / 1000;
+
+	/* wr_cycle */
+	temp = gpmc_round_ps_to_sync_clk(dev_t->t_cez_w, gpmc_t->sync_clk);
+	temp += gpmc_t->wr_access * 1000;
+	/* barter t_ce_rdyz with t_cez_w ? */
+	if (dev_t->t_ce_rdyz)
+		temp = max_t(u32, temp,
+				 gpmc_t->cs_wr_off * 1000 + dev_t->t_ce_rdyz);
+	gpmc_t->wr_cycle = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	return 0;
+}
+
+static int gpmc_calc_async_read_timings(struct gpmc_timings *gpmc_t,
+				struct gpmc_device_timings *dev_t)
+{
+	bool mux = dev_t->mux;
+	u32 temp;
+
+	/* adv_rd_off */
+	temp = dev_t->t_avdp_r;
+	if (mux)
+		temp = max_t(u32,
+			(gpmc_t->adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
+	gpmc_t->adv_rd_off = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	/* oe_on */
+	temp = dev_t->t_oeasu;
+	if (mux)
+		temp = max_t(u32, temp,
+			gpmc_t->adv_rd_off * 1000 + dev_t->t_aavdh);
+	gpmc_t->oe_on = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	/* access */
+	temp = max_t(u32, dev_t->t_iaa, /* remove t_iaa in async ? */
+				gpmc_t->oe_on * 1000 + dev_t->t_oe);
+	temp = max_t(u32, temp,
+				gpmc_t->cs_on * 1000 + dev_t->t_ce);
+	temp = max_t(u32, temp,
+				gpmc_t->adv_on * 1000 + dev_t->t_aa);
+	gpmc_t->access = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	gpmc_t->oe_off = gpmc_t->access + gpmc_ticks_to_ns(1);
+	gpmc_t->cs_rd_off = gpmc_t->oe_off;
+
+	/* rd_cycle */
+	temp = max_t(u32, dev_t->t_rd_cycle,
+			gpmc_t->cs_rd_off * 1000 + dev_t->t_cez_r);
+	temp = max_t(u32, temp,
+			gpmc_t->oe_off * 1000 + dev_t->t_oez);
+	gpmc_t->rd_cycle = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	return 0;
+}
+
+static int gpmc_calc_async_write_timings(struct gpmc_timings *gpmc_t,
+				struct gpmc_device_timings *dev_t)
+{
+	bool mux = dev_t->mux;
+	u32 temp;
+
+	/* adv_wr_off */
+	temp = dev_t->t_avdp_w;
+	if (mux)
+		temp = max_t(u32,
+			(gpmc_t->adv_on + gpmc_ticks_to_ns(1)) * 1000, temp);
+	gpmc_t->adv_wr_off = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	/* wr_data_mux_bus */
+	temp = dev_t->t_weasu;
+	if (mux) {
+		temp = max_t(u32, temp,
+			gpmc_t->adv_wr_off * 1000 + dev_t->t_aavdh);
+		temp = max_t(u32, temp, (gpmc_t->adv_wr_off +
+				gpmc_ticks_to_ns(dev_t->cyc_aavdh_we)) * 1000);
+	}
+	gpmc_t->wr_data_mux_bus = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	/* we_on */
+	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
+		gpmc_t->we_on = gpmc_round_ps_to_ticks(dev_t->t_weasu) / 1000;
+	else
+		gpmc_t->we_on = gpmc_t->wr_data_mux_bus;
+
+	/* we_off */
+	temp = gpmc_t->we_on * 1000 + dev_t->t_wpl;
+	gpmc_t->we_off = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	gpmc_t->cs_wr_off = gpmc_round_ps_to_ticks((gpmc_t->we_off * 1000 +
+				dev_t->t_wph)) / 1000;
+
+	/* wr_cycle */
+	temp = max_t(u32, dev_t->t_wr_cycle,
+				gpmc_t->cs_wr_off * 1000 + dev_t->t_cez_w);
+	gpmc_t->wr_cycle = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	return 0;
+}
+
+static int gpmc_calc_sync_common_timings(struct gpmc_timings *gpmc_t,
+			struct gpmc_device_timings *dev_t)
+{
+	u32 temp;
+
+	gpmc_t->sync_clk = gpmc_calc_divider(dev_t->clk) *
+						gpmc_get_fclk_period();
+
+	gpmc_t->page_burst_access = gpmc_round_ps_to_sync_clk(
+					dev_t->t_bacc,
+					gpmc_t->sync_clk) / 1000;
+
+	temp = max_t(u32, dev_t->t_ces, dev_t->t_avds);
+	gpmc_t->clk_activation = gpmc_round_ps_to_ticks(temp) / 1000;
+
+	if (gpmc_calc_divider(gpmc_t->sync_clk) != 1)
+		return 0;
+
+	if (dev_t->ce_xdelay)
+		gpmc_t->bool_timings.cs_extra_delay = true;
+	if (dev_t->avd_xdelay)
+		gpmc_t->bool_timings.adv_extra_delay = true;
+	if (dev_t->oe_xdelay)
+		gpmc_t->bool_timings.oe_extra_delay = true;
+	if (dev_t->we_xdelay)
+		gpmc_t->bool_timings.we_extra_delay = true;
+
+	return 0;
+}
+
+static int gpmc_calc_common_timings(struct gpmc_timings *gpmc_t,
+			struct gpmc_device_timings *dev_t)
+{
+	u32 temp;
+
+	/* cs_on */
+	gpmc_t->cs_on = gpmc_round_ns_to_ticks(dev_t->t_ceasu / 1000);
+
+	/* adv_on */
+	temp = dev_t->t_avdasu;
+	if (dev_t->t_ce_avd)
+		temp = max_t(u32, temp,
+				gpmc_t->cs_on * 1000 + dev_t->t_ce_avd);
+	gpmc_t->adv_on = gpmc_round_ns_to_ticks(temp / 1000);
+
+	if (dev_t->sync_write || dev_t->sync_read)
+		gpmc_calc_sync_common_timings(gpmc_t, dev_t);
+
+	return 0;
+}
+
+int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
+			struct gpmc_device_timings *dev_t)
+{
+	memset(gpmc_t, 0, sizeof(*gpmc_t));
+
+	gpmc_calc_common_timings(gpmc_t, dev_t);
+
+	if (dev_t->sync_read)
+		gpmc_calc_sync_read_timings(gpmc_t, dev_t);
+	else
+		gpmc_calc_async_read_timings(gpmc_t, dev_t);
+
+	if (dev_t->sync_write)
+		gpmc_calc_sync_write_timings(gpmc_t, dev_t);
+	else
+		gpmc_calc_async_write_timings(gpmc_t, dev_t);
+
+	return 0;
+}
+
 static int __init gpmc_init(void)
 {
 	u32 l;
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 1cafbfd..e59a932 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -152,6 +152,67 @@ struct gpmc_timings {
 	struct gpmc_bool_timings bool_timings;
 };
 
+/* Device timings in picoseconds */
+struct gpmc_device_timings {
+	u32     t_ceasu;	/* address setup to CS valid */
+	u32     t_avdasu;	/* address setup to ADV valid */
+	/* XXX: try to combine t_avdp_r & t_avdp_w. Issue is
+	 * of tusb using these timings even for sync whilst
+	 * ideally for adv_rd/(wr)_off it should have considered
+	 * t_avdh instead. This indirectly necessitates r/w
+	 * variations of t_avdp as it is possible to have one
+	 * sync & other async
+	 */
+	u32	t_avdp_r;	/* ADV low time (what about t_cer ?) */
+	u32	t_avdp_w;
+	u32	t_aavdh;	/* address hold time */
+	u32     t_oeasu;	/* address setup to OE valid */
+	u32     t_aa;		/* access time from ADV assertion */
+	u32     t_iaa;		/* initial access time */
+	u32     t_oe;		/* access time from OE assertion */
+	u32     t_ce;		/* access time from CS asertion */
+	u32     t_rd_cycle;	/* read cycle time */
+	u32     t_cez_r;	/* read CS deassertion to high Z */
+	u32     t_cez_w;	/* write CS deassertion to high Z */
+	u32     t_oez;		/* OE deassertion to high Z */
+	u32     t_weasu;	/* address setup to WE valid */
+	u32     t_wpl;		/* write assertion time */
+	u32     t_wph;		/* write deassertion time */
+	u32     t_wr_cycle;	/* write cycle time */
+
+	u32	clk;
+	u32	t_bacc;		/* burst access valid clock to output delay */
+	u32	t_ces;		/* CS setup time to clk */
+	u32	t_avds;		/* ADV setup time to clk */
+	u32	t_avdh;		/* ADV hold time from clk */
+	u32     t_ach;		/* address hold time from clk */
+	u32	t_rdyo;		/* clk to ready valid */
+
+	u32	t_ce_rdyz;	/* XXX: description ?, or use t_cez instead */
+	u32	t_ce_avd;	/* CS on to ADV on delay */
+
+	/* XXX: check the possibility of combining
+	 * cyc_aavhd_oe & cyc_aavdh_we
+	 */
+	u8	cyc_aavdh_oe;
+	u8	cyc_aavdh_we;
+	u8	cyc_oe;
+	u8	cyc_wpl;
+	u32     cyc_iaa;
+
+	bool	mux;		/* address & data muxed */
+	bool	sync_write;	/* synchronous write */
+	bool	sync_read;	/* synchronous read */
+
+	bool	ce_xdelay;
+	bool	avd_xdelay;
+	bool	oe_xdelay;
+	bool	we_xdelay;
+};
+
+extern int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
+				struct gpmc_device_timings *dev_t);
+
 struct gpmc_nand_regs {
 	void __iomem	*gpmc_status;
 	void __iomem	*gpmc_nand_command;
-- 
1.7.1

