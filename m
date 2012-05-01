From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 12/39] ARM: OMAP2+: gpmc-tusb6010: Adapt to gpmc driver
Date: Tue, 1 May 2012 17:37:32 +0530
Message-ID: <9d28cfec31eac2b7975e34c37aad884c75c3cdac.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1335873032.git.afzal-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently gpmc is configured in platform for tusb6010. As configuring
gpmc has been moved to gpmc driver, populate details needed for the
driver to configure gpmc. gpmc driver would configure based on this
information.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/usb-tusb6010.c |  177 ++++++++++++++----------------------
 include/linux/usb/musb.h           |    4 +-
 2 files changed, 70 insertions(+), 111 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index db84a46..d7817d2 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -22,6 +22,24 @@
 
 #include "mux.h"
 
+static struct resource tusb_resources = {
+	.name	= "mc",
+	.flags	= IORESOURCE_IRQ,
+};
+
+#define	TUSB_GPMC_CS_ASYNC_IDX	1
+#define	TUSB_GPMC_CS_SYNC_IDX	2
+#define	TUSB_GPMC_CS_NUM	2
+
+static struct gpmc_cs_data gpmc_tusb_cs_data[TUSB_GPMC_CS_NUM];
+
+static struct gpmc_device_pdata gpmc_tusb_data = {
+	.name		= "musb-tusb",
+	.id		= -1,
+	.per_res	= &tusb_resources,
+	.per_res_cnt	= 1,
+};
+
 static u8		async_cs, sync_cs;
 static unsigned		refclk_psec;
 
@@ -51,9 +69,9 @@ next_clk(unsigned t1_NS, unsigned t2_ps, unsigned fclk_ps)
 
 /* NOTE:  timings are from tusb 6010 datasheet Rev 1.8, 12-Sept 2006 */
 
-static int tusb_set_async_mode(unsigned sysclk_ps, unsigned fclk_ps)
+static void tusb_set_async_mode(unsigned sysclk_ps, unsigned fclk_ps)
 {
-	struct gpmc_timings	t;
+	static struct gpmc_timings t;
 	unsigned		t_acsnh_advnh = sysclk_ps + 3000;
 	unsigned		tmp;
 
@@ -106,12 +124,12 @@ static int tusb_set_async_mode(unsigned sysclk_ps, unsigned fclk_ps)
 	tmp = t.cs_wr_off * 1000 + 7000 /* t_acsn_rdy_z */;
 	t.wr_cycle = next_clk(t.cs_wr_off, tmp, fclk_ps);
 
-	return gpmc_cs_set_timings(async_cs, &t);
+	gpmc_tusb_cs_data[TUSB_GPMC_CS_ASYNC_IDX].timing = &t;
 }
 
 static int tusb_set_sync_mode(unsigned sysclk_ps, unsigned fclk_ps)
 {
-	struct gpmc_timings	t;
+	static struct gpmc_timings t;
 	unsigned		t_scsnh_advnh = sysclk_ps + 3000;
 	unsigned		tmp;
 
@@ -174,71 +192,30 @@ static int tusb_set_sync_mode(unsigned sysclk_ps, unsigned fclk_ps)
 	tmp = t.cs_wr_off * 1000 + 7000 /* t_scsn_rdy_z */;
 	t.wr_cycle = next_clk(t.cs_wr_off, tmp, fclk_ps);
 
-	return gpmc_cs_set_timings(sync_cs, &t);
+	gpmc_tusb_cs_data[TUSB_GPMC_CS_SYNC_IDX].timing = &t;
+
+	return 0;
 }
 
 extern unsigned long gpmc_get_fclk_period(void);
 
 /* tusb driver calls this when it changes the chip's clocking */
