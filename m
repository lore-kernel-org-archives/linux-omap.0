From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Re-posting DMA Macros updated to use DMA V4 baseaddress
Date: Fri, 8 Jun 2007 16:21:31 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470117C26F@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Modified DMA macros to use DMA V4 Base, to support all DMA V4 based OMAP
platforms.

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/plat-omap/dma.c
 include/asm-arm/arch-omap/dma.h
 include/asm-arm/arch-omap/omap24xx.h

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/include/asm-arm/arch-omap/omap24xx.h	2007-06-08 =
08:09:45.000000000 -0500
+++ lin_for_mmc/include/asm-arm/arch-omap/omap24xx.h	2007-06-08 =
13:08:09.000000000 -0500
@@ -35,6 +35,7 @@
 #define L4_24XX_BASE		0x48000000
 #define L4_WK_243X_BASE		0x49000000
 #define L3_24XX_BASE		0x68000000
+#define L4_OMAP_BASE		L4_24XX_BASE
=20
 /* interrupt controller */
 #define OMAP24XX_IC_BASE	(L4_24XX_BASE + 0xfe000)

--- linux-omap/include/asm-arm/arch-omap/dma.h	2007-05-16 =
14:33:06.000000000 -0500
+++ lin_for_mmc/include/asm-arm/arch-omap/dma.h	2007-06-08 =
13:08:09.000000000 -0500
@@ -45,22 +45,22 @@
 #define OMAP_DMA_PCHD_SR		(OMAP_DMA_BASE + 0x4c0)
=20
 /* Hardware registers for omap2 */
-#define OMAP24XX_DMA_BASE		(L4_24XX_BASE + 0x56000)
-#define OMAP_DMA4_REVISION		(OMAP24XX_DMA_BASE + 0x00)
-#define OMAP_DMA4_GCR_REG		(OMAP24XX_DMA_BASE + 0x78)
-#define OMAP_DMA4_IRQSTATUS_L0		(OMAP24XX_DMA_BASE + 0x08)
-#define OMAP_DMA4_IRQSTATUS_L1		(OMAP24XX_DMA_BASE + 0x0c)
-#define OMAP_DMA4_IRQSTATUS_L2		(OMAP24XX_DMA_BASE + 0x10)
-#define OMAP_DMA4_IRQSTATUS_L3		(OMAP24XX_DMA_BASE + 0x14)
-#define OMAP_DMA4_IRQENABLE_L0		(OMAP24XX_DMA_BASE + 0x18)
-#define OMAP_DMA4_IRQENABLE_L1		(OMAP24XX_DMA_BASE + 0x1c)
-#define OMAP_DMA4_IRQENABLE_L2		(OMAP24XX_DMA_BASE + 0x20)
-#define OMAP_DMA4_IRQENABLE_L3		(OMAP24XX_DMA_BASE + 0x24)
-#define OMAP_DMA4_SYSSTATUS		(OMAP24XX_DMA_BASE + 0x28)
-#define OMAP_DMA4_CAPS_0		(OMAP24XX_DMA_BASE + 0x64)
-#define OMAP_DMA4_CAPS_2		(OMAP24XX_DMA_BASE + 0x6c)
-#define OMAP_DMA4_CAPS_3		(OMAP24XX_DMA_BASE + 0x70)
-#define OMAP_DMA4_CAPS_4		(OMAP24XX_DMA_BASE + 0x74)
+#define OMAP_DMA4_BASE			(L4_OMAP_BASE + 0x56000)
+#define OMAP_DMA4_REVISION		(OMAP_DMA4_BASE + 0x00)
+#define OMAP_DMA4_GCR_REG		(OMAP_DMA4_BASE + 0x78)
+#define OMAP_DMA4_IRQSTATUS_L0		(OMAP_DMA4_BASE + 0x08)
+#define OMAP_DMA4_IRQSTATUS_L1		(OMAP_DMA4_BASE + 0x0c)
+#define OMAP_DMA4_IRQSTATUS_L2		(OMAP_DMA4_BASE + 0x10)
+#define OMAP_DMA4_IRQSTATUS_L3		(OMAP_DMA4_BASE + 0x14)
+#define OMAP_DMA4_IRQENABLE_L0		(OMAP_DMA4_BASE + 0x18)
+#define OMAP_DMA4_IRQENABLE_L1		(OMAP_DMA4_BASE + 0x1c)
+#define OMAP_DMA4_IRQENABLE_L2		(OMAP_DMA4_BASE + 0x20)
+#define OMAP_DMA4_IRQENABLE_L3		(OMAP_DMA4_BASE + 0x24)
+#define OMAP_DMA4_SYSSTATUS		(OMAP_DMA4_BASE + 0x28)
+#define OMAP_DMA4_CAPS_0		(OMAP_DMA4_BASE + 0x64)
+#define OMAP_DMA4_CAPS_2		(OMAP_DMA4_BASE + 0x6c)
+#define OMAP_DMA4_CAPS_3		(OMAP_DMA4_BASE + 0x70)
+#define OMAP_DMA4_CAPS_4		(OMAP_DMA4_BASE + 0x74)
=20
 #ifdef CONFIG_ARCH_OMAP1
