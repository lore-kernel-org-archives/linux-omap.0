From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 31/36] ARM: OMAP2: usb-tusb6010: Use gpmc_generic_init()
Date: Wed, 11 Jun 2014 11:56:36 +0300
Message-ID: <1402477001-31132-32-git-send-email-rogerq@ti.com>
References: <1402477001-31132-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402477001-31132-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, dwmw2@infradead.org, computersforpeace@gmail.com
Cc: kyungmin.park@samsung.com, pekon@ti.com, ezequiel.garcia@free-electrons.com, javier@dowhile0.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Don't access any GPMC registers here. Use gpmc_generic_init()
to pass GPMC Chip Select settings, platform device and platform data
to the GPMC driver.

CC: Felipe Balbi <balbi@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c | 78 +++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 71e6246..d28f5cd 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -125,13 +125,17 @@ EXPORT_SYMBOL_GPL(tusb6010_platform_retime);
 
 static struct resource tusb_resources[] = {
 	/* Order is significant!  The start/end fields
-	 * are updated during setup..
+	 * are updated by GPMC driver, see gpmc_probe_legacy()
 	 */
-	{ /* Asynchronous access */
-		.flags	= IORESOURCE_MEM,
+	{ /* Asynchronous access, for PIO */
+		.flags = IORESOURCE_MEM,
+		.start = 0,
+		.end = 0x9ff,
 	},
-	{ /* Synchronous access */
-		.flags	= IORESOURCE_MEM,
+	{ /* Synchronous access, for DMA */
+		.flags = IORESOURCE_MEM,
+		.start = 0,
+		.end = 0x9ff,
 	},
 	{ /* IRQ */
 		.name	= "mc",
@@ -163,37 +167,16 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 	int		status;
 	static char	error[] __initdata =
 		KERN_ERR "tusb6010 init error %d, %d\n";
+	struct gpmc_device_timings dev_async_t;
+	struct gpmc_device_timings dev_sync_t;
 
-	/* ASYNC region, primarily for PIO */
-	status = gpmc_cs_request(async, SZ_16M, (unsigned long *)
-				&tusb_resources[0].start);
-	if (status < 0) {
-		printk(error, 1, status);
-		return status;
-	}
-	tusb_resources[0].end = tusb_resources[0].start + 0x9ff;
+	/* GPMC settings */
 	tusb_async.wait_pin = waitpin;
 	async_cs = async;
 
-	status = gpmc_cs_program_settings(async_cs, &tusb_async);
-	if (status < 0)
-		return status;
-
-	/* SYNC region, primarily for DMA */
-	status = gpmc_cs_request(sync, SZ_16M, (unsigned long *)
-				&tusb_resources[1].start);
-	if (status < 0) {
-		printk(error, 2, status);
-		return status;
-	}
-	tusb_resources[1].end = tusb_resources[1].start + 0x9ff;
 	tusb_sync.wait_pin = waitpin;
 	sync_cs = sync;
 
-	status = gpmc_cs_program_settings(sync_cs, &tusb_sync);
-	if (status < 0)
-		return status;
-
 	/* IRQ */
 	status = gpio_request_one(irq, GPIOF_IN, "TUSB6010 irq");
 	if (status < 0) {
@@ -208,11 +191,10 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 		return -ENODEV;
 	}
 	refclk_psec = ps_refclk;
-	status = tusb6010_platform_retime(1);
-	if (status < 0) {
-		printk(error, 5, status);
-		return status;
-	}
+
+	/* device timings */
+	tusb_get_async_timings(ps_refclk, &dev_async_t);
+	tusb_get_sync_timings(ps_refclk, &dev_sync_t);
 
 	/* finish device setup ... */
 	if (!data) {
@@ -240,11 +222,29 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 			omap_mux_init_signal("sys_ndmareq5", 0);
 	}
 
-	/* so far so good ... register the device */
-	status = platform_device_register(&tusb_device);
-	if (status < 0) {
-		printk(error, 7, status);
-		return status;
+	/* Register ASYNC region */
+	status = gpmc_generic_init(async_cs, false,
+				   &tusb_async, &dev_async_t, NULL,
+				   &tusb_device, sizeof(*data));
+
+	if (status) {
+		pr_err("%s: failed to register ASYNC region\n", __func__);
+		goto fail;
 	}
+
+	/* Register SYNC region */
+	status = gpmc_generic_init(sync_cs, false,
+				   &tusb_sync, &dev_sync_t, NULL,
+				   &tusb_device, sizeof(*data));
+	if (status) {
+		pr_err("%s: failed to register SYNC region\n", __func__);
+		goto fail;
+	}
+
 	return 0;
+
+fail:
+	gpio_free(irq);
+	return status;
+
 }
-- 
1.8.3.2
