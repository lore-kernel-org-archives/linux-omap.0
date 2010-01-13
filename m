From: Philip Balister <philip@balister.org>
Subject: Enabling spidev in MCSPI1
Date: Wed, 13 Jan 2010 08:00:43 -0500
Message-ID: <4B4DC3FB.3020702@balister.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090701090004070508070504"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:16322 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753215Ab0AMNAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 08:00:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090701090004070508070504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm trying to enable spidev on mcspi1, but when I do, the kernel while 
booting after the kernel is uncompressed. No useful messages are 
displayed. This is with a current git.

I've attached the diff I use to add the spi driver to the board file. 
(OVero + Summit).

With the #if 0 inplace the kernel boots, enable that code and it fails.

+#if 0
+       spi_register_board_info(overo_mcspi_board_info,
+               ARRAY_SIZE(overo_mcspi_board_info));
+#endif

Does anyone see anything obviously wrong with what I am doing?

Philip

--------------090701090004070508070504
Content-Type: text/plain;
 name="spidev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="spidev.diff"

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d192dd9..804d88f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -33,6 +33,8 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
+#include <linux/spi/spi.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
@@ -184,6 +186,16 @@ static inline void __init overo_init_smsc911x(void)
 static inline void __init overo_init_smsc911x(void) { return; }
 #endif
 
+static struct spi_board_info overo_mcspi_board_info[] = {
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 12000000, // 12 MHz
+		.bus_num	= 1,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_1,
+	},
+};
+
 static struct mtd_partition overo_nand_partitions[] = {
 	{
 		.name           = "xloader",
@@ -424,7 +436,10 @@ static void __init overo_init(void)
 	usb_ehci_init(&ehci_pdata);
 	overo_ads7846_init();
 	overo_init_smsc911x();
-
+#if 0
+	spi_register_board_info(overo_mcspi_board_info,
+		ARRAY_SIZE(overo_mcspi_board_info));
+#endif
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);

--------------090701090004070508070504--
