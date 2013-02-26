From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 03/14] ARM: OMAP2+: Add structure for storing GPMC settings
Date: Tue, 26 Feb 2013 11:30:30 -0600
Message-ID: <1361899842-30303-4-git-send-email-jon-hunter@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40017 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754984Ab3BZRbF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Feb 2013 12:31:05 -0500
In-Reply-To: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Jon Hunter <jon-hunter@ti.com>

The GPMC has various different configuration options such as bus-width,
synchronous or asychronous mode selection, burst mode options etc.
Currently, there is no central structure for storing all these options
when configuring the GPMC for a given device. Some of the options are
stored in the GPMC timing structure and some are directly programmed
into the GPMC configuration register. Add a new structure to store
these options and convert code to use this structure. Adding this
structure will allow us to create a common function for configuring
these options.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |   18 ++++++++++-----
 arch/arm/mach-omap2/gpmc-smc91x.c  |    2 +-
 arch/arm/mach-omap2/gpmc.c         |   45 +++++++++++++++++++++---------------
 arch/arm/mach-omap2/gpmc.h         |   22 ++++++++++++++----
 arch/arm/mach-omap2/usb-tusb6010.c |   19 ++++++++-------
 5 files changed, 68 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 758b09c..8b1c08e 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -47,6 +47,15 @@ static struct platform_device gpmc_onenand_device = {
 	.resource	= &gpmc_onenand_resource,
 };
 
+static struct gpmc_settings onenand_async = {
+	.mux_add_data	= true,
+};
+
+static struct gpmc_settings onenand_sync = {
+	.burst_read	= true,
+	.mux_add_data	= true,
+};
+
 static void omap2_onenand_calc_async_timings(struct gpmc_timings *t)
 {
 	struct gpmc_device_timings dev_t;
@@ -63,7 +72,6 @@ static void omap2_onenand_calc_async_timings(struct gpmc_timings *t)
 
 	memset(&dev_t, 0, sizeof(dev_t));
 
-	dev_t.mux = true;
 	dev_t.t_avdp_r = max_t(int, t_avdp, t_cer) * 1000;
 	dev_t.t_avdp_w = dev_t.t_avdp_r;
 	dev_t.t_aavdh = t_aavdh * 1000;
@@ -75,7 +83,7 @@ static void omap2_onenand_calc_async_timings(struct gpmc_timings *t)
 	dev_t.t_wpl = t_wpl * 1000;
 	dev_t.t_wph = t_wph * 1000;
 
-	gpmc_calc_timings(t, &dev_t);
+	gpmc_calc_timings(t, &onenand_async, &dev_t);
 }
 
 static int gpmc_set_async_mode(int cs, struct gpmc_timings *t)
