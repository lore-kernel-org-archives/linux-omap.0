From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Add 3430 support in dma.h
Date: Wed, 20 Jun 2007 22:17:28 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47012A5139@dlee13.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add 3430 support in dma.h

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 include/asm-arm/arch-omap/dma.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/include/asm-arm/arch-omap/dma.h	2007-06-12 =
15:08:51.000000000 -0500
+++ val_3430_GIT/include/asm-arm/arch-omap/dma.h	2007-06-20 =
14:36:59.000000000 -0500
@@ -45,7 +45,12 @@
 #define OMAP_DMA_PCHD_SR		(OMAP_DMA_BASE + 0x4c0)
=20
 /* Hardware registers for omap2 */
-#define OMAP_DMA4_BASE			(L4_OMAP_BASE + 0x56000)
+#if defined(CONFIG_ARCH_OMAP3)
+#define OMAP_DMA4_BASE			(L4_34XX_BASE + 0x56000)
+#elif defined(CONFIG_ARCH_OMAP2)
+#define OMAP_DMA4_BASE			(L4_24XX_BASE + 0x56000)
+#endif
+
 #define OMAP_DMA4_REVISION		(OMAP_DMA4_BASE + 0x00)
 #define OMAP_DMA4_GCR_REG		(OMAP_DMA4_BASE + 0x78)
 #define OMAP_DMA4_IRQSTATUS_L0		(OMAP_DMA4_BASE + 0x08)
