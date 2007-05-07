From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Patch to fix dsp mapping for 2430.
Date: Mon, 7 May 2007 15:50:25 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429EAAC42@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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

This patch fixes the DSP mapping for 2430.

Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
---

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 871fde3..3ce0bc9 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -80,12 +80,14 @@ static struct map_desc omap2_io_desc[] __initdata =
=3D
{
 		.length		=3D DSP_MEM_24XX_SIZE,
 		.type		=3D MT_DEVICE
 	},
+#ifdef CONFIG_ARCH_OMAP2420
 	{
 		.virtual	=3D DSP_IPI_24XX_VIRT,
 		.pfn		=3D __phys_to_pfn(DSP_IPI_24XX_PHYS),
 		.length		=3D DSP_IPI_24XX_SIZE,
 		.type		=3D MT_DEVICE
 	},
+#endif
 	{
 		.virtual	=3D DSP_MMU_24XX_VIRT,
 		.pfn		=3D __phys_to_pfn(DSP_MMU_24XX_PHYS),
diff --git a/include/asm-arm/arch-omap/omap24xx.h
b/include/asm-arm/arch-omap/omap24xx.h
index 66592c8..2f806b3 100644
--- a/include/asm-arm/arch-omap/omap24xx.h
+++ b/include/asm-arm/arch-omap/omap24xx.h
@@ -34,10 +34,18 @@
 #endif
=20
 /* DSP SS */
+#ifdef CONFIG_ARCH_OMAP2420
 #define OMAP24XX_DSP_BASE	0x58000000
 #define OMAP24XX_DSP_MEM_BASE	(OMAP24XX_DSP_BASE + 0x0)
 #define OMAP24XX_DSP_IPI_BASE	(OMAP24XX_DSP_BASE + 0x1000000)
 #define OMAP24XX_DSP_MMU_BASE	(OMAP24XX_DSP_BASE + 0x2000000)
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+#define OMAP24XX_DSP_BASE	0x5C000000
+#define OMAP24XX_DSP_MEM_BASE	(OMAP24XX_DSP_BASE + 0x0)
+#define OMAP24XX_DSP_MMU_BASE	(OMAP24XX_DSP_BASE + 0x1000000)
+#endif
=20
 /* Mailbox */
 #define OMAP24XX_MAILBOX_BASE	(L4_24XX_BASE + 0x94000)
