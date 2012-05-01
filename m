From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 11/39] ARM: OMAP2+: gpmc-smc91x: Adapt to use gpmc driver
Date: Tue, 1 May 2012 17:37:24 +0530
Message-ID: <95dd1a02da8ab95f2c20b19f75b0538d553b9c1c.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1335873032.git.afzal-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently gpmc is configured in platform for smc91x. As configuring
gpmc has been moved to gpmc driver, populate details needed for the
driver to configure gpmc. gpmc driver would configure based on this
information.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-2430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c           |    1 +
 arch/arm/mach-omap2/board-3630sdp.c           |    1 +
 arch/arm/mach-omap2/gpmc-smc91x.c             |   87 +++++++++++--------------
 arch/arm/plat-omap/include/plat/gpmc-smc91x.h |   10 ++-
 5 files changed, 47 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index e658f83..68679a8 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -175,7 +175,7 @@ static struct omap_smc91x_platform_data board_smc91x_data = {
 	.gpio_irq	= 149,
 	.flags		= GPMC_MUX_ADD_DATA | GPMC_TIMINGS_SMC91C96 |
 				IORESOURCE_IRQ_LOWLEVEL,
-
+	.skip_timing	= true,
 };
 
 static void __init board_smc91x_init(void)
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ac2e398..367a466 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -434,6 +434,7 @@ static struct omap_smc91x_platform_data board_smc91x_data = {
 	.cs		= 3,
 	.flags		= GPMC_MUX_ADD_DATA | GPMC_TIMINGS_SMC91C96 |
 				IORESOURCE_IRQ_LOWLEVEL,
+	.skip_timing	= true,
 };
 
 static void __init board_smc91x_init(void)
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 74195b7..143e47f 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -32,6 +32,7 @@
 static struct omap_smc91x_platform_data board_smc91x_data = {
 	.cs             = 3,
 	.flags          = GPMC_MUX_ADD_DATA | IORESOURCE_IRQ_LOWLEVEL,
+	.skip_timing	= true,
 };
 
 static void __init board_smc91x_init(void)
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
index ba10c24..9389df1 100644
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -23,13 +23,8 @@
 
 static struct omap_smc91x_platform_data *gpmc_cfg;
 
