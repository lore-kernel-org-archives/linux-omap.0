From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 2/4] ARM: OMAP2+: onenand: generic timing calculation
Date: Fri, 5 Oct 2012 21:31:07 +0530
Message-ID: <c4042a91fcb834d083a3bb72b24434b0fd1086a5.1349450723.git.afzal@ti.com>
References: <cover.1349450723.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41234 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756577Ab2JEQBU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Oct 2012 12:01:20 -0400
In-Reply-To: <cover.1349450723.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Generic gpmc timing calculation helper is available now, use
it instead of custom timing calculation.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c | 124 +++++++++++++------------------------
 1 file changed, 43 insertions(+), 81 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 54e2255..94a349e 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -49,6 +49,7 @@ static struct platform_device gpmc_onenand_device = {
 
 static struct gpmc_timings omap2_onenand_calc_async_timings(void)
 {
+	struct gpmc_device_timings dev_t;
 	struct gpmc_timings t;
 
 	const int t_cer = 15;
@@ -58,35 +59,24 @@ static struct gpmc_timings omap2_onenand_calc_async_timings(void)
 	const int t_aa = 76;
 	const int t_oe = 20;
 	const int t_cez = 20; /* max of t_cez, t_oez */
-	const int t_ds = 30;
 	const int t_wpl = 40;
 	const int t_wph = 30;
 
-	memset(&t, 0, sizeof(t));
-	t.sync_clk = 0;
-	t.cs_on = 0;
-	t.adv_on = 0;
-
-	/* Read */
-	t.adv_rd_off = gpmc_round_ns_to_ticks(max_t(int, t_avdp, t_cer));
-	t.oe_on  = t.adv_rd_off + gpmc_round_ns_to_ticks(t_aavdh);
-	t.access = t.adv_on + gpmc_round_ns_to_ticks(t_aa);
-	t.access = max_t(int, t.access, t.cs_on + gpmc_round_ns_to_ticks(t_ce));
-	t.access = max_t(int, t.access, t.oe_on + gpmc_round_ns_to_ticks(t_oe));
-	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
-	t.cs_rd_off = t.oe_off;
-	t.rd_cycle  = t.cs_rd_off + gpmc_round_ns_to_ticks(t_cez);
-
-	/* Write */
-	t.adv_wr_off = t.adv_rd_off;
-	t.we_on  = t.oe_on;
-	if (cpu_is_omap34xx()) {
-		t.wr_data_mux_bus = t.we_on;
-		t.wr_access = t.we_on + gpmc_round_ns_to_ticks(t_ds);
-	}
-	t.we_off = t.we_on + gpmc_round_ns_to_ticks(t_wpl);
-	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(t_wph);
-	t.wr_cycle  = t.cs_wr_off + gpmc_round_ns_to_ticks(t_cez);
+	memset(&dev_t, 0, sizeof(dev_t));
+
+	dev_t.mux = true;
+	dev_t.t_avdp_r = max_t(int, t_avdp, t_cer) * 1000;
+	dev_t.t_avdp_w = dev_t.t_avdp_r;
+	dev_t.t_aavdh = t_aavdh * 1000;
+	dev_t.t_aa = t_aa * 1000;
+	dev_t.t_ce = t_ce * 1000;
+	dev_t.t_oe = t_oe * 1000;
+	dev_t.t_cez_r = t_cez * 1000;
+	dev_t.t_cez_w = dev_t.t_cez_r;
+	dev_t.t_wpl = t_wpl * 1000;
+	dev_t.t_wph = t_wph * 1000;
+
+	gpmc_calc_timings(&t, &dev_t);
 
 	return t;
 }
@@ -172,16 +162,15 @@ static struct gpmc_timings
 omap2_onenand_calc_sync_timings(struct omap_onenand_platform_data *cfg,
 				int freq)
 {
+	struct gpmc_device_timings dev_t;
 	struct gpmc_timings t;
 	const int t_cer  = 15;
 	const int t_avdp = 12;
 	const int t_cez  = 20; /* max of t_cez, t_oez */
-	const int t_ds   = 30;
 	const int t_wpl  = 40;
 	const int t_wph  = 30;
 	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
-	int div, fclk_offset_ns, fclk_offset, gpmc_clk_ns;
-	int ticks_cez;
+	int div, gpmc_clk_ns;
 
 	if (cfg->flags & ONENAND_SYNC_READ)
 		onenand_flags = ONENAND_FLAG_SYNCREAD;
@@ -248,62 +237,35 @@ omap2_onenand_calc_sync_timings(struct omap_onenand_platform_data *cfg,
 		latency = 4;
 
 	/* Set synchronous read timings */
-	memset(&t, 0, sizeof(t));
-
-	if (div == 1) {
-		t.bool_timings.cs_extra_delay = true;
-		t.bool_timings.adv_extra_delay = true;
-		t.bool_timings.oe_extra_delay = true;
-		t.bool_timings.we_extra_delay = true;
-	}
+	memset(&dev_t, 0, sizeof(dev_t));
 
-	t.sync_clk = min_gpmc_clk_period;
-	t.cs_on = 0;
-	t.adv_on = 0;
-	fclk_offset_ns = gpmc_round_ns_to_ticks(max_t(int, t_ces, t_avds));
-	fclk_offset = gpmc_ns_to_ticks(fclk_offset_ns);
-	t.page_burst_access = gpmc_clk_ns;
-
-	/* Read */
-	t.adv_rd_off = gpmc_ticks_to_ns(fclk_offset + gpmc_ns_to_ticks(t_avdh));
-	t.oe_on = gpmc_ticks_to_ns(fclk_offset + gpmc_ns_to_ticks(t_ach));
-	/* Force at least 1 clk between AVD High to OE Low */
-	if (t.oe_on <= t.adv_rd_off)
-		t.oe_on = t.adv_rd_off + gpmc_round_ns_to_ticks(1);
-	t.access = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div);
-	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
-	t.cs_rd_off = t.oe_off;
-	ticks_cez = ((gpmc_ns_to_ticks(t_cez) + div - 1) / div) * div;
-	t.rd_cycle = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div +
-		     ticks_cez);
-
-	t.clk_activation = fclk_offset_ns;
-
-	/* Write */
+	dev_t.mux = true;
+	dev_t.sync_read = true;
 	if (onenand_flags & ONENAND_FLAG_SYNCWRITE) {
-		t.adv_wr_off = t.adv_rd_off;
-		t.we_on  = 0;
-		t.we_off = t.cs_rd_off;
-		t.cs_wr_off = t.cs_rd_off;
-		t.wr_cycle  = t.rd_cycle;
-		if (cpu_is_omap34xx()) {
-			t.wr_data_mux_bus = gpmc_ticks_to_ns(fclk_offset +
-					gpmc_ps_to_ticks(min_gpmc_clk_period +
-					t_rdyo * 1000));
-			t.wr_access = t.access;
-		}
+		dev_t.sync_write = true;
 	} else {
-		t.adv_wr_off = gpmc_round_ns_to_ticks(max_t(int,
-							t_avdp, t_cer));
-		t.we_on  = t.adv_wr_off + gpmc_round_ns_to_ticks(t_aavdh);
-		t.we_off = t.we_on + gpmc_round_ns_to_ticks(t_wpl);
-		t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(t_wph);
-		t.wr_cycle  = t.cs_wr_off + gpmc_round_ns_to_ticks(t_cez);
-		if (cpu_is_omap34xx()) {
-			t.wr_data_mux_bus = t.we_on;
-			t.wr_access = t.we_on + gpmc_round_ns_to_ticks(t_ds);
-		}
+		dev_t.t_avdp_w = max(t_avdp, t_cer) * 1000;
+		dev_t.t_wpl = t_wpl * 1000;
+		dev_t.t_wph = t_wph * 1000;
+		dev_t.t_aavdh = t_aavdh * 1000;
 	}
+	dev_t.ce_xdelay = true;
+	dev_t.avd_xdelay = true;
+	dev_t.oe_xdelay = true;
+	dev_t.we_xdelay = true;
+	dev_t.clk = min_gpmc_clk_period;
+	dev_t.t_bacc = dev_t.clk;
+	dev_t.t_ces = t_ces * 1000;
+	dev_t.t_avds = t_avds * 1000;
+	dev_t.t_avdh = t_avdh * 1000;
+	dev_t.t_ach = t_ach * 1000;
+	dev_t.cyc_iaa = (latency + 1);
+	dev_t.t_cez_r = t_cez * 1000;
+	dev_t.t_cez_w = dev_t.t_cez_r;
+	dev_t.cyc_aavdh_oe = 1;
+	dev_t.t_rdyo = t_rdyo * 1000 + min_gpmc_clk_period;
+
+	gpmc_calc_timings(&t, &dev_t);
 
 	return t;
 }
-- 
1.7.12