@@ -235,10 +243,8 @@ static void omap2_onenand_calc_sync_timings(struct gpmc_timings *t,
 	/* Set synchronous read timings */
 	memset(&dev_t, 0, sizeof(dev_t));
 
-	dev_t.mux = true;
-	dev_t.sync_read = true;
 	if (onenand_flags & ONENAND_FLAG_SYNCWRITE) {
-		dev_t.sync_write = true;
+		onenand_sync.sync_write = true;
 	} else {
 		dev_t.t_avdp_w = max(t_avdp, t_cer) * 1000;
 		dev_t.t_wpl = t_wpl * 1000;
@@ -261,7 +267,7 @@ static void omap2_onenand_calc_sync_timings(struct gpmc_timings *t,
 	dev_t.cyc_aavdh_oe = 1;
 	dev_t.t_rdyo = t_rdyo * 1000 + min_gpmc_clk_period;
 
-	gpmc_calc_timings(t, &dev_t);
+	gpmc_calc_timings(t, &onenand_sync, &dev_t);
 }
 
 static int gpmc_set_sync_mode(int cs, struct gpmc_timings *t)
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
index 11d0b75..4b78338 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -104,7 +104,7 @@ static int smc91c96_gpmc_retime(void)
 	dev_t.t_cez_w = t4_w * 1000;
 	dev_t.t_wr_cycle = (t20 - t3) * 1000;
 
-	gpmc_calc_timings(&t, &dev_t);
+	gpmc_calc_timings(&t, NULL, &dev_t);
 
 	return gpmc_cs_set_timings(gpmc_cfg->cs, &t);
 }
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1c63de0..465cac9 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -828,9 +828,9 @@ static u32 gpmc_round_ps_to_sync_clk(u32 time_ps, u32 sync_clk)
 
 /* XXX: can the cycles be avoided ? */
 static int gpmc_calc_sync_read_timings(struct gpmc_timings *gpmc_t,
-				struct gpmc_device_timings *dev_t)
+				       struct gpmc_device_timings *dev_t,
+				       bool mux)
 {
-	bool mux = dev_t->mux;
 	u32 temp;
 
 	/* adv_rd_off */
@@ -883,9 +883,9 @@ static int gpmc_calc_sync_read_timings(struct gpmc_timings *gpmc_t,
 }
 
 static int gpmc_calc_sync_write_timings(struct gpmc_timings *gpmc_t,
-				struct gpmc_device_timings *dev_t)
+					struct gpmc_device_timings *dev_t,
+					bool mux)
 {
-	bool mux = dev_t->mux;
 	u32 temp;
 
 	/* adv_wr_off */
@@ -945,9 +945,9 @@ static int gpmc_calc_sync_write_timings(struct gpmc_timings *gpmc_t,
 }
 
 static int gpmc_calc_async_read_timings(struct gpmc_timings *gpmc_t,
-				struct gpmc_device_timings *dev_t)
+					struct gpmc_device_timings *dev_t,
+					bool mux)
 {
-	bool mux = dev_t->mux;
 	u32 temp;
 
 	/* adv_rd_off */
@@ -985,9 +985,9 @@ static int gpmc_calc_async_read_timings(struct gpmc_timings *gpmc_t,
 }
 
 static int gpmc_calc_async_write_timings(struct gpmc_timings *gpmc_t,
-				struct gpmc_device_timings *dev_t)
+					 struct gpmc_device_timings *dev_t,
+					 bool mux)
 {
-	bool mux = dev_t->mux;
 	u32 temp;
 
 	/* adv_wr_off */
@@ -1057,7 +1057,8 @@ static int gpmc_calc_sync_common_timings(struct gpmc_timings *gpmc_t,
 }
 
 static int gpmc_calc_common_timings(struct gpmc_timings *gpmc_t,
-			struct gpmc_device_timings *dev_t)
+				    struct gpmc_device_timings *dev_t,
+				    bool sync)
 {
 	u32 temp;
 
@@ -1071,7 +1072,7 @@ static int gpmc_calc_common_timings(struct gpmc_timings *gpmc_t,
 				gpmc_t->cs_on + dev_t->t_ce_avd);
 	gpmc_t->adv_on = gpmc_round_ps_to_ticks(temp);
 
-	if (dev_t->sync_write || dev_t->sync_read)
+	if (sync)
 		gpmc_calc_sync_common_timings(gpmc_t, dev_t);
 
 	return 0;
@@ -1106,21 +1107,29 @@ static void gpmc_convert_ps_to_ns(struct gpmc_timings *t)
 }
 
 int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
