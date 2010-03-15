From: Ben Gamari <bgamari.foss@gmail.com>
Subject: SPI troubles
Date: Sun, 14 Mar 2010 19:44:33 -0700 (PDT)
Message-ID: <4b9d9f11.9a15f10a.3902.6dc3@mx.google.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59719 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198Ab0COCof (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Mar 2010 22:44:35 -0400
Received: by vws12 with SMTP id 12so28501vws.19
        for <linux-omap@vger.kernel.org>; Sun, 14 Mar 2010 19:44:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: beagleboard@googlegroups.com, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

Hey all,

As I've mentioned here in the past, I am currently putting together a board for
doing analog data acquisition on the BeagleBoard platform. Unfortunately, I
have wasted nearly the entire weekend trying to accomplish the (one would
think) simple goal of recieving data with the McSPI controllers (in particular,
run a loop-back test on McSPI3 with spidev_test).

While I can reliably see a signal sent on the SIMO line, I have not once been
able to recieve anything but zeros in return. I have verified that the the SOMI
ball works as expected as a GPIO input. I have tried every pinmux configuration
imaginable (using both the kernel and u-boot) and yet I have still met no
success. It seems like this has been an issue in the past[1] and it seems that
at one point SPI was working[2], yet I have been completely unable to reproduce
this result.

When measuring the SIMO signal on the expansion connector with my daughterboard
connected, I noticed that the daughterboard's level shifter appeared to be
driving the signal higher than it should, to ~2.9 Volts. I then checked the
1.8V rail voltage and found that it too was higher than expected, again at 2.9
volts. When I unplug the daughterboard, the 1.8V rail voltage returns to its
expected value.

I'm both perplexed and concerned with this behavior. I completely fail to
see how my board is raising the voltage on the 1.8V rail (schematic available
at [3]).  While the BeagleBoard seems quite stable, I'm very concerned that
perhaps the daughterboard over-drove the SIMO ball and burned out some subset
of the OMAP.  Regardless, as mentioned earlier, I have verified the
functionality of the same ball as a GPIO input. Thus, I am thoroughly confused.
Is it possible that the ball's GPIO receiver could remain functional while the
McSPI receiver is burned out?

I am using a 2.6.32 kernel and can see in debugfs that the pinmux is configured
correct, with only the sdmmc2_dat0 pin exposing the McSPI3_SOMI signal. The
kernel patch I'm using to configure the muxes and spi controllers is included
below. As can be seen, I've also tried using the spi-gpio driver, but
unfortunately I wasn't even able to get it producing data on SIMO.

I've tried this using two daughterboards on two different Beagles (a B7 and a
new C4) with identical results on both.  If anyone has any ideas at all, I would
love to hear them. I am really unsure of how to proceed at this point and I'm
quickly running out of time to devote to this project. I've included my kernel
patch below and the daughterboard design is available in Eagle format at [3].

Thanks,

- Ben


P.S. It seems to me that SPI is one of the more important interfaces on the
BoardBoard. As such, it would be really nice if there was a standard test of
SPI functionality. It seems many people have struggled to get SPI working on
the BeagleBoard and not too many have succeeded. A standard prescription would
be extremely useful.

P.P.S. Is it just me or does the omap_pinmux interface need some refinement.
Using it has been an exercise in frustration, between extremely sparse
documentation, quirky behavior (I still haven't figure out how to get gpio_130
configured.  omap_mux_init_gpio fails with "multiple paths for gpio130" whereas
omap_mux_init_signal fails to even recognize the signal name), and general
complexity. The idea behind the interface seems excellent, but it seems it
hasn't been used enough not to be a complete pain in the ass to figure out and
use.


[1] http://markmail.org/message/2vbfuz7bltvrk6g3#query:beagle%20spi%20zeros+page:1+mid:wduqfhs4ur373ehp+state:results
[2] http://groups.google.com/group/beagleboard/browse_thread/thread/42988f0e14db0f01/816397901ec999c4?lnk=gst&q=Balister+&pli=1
[3] http://goldnerlab.physics.umass.edu/git?p=tracker-board.git;a=summary



diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 231cb4e..b23c5a5 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -12,6 +12,10 @@
  * published by the Free Software Foundation.
  */
 
+//#define BEAGLE_GPIO_SPI
+
+
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -28,6 +32,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 
+#include <linux/spi/spi.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
 
@@ -372,6 +377,159 @@ static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&keys_gpio,
 };
 
