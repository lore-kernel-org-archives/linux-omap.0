From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH] ARM: OMAP: dts: add n8x0 onenand
Date: Sat, 16 Nov 2013 20:36:22 +0200
Message-ID: <1384626982-11635-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Convert onenand to DT on n8x0 boards.

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---

	This patch is based on top of Tony's 2420 DT patches.

 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 65 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-n8x0.c            | 44 -------------------
 2 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index c539693..89608b2 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -32,3 +32,68 @@
 &i2c2 {
 	clock-frequency = <400000>;
 };
+
+&gpmc {
+	ranges = <0 0 0x04000000 0x10000000>;
+
+	/* gpio-irq for dma: 26 */
+
+	onenand@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0 0x10000000>;
+
+		gpmc,sync-read;
+		gpmc,burst-length = <16>;
+		gpmc,burst-read;
+		gpmc,burst-wrap;
+		gpmc,device-width = <2>;
+		gpmc,mux-add-data = <2>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <127>;
+		gpmc,cs-wr-off-ns = <109>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <18>;
+		gpmc,adv-wr-off-ns = <18>;
+		gpmc,oe-on-ns = <27>;
+		gpmc,oe-off-ns = <127>;
+		gpmc,we-on-ns = <27>;
+		gpmc,we-off-ns = <72>;
+		gpmc,rd-cycle-ns = <145>;
+		gpmc,wr-cycle-ns = <136>;
+		gpmc,access-ns = <118>;
+		gpmc,page-burst-access-ns = <27>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,clk-activation-ns = <9>;
+		gpmc,sync-clk-ps = <27000>;
+
+		/* MTD partition table corresponding to old board-n8x0 file. */
+		partition@0 {
+			label = "bootloader";
+			reg = <0x00000000 0x00020000>;
+			read-only;
+		};
+		partition@1 {
+			label = "config";
+			reg = <0x00020000 0x00060000>;
+		};
+		partition@2 {
+			label = "kernel";
+			reg = <0x00080000 0x00200000>;
+		};
+		partition@3 {
+			label = "initfs";
+			reg = <0x00280000 0x00400000>;
+		};
+		partition@4 {
+			label = "rootfs";
+			reg = <0x00680000 0x0f980000>;
+		};
+		partition@5 {
+			label = "omap2-onenand";
+			reg = <0x00000000 0x10000000>;
+		};
+	};
+};
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 5e04bdc..f7996194 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -162,49 +162,6 @@ static struct spi_board_info n800_spi_board_info[] __initdata = {
 	},
 };
 
-#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
-	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
-
-static struct mtd_partition onenand_partitions[] = {
-	{
-		.name           = "bootloader",
-		.offset         = 0,
-		.size           = 0x20000,
-		.mask_flags     = MTD_WRITEABLE,	/* Force read-only */
-	},
-	{
-		.name           = "config",
-		.offset         = MTDPART_OFS_APPEND,
-		.size           = 0x60000,
-	},
-	{
-		.name           = "kernel",
-		.offset         = MTDPART_OFS_APPEND,
-		.size           = 0x200000,
-	},
-	{
-		.name           = "initfs",
-		.offset         = MTDPART_OFS_APPEND,
-		.size           = 0x400000,
-	},
-	{
-		.name           = "rootfs",
-		.offset         = MTDPART_OFS_APPEND,
-		.size           = MTDPART_SIZ_FULL,
-	},
-};
-
-static struct omap_onenand_platform_data board_onenand_data[] = {
-	{
-		.cs		= 0,
-		.gpio_irq	= 26,
-		.parts		= onenand_partitions,
-		.nr_parts	= ARRAY_SIZE(onenand_partitions),
-		.flags		= ONENAND_SYNC_READ,
-	}
-};
-#endif
-
 #if defined(CONFIG_MENELAUS) &&						\
 	(defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE))
 
@@ -639,7 +596,6 @@ static int __init n8x0_late_initcall(void)
 	if (!board_caps)
 		return -ENODEV;
 
-	gpmc_onenand_init(board_onenand_data);
 	n8x0_mmc_init();
 	n8x0_usb_init();
 
-- 
1.8.4.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