-int tusb6010_platform_retime(unsigned is_refclk)
+static int tusb6010_platform_retime(unsigned is_refclk)
 {
-	static const char	error[] =
-		KERN_ERR "tusb6010 %s retime error %d\n";
-
 	unsigned	fclk_ps = gpmc_get_fclk_period();
 	unsigned	sysclk_ps;
-	int		status;
 
 	if (!refclk_psec || fclk_ps == 0)
 		return -ENODEV;
 
 	sysclk_ps = is_refclk ? refclk_psec : TUSB6010_OSCCLK_60;
 
-	status = tusb_set_async_mode(sysclk_ps, fclk_ps);
-	if (status < 0) {
-		printk(error, "async", status);
-		goto done;
-	}
-	status = tusb_set_sync_mode(sysclk_ps, fclk_ps);
-	if (status < 0)
-		printk(error, "sync", status);
-done:
-	return status;
+	tusb_set_async_mode(sysclk_ps, fclk_ps);
+	return tusb_set_sync_mode(sysclk_ps, fclk_ps);
 }
-EXPORT_SYMBOL_GPL(tusb6010_platform_retime);
-
-static struct resource tusb_resources[] = {
-	/* Order is significant!  The start/end fields
-	 * are updated during setup..
-	 */
-	{ /* Asynchronous access */
-		.flags	= IORESOURCE_MEM,
-	},
-	{ /* Synchronous access */
-		.flags	= IORESOURCE_MEM,
-	},
-	{ /* IRQ */
-		.name	= "mc",
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 tusb_dmamask = ~(u32)0;
-
-static struct platform_device tusb_device = {
-	.name		= "musb-tusb",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &tusb_dmamask,
-		.coherent_dma_mask	= 0xffffffff,
-	},
-	.num_resources	= ARRAY_SIZE(tusb_resources),
-	.resource	= tusb_resources,
-};
-
 
 /* this may be called only from board-*.c setup code */
-int __init
+__init struct gpmc_device_pdata *
 tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 		unsigned ps_refclk, unsigned waitpin,
 		unsigned async, unsigned sync,
@@ -249,82 +226,72 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 		KERN_ERR "tusb6010 init error %d, %d\n";
 
 	/* ASYNC region, primarily for PIO */
-	status = gpmc_cs_request(async, SZ_16M, (unsigned long *)
-				&tusb_resources[0].start);
-	if (status < 0) {
-		printk(error, 1, status);
-		return status;
-	}
-	tusb_resources[0].end = tusb_resources[0].start + 0x9ff;
+	gpmc_tusb_cs_data[TUSB_GPMC_CS_ASYNC_IDX].cs		= async;
+	gpmc_tusb_cs_data[TUSB_GPMC_CS_ASYNC_IDX].mem_size	= 0x1000;
+
 	async_cs = async;
-	gpmc_cs_write_reg(async, GPMC_CS_CONFIG1,
-			  GPMC_CONFIG1_PAGE_LEN(2)
-			| GPMC_CONFIG1_WAIT_READ_MON
-			| GPMC_CONFIG1_WAIT_WRITE_MON
-			| GPMC_CONFIG1_WAIT_PIN_SEL(waitpin)
-			| GPMC_CONFIG1_READTYPE_ASYNC
-			| GPMC_CONFIG1_WRITETYPE_ASYNC
-			| GPMC_CONFIG1_DEVICESIZE_16
-			| GPMC_CONFIG1_DEVICETYPE_NOR
-			| GPMC_CONFIG1_MUXADDDATA);
 
+	gpmc_tusb_cs_data[TUSB_GPMC_CS_ASYNC_IDX].have_config = true;
+	gpmc_tusb_cs_data[TUSB_GPMC_CS_ASYNC_IDX].config = GPMC_DEVICESIZE_16 |
+						GPMC_WAIT_READ_MON |
+						GPMC_WAIT_WRITE_MON |
+						GPMC_READTYPE_ASYNC |
+						GPMC_WRITETYPE_ASYNC |
+						GPMC_DEVICETYPE_NOR |
+						GPMC_MUXADDDATA |
+						GPMC_PAGE_LEN_16 |
+						waitpin;
 
 	/* SYNC region, primarily for DMA */
-	status = gpmc_cs_request(sync, SZ_16M, (unsigned long *)
-				&tusb_resources[1].start);
-	if (status < 0) {
-		printk(error, 2, status);
-		return status;
-	}
-	tusb_resources[1].end = tusb_resources[1].start + 0x9ff;
+	gpmc_tusb_cs_data[TUSB_GPMC_CS_SYNC_IDX].cs		= sync;
+	gpmc_tusb_cs_data[TUSB_GPMC_CS_SYNC_IDX].mem_size	= 0x1000;
+
 	sync_cs = sync;
-	gpmc_cs_write_reg(sync, GPMC_CS_CONFIG1,
-			  GPMC_CONFIG1_READMULTIPLE_SUPP
-			| GPMC_CONFIG1_READTYPE_SYNC
-			| GPMC_CONFIG1_WRITEMULTIPLE_SUPP
-			| GPMC_CONFIG1_WRITETYPE_SYNC
-			| GPMC_CONFIG1_CLKACTIVATIONTIME(1)
-			| GPMC_CONFIG1_PAGE_LEN(2)
-			| GPMC_CONFIG1_WAIT_READ_MON
-			| GPMC_CONFIG1_WAIT_WRITE_MON
-			| GPMC_CONFIG1_WAIT_PIN_SEL(waitpin)
-			| GPMC_CONFIG1_DEVICESIZE_16
-			| GPMC_CONFIG1_DEVICETYPE_NOR
-			| GPMC_CONFIG1_MUXADDDATA
-			/* fclk divider gets set later */
-			);
+
+	gpmc_tusb_cs_data[TUSB_GPMC_CS_SYNC_IDX].have_config = true;
+	/* fclk divider gets set later */
+	gpmc_tusb_cs_data[TUSB_GPMC_CS_SYNC_IDX].config = GPMC_DEVICESIZE_16 |
+						GPMC_WAIT_READ_MON |
+						GPMC_WAIT_WRITE_MON |
+						GPMC_READTYPE_SYNC |
+						GPMC_WRITETYPE_SYNC |
+						GPMC_DEVICETYPE_NOR |
+						GPMC_MUXADDDATA |
+						GPMC_PAGE_LEN_16 |
+						GPMC_CLOCKACTIVATION_TIME_1 |
+						GPMC_READMULTIPLE |
+						GPMC_WRITEMULTIPLE |
+						waitpin;
 
 	/* IRQ */
 	status = gpio_request_one(irq, GPIOF_IN, "TUSB6010 irq");
 	if (status < 0) {
 		printk(error, 3, status);
-		return status;
+		return NULL;
 	}
-	tusb_resources[2].start = irq + IH_GPIO_BASE;
+	tusb_resources.start = irq + IH_GPIO_BASE;
 
 	/* set up memory timings ... can speed them up later */
 	if (!ps_refclk) {
 		printk(error, 4, status);
-		return -ENODEV;
+		return NULL;
 	}
 	refclk_psec = ps_refclk;
 	status = tusb6010_platform_retime(1);
 	if (status < 0) {
 		printk(error, 5, status);
-		return status;
+		return NULL;
 	}
 
-	/* finish device setup ... */
 	if (!data) {
 		printk(error, 6, status);
-		return -ENODEV;
+		return NULL;
 	}
-	tusb_device.dev.platform_data = data;
+	gpmc_tusb_data.pdata = data;
+	gpmc_tusb_data.pdata_size = sizeof(*data);
 
 	/* REVISIT let the driver know what DMA channels work */
-	if (!dmachan)
-		tusb_device.dev.dma_mask = NULL;
-	else {
+	if (dmachan) {
 		/* assume OMAP 2420 ES2.0 and later */
 		if (dmachan & (1 << 0))
 			omap_mux_init_signal("sys_ndmareq0", 0);
@@ -340,11 +307,5 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 			omap_mux_init_signal("sys_ndmareq5", 0);
 	}
 
-	/* so far so good ... register the device */
-	status = platform_device_register(&tusb_device);
-	if (status < 0) {
-		printk(error, 7, status);
-		return status;
-	}
-	return 0;
+	return &gpmc_tusb_data;
 }
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index eb50525..a7de510 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -139,14 +139,12 @@ struct musb_hdrc_platform_data {
 
 #ifdef	CONFIG_ARCH_OMAP2
 
-extern int __init tusb6010_setup_interface(
+extern __init struct gpmc_device_pdata *tusb6010_setup_interface(
 		struct musb_hdrc_platform_data *data,
 		unsigned ps_refclk, unsigned waitpin,
 		unsigned async_cs, unsigned sync_cs,
 		unsigned irq, unsigned dmachan);
 
-extern int tusb6010_platform_retime(unsigned is_refclk);
