From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 08/39] ARM: OMAP2+: gpmc-onenand: Adapt to use gpmc driver
Date: Tue, 1 May 2012 17:37:03 +0530
Message-ID: <22c26038c318cc6548c108a6958e712cc387863e.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59644 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755968Ab2EAMYN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:24:13 -0400
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Currently gpmc is configured in platform for onenand. As configuring
gpmc has been moved to gpmc driver, populate details needed for the
driver to configure gpmc. gpmc driver would configure based on this
information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c        |  111 +++++++++++++++--------------
 arch/arm/plat-omap/include/plat/onenand.h |    7 +-
 2 files changed, 61 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index a0fa9bb..d7775d5 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -25,9 +25,17 @@
 
 static struct omap_onenand_platform_data *gpmc_onenand_data;
 
-static struct platform_device gpmc_onenand_device = {
+#define ONENAND_IO_SIZE		SZ_128K
+
+static struct gpmc_cs_data gpmc_onenand_cs_info = {
+	.mem_size	= ONENAND_IO_SIZE,
+};
+
+static struct gpmc_device_pdata gpmc_onenand_info = {
 	.name		= "omap2-onenand",
 	.id		= -1,
+	.cs_data	= &gpmc_onenand_cs_info,
+	.num_cs		= 1,
 };
 
 static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
@@ -79,13 +87,17 @@ static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
 	t.wr_cycle  = t.cs_wr_off + gpmc_round_ns_to_ticks(t_cez);
 
 	/* Configure GPMC for asynchronous read */
-	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
-			  GPMC_CONFIG1_DEVICESIZE_16 |
-			  GPMC_CONFIG1_MUXADDDATA);
-
-	err = gpmc_cs_set_timings(cs, &t);
-	if (err)
+	gpmc_onenand_cs_info.have_config = true;
+	gpmc_onenand_cs_info.config = GPMC_DEVICESIZE_16 |
+					GPMC_MUXADDDATA |
+					GPMC_DEVICETYPE_NOR;
+	gpmc_onenand_cs_info.timing = &t;
+	err = gpmc_cs_reconfigure(gpmc_onenand_info.name,
+			gpmc_onenand_info.id, &gpmc_onenand_cs_info);
+	if (err) {
+		pr_err("%s: gpmc_cs_reconfigure failed\n", __func__);
 		return err;
+	}
 
 	/* Ensure sync read and sync write are disabled */
 	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
@@ -180,7 +192,6 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	int first_time = 0, hf = 0, vhf = 0, sync_read = 0, sync_write = 0;
 	int err, ticks_cez;
 	int cs = cfg->cs, freq = *freq_ptr;
-	u32 reg;
 	bool clk_dep = false;
 
 	if (cfg->flags & ONENAND_SYNC_READ) {
@@ -276,27 +287,10 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
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
+		t.control.cs_extra_delay = true;
+		t.control.adv_extra_delay = true;
+		t.control.oe_extra_delay = true;
+		t.control.we_extra_delay = true;
 	}
 
 	/* Set synchronous read timings */
@@ -348,24 +342,31 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 	}
 
 	/* Configure GPMC for synchronous read */
