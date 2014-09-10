From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 2/3] ARM: OMAP4+: Move SRAM data to DT
Date: Wed, 10 Sep 2014 11:04:03 -0500
Message-ID: <71139ee4a0184da22b63f954414d019758c18d3b.1410362895.git.d-gerlach@ti.com>
References: <cover.1410362895.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51151 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbaIJQE1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2014 12:04:27 -0400
In-Reply-To: <cover.1410362895.git.d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Use drivers/misc/sram.c driver to manage SRAM on all DT only
OMAP platforms (am33xx, am43xx, omap4 and omap5) instead of
the existing private plat-omap/sram.c

Address and size related data  is removed from mach-omap2/sram.c
and now passed to drivers/misc/sram.c from DT.

Users can hence use general purpose allocator apis instead of
OMAP private ones to manage and use SRAM.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi        |  5 ++---
 arch/arm/boot/dts/am4372.dtsi        |  5 +++++
 arch/arm/boot/dts/omap4.dtsi         |  5 +++++
 arch/arm/boot/dts/omap5.dtsi         |  5 +++++
 arch/arm/configs/omap2plus_defconfig |  1 +
 arch/arm/mach-omap2/sram.c           | 26 +-------------------------
 arch/arm/mach-omap2/sram.h           |  1 -
 7 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 3a0a161..c8238c4 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -726,9 +726,8 @@
 		};
 
 		ocmcram: ocmcram@40300000 {
-			compatible = "ti,am3352-ocmcram";
-			reg = <0x40300000 0x10000>;
-			ti,hwmods = "ocmcram";
+			compatible = "mmio-sram";
+			reg = <0x40300000 0x10000>; /* 64k */
 		};
 
 		wkup_m3: wkup_m3@44d00000 {
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 8689949..24531de 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -885,6 +885,11 @@
 				clock-names = "fck";
 			};
 		};
+
+		ocmcram: ocmcram@40300000 {
+			compatible = "mmio-sram";
+			reg = <0x40300000 0x40000>; /* 256k */
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 69408b5..f584611 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -208,6 +208,11 @@
 			};
 		};
 
+		ocmcram: ocmcram@40304000 {
+			compatible = "mmio-sram";
+			reg = <0x40304000 0xa000>; /* 40k */
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index fc8df17..d4e6976 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -219,6 +219,11 @@
 			};
 		};
 
+		ocmcram: ocmcram@40300000 {
+			compatible = "mmio-sram";
+			reg = <0x40300000 0x20000>; /* 128k */
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index f650f00..5dd120f 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -101,6 +101,7 @@ CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_SENSORS_TSL2550=m
 CONFIG_BMP085_I2C=m
 CONFIG_SENSORS_LIS3_I2C=m
+CONFIG_SRAM=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index 5e45df0..e5ac29d 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -32,12 +32,6 @@
 
 #define OMAP2_SRAM_PUB_PA	(OMAP2_SRAM_PA + 0xf800)
 #define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0x8000)
-#ifdef CONFIG_OMAP4_ERRATA_I688
-#define OMAP4_SRAM_PUB_PA	OMAP4_SRAM_PA
-#else
-#define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
-#endif
-#define OMAP5_SRAM_PA		0x40300000
 
 #define SRAM_BOOTLOADER_SZ	0x00
 
@@ -105,32 +99,14 @@ static void __init omap_detect_sram(void)
 			} else {
 				omap_sram_size = 0x8000; /* 32K */
 			}
-		} else if (cpu_is_omap44xx()) {
-			omap_sram_start = OMAP4_SRAM_PUB_PA;
-			omap_sram_size = 0xa000; /* 40K */
-		} else if (soc_is_omap54xx()) {
-			omap_sram_start = OMAP5_SRAM_PA;
-			omap_sram_size = SZ_128K; /* 128KB */
 		} else {
 			omap_sram_start = OMAP2_SRAM_PUB_PA;
 			omap_sram_size = 0x800; /* 2K */
 		}
 	} else {
-		if (soc_is_am33xx()) {
-			omap_sram_start = AM33XX_SRAM_PA;
-			omap_sram_size = 0x10000; /* 64K */
-		} else if (soc_is_am43xx()) {
-			omap_sram_start = AM33XX_SRAM_PA;
-			omap_sram_size = SZ_256K;
-		} else if (cpu_is_omap34xx()) {
+		if (cpu_is_omap34xx()) {
 			omap_sram_start = OMAP3_SRAM_PA;
 			omap_sram_size = 0x10000; /* 64K */
-		} else if (cpu_is_omap44xx()) {
-			omap_sram_start = OMAP4_SRAM_PA;
-			omap_sram_size = 0xe000; /* 56K */
-		} else if (soc_is_omap54xx()) {
-			omap_sram_start = OMAP5_SRAM_PA;
-			omap_sram_size = SZ_128K; /* 128KB */
 		} else {
 			omap_sram_start = OMAP2_SRAM_PA;
 			if (cpu_is_omap242x())
diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
index ca7277c..3f83b80 100644
--- a/arch/arm/mach-omap2/sram.h
+++ b/arch/arm/mach-omap2/sram.h
@@ -80,4 +80,3 @@ static inline void omap_push_sram_idle(void) {}
 #else
 #define OMAP4_SRAM_PA		0x40300000
 #endif
-#define AM33XX_SRAM_PA		0x40300000
-- 
1.9.0

