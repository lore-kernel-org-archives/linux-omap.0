From: Philip Balister <philip@balister.org>
Subject: Kernel pinmux for OMAP3
Date: Mon, 27 Jul 2009 10:16:14 -0400
Message-ID: <4A6DB6AE.5090706@balister.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060300090801070706070900"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:21393 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751318AbZG0OXi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2009 10:23:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060300090801070706070900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've been working on setting up the kernel pinmux so we can use MCSPI3 
and MCSPI4 on the Beagleboard expansion connector. I've attached the 
patches I use to setup the pinumux and configure it from the board file.

There are some issues:

1) Kevin suggested the OMAP3_ prefix. The problem is that the same 
function may appear on multiple balls. Furthermore, depending on the IC 
package, the same ball may have completely different functions. How can 
we change the enum naming to account for this? Should the enum contain 
the ball and package ID? How about having a different mux array for each 
package?

2) I created subroutines to setup each function to avoid cluttering the 
init routine. I like this idea. These routines could be shared across 
different boards though. But the boards may use the same function on 
different pins.

I'd really like to see this issues sorted out so we can start making 
effective use of the kernel pinmux for boards like the beagle and overo 
where the pinmux settings may depend on what people attach to the 
expansion connectors.

Philip

--------------060300090801070706070900
Content-Type: text/x-patch;
 name="0001-Add-pinmux-definitions-for-MCSPI3-and-MCSPI4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Add-pinmux-definitions-for-MCSPI3-and-MCSPI4.patch"

>From 8001fdd0f8e0dcf85788834924b78469a27475bb Mon Sep 17 00:00:00 2001
From: Philip Balister <balister@moose.(none)>
Date: Tue, 21 Jul 2009 16:10:56 -0400
Subject: [PATCH 1/3] Add pinmux definitions for MCSPI3 and MCSPI4.

Add pinmux definitions for MCSPI3 and MCSPI4. There are also functions
to configure the pinmux added teh the beagle board file.
i# Please enter the commit message for your changes. Lines starting
---
 arch/arm/mach-omap2/board-omap3beagle.c |   17 +++++++++++++++++
 arch/arm/mach-omap2/mux.c               |   24 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/mux.h   |   14 ++++++++++++++
 3 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index b6a68d5..ebed27e 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -417,6 +417,23 @@ static void __init omap3_beagle_map_io(void)
 	omap2_map_common_io();
 }
 
