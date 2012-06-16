From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Sat, 16 Jun 2012 13:33:17 +0530
Message-ID: <117d4b5e84433330f56a9072c1394e69f5a41186.1339828867.git.afzal@ti.com>
References: <cover.1339828867.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38128 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755844Ab2FPISt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Jun 2012 04:18:49 -0400
In-Reply-To: <cover.1339828867.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Configure busturnaround, cycle2cycledelay, waitmonitoringtime,
clkactivationtime in gpmc_cs_set_timings(). This is done so
that boards can configure these parameters of gpmc in Kernel
instead of relying on bootloader.

This needed change to two existing users that were configuring
clk activation time by directly writing to registers. Thanks to
Tony for making me aware of the issue & being kind enough to
test this change.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

v2: Make use of timings api for setting clock activation time, and
 remove direct writing to register for clock activation. Peripherals
 making use of it were tusb6010 & onenand

 arch/arm/mach-omap2/gpmc-onenand.c     |    3 ++-
 arch/arm/mach-omap2/gpmc.c             |    6 ++++++
 arch/arm/mach-omap2/usb-tusb6010.c     |    3 ++-
 arch/arm/plat-omap/include/plat/gpmc.h |    6 ++++++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 975c1f9..476b18c 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -316,6 +316,8 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	t.rd_cycle = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div +
 		     ticks_cez);
 
+	t.clk_activation = fclk_offset_ns;
+
 	/* Write */
 	if (sync_write) {
 		t.adv_wr_off = t.adv_rd_off;
@@ -349,7 +351,6 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 			  (sync_read ? GPMC_CONFIG1_READTYPE_SYNC : 0) |
 			  (sync_write ? GPMC_CONFIG1_WRITEMULTIPLE_SUPP : 0) |
 			  (sync_write ? GPMC_CONFIG1_WRITETYPE_SYNC : 0) |
-			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
 			  GPMC_CONFIG1_PAGE_LEN(2) |
 			  (cpu_is_omap34xx() ? 0 :
 				(GPMC_CONFIG1_WAIT_READ_MON |
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 578fd4c..517953f 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -313,6 +313,12 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 
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
index 2e6e259..802fb22 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -128,6 +128,12 @@ struct gpmc_timings {
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
-- 
1.7.10.2