+#ifndef BEAGLE_GPIO_SPI
+
+static void __init omap3_beagle_config_mcspi3_mux(void)
+{
+	omap_mux_init_signal("sdmmc2_clk.mcspi3_clk", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdmmc2_dat3.mcspi3_cs0", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdmmc2_dat2.mcspi3_cs1", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdmmc2_cmd.mcspi3_simo", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdmmc2_dat0.mcspi3_somi", OMAP_PIN_INPUT_PULLUP);
+}
+
+static void __init omap3_beagle_config_mcspi4_mux(void)
+{
+	omap_mux_init_signal("mcbsp1_clkr.mcspi4_clk", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("mcbsp1_fsx.mcspi4_cs0", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("mcbsp1_dx.mcspi4_simo", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("mcbsp1_dr.mcspi4_somi", OMAP_PIN_INPUT_PULLUP);
+}
+
+static struct spi_board_info beagle_mcspi_board_info[] = {
+	// spi 3.0
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 48000000, //48 Mbps
+		.bus_num	= 3,
+		.chip_select	= 0,	
+		.mode = SPI_MODE_1,
+	},
+
+	// spi 3.1
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 48000000, //48 Mbps
+		.bus_num	= 3,
+		.chip_select	= 1,	
+		.mode = SPI_MODE_1,
+	},
+
+	// spi 4.0
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 48000000, //48 Mbps
+		.bus_num	= 4,
+		.chip_select	= 0,	
+		.mode = SPI_MODE_1,
+	},
+};
+
+#else /* BEAGLE_GPIO_SPI */
+#include <linux/spi/spi_gpio.h>
+
+#define SPI3_CLK 130
+#define SPI3_SOMI 132
+#define SPI3_SIMO 131
+#define SPI3_CS0 135
+#define SPI3_CS1 134
+
+#define SPI4_CLK 156
+#define SPI4_SOMI 159
+#define SPI4_SIMO 158
+#define SPI4_CS0 161
+
+#define GPIO_SPI_PIN(pin, dir, name)  \
+	omap_mux_init_gpio(pin, OMAP_PIN_##dir); \
+	gpio_request(pin, name); \
+	gpio_export(pin, true);
+
+static void __init omap3_beagle_config_gpio_spi3_mux(void)
+{
+	GPIO_SPI_PIN(SPI3_CLK, OUTPUT, "spi3_clk");
+	GPIO_SPI_PIN(SPI3_SIMO, OUTPUT, "spi3_simo");
+	GPIO_SPI_PIN(SPI3_SOMI, INPUT, "spi3_somi");
+	GPIO_SPI_PIN(SPI3_CS0, OUTPUT, "spi3_cs0");
+	GPIO_SPI_PIN(SPI3_CS1, OUTPUT, "spi3_cs1");
+}
+
+static void __init omap3_beagle_config_gpio_spi4_mux(void)
+{
+	GPIO_SPI_PIN(SPI4_CLK, OUTPUT, "spi4_clk");
+	GPIO_SPI_PIN(SPI4_SIMO, OUTPUT, "spi4_simo");
+	GPIO_SPI_PIN(SPI4_SOMI, INPUT, "spi4_somi");
+	GPIO_SPI_PIN(SPI4_CS0, OUTPUT, "spi4_cs0");
+}
+
+static struct spi_gpio_platform_data beagle_gpio_spi_platform_data[] = {
+	// spi 3
+	{
+		.sck = SPI3_CLK,
+		.miso = SPI3_SOMI,
+		.mosi = SPI3_SIMO,
+		.num_chipselect = 2,
+	},
+
+	// spi 4
+	{
+		.sck = SPI4_CLK,
+		.miso = SPI4_SOMI,
+		.mosi = SPI4_SIMO,
+		.num_chipselect = 1,
+	},
+};
+
+static struct platform_device beagle_gpio_spi_platform_device[] = {
+	// spi .
+	{
+		.name		= "spi_gpio",
+		.id		= 3,
+		.dev		= {
+			.platform_data = &beagle_gpio_spi_platform_data[0],
+		},
+	},
+
+	// spi 4
+	{
+		.name		= "spi_gpio",
+		.id		= 4,
+		.dev		= {
+			.platform_data = &beagle_gpio_spi_platform_data[1],
+		},
+	},
+};
+
+static struct spi_board_info beagle_gpio_spi_board_info[] = {
+	// spi 3.0
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 48000000, //48 Mbps
+		.bus_num	= 3,
+		.mode = SPI_MODE_1,
+		.controller_data = (void *) SPI3_CS0,
+	},
+
+	// spi 3.1
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 48000000, //48 Mbps
+		.bus_num	= 3,
+		.mode = SPI_MODE_1,
+		.controller_data = (void *) SPI3_CS1,
+	},
+
+	// spi 4.0
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 48000000, //48 Mbps
+		.bus_num	= 4,
+		.mode = SPI_MODE_1,
+		.controller_data = (void *) SPI4_CS0,
+	},
+};
+
+#endif /* BEAGLE_GPIO_SPI */
+
 static void __init omap3beagle_flash_init(void)
 {
 	u8 cs = 0;
@@ -432,12 +590,30 @@ static struct omap_board_mux board_mux[] __initdata = {
 
 static void __init omap3_beagle_init(void)
 {
+	int i;
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_i2c_init();
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_serial_init();
 
+#ifndef BEAGLE_GPIO_SPI
+	printk(KERN_ERR "Using McSPI for SPI\n");
+	omap3_beagle_config_mcspi3_mux();
+	omap3_beagle_config_mcspi4_mux();
+	spi_register_board_info(beagle_mcspi_board_info,
+			ARRAY_SIZE(beagle_mcspi_board_info));
+#else
+	printk(KERN_ERR "Using GPIO for SPI\n");
+	omap3_beagle_config_gpio_spi3_mux();
+	omap3_beagle_config_gpio_spi4_mux();
+	for (i=0; i<3; i++)
+		platform_device_register(&beagle_gpio_spi_platform_device[i]);
+	spi_register_board_info(beagle_gpio_spi_board_info,
+			ARRAY_SIZE(beagle_gpio_spi_board_info));
+#endif
+
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
 	gpio_request(170, "DVI_nPD");
 	/* REVISIT leave DVI powered down until it's needed ... */
@@ -458,6 +634,7 @@ static void __init omap3_beagle_map_io(void)
 	omap2_map_common_io();
 }
 
+
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
 	.phys_io	= 0x48000000,