-			struct gpmc_device_timings *dev_t)
+		      struct gpmc_settings *gpmc_s,
+		      struct gpmc_device_timings *dev_t)
 {
+	bool mux = false, sync = false;
+
+	if (gpmc_s) {
+		mux = gpmc_s->mux_add_data;
+		sync = (gpmc_s->sync_read || gpmc_s->sync_write);
+	}
+
 	memset(gpmc_t, 0, sizeof(*gpmc_t));
 
-	gpmc_calc_common_timings(gpmc_t, dev_t);
+	gpmc_calc_common_timings(gpmc_t, dev_t, sync);
 
-	if (dev_t->sync_read)
-		gpmc_calc_sync_read_timings(gpmc_t, dev_t);
+	if (gpmc_s && gpmc_s->sync_read)
+		gpmc_calc_sync_read_timings(gpmc_t, dev_t, mux);
 	else
-		gpmc_calc_async_read_timings(gpmc_t, dev_t);
+		gpmc_calc_async_read_timings(gpmc_t, dev_t, mux);
 
-	if (dev_t->sync_write)
-		gpmc_calc_sync_write_timings(gpmc_t, dev_t);
+	if (gpmc_s && gpmc_s->sync_write)
+		gpmc_calc_sync_write_timings(gpmc_t, dev_t, mux);
 	else
-		gpmc_calc_async_write_timings(gpmc_t, dev_t);
+		gpmc_calc_async_write_timings(gpmc_t, dev_t, mux);
 
 	/* TODO: remove, see function definition */
 	gpmc_convert_ps_to_ns(gpmc_t);
diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
index fe0a844..785e9ce 100644
--- a/arch/arm/mach-omap2/gpmc.h
+++ b/arch/arm/mach-omap2/gpmc.h
@@ -178,10 +178,6 @@ struct gpmc_device_timings {
 	u8 cyc_wpl;	/* write deassertion time in cycles */
 	u32 cyc_iaa;	/* initial access time in cycles */
 
-	bool mux;	/* address & data muxed */
-	bool sync_write;/* synchronous write */
-	bool sync_read;	/* synchronous read */
-
 	/* extra delays */
 	bool ce_xdelay;
 	bool avd_xdelay;
@@ -189,8 +185,24 @@ struct gpmc_device_timings {
 	bool we_xdelay;
 };
 
+struct gpmc_settings {
+	bool burst_wrap;	/* enables wrap bursting */
+	bool burst_read;	/* enables read page/burst mode */
+	bool burst_write;	/* enables write page/burst mode */
+	bool device_nand;	/* device is NAND */
+	bool mux_add_data;	/* multiplex address & data */
+	bool sync_read;		/* enables synchronous reads */
+	bool sync_write;	/* enables synchronous writes */
+	bool wait_on_read;	/* monitor wait on reads */
+	bool wait_on_write;	/* monitor wait on writes */
+	u32 burst_len;		/* page/burst length */
+	u32 device_width;	/* device bus width (8 or 16 bit) */
+	u32 wait_pin;		/* wait-pin to be used */
+};
+
 extern int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
-				struct gpmc_device_timings *dev_t);
+			     struct gpmc_settings *gpmc_s,
+			     struct gpmc_device_timings *dev_t);
 
 extern void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs);
 extern int gpmc_get_client_irq(unsigned irq_config);
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index c5a3c6f..940410a 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -26,6 +26,15 @@
 static u8		async_cs, sync_cs;
 static unsigned		refclk_psec;
 
+static struct gpmc_settings tusb_async = {
+	.mux_add_data	= true,
+};
+
+static struct gpmc_settings tusb_sync = {
+	.mux_add_data	= true,
+	.sync_read	= true,
+	.sync_write	= true,
+};
 
 /* NOTE:  timings are from tusb 6010 datasheet Rev 1.8, 12-Sept 2006 */
 
@@ -37,8 +46,6 @@ static int tusb_set_async_mode(unsigned sysclk_ps)
 
 	memset(&dev_t, 0, sizeof(dev_t));
 
-	dev_t.mux = true;
-
 	dev_t.t_ceasu = 8 * 1000;
 	dev_t.t_avdasu = t_acsnh_advnh - 7000;
 	dev_t.t_ce_avd = 1000;
@@ -52,7 +59,7 @@ static int tusb_set_async_mode(unsigned sysclk_ps)
 	dev_t.t_wpl = 300;
 	dev_t.cyc_aavdh_we = 1;
 
-	gpmc_calc_timings(&t, &dev_t);
+	gpmc_calc_timings(&t, &tusb_async, &dev_t);
 
 	return gpmc_cs_set_timings(async_cs, &t);
 }
@@ -65,10 +72,6 @@ static int tusb_set_sync_mode(unsigned sysclk_ps)
 
 	memset(&dev_t, 0, sizeof(dev_t));
 
-	dev_t.mux = true;
-	dev_t.sync_read = true;
-	dev_t.sync_write = true;
-
 	dev_t.clk = 11100;
 	dev_t.t_bacc = 1000;
 	dev_t.t_ces = 1000;
@@ -84,7 +87,7 @@ static int tusb_set_sync_mode(unsigned sysclk_ps)
 	dev_t.cyc_wpl = 6;
 	dev_t.t_ce_rdyz = 7000;
 
-	gpmc_calc_timings(&t, &dev_t);
+	gpmc_calc_timings(&t, &tusb_sync, &dev_t);
 
 	return gpmc_cs_set_timings(sync_cs, &t);
 }
-- 
1.7.10.4

