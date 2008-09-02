From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc3-omap1] omap3 beagle: nand (mostly) cleanups
Date: Tue, 2 Sep 2008 10:23:55 -0700
Message-ID: <200809021023.55493.david-b@pacbell.net>
References: <200808291012.47332.david-b@pacbell.net> <13B9B4C6EF24D648824FF11BE896716203653CA11D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:26526 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751544AbYIBRX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 13:23:59 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203653CA11D@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 29 August 2008, Woodruff, Richard wrote:
> Actually, this was talked about before a bit and the
> SZ_xyz flags were left out. 
> 
> The point of telling the geometry in the addition was
> to be explicit about the number of sectors being used. 

So ... this instead?

=== CUT HERE
From: David Brownell <dbrownell@users.sourceforge.net>

Clean up the Beagle NAND config a bit:  use SZ_128K instead of
an arithmetic expression for the NAND block size.  Set the
NAND_BUSWIDTH_16 flag.  Make its init routine static.

(Unrelated:  make omap3_beagle_i2c_init be part of beagle_init.
It shouldn't be called on non-beagle hardware; and beagle_init
already runs with other arch_initcall code.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -42,32 +42,35 @@
 #include <mach/gpmc.h>
 #include <mach/nand.h>
 
+
 #define GPMC_CS0_BASE  0x60
 #define GPMC_CS_SIZE   0x30
 
+#define NAND_BLOCK_SIZE		SZ_128K
+
 static struct mtd_partition omap3beagle_nand_partitions[] = {
 	/* All the partition sizes are listed in terms of NAND block size */
 	{
 		.name		= "X-Loader",
 		.offset		= 0,
-		.size		= 4*(64 * 2048),
+		.size		= 4 * NAND_BLOCK_SIZE,
 		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
 	},
 	{
 		.name		= "U-Boot",
 		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
-		.size		= 15*(64 * 2048),
+		.size		= 15 * NAND_BLOCK_SIZE,
 		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
 	},
 	{
 		.name		= "U-Boot Env",
 		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x260000 */
-		.size		= 1*(64 * 2048),
+		.size		= 1 * NAND_BLOCK_SIZE,
 	},
 	{
 		.name		= "Kernel",
 		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
-		.size		= 32*(64 * 2048),
+		.size		= 32 * NAND_BLOCK_SIZE,
 	},
 	{
 		.name		= "File System",
@@ -77,6 +80,7 @@ static struct mtd_partition omap3beagle_
 };
 
 static struct omap_nand_platform_data omap3beagle_nand_data = {
+	.options	= NAND_BUSWIDTH_16,
 	.parts		= omap3beagle_nand_partitions,
 	.nr_parts	= ARRAY_SIZE(omap3beagle_nand_partitions),
 	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
@@ -205,7 +209,7 @@ static struct platform_device *omap3_bea
 	&keys_gpio,
 };
 
-void __init omap3beagle_flash_init(void)
+static void __init omap3beagle_flash_init(void)
 {
 	u8 cs = 0;
 	u8 nandcs = GPMC_CS_NUM + 1;
@@ -245,6 +249,7 @@ void __init omap3beagle_flash_init(void)
 
 static void __init omap3_beagle_init(void)
 {
+	omap3_beagle_i2c_init();
 	platform_add_devices(omap3_beagle_devices, ARRAY_SIZE(omap3_beagle_devices));
 	omap_board_config = omap3_beagle_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
@@ -255,8 +260,6 @@ static void __init omap3_beagle_init(voi
 	omap3beagle_flash_init();
 }
 
-arch_initcall(omap3_beagle_i2c_init);
-
 static void __init omap3_beagle_map_io(void)
 {
 	omap2_set_globals_343x();