+static void __init omap3_beagle_config_mcspi3_mux(void)
+{
+	omap_cfg_reg(OMAP3_MCSPI3_CLK);
+	omap_cfg_reg(OMAP3_MCSPI3_SIMO);
+	omap_cfg_reg(OMAP3_MCSPI3_SOMI);
+	omap_cfg_reg(OMAP3_MCSPI3_CS0);
+	omap_cfg_reg(OMAP3_MCSPI3_CS1);
+}
+
+static void __init omap3_beagle_config_mcspi4_mux(void)
+{
+	omap_cfg_reg(OMAP3_MCSPI4_CLK);
+	omap_cfg_reg(OMAP3_MCSPI4_SIMO);
+	omap_cfg_reg(OMAP3_MCSPI4_SOMI);
+	omap_cfg_reg(OMAP3_MCSPI4_CS0);
+}
+
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
 	.phys_io	= 0x48000000,
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 026c4fc..9b5eb93 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -486,6 +486,30 @@ MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+
+/* MCSPI3 Master */
+MUX_CFG_34XX("OMAP3_MCSPI3_CLK", 0x158,
+		OMAP34XX_MUX_MODE1 | OMAP3_INPUT_EN)		 
+MUX_CFG_34XX("OMAP3_MCSPI3_SIMO", 0x15a,
+		OMAP34XX_MUX_MODE1 | OMAP3_INPUT_EN)		 
+MUX_CFG_34XX("OMAP3_MCSPI3_SOMI", 0x15c,
+		OMAP34XX_MUX_MODE1 | OMAP3_INPUT_EN | OMAP2_PULL_UP |
+		OMAP2_PULL_ENA)		 
+MUX_CFG_34XX("OMAP3_MCSPI3_CS0", 0x162,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)		 
+MUX_CFG_34XX("OMAP3_MCSPI3_CS1", 0x160,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)		 
+
+/* MCSPI4 Master */
+MUX_CFG_34XX("OMAP3_MCSPI4_CLK", 0x18c,
+		OMAP34XX_MUX_MODE1 | OMAP3_INPUT_EN)		 
+MUX_CFG_34XX("OMAP3_MCSPI4_SIMO", 0x190,
+		OMAP34XX_MUX_MODE1 | OMAP3_INPUT_EN)		 
+MUX_CFG_34XX("OMAP3_MCSPI4_SOMI", 0x192,
+		OMAP34XX_MUX_MODE1 | OMAP3_INPUT_EN | OMAP2_PULL_UP |
+		OMAP2_PULL_ENA)		 
+MUX_CFG_34XX("OMAP3_MCSPI4_CS0", 0x196,
+		OMAP34XX_MUX_MODE1 | OMAP34XX_PIN_OUTPUT)		 
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 85a6217..9c4d579 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -853,6 +853,20 @@ enum omap34xx_index {
 	AE5_34XX_GPIO143,
 	H19_34XX_GPIO164_OUT,
 	J25_34XX_GPIO170,
+
+	/* MCSPI3 */
+	OMAP3_MCSPI3_CLK,
+	OMAP3_MCSPI3_SIMO,
+	OMAP3_MCSPI3_SOMI,
+	OMAP3_MCSPI3_CS0,
+	OMAP3_MCSPI3_CS1,
+
+	/* MCSPI4 */
+	OMAP3_MCSPI4_CLK,
+	OMAP3_MCSPI4_SIMO,
+	OMAP3_MCSPI4_SOMI,
+	OMAP3_MCSPI4_CS0,
+	
 };
 
 struct omap_mux_cfg {
-- 
1.6.2.5


--------------060300090801070706070900
Content-Type: text/x-patch;
 name="0002-Enable-MCSPI3-and-MCSPI4-for-the-BeagleBoard.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-Enable-MCSPI3-and-MCSPI4-for-the-BeagleBoard.patch"

>From ec079182472f64b2ef0ea21375f0639546eefa88 Mon Sep 17 00:00:00 2001
From: Philip Balister <balister@localhost.localdomain>
Date: Tue, 19 May 2009 18:22:43 -0400
Subject: [PATCH 2/3] Enable MCSPI3 and MCSPI4 for the BeagleBoard.

This patch enables support for MCSPI3 and 4 for the Beagle Board. They
are configured for use with the spidev driver. The pins for these SPI
interfaces are available on teh expansion connector. MUX changes will be
done in u-boot.

Signed-off-by: Philip Balister <philip@balister.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index ebed27e..ba51dfe 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -24,6 +24,8 @@
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 
+#include <linux/spi/spi.h>
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
@@ -354,6 +356,32 @@ static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&keys_gpio,
 };
 
