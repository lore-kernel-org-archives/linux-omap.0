From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc3-omap1] omap3 beagle: nand (mostly) cleanups
Date: Fri, 29 Aug 2008 10:12:47 -0700
Message-ID: <200808291012.47332.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:35760 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758085AbYH2RT2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Aug 2008 13:19:28 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Clean up the Beagle NAND config a bit:  use SZ_128K instead of
an arithmetic expression for the NAND block size.  Set the
NAND_BUSWIDTH_16 flag.  Make its init routine static.

(Unrelated:  make omap3_beagle_i2c_init be part of beagle_init.
It shouldn't be called on non-beagle hardware; and beagle_init
already runs with other arch_initcall code.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- beagle.orig/arch/arm/mach-omap2/board-omap3beagle.c	2008-08-27 21:19:12.000000000 -0700
+++ beagle/arch/arm/mach-omap2/board-omap3beagle.c	2008-08-27 21:21:18.000000000 -0700
@@ -50,24 +50,24 @@ static struct mtd_partition omap3beagle_
 	{
 		.name		= "X-Loader",
 		.offset		= 0,
-		.size		= 4*(64 * 2048),
+		.size		= 4 * SZ_128K,
 		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
 	},
 	{
 		.name		= "U-Boot",
 		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
-		.size		= 15*(64 * 2048),
+		.size		= 15 * SZ_128K,
 		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
 	},
 	{
 		.name		= "U-Boot Env",
 		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x260000 */
-		.size		= 1*(64 * 2048),
+		.size		= 1 * SZ_128K,
 	},
 	{
 		.name		= "Kernel",
 		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
-		.size		= 32*(64 * 2048),
+		.size		= 32 * SZ_128K,
 	},
 	{
 		.name		= "File System",
@@ -77,6 +77,7 @@ static struct mtd_partition omap3beagle_
 };
 
 static struct omap_nand_platform_data omap3beagle_nand_data = {
+	.options	= NAND_BUSWIDTH_16,
 	.parts		= omap3beagle_nand_partitions,
 	.nr_parts	= ARRAY_SIZE(omap3beagle_nand_partitions),
 	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
@@ -205,7 +206,7 @@ static struct platform_device *omap3_bea
 	&keys_gpio,
 };
 
-void __init omap3beagle_flash_init(void)
+static void __init omap3beagle_flash_init(void)
 {
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;
@@ -245,6 +246,7 @@ void __init omap3beagle_flash_init(void)
 
 static void __init omap3_beagle_init(void)
 {
+	omap3_beagle_i2c_init();
 	platform_add_devices(omap3_beagle_devices, ARRAY_SIZE(omap3_beagle_devices));
 	omap_board_config = omap3_beagle_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
@@ -255,8 +257,6 @@ static void __init omap3_beagle_init(voi
 	omap3beagle_flash_init();
 }
 
-arch_initcall(omap3_beagle_i2c_init);
-
 static void __init omap3_beagle_map_io(void)
 {
 	omap2_set_globals_343x();
