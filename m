From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/4] Add minimal support for DEVKIT8000
Date: Thu, 12 Nov 2009 12:40:32 +0200
Message-ID: <20091112104032.GB32578@nokia.com>
References: <75653cbc7d7ba7c6cfc501db7c0373d3@djdvant.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57768 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbZKLKs0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 05:48:26 -0500
Content-Disposition: inline
In-Reply-To: <75653cbc7d7ba7c6cfc501db7c0373d3@djdvant.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kim Botherway <kbotherway@djdvant.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, Nov 12, 2009 at 11:17:42AM +0100, ext Kim Botherway wrote:
>These patches add omap3 board support for the Timll DEVKIT8000
>
>diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>index 8685df5..5c850e1 100644
>--- a/arch/arm/mach-omap2/Kconfig
>+++ b/arch/arm/mach-omap2/Kconfig
>@@ -53,6 +53,10 @@ config MACH_OMAP3_BEAGLE
>        bool "OMAP3 BEAGLE board"
>        depends on ARCH_OMAP3 && ARCH_OMAP34XX
>
>+config MACH_OMAP3_DEVKIT8000
>+        bool "OMAP3 DEVKIT8000 board"
>+        depends on ARCH_OMAP3 && ARCH_OMAP34XX
>+
> config MACH_OMAP_LDP
>        bool "OMAP3 LDP board"
>        depends on ARCH_OMAP3 && ARCH_OMAP34XX
>diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>index 03cb4fc..080f3ac 100644
>--- a/arch/arm/mach-omap2/Makefile
>+++ b/arch/arm/mach-omap2/Makefile
>@@ -57,6 +57,8 @@ obj-$(CONFIG_MACH_OMAP_2430SDP)               += board-2430sdp.o \
> obj-$(CONFIG_MACH_OMAP_APOLLON)                += board-apollon.o
> obj-$(CONFIG_MACH_OMAP3_BEAGLE)                += board-omap3beagle.o \
>                                           mmc-twl4030.o
>+obj-$(CONFIG_MACH_OMAP3_DEVKIT8000)     += board-omap3devkit8000.o \
>+                                           mmc-twl4030.o
> obj-$(CONFIG_MACH_OMAP_LDP)            += board-ldp.o \
>                                           mmc-twl4030.o
> obj-$(CONFIG_MACH_OVERO)               += board-overo.o \
>diff --git a/arch/arm/mach-omap2/board-omap3devkit8000.c
>b/arch/arm/mach-omap2/board-omap3devkit8000.c
>new file mode 100644
>index 0000000..5be7852
>--- /dev/null
>+++ b/arch/arm/mach-omap2/board-omap3devkit8000.c
>@@ -0,0 +1,604 @@
>+/*
>+ * linux/arch/arm/mach-omap2/board-omap3devkit8000.c

remove the path, it should be something like:

board-omap3devkit8000.c - Texas Instruments' DevKit 8000

>+static struct omap_nand_platform_data omap3devkit8000_nand_data = {
>+       .options        = NAND_BUSWIDTH_16,
>+       .parts          = omap3devkit8000_nand_partitions,
>+       .nr_parts       = ARRAY_SIZE(omap3devkit8000_nand_partitions),
>+       .dma_channel    = -1,           /* disable DMA in OMAP NAND driver */
>+       .nand_setup     = NULL,
>+       .dev_ready      = NULL,

this is static variable, you don't need these NULL here.

>+};
>+
>+static struct resource omap3devkit8000_nand_resource = {

wrong, should be a real array:

static struct resource omap3devkti8000_nand_resources[] = {
	{
		.start	= ??,
		.end	= ??,
		.flags	= IORESOURCE_MEM,
	},
};

>+static struct platform_device omap3devkit8000_nand_device = {
>+       .name           = "omap2-nand",
>+       .id             = -1,
>+       .dev            = {
>+               .platform_data  = &omap3devkit8000_nand_data,
>+       },
>+       .num_resources  = 1,
>+       .resource       = &omap3devkit8000_nand_resource,

	.num_resources = ARRAY_SIZE(omap3devkit8000_nand_resources),
	.resource	= omap3devkit8000_nand_resources,

>+static struct gpio_led gpio_leds[] = {
>+       {
>+               .name                   = "led1",
>+               .default_trigger        = "heartbeat",
>+               .gpio                   = 186,
>+               .active_low             = true,
>+       },
>+       {
>+               .name                   = "led2",
>+               .default_trigger        = "mmc0",
>+               .gpio                   = 163,
>+               .active_low             = true,
>+       },
>+       {
>+               .name                   = "ledB",
>+               .default_trigger        = "none",
>+               .gpio                   = 153,
>+               .active_low             = true,
>+       },
>+       {
>+               .name                   = "led3",
>+               .default_trigger        = "none",
>+               .gpio                   = 164,  /* gets replaced */

if so, you should initialize to -EINVAL.

>+static struct ads7846_platform_data ads7846_config = {
>+       .x_max                  = 0x0fff,
>+       .y_max                  = 0x0fff,
>+//     .x_plate_ohms           = 180,
>+//     .pressure_max           = 255,

why this commented code with the wrong comment style here ?

>+static struct spi_board_info omap3devkit8000_spi_board_info[] __initdata = {
>+       {
>+               .modalias               = "ads7846",
>+               .bus_num                = 2,
>+               .chip_select            = 0,
>+               .max_speed_hz           = 1500000,
>+               .controller_data        = &ads7846_mcspi_config,
>+               .irq                    = OMAP_GPIO_IRQ(OMAP3_DEVKIT_TS_GPIO),
>+               .platform_data          = &ads7846_config,
>+       }
>+};
>+
>+

one blank like is enough.

>+#define OMAP_DM9000_BASE       0x2c000000
>+
>+static struct resource omap_dm9000_resources[] = {
>+       [0] = {
>+               .start          = OMAP_DM9000_BASE,
>+               .end            = (OMAP_DM9000_BASE + 0x4 - 1),
>+               .flags          = IORESOURCE_MEM,
>+       },
>+       [1] = {
>+               .start          = (OMAP_DM9000_BASE + 0x400),
>+               .end            = (OMAP_DM9000_BASE + 0x400 + 0x4 - 1),
>+               .flags          = IORESOURCE_MEM,
>+       },
>+       [2] = {
>+               .start          = OMAP_GPIO_IRQ(OMAP_DM9000_GPIO_IRQ),
>+               .end            = OMAP_GPIO_IRQ(OMAP_DM9000_GPIO_IRQ),

no need to initialize end here.

>+static void __init omap_dm9000_init(void)
>+{
>+        if (gpio_request(OMAP_DM9000_GPIO_IRQ, "dm9000 irq") < 0) {
>+                printk(KERN_ERR "Failed to request GPIO%d for dm9000 IRQ\n",
>+                        OMAP_DM9000_GPIO_IRQ);
>+                return;
>+        }
>+
>+        gpio_direction_input(OMAP_DM9000_GPIO_IRQ);
>+}
>+
>+

one blank like is enough.

-- 
balbi
