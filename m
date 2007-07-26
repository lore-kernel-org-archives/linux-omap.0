From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [RFC 4/5] MMC/SD Controller driver for OMAP2430
Date: Wed, 25 Jul 2007 19:19:22 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47016A3484@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Include files updated to support MMC/SD for OMAP 2430 MMC Controller.

Regards,
Khasim

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


diff -purN linux-omap/include/asm-arm/arch-omap/dma.h =
lin_for_mmc/include/asm-arm/arch-omap/dma.h
--- linux-omap/include/asm-arm/arch-omap/dma.h	2007-07-03 =
12:23:24.000000000 -0500
+++ lin_for_mmc/include/asm-arm/arch-omap/dma.h	2007-07-13 =
17:00:49.000000000 -0500
@@ -235,7 +235,8 @@
 #define OMAP24XX_DMA_SPI2_RX0		44	/* SDMA_43 */
 #define OMAP24XX_DMA_SPI2_TX1		45	/* SDMA_44 */
 #define OMAP24XX_DMA_SPI2_RX1		46	/* SDMA_45 */
-
+#define OMAP24XX_DMA_MMC2_TX		47	/* SDMA_46 */
+#define OMAP24XX_DMA_MMC2_RX		48	/* SDMA_47 */
 #define OMAP24XX_DMA_UART1_TX		49	/* SDMA_48 */
 #define OMAP24XX_DMA_UART1_RX		50	/* SDMA_49 */
 #define OMAP24XX_DMA_UART2_TX		51	/* SDMA_50 */

diff -purN linux-omap/include/asm-arm/arch-omap/mmc.h =
lin_for_mmc/include/asm-arm/arch-omap/mmc.h
--- linux-omap/include/asm-arm/arch-omap/mmc.h	2007-05-09 =
00:31:00.000000000 -0500
+++ lin_for_mmc/include/asm-arm/arch-omap/mmc.h	2007-07-25 =
02:22:48.000000000 -0500
@@ -39,6 +39,10 @@ struct omap_mmc_platform_data {
 	int (* init)(struct device *dev);
 	void (* cleanup)(struct device *dev);
=20
+	/* To handle board related suspend/resume functionality for MMC */
+	int (* suspend)(struct device *dev, int slot);
+	int (* resume)(struct device *dev, int slot);
+
 	struct omap_mmc_slot_data {
 		int (* set_bus_mode)(struct device *dev, int slot, int bus_mode);
 		int (* set_power)(struct device *dev, int slot, int power_on, int =
vdd);

diff -purN linux-omap/include/asm-arm/arch-omap/omap24xx.h =
lin_for_mmc/include/asm-arm/arch-omap/omap24xx.h
--- linux-omap/include/asm-arm/arch-omap/omap24xx.h	2007-06-21 =
08:19:14.000000000 -0500
+++ lin_for_mmc/include/asm-arm/arch-omap/omap24xx.h	2007-07-13 =
11:57:50.000000000 -0500
@@ -101,6 +101,10 @@
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP2_CTRL_BASE		OMAP243X_CTRL_BASE
=20
+#define CONTROL_DEVCONF0        (L4_WK_243X_BASE + 0x2274)
+#define CONTROL_DEVCONF1        (L4_WK_243X_BASE + 0x22E8)
+#define CONTROL_PBIAS_LITE_1    (L4_WK_243X_BASE + 0x24A0)
+
 #endif
=20
 #endif /* __ASM_ARCH_OMAP24XX_H */
