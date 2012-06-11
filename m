From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 2/9] ARM: OMAP2+: gpmc-onenand: Adapt to use gpmc driver
Date: Mon, 11 Jun 2012 20:29:21 +0530
Message-ID: <639b0ae5a84f92f06f2f86f177edeff2930d2964.1339419379.git.afzal@ti.com>
References: <cover.1339419379.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33352 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab2FKPPE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 11:15:04 -0400
In-Reply-To: <cover.1339419379.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Currently gpmc is configured in platform for onenand. As
gpmc driver is now present, populate details needed for the
driver to configure gpmc, gpmc driver would configure based
on this information. Old interface has been left as is so
that platforms can continue configuring gpmc using old
interface too. This is done so that driver conversion can
be done gradually without breaking any.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c        |  117 +++++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/onenand.h |    8 +-
 2 files changed, 109 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index fd4c48d..0601284 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -27,6 +27,20 @@
 
 static struct omap_onenand_platform_data *gpmc_onenand_data;
 
+static struct gpmc_cs_data gpmc_onenand_cs_info = {
+	.mem_size	= ONENAND_IO_SIZE,
+	.have_config	= true,
+	.config		= GPMC_CONFIG1_DEVICESIZE_16 | GPMC_CONFIG1_MUXADDDATA |
+				GPMC_CONFIG1_DEVICETYPE_NOR,
+};
+
+static struct gpmc_device_pdata gpmc_onenand_info = {
+	.name		= "omap2-onenand",
+	.id		= -1,
+	.cs_data	= &gpmc_onenand_cs_info,
+	.num_cs		= 1,
+};
+
 static struct resource gpmc_onenand_resource = {
 	.flags		= IORESOURCE_MEM,
 };
@@ -80,15 +94,22 @@ static int omap2_onenand_set_async_mode(int cs)
 	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(t_wph);
 	t.wr_cycle  = t.cs_wr_off + gpmc_round_ns_to_ticks(t_cez);
 
-	/* Configure GPMC for asynchronous read */
-	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
-			  GPMC_CONFIG1_DEVICESIZE_16 |
-			  GPMC_CONFIG1_MUXADDDATA);
-
-	err = gpmc_cs_set_timings(cs, &t);
-	if (err)
-		return err;
-
+	/* gpmc driver interface being used */
+	if (gpmc_onenand_info.pdata != NULL) {
+		gpmc_onenand_cs_info.time_ctrl.type = has_period;
+		gpmc_onenand_cs_info.time_ctrl.timings = t;
+		return 0;
+	/* older interface */
+	} else {
+		/* Configure GPMC for asynchronous read */
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
+				  GPMC_CONFIG1_DEVICESIZE_16 |
+				  GPMC_CONFIG1_MUXADDDATA);
+
+		err = gpmc_cs_set_timings(cs, &t);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
@@ -180,6 +201,9 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	int cs = cfg->cs, freq = *freq_ptr;
 	u32 reg;
 	bool clk_dep = false;
+	struct gpmc_cs_data cs_info;
+
+	memset(&cs_info, 0, sizeof(cs_info));
 
 	/* Ensure sync read and sync write are disabled */
 	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
@@ -275,7 +299,16 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 		set_onenand_cfg(onenand_base, latency,
 					sync_read, sync_write, hf, vhf);
 
-	if (div == 1) {
+	/* gpmc driver interface */
+	if (gpmc_onenand_info.pdata != NULL) {
+		if (div == 1) {
+			cs_info.time_ctrl.bool_timings.cs_extra_delay = true;
+			cs_info.time_ctrl.bool_timings.adv_extra_delay = true;
+			cs_info.time_ctrl.bool_timings.oe_extra_delay = true;
+			cs_info.time_ctrl.bool_timings.we_extra_delay = true;
+		}
+	/* old interface */
+	} else if (div == 1) {
 		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
 		reg |= (1 << 7);
 		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG2, reg);
@@ -347,8 +380,39 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 		}
 	}
 
