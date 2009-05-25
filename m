From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/10] ARM: OMAP2/3: Add generic smc91x support when
	connected to GPMC, v2
Date: Mon, 25 May 2009 09:59:56 -0700
Message-ID: <20090525165956.GE29933@atomide.com>
References: <20090519232905.12760.15490.stgit@localhost> <20090519234245.12760.17479.stgit@localhost> <20090525094638.GF28195@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8X7/QrJGcKSMr1RN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64771 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZEYRAJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 13:00:09 -0400
Content-Disposition: inline
In-Reply-To: <20090525094638.GF28195@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090525 02:46]:
> On Tue, May 19, 2009 at 04:42:45PM -0700, Tony Lindgren wrote:
> > Convert the board-rx51 smc91x code to be generic and make
> > the boards to use it. This allows future recalculation of the
> > timings when the source clock gets scaled.
> 
> Same complaint about splitting the stub function from where it's
> used - it's worse than wrapping the call in an ifdef itself.

Here's this one updated to make it local for each board-*.c.

Tony

--8X7/QrJGcKSMr1RN
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="gpmc-smc91x-v2.patch"

>From a9bf1f89964eb53ef47e64a67d090594e5202e58 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 25 May 2009 09:54:42 -0700
Subject: [PATCH] ARM: OMAP2/3: Add generic smc91x support when connected to GPMC

Convert the board-rx51 smc91x code to be generic and make
the boards to use it. This allows future recalculation of the
timings when the source clock gets scaled.

Also correct the rx51 interrupt to be IORESOURCE_IRQ_HIGHLEVEL.

Thanks to Paul Walmsley <paul@pwsan.com> for better GPMC timing
calculations.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 11f7f66..e4f6f61 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -61,3 +61,6 @@ endif
 
 onenand-$(CONFIG_MTD_ONENAND_OMAP2)	:= gpmc-onenand.o
 obj-y					+= $(onenand-m) $(onenand-y)
+
+smc91x-$(CONFIG_SMC91X)			:= gpmc-smc91x.o
+obj-y					+= $(smc91x-m) $(smc91x-y)
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 2214365..ef70b79 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -36,14 +36,11 @@
 #include <mach/common.h>
 #include <mach/gpmc.h>
 #include <mach/usb.h>
+#include <mach/gpmc-smc91x.h>
 
 #include "mmc-twl4030.h"
 
 #define SDP2430_CS0_BASE	0x04000000
-#define	SDP2430_FLASH_CS	0
-#define	SDP2430_SMC91X_CS	5
-
-#define SDP2430_ETHR_GPIO_IRQ		149
 
 static struct mtd_partition sdp2430_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
@@ -99,100 +96,43 @@ static struct platform_device sdp2430_flash_device = {
 	.resource	= &sdp2430_flash_resource,
 };
 
-static struct resource sdp2430_smc91x_resources[] = {
-	[0] = {
-		.start	= SDP2430_CS0_BASE,
-		.end	= SDP2430_CS0_BASE + SZ_64M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= OMAP_GPIO_IRQ(SDP2430_ETHR_GPIO_IRQ),
-		.end	= OMAP_GPIO_IRQ(SDP2430_ETHR_GPIO_IRQ),
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
-};
-
-static struct platform_device sdp2430_smc91x_device = {
-	.name		= "smc91x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(sdp2430_smc91x_resources),
-	.resource	= sdp2430_smc91x_resources,
-};
-
 static struct platform_device *sdp2430_devices[] __initdata = {
-	&sdp2430_smc91x_device,
 	&sdp2430_flash_device,
 };
 
-static inline void __init sdp2430_init_smc91x(void)
-{
-	int eth_cs;
-	unsigned long cs_mem_base;
-	unsigned int rate;
-	struct clk *gpmc_fck;
-
-	eth_cs = SDP2430_SMC91X_CS;
+#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
 
-	gpmc_fck = clk_get(NULL, "gpmc_fck");	/* Always on ENABLE_ON_INIT */
-	if (IS_ERR(gpmc_fck)) {
-		WARN_ON(1);
-		return;
-	}
+static struct omap_smc91x_platform_data board_smc91x_data = {
+	.cs		= 5,
+	.gpio_irq	= 149,
+	.flags		= GPMC_MUX_ADD_DATA | GPMC_TIMINGS_SMC91C96 |
+				IORESOURCE_IRQ_LOWLEVEL,
 
-	clk_enable(gpmc_fck);
-	rate = clk_get_rate(gpmc_fck);
-
-	/* Make sure CS1 timings are correct, for 2430 always muxed */
-	gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG1, 0x00011200);
-
-	if (rate >= 160000000) {
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f01);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080803);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1c0b1c0a);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x041f1F1F);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000004C4);
-	} else if (rate >= 130000000) {
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f00);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080802);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1C091C09);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x041f1F1F);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000004C4);
-	} else { /* rate = 100000000 */
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f00);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080802);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1C091C09);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x031A1F1F);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000003C2);
-	}
+};
 