=20
@@ -86,19 +86,19 @@
 #define OMAP_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
=20
 /* Common channel specific registers for omap2 */
-#define OMAP_DMA_CCR_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0x80)
-#define OMAP_DMA_CLNK_CTRL_REG(n)	__REG32(OMAP24XX_DMA_BASE + 0x60 * =
(n) + 0x84)
-#define OMAP_DMA_CICR_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0x88)
-#define OMAP_DMA_CSR_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0x8c)
-#define OMAP_DMA_CSDP_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0x90)
-#define OMAP_DMA_CEN_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0x94)
-#define OMAP_DMA_CFN_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0x98)
-#define OMAP_DMA_CSEI_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0xa4)
-#define OMAP_DMA_CSFI_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0xa8)
-#define OMAP_DMA_CDEI_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0xac)
-#define OMAP_DMA_CDFI_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0xb0)
-#define OMAP_DMA_CSAC_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0xb4)
-#define OMAP_DMA_CDAC_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0xb8)
+#define OMAP_DMA_CCR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0x80)
+#define OMAP_DMA_CLNK_CTRL_REG(n)	__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0x84)
+#define OMAP_DMA_CICR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0x88)
+#define OMAP_DMA_CSR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0x8c)
+#define OMAP_DMA_CSDP_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0x90)
+#define OMAP_DMA_CEN_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0x94)
+#define OMAP_DMA_CFN_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0x98)
+#define OMAP_DMA_CSEI_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0xa4)
+#define OMAP_DMA_CSFI_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0xa8)
+#define OMAP_DMA_CDEI_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0xac)
+#define OMAP_DMA_CDFI_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0xb0)
+#define OMAP_DMA_CSAC_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0xb4)
+#define OMAP_DMA_CDAC_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0xb8)
=20
 #endif
=20
@@ -113,11 +113,11 @@
 #define OMAP1_DMA_LCH_CTRL_REG(n)	__REG16(OMAP_DMA_BASE + 0x40 * (n) + =
0x2a)
=20
 /* Channel specific registers only on omap2 */
-#define OMAP2_DMA_CSSA_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0x9c)
-#define OMAP2_DMA_CDSA_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0xa0)
-#define OMAP2_DMA_CCEN_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0xbc)
-#define OMAP2_DMA_CCFN_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) + =
0xc0)
-#define OMAP2_DMA_COLOR_REG(n)		__REG32(OMAP24XX_DMA_BASE + 0x60 * (n) =
+ 0xc4)
+#define OMAP2_DMA_CSSA_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0x9c)
+#define OMAP2_DMA_CDSA_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0xa0)
+#define OMAP2_DMA_CCEN_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0xbc)
+#define OMAP2_DMA_CCFN_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0xc0)
+#define OMAP2_DMA_COLOR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + =
0xc4)
=20
 =
/*-----------------------------------------------------------------------=
-----*/
=20

--- linux-omap/arch/arm/plat-omap/dma.c	2007-05-25 13:27:04.000000000 =
-0500
+++ lin_for_mmc/arch/arm/plat-omap/dma.c	2007-06-08 13:14:44.000000000 =
-0500
@@ -628,7 +628,7 @@ void omap_clear_dma(int lch)
=20
 	if (cpu_is_omap24xx()) {
 		int i;
-		u32 lch_base =3D OMAP24XX_DMA_BASE + lch * 0x60 + 0x80;
+		u32 lch_base =3D OMAP_DMA4_BASE + lch * 0x60 + 0x80;
 		for (i =3D 0; i < 0x44; i +=3D 4)
 			omap_writel(0, lch_base + i);
 	}