-	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
-			  GPMC_CONFIG1_WRAPBURST_SUPP |
-			  GPMC_CONFIG1_READMULTIPLE_SUPP |
-			  (sync_read ? GPMC_CONFIG1_READTYPE_SYNC : 0) |
-			  (sync_write ? GPMC_CONFIG1_WRITEMULTIPLE_SUPP : 0) |
-			  (sync_write ? GPMC_CONFIG1_WRITETYPE_SYNC : 0) |
-			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
-			  GPMC_CONFIG1_PAGE_LEN(2) |
-			  (cpu_is_omap34xx() ? 0 :
-				(GPMC_CONFIG1_WAIT_READ_MON |
-				 GPMC_CONFIG1_WAIT_PIN_SEL(0))) |
-			  GPMC_CONFIG1_DEVICESIZE_16 |
-			  GPMC_CONFIG1_DEVICETYPE_NOR |
-			  GPMC_CONFIG1_MUXADDDATA);
-
-	err = gpmc_cs_set_timings(cs, &t);
-	if (err)
+	gpmc_onenand_cs_info.have_config = true;
+	gpmc_onenand_cs_info.config = GPMC_DEVICESIZE_16 | GPMC_MUXADDDATA |
+					GPMC_DEVICETYPE_NOR | GPMC_WRAPBURST |
+					GPMC_READMULTIPLE | GPMC_PAGE_LEN_16;
+	if (!cpu_is_omap34xx())
+		gpmc_onenand_cs_info.config |= GPMC_WAIT_READ_MON |
+						GPMC_WAITPIN_0;
+	if (sync_read)
+		gpmc_onenand_cs_info.config |= GPMC_READTYPE_SYNC;
+	if (sync_write)
+		gpmc_onenand_cs_info.config |= GPMC_WRITETYPE_SYNC |
+						GPMC_WRITEMULTIPLE;
+	if (fclk_offset == 0)
+		gpmc_onenand_cs_info.config |= GPMC_CLOCKACTIVATIONTIME_0;
+	else if (fclk_offset == 1)
+		gpmc_onenand_cs_info.config |= GPMC_CLOCKACTIVATIONTIME_1;
+	else if (fclk_offset == 2)
+		gpmc_onenand_cs_info.config |= GPMC_CLOCKACTIVATIONTIME_2;
+	gpmc_onenand_cs_info.timing = &t;
+	err = gpmc_cs_reconfigure(gpmc_onenand_info.name,
+			gpmc_onenand_info.id, &gpmc_onenand_cs_info);
+	if (err) {
+		pr_err("%s: gpmc_cs_reconfigure failed\n", __func__);
 		return err;
+	}
 
 	set_onenand_cfg(onenand_base, latency, sync_read, sync_write, hf, vhf);
 
@@ -376,23 +377,21 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
 
 static int gpmc_onenand_setup(void __iomem *onenand_base, int *freq_ptr)
 {
-	struct device *dev = &gpmc_onenand_device.dev;
-
 	/* Set sync timings in GPMC */
 	if (omap2_onenand_set_sync_mode(gpmc_onenand_data, onenand_base,
 			freq_ptr) < 0) {
-		dev_err(dev, "Unable to set synchronous mode\n");
+		pr_err("%s: Unable to set synchronous mode\n", __func__);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
+struct gpmc_device_pdata *
+__init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 {
 	gpmc_onenand_data = _onenand_data;
 	gpmc_onenand_data->onenand_setup = gpmc_onenand_setup;
-	gpmc_onenand_device.dev.platform_data = gpmc_onenand_data;
 
 	if (cpu_is_omap24xx() &&
 			(gpmc_onenand_data->flags & ONENAND_SYNC_READWRITE)) {
@@ -401,8 +400,10 @@ void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 		gpmc_onenand_data->flags |= ONENAND_SYNC_READ;
 	}
 
-	if (platform_device_register(&gpmc_onenand_device) < 0) {
-		printk(KERN_ERR "Unable to register OneNAND device\n");
-		return;
-	}
+	gpmc_onenand_info.pdata = gpmc_onenand_data;
+	gpmc_onenand_info.pdata_size = sizeof(*gpmc_onenand_data);
+
+	gpmc_onenand_cs_info.cs = gpmc_onenand_data->cs;
+
+	return &gpmc_onenand_info;
 }
diff --git a/arch/arm/plat-omap/include/plat/onenand.h b/arch/arm/plat-omap/include/plat/onenand.h
index 2858667..47cd710 100644
--- a/arch/arm/plat-omap/include/plat/onenand.h
+++ b/arch/arm/plat-omap/include/plat/onenand.h
@@ -40,14 +40,17 @@ struct omap_onenand_platform_data {
 #if defined(CONFIG_MTD_ONENAND_OMAP2) || \
 	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
 
-extern void gpmc_onenand_init(struct omap_onenand_platform_data *d);
+extern struct gpmc_device_pdata *
+gpmc_onenand_init(struct omap_onenand_platform_data *d);
 
 #else
 
 #define board_onenand_data	NULL
 
-static inline void gpmc_onenand_init(struct omap_onenand_platform_data *d)
+static inline struct gpmc_device_pdata *
+gpmc_onenand_init(struct omap_onenand_platform_data *d)
 {
+	return NULL;
 }
 
 #endif
-- 
1.7.10

