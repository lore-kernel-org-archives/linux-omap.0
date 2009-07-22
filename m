From: "Syed Rafiuddin" <rafiuddin.syed-l0cyMroinI0@public.gmane.org>
Subject: [RESUBMIT][PATCH][RFC] OMAP4: McSPI Support for
	OMAP4430
Date: Wed, 22 Jul 2009 19:20:06 +0530 (IST)
Message-ID: <54771.192.168.10.89.1248270606.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
References: 
In-Reply-To: 
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "David Brownell"" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>"@dlep35.itg.ti.com
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Patch updated as it was line wrapped in previous submission.

-Rafiuddin.Syed


This patch adds McSPI support for OMAP4430 SDP platform. All the base addresses
are changed between OMAP1/2/3 and OMAP4.The fields of the resource structures
are filled at runtime to have McSPI support on OMAP4.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>
Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Acked-by: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/devices.c |   29 +++++++++++++++++++++++------
 drivers/spi/omap2_mcspi.c     |   10 ++++++----
 2 files changed, 29 insertions(+), 10 deletions(-)

Index: kernel-omap4-base/arch/arm/mach-omap2/devices.c
===================================================================
--- kernel-omap4-base.orig/arch/arm/mach-omap2/devices.c
+++ kernel-omap4-base/arch/arm/mach-omap2/devices.c
@@ -257,6 +257,11 @@ static inline void omap_init_sti(void) {
 #define OMAP2_MCSPI3_BASE		0x480b8000
 #define OMAP2_MCSPI4_BASE		0x480ba000

+#define OMAP4_MCSPI1_BASE		0x48098100
+#define OMAP4_MCSPI2_BASE		0x4809a100
+#define OMAP4_MCSPI3_BASE		0x480b8100
+#define OMAP4_MCSPI4_BASE		0x480ba100
+
 static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
 	.num_cs		= 4,
 };
@@ -301,7 +306,8 @@ static struct platform_device omap2_mcsp
 	},
 };

-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi3_config = {
 	.num_cs		= 2,
 };
@@ -325,7 +331,7 @@ static struct platform_device omap2_mcsp
 };
 #endif

-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi4_config = {
 	.num_cs		= 1,
 };
@@ -351,14 +357,25 @@ static struct platform_device omap2_mcsp

 static void omap_init_mcspi(void)
 {
+	if (cpu_is_omap44xx()) {
+		omap2_mcspi1_resources[0].start	= OMAP4_MCSPI1_BASE;
+		omap2_mcspi1_resources[0].end	= OMAP4_MCSPI1_BASE + 0xff;
+		omap2_mcspi2_resources[0].start	= OMAP4_MCSPI2_BASE;
+		omap2_mcspi2_resources[0].end	= OMAP4_MCSPI2_BASE + 0xff;
+		omap2_mcspi3_resources[0].start	= OMAP4_MCSPI3_BASE;
+		omap2_mcspi3_resources[0].end	= OMAP4_MCSPI3_BASE + 0xff;
+		omap2_mcspi4_resources[0].start	= OMAP4_MCSPI4_BASE;
+		omap2_mcspi4_resources[0].end	= OMAP4_MCSPI4_BASE + 0xff;
+	}
 	platform_device_register(&omap2_mcspi1);
 	platform_device_register(&omap2_mcspi2);
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
-	if (cpu_is_omap2430() || cpu_is_omap343x())
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
+	if (cpu_is_omap2430() || cpu_is_omap343x() || cpu_is_omap44xx())
 		platform_device_register(&omap2_mcspi3);
 #endif
-#ifdef CONFIG_ARCH_OMAP3
-	if (cpu_is_omap343x())
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+	if (cpu_is_omap343x() || cpu_is_omap44xx())
 		platform_device_register(&omap2_mcspi4);
 #endif
 }
Index: kernel-omap4-base/drivers/spi/omap2_mcspi.c
===================================================================
--- kernel-omap4-base.orig/drivers/spi/omap2_mcspi.c
+++ kernel-omap4-base/drivers/spi/omap2_mcspi.c
@@ -907,7 +907,8 @@ static u8 __initdata spi2_txdma_id[] = {
 	OMAP24XX_DMA_SPI2_TX1,
 };

-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX) || \
+	 defined(CONFIG_ARCH_OMAP4)
 static u8 __initdata spi3_rxdma_id[] = {
 	OMAP24XX_DMA_SPI3_RX0,
 	OMAP24XX_DMA_SPI3_RX1,
@@ -919,7 +920,7 @@ static u8 __initdata spi3_txdma_id[] = {
 };
 #endif

-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static u8 __initdata spi4_rxdma_id[] = {
 	OMAP34XX_DMA_SPI4_RX0,
 };
@@ -949,14 +950,15 @@ static int __init omap2_mcspi_probe(stru
 		txdma_id = spi2_txdma_id;
 		num_chipselect = 2;
 		break;
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
 	case 3:
 		rxdma_id = spi3_rxdma_id;
 		txdma_id = spi3_txdma_id;
 		num_chipselect = 2;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	case 4:
 		rxdma_id = spi4_rxdma_id;
 		txdma_id = spi4_txdma_id;



------------------------------------------------------------------------------
