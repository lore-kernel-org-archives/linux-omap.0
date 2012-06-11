From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 5/9] ARM: OMAP2+: gpmc-smc91x: Adapt to use gpmc driver
Date: Mon, 11 Jun 2012 20:29:40 +0530
Message-ID: <0bdbc293fc98613011d37ec59559ba6d475eadf2.1339419379.git.afzal@ti.com>
References: <cover.1339419379.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52382 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab2FKPPU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 11:15:20 -0400
In-Reply-To: <cover.1339419379.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Currently gpmc is configured in platform for smc91x. As now
gpmc driver is present, populate details needed for the
driver to configure gpmc, gpmc driver would configure based
on this information. Old interface has been left as is so
that platforms can continue configuring gpmc using old
interface too. This is done so that driver conversion can
be done gradually without breaking any.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-smc91x.c             |   69 +++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/gpmc-smc91x.h |   12 +++--
 2 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
index ba10c24..06f7e73 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -48,6 +48,19 @@ static struct platform_device gpmc_smc91x_device = {
 	.resource	= gpmc_smc91x_resources,
 };
 
+static struct gpmc_cs_data gpmc_smc91x_cs_data;
+
+static struct gpmc_device_pdata gpmc_smc91x_data = {
+	.name		= "smc91x",
+	.id		= -1,
+	.pdata		= &gpmc_smc91x_info,
+	.pdata_size	= sizeof(gpmc_smc91x_info),
+	.per_res	= gpmc_smc91x_resources + 1,
+	.per_res_cnt	= 1,
+	.cs_data	= &gpmc_smc91x_cs_data,
+	.num_cs		= 1,
+};
+
 /*
  * Set the gpmc timings for smc91c96. The timings are taken
  * from the data sheet available at:
@@ -100,9 +113,18 @@ static int smc91c96_gpmc_retime(void)
 		l |= GPMC_CONFIG1_WAIT_READ_MON;
 	if (gpmc_cfg->flags & GPMC_WRITE_MON)
 		l |= GPMC_CONFIG1_WAIT_WRITE_MON;
-	if (gpmc_cfg->wait_pin)
-		l |= GPMC_CONFIG1_WAIT_PIN_SEL(gpmc_cfg->wait_pin);
-	gpmc_cs_write_reg(gpmc_cfg->cs, GPMC_CS_CONFIG1, l);
+
+	/* gpmc driver interface */
+	if (gpmc_smc91x_cs_data.mem_size == 0x10) {
+		gpmc_smc91x_cs_data.have_config = true;
+		/* waitpin macro, not waitpin number */
+		gpmc_smc91x_cs_data.config |= l |
+				(gpmc_cfg->wait_pin & GPMC_WAITPIN_MASK);
+	} else {
+		if (gpmc_cfg->wait_pin)
+			l |= GPMC_CONFIG1_WAIT_PIN_SEL(gpmc_cfg->wait_pin);
+		gpmc_cs_write_reg(gpmc_cfg->cs, GPMC_CS_CONFIG1, l);
+	}
 
 	/*
 	 * FIXME: Calculate the address and data bus muxed timings.
@@ -114,7 +136,13 @@ static int smc91c96_gpmc_retime(void)
 	if (gpmc_cfg->flags & GPMC_MUX_ADD_DATA)
 		return 0;
 
-	return gpmc_cs_set_timings(gpmc_cfg->cs, &t);
+	/* gpmc driver interface */
+	if (gpmc_smc91x_cs_data.mem_size == 0x10) {
+		gpmc_smc91x_cs_data.time_ctrl.type = has_period;
+		gpmc_smc91x_cs_data.time_ctrl.timings = t;
+		return 0;
+	} else
+		return gpmc_cs_set_timings(gpmc_cfg->cs, &t);
 }
 
 /*
@@ -132,13 +160,17 @@ void __init gpmc_smc91x_init(struct omap_smc91x_platform_data *board_data)
 	if (gpmc_cfg->flags & GPMC_TIMINGS_SMC91C96)
 		gpmc_cfg->retime = smc91c96_gpmc_retime;
 
-	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
-		return;
+	/* old interface */
+	if (gpmc_smc91x_cs_data.mem_size != 0x10) {
+		if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
+			pr_err("error: gpmc_cs_request on smc91x\n");
+			return;
+		}
+
+		gpmc_smc91x_resources[0].start = cs_mem_base + 0x300;
+		gpmc_smc91x_resources[0].end = cs_mem_base + 0x30f;
 	}
 
-	gpmc_smc91x_resources[0].start = cs_mem_base + 0x300;
-	gpmc_smc91x_resources[0].end = cs_mem_base + 0x30f;
 	gpmc_smc91x_resources[1].flags |= (gpmc_cfg->flags & IRQF_TRIGGER_MASK);
 
 	if (gpmc_cfg->retime) {
@@ -170,6 +202,10 @@ void __init gpmc_smc91x_init(struct omap_smc91x_platform_data *board_data)
 		gpio_set_value(gpmc_cfg->gpio_reset, 0);
 	}
 
+	/* gpmc driver interface */
+	if (gpmc_smc91x_cs_data.mem_size == 0x10)
+		return;
+
 	if (platform_device_register(&gpmc_smc91x_device) < 0) {
 		printk(KERN_ERR "Unable to register smc91x device\n");
 		gpio_free(gpmc_cfg->gpio_reset);
@@ -184,7 +220,20 @@ free3:
 free2:
 	gpio_free(gpmc_cfg->gpio_irq);
 free1:
-	gpmc_cs_free(gpmc_cfg->cs);
+	if (gpmc_smc91x_cs_data.mem_size != 0x10)
+		gpmc_cs_free(gpmc_cfg->cs);
 
 	printk(KERN_ERR "Could not initialize smc91x\n");
 }
+
+struct gpmc_device_pdata *
+__init gpmc_smc91x_update(struct omap_smc91x_platform_data *board_data)
+{
+	gpmc_smc91x_cs_data.cs		= gpmc_cfg->cs;
+	gpmc_smc91x_cs_data.mem_offset	= 0x300;
+	gpmc_smc91x_cs_data.mem_size	= 0x10;
+
+	gpmc_smc91x_init(board_data);
+
+	return &gpmc_smc91x_data;
+}
diff --git a/arch/arm/plat-omap/include/plat/gpmc-smc91x.h b/arch/arm/plat-omap/include/plat/gpmc-smc91x.h
index b64fbee..91cc7ef 100644
--- a/arch/arm/plat-omap/include/plat/gpmc-smc91x.h
+++ b/arch/arm/plat-omap/include/plat/gpmc-smc91x.h
@@ -27,16 +27,18 @@ struct omap_smc91x_platform_data {
 
 #if defined(CONFIG_SMC91X) || \
 	defined(CONFIG_SMC91X_MODULE)
-
 extern void gpmc_smc91x_init(struct omap_smc91x_platform_data *d);
-
+extern struct gpmc_device_pdata *
+gpmc_smc91x_update(struct omap_smc91x_platform_data *board_data);
 #else
-
 #define board_smc91x_data	NULL
-
 static inline void gpmc_smc91x_init(struct omap_smc91x_platform_data *d)
 {
 }
-
+static inline struct gpmc_device_pdata *
+gpmc_smc91x_update(struct omap_smc91x_platform_data *board_data)
+{
+	return NULL;
+}
 #endif
 #endif
-- 
1.7.10.2