-	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
-		goto out;
-	}
+static void __init board_smc91x_init(void)
+{
+	if (omap_rev() > OMAP3430_REV_ES1_0)
+		board_smc91x_data.gpio_irq = 6;
+	else
+		board_smc91x_data.gpio_irq = 29;
 
-	sdp2430_smc91x_resources[0].start = cs_mem_base + 0x300;
-	sdp2430_smc91x_resources[0].end = cs_mem_base + 0x30f;
-	udelay(100);
+	gpmc_smc91x_init(&board_smc91x_data);
+}
 
-	if (gpio_request(SDP2430_ETHR_GPIO_IRQ, "SMC91x irq") < 0) {
-		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
-			SDP2430_ETHR_GPIO_IRQ);
-		gpmc_cs_free(eth_cs);
-		goto out;
-	}
-	gpio_direction_input(SDP2430_ETHR_GPIO_IRQ);
+#else
 
-out:
-	clk_disable(gpmc_fck);
-	clk_put(gpmc_fck);
+static inline void board_smc91x_init(void)
+{
 }
 
+#endif
+
 static void __init omap_2430sdp_init_irq(void)
 {
 	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
-	sdp2430_init_smc91x();
 }
 
 static struct omap_uart_config sdp2430_uart_config __initdata = {
@@ -256,6 +196,7 @@ static void __init omap_2430sdp_init(void)
 	omap_serial_init();
 	twl4030_mmc_init(mmc);
 	usb_musb_init();
+	board_smc91x_init();
 }
 
 static void __init omap_2430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ed92749..0e63695 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -39,15 +39,12 @@
 
 #include <mach/control.h>
 #include <mach/keypad.h>
+#include <mach/gpmc-smc91x.h>
 
 #include "mmc-twl4030.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
-#define SDP3430_ETHR_GPIO_IRQ_SDPV1	29
-#define SDP3430_ETHR_GPIO_IRQ_SDPV2	6
-#define SDP3430_SMC91X_CS		3
-
 #define SDP3430_TS_GPIO_IRQ_SDPV1	3
 #define SDP3430_TS_GPIO_IRQ_SDPV2	2
 
@@ -56,24 +53,6 @@
 
 #define TWL4030_MSECURE_GPIO 22
 
-static struct resource sdp3430_smc91x_resources[] = {
-	[0] = {
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= 0,
-		.end	= 0,
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
-};
-
-static struct platform_device sdp3430_smc91x_device = {
-	.name		= "smc91x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(sdp3430_smc91x_resources),
-	.resource	= sdp3430_smc91x_resources,
-};
-
 static int sdp3430_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -184,48 +163,14 @@ static struct regulator_consumer_supply sdp3430_vdvi_supply = {
 };
 
 static struct platform_device *sdp3430_devices[] __initdata = {
-	&sdp3430_smc91x_device,
 	&sdp3430_lcd_device,
 };
 
-static inline void __init sdp3430_init_smc91x(void)
-{
-	int eth_cs;
-	unsigned long cs_mem_base;
-	int eth_gpio = 0;
-
-	eth_cs = SDP3430_SMC91X_CS;
-
-	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
-		return;
-	}
-
-	sdp3430_smc91x_resources[0].start = cs_mem_base + 0x300;
-	sdp3430_smc91x_resources[0].end = cs_mem_base + 0x30f;
-	udelay(100);
-
-	if (omap_rev() > OMAP3430_REV_ES1_0)
-		eth_gpio = SDP3430_ETHR_GPIO_IRQ_SDPV2;
-	else
-		eth_gpio = SDP3430_ETHR_GPIO_IRQ_SDPV1;
-
-	sdp3430_smc91x_resources[1].start = gpio_to_irq(eth_gpio);
-
-	if (gpio_request(eth_gpio, "SMC91x irq") < 0) {
-		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
-			eth_gpio);
-		return;
-	}
-	gpio_direction_input(eth_gpio);
-}
-
 static void __init omap_3430sdp_init_irq(void)
 {
 	omap2_init_common_hw(NULL);
 	omap_init_irq();
 	omap_gpio_init();
-	sdp3430_init_smc91x();
 }
 
 static struct omap_uart_config sdp3430_uart_config __initdata = {
@@ -506,6 +451,32 @@ static int __init omap3430_i2c_init(void)
 	return 0;
 }
 