-	/* Configure GPMC for synchronous read */
-	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
+	/* gpmc driver interface */
+	if (gpmc_onenand_info.pdata != NULL) {
+		cs_info.have_config = true;
+		cs_info.config = GPMC_CONFIG1_DEVICESIZE_16 |
+					GPMC_CONFIG1_MUXADDDATA |
+					GPMC_CONFIG1_DEVICETYPE_NOR |
+					GPMC_CONFIG1_WRAPBURST_SUPP |
+					GPMC_CONFIG1_READMULTIPLE_SUPP |
+					GPMC_CONFIG1_PAGE_LEN_16;
+
+		if (!cpu_is_omap34xx())
+			cs_info.config |= GPMC_WAITPIN_0 |
+						GPMC_CONFIG1_WAIT_READ_MON;
+		if (sync_read)
+			cs_info.config |=
+						GPMC_CONFIG1_READTYPE_SYNC;
+		if (sync_write)
+			cs_info.config |=
+						GPMC_CONFIG1_WRITETYPE_SYNC |
+						GPMC_CONFIG1_WRITEMULTIPLE_SUPP;
+		t.clk_activation = fclk_offset_ns;
+		cs_info.time_ctrl.type = has_period;
+		cs_info.time_ctrl.timings = t;
+		err = gpmc_cs_reconfigure(gpmc_onenand_info.name,
+				gpmc_onenand_info.id, &cs_info);
+		if (err) {
+			pr_err("%s: gpmc_cs_reconfigure failed\n", __func__);
+			return err;
+		}
+	/* old interface */
+	} else {
+		/* Configure GPMC for synchronous read */
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
 			  GPMC_CONFIG1_WRAPBURST_SUPP |
 			  GPMC_CONFIG1_READMULTIPLE_SUPP |
 			  (sync_read ? GPMC_CONFIG1_READTYPE_SYNC : 0) |
@@ -363,9 +427,10 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 			  GPMC_CONFIG1_DEVICETYPE_NOR |
 			  GPMC_CONFIG1_MUXADDDATA);
 
-	err = gpmc_cs_set_timings(cs, &t);
-	if (err)
-		return err;
+		err = gpmc_cs_set_timings(cs, &t);
+		if (err)
+			return err;
+	}
 
 	set_onenand_cfg(onenand_base, latency, sync_read, sync_write, hf, vhf);
 
@@ -421,3 +486,25 @@ void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 		return;
 	}
 }
+
+struct gpmc_device_pdata *
+__init gpmc_onenand_update(struct omap_onenand_platform_data *_onenand_data)
+{
+	gpmc_onenand_data = _onenand_data;
+	gpmc_onenand_data->onenand_setup = gpmc_onenand_setup;
+
+	if (cpu_is_omap24xx() &&
+			(gpmc_onenand_data->flags & ONENAND_SYNC_READWRITE)) {
+		pr_warn("error: onenand using only SYNC_READ on 24xx\n");
+		gpmc_onenand_data->flags &= ~ONENAND_SYNC_READWRITE;
+		gpmc_onenand_data->flags |= ONENAND_SYNC_READ;
+	}
+
+	gpmc_onenand_info.pdata = gpmc_onenand_data;
+	gpmc_onenand_info.pdata_size = sizeof(*gpmc_onenand_data);
+	gpmc_onenand_cs_info.cs = gpmc_onenand_data->cs;
+
+	omap2_onenand_set_async_mode(gpmc_onenand_data->cs);
+
+	return &gpmc_onenand_info;
+}
diff --git a/arch/arm/plat-omap/include/plat/onenand.h b/arch/arm/plat-omap/include/plat/onenand.h
index 2858667..0e082d8 100644
--- a/arch/arm/plat-omap/include/plat/onenand.h
+++ b/arch/arm/plat-omap/include/plat/onenand.h
@@ -41,7 +41,8 @@ struct omap_onenand_platform_data {
 	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
 
 extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
-
+extern struct gpmc_device_pdata *
+gpmc_onenand_update(struct omap_onenand_platform_data *_onenand_data);
 #else
 
 #define board_onenand_data	NULL
@@ -49,5 +50,10 @@ extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
 static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
 {
 }
+static inline struct gpmc_device_pdata *
+gpmc_onenand_update(struct omap_onenand_platform_data *_onenand_data)
+{
+	return NULL;
+}
 
 #endif
-- 
1.7.10.2