-static struct resource gpmc_smc91x_resources[] = {
-	[0] = {
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.flags		= IORESOURCE_IRQ,
-	},
+static struct resource gpmc_smc91x_resource = {
+	.flags		= IORESOURCE_IRQ,
 };
 
 static struct smc91x_platdata gpmc_smc91x_info = {
@@ -38,14 +33,17 @@ static struct smc91x_platdata gpmc_smc91x_info = {
 	.ledb	= RPC_LED_TX_RX,
 };
 
-static struct platform_device gpmc_smc91x_device = {
+static struct gpmc_cs_data gpmc_smc91x_cs_data;
+
+static struct gpmc_device_pdata gpmc_smc91x_data = {
 	.name		= "smc91x",
 	.id		= -1,
-	.dev		= {
-		.platform_data = &gpmc_smc91x_info,
-	},
-	.num_resources	= ARRAY_SIZE(gpmc_smc91x_resources),
-	.resource	= gpmc_smc91x_resources,
+	.pdata		= &gpmc_smc91x_info,
+	.pdata_size	= sizeof(gpmc_smc91x_info),
+	.per_res	= &gpmc_smc91x_resource,
+	.per_res_cnt	= 1,
+	.cs_data	= &gpmc_smc91x_cs_data,
+	.num_cs		= 1,
 };
 
 /*
@@ -54,9 +52,10 @@ static struct platform_device gpmc_smc91x_device = {
  * http://www.smsc.com/main/catalog/lan91c96.html
  * REVISIT: Level shifters can add at least to the access latency.
  */
-static int smc91c96_gpmc_retime(void)
+static void smc91c96_gpmc_retime(void)
 {
-	struct gpmc_timings t;
+	/* GPMC timing configuration after this function dies, hence static */
+	static struct gpmc_timings t;
 	const int t3 = 10;	/* Figure 12.2 read and 12.4 write */
 	const int t4_r = 20;	/* Figure 12.2 read */
 	const int t4_w = 5;	/* Figure 12.4 write */
@@ -65,7 +64,6 @@ static int smc91c96_gpmc_retime(void)
 	const int t7 = 5;	/* Figure 12.4 write */
 	const int t8 = 5;	/* Figure 12.4 write */
 	const int t20 = 185;	/* Figure 12.2 read and 12.4 write */
-	u32 l;
 
 	memset(&t, 0, sizeof(t));
 
@@ -93,16 +91,17 @@ static int smc91c96_gpmc_retime(void)
 	t.cs_wr_off = t.we_off + t4_w;
 	t.wr_cycle = t20 - t.we_on;
 
-	l = GPMC_CONFIG1_DEVICESIZE_16;
+	gpmc_smc91x_cs_data.have_config = true;
+	gpmc_smc91x_cs_data.config = GPMC_DEVICESIZE_16;
 	if (gpmc_cfg->flags & GPMC_MUX_ADD_DATA)
-		l |= GPMC_CONFIG1_MUXADDDATA;
+		gpmc_smc91x_cs_data.config |= GPMC_MUXADDDATA;
 	if (gpmc_cfg->flags & GPMC_READ_MON)
-		l |= GPMC_CONFIG1_WAIT_READ_MON;
+		gpmc_smc91x_cs_data.config |= GPMC_WAIT_READ_MON;
 	if (gpmc_cfg->flags & GPMC_WRITE_MON)
-		l |= GPMC_CONFIG1_WAIT_WRITE_MON;
+		gpmc_smc91x_cs_data.config |= GPMC_WAIT_WRITE_MON;
+	/* waitpin macros in GPMC header file has to be used by platforms */
 	if (gpmc_cfg->wait_pin)
-		l |= GPMC_CONFIG1_WAIT_PIN_SEL(gpmc_cfg->wait_pin);
-	gpmc_cs_write_reg(gpmc_cfg->cs, GPMC_CS_CONFIG1, l);
+		gpmc_smc91x_cs_data.config |= gpmc_cfg->wait_pin;
 
 	/*
 	 * FIXME: Calculate the address and data bus muxed timings.
@@ -111,10 +110,10 @@ static int smc91c96_gpmc_retime(void)
 	 * FPGA in between smc91x and omap as the timings are different
 	 * from above?
 	 */
-	if (gpmc_cfg->flags & GPMC_MUX_ADD_DATA)
-		return 0;
+	if (gpmc_cfg->skip_timing)
+		return;
 
-	return gpmc_cs_set_timings(gpmc_cfg->cs, &t);
+	gpmc_smc91x_cs_data.timing = &t;
 }
 
 /*
@@ -122,9 +121,9 @@ static int smc91c96_gpmc_retime(void)
  * assume that pin multiplexing is done in the board-*.c file,
  * or in the bootloader.
  */
-void __init gpmc_smc91x_init(struct omap_smc91x_platform_data *board_data)
+__init struct gpmc_device_pdata *
+gpmc_smc91x_init(struct omap_smc91x_platform_data *board_data)
 {
-	unsigned long cs_mem_base;
 	int ret;
 
 	gpmc_cfg = board_data;
@@ -132,25 +131,19 @@ void __init gpmc_smc91x_init(struct omap_smc91x_platform_data *board_data)
 	if (gpmc_cfg->flags & GPMC_TIMINGS_SMC91C96)
 		gpmc_cfg->retime = smc91c96_gpmc_retime;
 
-	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
-		return;
-	}
+	gpmc_smc91x_cs_data.cs		= gpmc_cfg->cs;
+	gpmc_smc91x_cs_data.mem_offset	= 0x300;
+	gpmc_smc91x_cs_data.mem_size	= 0x10;
 
-	gpmc_smc91x_resources[0].start = cs_mem_base + 0x300;
-	gpmc_smc91x_resources[0].end = cs_mem_base + 0x30f;
-	gpmc_smc91x_resources[1].flags |= (gpmc_cfg->flags & IRQF_TRIGGER_MASK);
+	gpmc_smc91x_resource.flags |= (gpmc_cfg->flags & IRQF_TRIGGER_MASK);
 
-	if (gpmc_cfg->retime) {
-		ret = gpmc_cfg->retime();
-		if (ret != 0)
-			goto free1;
-	}
+	if (gpmc_cfg->retime)
+		gpmc_cfg->retime();
 
 	if (gpio_request_one(gpmc_cfg->gpio_irq, GPIOF_IN, "SMC91X irq") < 0)
-		goto free1;
+		return NULL;
 
-	gpmc_smc91x_resources[1].start = gpio_to_irq(gpmc_cfg->gpio_irq);
+	gpmc_smc91x_resource.start = gpio_to_irq(gpmc_cfg->gpio_irq);
 
 	if (gpmc_cfg->gpio_pwrdwn) {
 		ret = gpio_request_one(gpmc_cfg->gpio_pwrdwn,
@@ -170,21 +163,15 @@ void __init gpmc_smc91x_init(struct omap_smc91x_platform_data *board_data)
 		gpio_set_value(gpmc_cfg->gpio_reset, 0);
 	}
 
-	if (platform_device_register(&gpmc_smc91x_device) < 0) {
-		printk(KERN_ERR "Unable to register smc91x device\n");
-		gpio_free(gpmc_cfg->gpio_reset);
-		goto free3;
-	}
-
-	return;
+	return &gpmc_smc91x_data;
 
 free3:
 	if (gpmc_cfg->gpio_pwrdwn)
 		gpio_free(gpmc_cfg->gpio_pwrdwn);
 free2:
 	gpio_free(gpmc_cfg->gpio_irq);
-free1:
-	gpmc_cs_free(gpmc_cfg->cs);
 
 	printk(KERN_ERR "Could not initialize smc91x\n");
+
+	return NULL;
 }
diff --git a/arch/arm/plat-omap/include/plat/gpmc-smc91x.h b/arch/arm/plat-omap/include/plat/gpmc-smc91x.h
index b64fbee..f3a01b1 100644
--- a/arch/arm/plat-omap/include/plat/gpmc-smc91x.h
+++ b/arch/arm/plat-omap/include/plat/gpmc-smc91x.h
@@ -22,20 +22,24 @@ struct omap_smc91x_platform_data {
 	int	gpio_reset;
 	int	wait_pin;	/* Optional GPMC_CONFIG1_WAITPINSELECT */
 	u32	flags;
-	int	(*retime)(void);
+	bool	skip_timing;
+	void	(*retime)(void);
 };
 
 #if defined(CONFIG_SMC91X) || \
 	defined(CONFIG_SMC91X_MODULE)
 
-extern void gpmc_smc91x_init(struct omap_smc91x_platform_data *d);
+extern struct gpmc_device_pdata *
+gpmc_smc91x_init(struct omap_smc91x_platform_data *d);
 
 #else
 
 #define board_smc91x_data	NULL
 
-static inline void gpmc_smc91x_init(struct omap_smc91x_platform_data *d)
+static inline struct gpmc_device_pdata *
+gpmc_smc91x_init(struct omap_smc91x_platform_data *d)
 {
+	return NULL;
 }
 
 #endif
-- 
1.7.10

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