+#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
+
+static struct omap_smc91x_platform_data board_smc91x_data = {
+	.cs		= 3,
+	.flags		= GPMC_MUX_ADD_DATA | GPMC_TIMINGS_SMC91C96 |
+				IORESOURCE_IRQ_LOWLEVEL,
+};
+
+static void __init board_smc91x_init(void)
+{
+	if (omap_rev() > OMAP3430_REV_ES1_0)
+		board_smc91x_data.gpio_irq = 6;
+	else
+		board_smc91x_data.gpio_irq = 29;
+
+	gpmc_smc91x_init(&board_smc91x_data);
+}
+
+#else
+
+static inline void board_smc91x_init(void)
+{
+}
+
+#endif
+
 static void __init omap_3430sdp_init(void)
 {
 	omap3430_i2c_init();
@@ -522,6 +493,7 @@ static void __init omap_3430sdp_init(void)
 	ads7846_dev_init();
 	omap_serial_init();
 	usb_musb_init();
+	board_smc91x_init();
 }
 
 static void __init omap_3430sdp_map_io(void)
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ca18ae9..233c745 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -28,31 +28,10 @@
 #include <mach/gpmc.h>
 #include <mach/keypad.h>
 #include <mach/onenand.h>
+#include <mach/gpmc-smc91x.h>
 
 #include "mmc-twl4030.h"
 