+static struct spi_board_info beagle_mcspi_board_info[] = {
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 48000000, //48 Mbps
+		.bus_num	= 3,
+		.chip_select	= 0,	
+		.mode = SPI_MODE_1,
+	},
+
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 48000000, //48 Mbps
+		.bus_num	= 3,
+		.chip_select	= 1,	
+		.mode = SPI_MODE_1,
+	},
+
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 48000000, //48 Mbps
+		.bus_num	= 4,
+		.chip_select	= 0,	
+		.mode = SPI_MODE_1,
+	},
+};
+
 static void __init omap3beagle_flash_init(void)
 {
 	u8 cs = 0;
@@ -401,6 +429,9 @@ static void __init omap3_beagle_init(void)
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap_serial_init();
 
+	spi_register_board_info(beagle_mcspi_board_info,
+			ARRAY_SIZE(beagle_mcspi_board_info));
+
 	omap_cfg_reg(J25_34XX_GPIO170);
 	gpio_request(170, "DVI_nPD");
 	/* REVISIT leave DVI powered down until it's needed ... */
-- 
1.6.2.5


--------------060300090801070706070900
Content-Type: text/x-patch;
 name="0003-Configure-pinmux-for-MCSPI2-and-4-for-beagle.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0003-Configure-pinmux-for-MCSPI2-and-4-for-beagle.patch"

>From d92bebf67d632a7e94bf6e4fc62609c943a66cea Mon Sep 17 00:00:00 2001
From: Philip Balister <balister@moose.(none)>
Date: Wed, 22 Jul 2009 15:25:28 -0400
Subject: [PATCH 3/3] Configure pinmux for MCSPI2 and 4 for beagle.

---
 arch/arm/mach-omap2/board-omap3beagle.c |   41 ++++++++++++++++++-------------
 1 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index ba51dfe..d3850ea 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -420,6 +420,25 @@ static void __init omap3beagle_flash_init(void)
 	}
 }
 
+#ifdef CONFIG_SPI_OMAP24XX
+static void __init omap3_beagle_config_mcspi3_mux(void)
+{
+        omap_cfg_reg(OMAP3_MCSPI3_CLK);
+        omap_cfg_reg(OMAP3_MCSPI3_SIMO);
+        omap_cfg_reg(OMAP3_MCSPI3_SOMI);
+        omap_cfg_reg(OMAP3_MCSPI3_CS0);
+        omap_cfg_reg(OMAP3_MCSPI3_CS1);
+}
+
+static void __init omap3_beagle_config_mcspi4_mux(void)
+{
+        omap_cfg_reg(OMAP3_MCSPI4_CLK);
+        omap_cfg_reg(OMAP3_MCSPI4_SIMO);
+        omap_cfg_reg(OMAP3_MCSPI4_SOMI);
+        omap_cfg_reg(OMAP3_MCSPI4_CS0);
+}
+#endif
+
 static void __init omap3_beagle_init(void)
 {
 	omap3_beagle_i2c_init();
@@ -429,8 +448,13 @@ static void __init omap3_beagle_init(void)
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap_serial_init();
 
+#ifdef CONFIG_SPI_OMAP24XX
+	omap3_beagle_config_mcspi3_mux();
+	omap3_beagle_config_mcspi4_mux();
+
 	spi_register_board_info(beagle_mcspi_board_info,
 			ARRAY_SIZE(beagle_mcspi_board_info));
+#endif
 
 	omap_cfg_reg(J25_34XX_GPIO170);
 	gpio_request(170, "DVI_nPD");
@@ -448,23 +472,6 @@ static void __init omap3_beagle_map_io(void)
 	omap2_map_common_io();
 }
 
-static void __init omap3_beagle_config_mcspi3_mux(void)
-{
-	omap_cfg_reg(OMAP3_MCSPI3_CLK);
-	omap_cfg_reg(OMAP3_MCSPI3_SIMO);
-	omap_cfg_reg(OMAP3_MCSPI3_SOMI);
-	omap_cfg_reg(OMAP3_MCSPI3_CS0);
-	omap_cfg_reg(OMAP3_MCSPI3_CS1);
-}
-
-static void __init omap3_beagle_config_mcspi4_mux(void)
-{
-	omap_cfg_reg(OMAP3_MCSPI4_CLK);
-	omap_cfg_reg(OMAP3_MCSPI4_SIMO);
-	omap_cfg_reg(OMAP3_MCSPI4_SOMI);
-	omap_cfg_reg(OMAP3_MCSPI4_CS0);
-}
-
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
 	.phys_io	= 0x48000000,
-- 
1.6.2.5


--------------060300090801070706070900--