-
-#define SMC91X_CS			1
-#define SMC91X_GPIO_IRQ			54
-#define SMC91X_GPIO_RESET		164
-#define SMC91X_GPIO_PWRDWN		86
-
-static struct resource rx51_smc91x_resources[] = {
-	[0] = {
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.flags		= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
-	},
-};
-
-static struct platform_device rx51_smc91x_device = {
-	.name		= "smc91x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(rx51_smc91x_resources),
-	.resource	= rx51_smc91x_resources,
-};
-
 static int rx51_keymap[] = {
 	KEY(0, 0, KEY_Q),
 	KEY(0, 1, KEY_W),
@@ -108,98 +87,6 @@ static struct twl4030_keypad_data rx51_kp_data = {
 	.rep		= 1,
 };
 
-static struct platform_device *rx51_peripherals_devices[] = {
-	&rx51_smc91x_device,
-};
-
-/*
- * Timings are taken from smsc-lan91c96-ms.pdf
- */
-static int smc91x_init_gpmc(int cs)
-{
-	struct gpmc_timings t;
-	const int t2_r = 45;		/* t2 in Figure 12.10 */
-	const int t2_w = 30;		/* t2 in Figure 12.11 */
-	const int t3 = 15;		/* t3 in Figure 12.10 */
-	const int t5_r = 0;		/* t5 in Figure 12.10 */
-	const int t6_r = 45;		/* t6 in Figure 12.10 */
-	const int t6_w = 0;		/* t6 in Figure 12.11 */
-	const int t7_w = 15;		/* t7 in Figure 12.11 */
-	const int t15 = 12;		/* t15 in Figure 12.2 */
-	const int t20 = 185;		/* t20 in Figure 12.2 */
-
-	memset(&t, 0, sizeof(t));
-
-	t.cs_on = t15;
-	t.cs_rd_off = t3 + t2_r + t5_r;	/* Figure 12.10 */
-	t.cs_wr_off = t3 + t2_w + t6_w;	/* Figure 12.11 */
-	t.adv_on = t3;			/* Figure 12.10 */
-	t.adv_rd_off = t3 + t2_r;	/* Figure 12.10 */
-	t.adv_wr_off = t3 + t2_w;	/* Figure 12.11 */
-	t.oe_off = t3 + t2_r + t5_r;	/* Figure 12.10 */
-	t.oe_on = t.oe_off - t6_r;	/* Figure 12.10 */
-	t.we_off = t3 + t2_w + t6_w;	/* Figure 12.11 */
-	t.we_on = t.we_off - t7_w;	/* Figure 12.11 */
-	t.rd_cycle = t20;		/* Figure 12.2 */
-	t.wr_cycle = t20;		/* Figure 12.4 */
-	t.access = t3 + t2_r + t5_r;	/* Figure 12.10 */
-	t.wr_access = t3 + t2_w + t6_w;	/* Figure 12.11 */
-
-	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, GPMC_CONFIG1_DEVICESIZE_16);
-
-	return gpmc_cs_set_timings(cs, &t);
-}
-
-static void __init rx51_init_smc91x(void)
-{
-	unsigned long cs_mem_base;
-	int ret;
-
-	omap_cfg_reg(U8_34XX_GPIO54_DOWN);
-	omap_cfg_reg(G25_34XX_GPIO86_OUT);
-	omap_cfg_reg(H19_34XX_GPIO164_OUT);
-
-	if (gpmc_cs_request(SMC91X_CS, SZ_16M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
-		return;
-	}
-
-	rx51_smc91x_resources[0].start = cs_mem_base + 0x300;
-	rx51_smc91x_resources[0].end = cs_mem_base + 0x30f;
-
-	smc91x_init_gpmc(SMC91X_CS);
-
-	if (gpio_request(SMC91X_GPIO_IRQ, "SMC91X irq") < 0)
-		goto free1;
-
-	gpio_direction_input(SMC91X_GPIO_IRQ);
-	rx51_smc91x_resources[1].start = gpio_to_irq(SMC91X_GPIO_IRQ);
-
-	ret = gpio_request(SMC91X_GPIO_PWRDWN, "SMC91X powerdown");
-	if (ret)
-		goto free2;
-	gpio_direction_output(SMC91X_GPIO_PWRDWN, 0);
-
-	ret = gpio_request(SMC91X_GPIO_RESET, "SMC91X reset");
-	if (ret)
-		goto free3;
-	gpio_direction_output(SMC91X_GPIO_RESET, 0);
-	gpio_set_value(SMC91X_GPIO_RESET, 1);
-	msleep(100);
-	gpio_set_value(SMC91X_GPIO_RESET, 0);
-
-	return;
-
-free3:
-	gpio_free(SMC91X_GPIO_PWRDWN);
-free2:
-	gpio_free(SMC91X_GPIO_IRQ);
-free1:
-	gpmc_cs_free(SMC91X_CS);
-
-	printk(KERN_ERR "Could not initialize smc91x\n");
-}
-
 static struct twl4030_madc_platform_data rx51_madc_data = {
 	.irq_line		= 1,
 };
@@ -466,12 +353,37 @@ static inline void board_onenand_init(void)
 
 #endif
 
+#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
+
+static struct omap_smc91x_platform_data board_smc91x_data = {
+	.cs		= 1,
+	.gpio_irq	= 54,
+	.gpio_pwrdwn	= 86,
+	.gpio_reset	= 164,
+	.flags		= GPMC_TIMINGS_SMC91C96 | IORESOURCE_IRQ_HIGHLEVEL,
+};
+
+static void __init board_smc91x_init(void)
+{
+	omap_cfg_reg(U8_34XX_GPIO54_DOWN);
+	omap_cfg_reg(G25_34XX_GPIO86_OUT);
+	omap_cfg_reg(H19_34XX_GPIO164_OUT);
+
+	gpmc_smc91x_init(&board_smc91x_data);
+}
+
+#else
+
+static inline void board_smc91x_init(void)
+{
+}
+
+#endif
+
 void __init rx51_peripherals_init(void)
 {
-	platform_add_devices(rx51_peripherals_devices,
-				ARRAY_SIZE(rx51_peripherals_devices));
 	rx51_i2c_init();
-	rx51_init_smc91x();
 	board_onenand_init();
+	board_smc91x_init();
 }
 
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
new file mode 100644
index 0000000..df99d31
--- /dev/null
+++ b/arch/arm/mach-omap2/gpmc-smc91x.c
@@ -0,0 +1,189 @@
+/*
+ * linux/arch/arm/mach-omap2/gpmc-smc91x.c
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Contact:	Tony Lindgren
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/smc91x.h>
+
+#include <mach/board.h>
+#include <mach/gpmc.h>
+#include <mach/gpmc-smc91x.h>
+
+static struct omap_smc91x_platform_data *gpmc_cfg;
+
+static struct resource gpmc_smc91x_resources[] = {
+	[0] = {
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct smc91x_platdata gpmc_smc91x_info = {
+	.flags  = SMC91X_USE_16BIT | SMC91X_NOWAIT | SMC91X_IO_SHIFT_0,
+};
+
+static struct platform_device gpmc_smc91x_device = {
+	.name		= "smc91x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(gpmc_smc91x_resources),
+	.resource	= gpmc_smc91x_resources,
+	.dev		= {
+		.platform_data = &gpmc_smc91x_info,
+	},
+};
+
+/*
+ * Set the gpmc timings for smc91c96. The timings are taken
+ * from the data sheet available at:
+ * http://www.smsc.com/main/catalog/lan91c96.html
+ * REVISIT: Level shifters can add at least to the access latency.
+ */
+static int smc91c96_gpmc_retime(void)
+{
+	struct gpmc_timings t;
+	const int t3 = 10;	/* Figure 12.2 read and 12.4 write */
+	const int t4_r = 20;	/* Figure 12.2 read */
+	const int t4_w = 5;	/* Figure 12.4 write */
+	const int t5 = 25;	/* Figure 12.2 read */
+	const int t6 = 15;	/* Figure 12.2 read */
+	const int t7 = 5;	/* Figure 12.4 write */
+	const int t8 = 5;	/* Figure 12.4 write */
+	const int t20 = 185;	/* Figure 12.2 read and 12.4 write */
+	u32 l;
+
+	memset(&t, 0, sizeof(t));
+
+	/* Read timings */
+	t.cs_on = 0;
+	t.adv_on = t.cs_on;
+	t.oe_on = t.adv_on + t3;
+	t.access = t.oe_on + t5;
+	t.oe_off = t.access;
+	t.adv_rd_off = t.oe_off + max(t4_r, t6);
+	t.cs_rd_off = t.oe_off;
+	t.rd_cycle = t20 - t.oe_on;
+
+	/* Write timings */
+	t.we_on = t.adv_on + t3;
+
+	if (cpu_is_omap34xx() && (gpmc_cfg->flags & GPMC_MUX_ADD_DATA)) {
+		t.wr_data_mux_bus = t.we_on;
+		t.we_off = t.wr_data_mux_bus + t7;
+	} else
+		t.we_off = t.we_on + t7;
+	if (cpu_is_omap34xx())
+		t.wr_access = t.we_off;
+	t.adv_wr_off = t.we_off + max(t4_w, t8);
+	t.cs_wr_off = t.we_off + t4_w;
+	t.wr_cycle = t20 - t.we_on;
+
+	l = GPMC_CONFIG1_DEVICESIZE_16;
+	if (gpmc_cfg->flags & GPMC_MUX_ADD_DATA)
+		l |= GPMC_CONFIG1_MUXADDDATA;
+	if (gpmc_cfg->flags & GPMC_READ_MON)
+		l |= GPMC_CONFIG1_WAIT_READ_MON;
+	if (gpmc_cfg->flags & GPMC_WRITE_MON)
+		l |= GPMC_CONFIG1_WAIT_WRITE_MON;
+	if (gpmc_cfg->wait_pin)
+		l |= GPMC_CONFIG1_WAIT_PIN_SEL(gpmc_cfg->wait_pin);
+	gpmc_cs_write_reg(gpmc_cfg->cs, GPMC_CS_CONFIG1, l);
+
+	/*
+	 * FIXME: Calculate the address and data bus muxed timings.
+	 * Note that at least adv_rd_off needs to be changed according
+	 * to omap3430 TRM Figure 11-11. Are the sdp boards using the
+	 * FPGA in between smc91x and omap as the timings are different
+	 * from above?
+	 */
+	if (gpmc_cfg->flags & GPMC_MUX_ADD_DATA)
+		return 0;
+
+	return gpmc_cs_set_timings(gpmc_cfg->cs, &t);
+}
+
+/*
+ * Initialize smc91x device connected to the GPMC. Note that we
+ * assume that pin multiplexing is done in the board-*.c file,
+ * or in the bootloader.
+ */
+void __init gpmc_smc91x_init(struct omap_smc91x_platform_data *board_data)
+{
+	unsigned long cs_mem_base;
+	int ret;
+
+	gpmc_cfg = board_data;
+
+	if (gpmc_cfg->flags & GPMC_TIMINGS_SMC91C96)
+		gpmc_cfg->retime = smc91c96_gpmc_retime;
+
+	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
+		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
+		return;
+	}
+
+	gpmc_smc91x_resources[0].start = cs_mem_base + 0x300;
+	gpmc_smc91x_resources[0].end = cs_mem_base + 0x30f;
+	gpmc_smc91x_resources[1].flags |= (gpmc_cfg->flags & IRQF_TRIGGER_MASK);
+
+	if (gpmc_cfg->retime) {
+		ret = gpmc_cfg->retime();
+		if (ret != 0)
+			goto free1;
+	}
+
+	if (gpio_request(gpmc_cfg->gpio_irq, "SMC91X irq") < 0)
+		goto free1;
+
+	gpio_direction_input(gpmc_cfg->gpio_irq);
+	gpmc_smc91x_resources[1].start = gpio_to_irq(gpmc_cfg->gpio_irq);
+
+	if (gpmc_cfg->gpio_pwrdwn) {
+		ret = gpio_request(gpmc_cfg->gpio_pwrdwn, "SMC91X powerdown");
+		if (ret)
+			goto free2;
+		gpio_direction_output(gpmc_cfg->gpio_pwrdwn, 0);
+	}
+
+	if (gpmc_cfg->gpio_reset) {
+		ret = gpio_request(gpmc_cfg->gpio_reset, "SMC91X reset");
+		if (ret)
+			goto free3;
+
+		gpio_direction_output(gpmc_cfg->gpio_reset, 0);
+		gpio_set_value(gpmc_cfg->gpio_reset, 1);
+		msleep(100);
+		gpio_set_value(gpmc_cfg->gpio_reset, 0);
+	}
+
+	if (platform_device_register(&gpmc_smc91x_device) < 0) {
+		printk(KERN_ERR "Unable to register smc91x device\n");
+		gpio_free(gpmc_cfg->gpio_reset);
+		goto free3;
+	}
+
+	return;
+
+free3:
+	if (gpmc_cfg->gpio_pwrdwn)
+		gpio_free(gpmc_cfg->gpio_pwrdwn);
+free2:
+	gpio_free(gpmc_cfg->gpio_irq);
+free1:
+	gpmc_cs_free(gpmc_cfg->cs);
+
+	printk(KERN_ERR "Could not initialize smc91x\n");
+}
diff --git a/arch/arm/plat-omap/include/mach/gpmc-smc91x.h b/arch/arm/plat-omap/include/mach/gpmc-smc91x.h
new file mode 100644
index 0000000..b64fbee
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/gpmc-smc91x.h
@@ -0,0 +1,42 @@
+/*
+ * arch/arm/plat-omap/include/mach/gpmc-smc91x.h
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_OMAP_GPMC_SMC91X_H__
+
+#define GPMC_TIMINGS_SMC91C96	(1 << 4)
+#define GPMC_MUX_ADD_DATA	(1 << 5) /* GPMC_CONFIG1_MUXADDDATA */
+#define GPMC_READ_MON		(1 << 6) /* GPMC_CONFIG1_WAIT_READ_MON */
+#define GPMC_WRITE_MON		(1 << 7) /* GPMC_CONFIG1_WAIT_WRITE_MON */
+
+struct omap_smc91x_platform_data {
+	int	cs;
+	int	gpio_irq;
+	int	gpio_pwrdwn;
+	int	gpio_reset;
+	int	wait_pin;	/* Optional GPMC_CONFIG1_WAITPINSELECT */
+	u32	flags;
+	int	(*retime)(void);
+};
+
+#if defined(CONFIG_SMC91X) || \
+	defined(CONFIG_SMC91X_MODULE)
+
+extern void gpmc_smc91x_init(struct omap_smc91x_platform_data *d);
+
+#else
+
+#define board_smc91x_data	NULL
+
+static inline void gpmc_smc91x_init(struct omap_smc91x_platform_data *d)
+{
+}
+
+#endif
+#endif

--8X7/QrJGcKSMr1RN--
