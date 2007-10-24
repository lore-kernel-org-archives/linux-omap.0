From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH 2/4] OMAP: DMA: Added support for OMAP3
Date: Wed, 24 Oct 2007 12:37:11 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804AF9863@dbde01.ent.ti.com>
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

From: Anand Gadiyar <gadiyar@ti.com>

Added DMA support for OMAP3.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/plat-omap/dma.c |   60 =
+++++++++++++++++++++++------------------------
 1 files changed, 30 insertions(+), 30 deletions(-)

Index: omap-git/arch/arm/plat-omap/dma.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- omap-git.orig/arch/arm/plat-omap/dma.c	2007-10-12 11:33:00.000000000 =
-0400
+++ omap-git/arch/arm/plat-omap/dma.c	2007-10-12 11:55:12.154720744 =
-0400
@@ -6,7 +6,7 @@
  * DMA channel linking for 1610 by Samuel Ortiz =
<samuel.ortiz@nokia.com>
  * Graphics DMA and LCD DMA graphics tranformations
  * by Imre Deak <imre.deak@nokia.com>
- * OMAP2 support Copyright (C) 2004-2005 Texas Instruments, Inc.
+ * OMAP2/3 support Copyright (C) 2004-2007 Texas Instruments, Inc.
  * Merged to support both OMAP1 and OMAP2 by Tony Lindgren =
<tony@atomide.com>
  * Some functions based on earlier dma-omap.c Copyright (C) 2001 =
RidgeRun, Inc.
  *
@@ -148,7 +148,7 @@
 		omap_writel(l, reg);
 	}
=20
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		if (priority)
 			OMAP_DMA_CCR_REG(lch) |=3D (1 << 6);
 		else
@@ -173,7 +173,7 @@
 			OMAP1_DMA_CCR2_REG(lch) |=3D 1 << 2;
 	}
=20
-	if (cpu_is_omap24xx() && dma_trigger) {
+	if (cpu_class_is_omap2() && dma_trigger) {
 		u32 val =3D OMAP_DMA_CCR_REG(lch);
=20
 		val &=3D ~(3 << 19);
@@ -213,7 +213,7 @@
=20
 	BUG_ON(omap_dma_in_1510_mode());
=20
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		REVISIT_24XX();
 		return;
 	}
@@ -245,7 +245,7 @@
=20
 void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
 {
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		OMAP_DMA_CSDP_REG(lch) &=3D ~(0x3 << 16);
 		OMAP_DMA_CSDP_REG(lch) |=3D (mode << 16);
 	}
@@ -269,7 +269,7 @@
 		OMAP1_DMA_CSSA_L_REG(lch) =3D src_start;
 	}
=20
-	if (cpu_is_omap24xx())
+	if (cpu_class_is_omap2())
 		OMAP2_DMA_CSSA_REG(lch) =3D src_start;
=20
 	OMAP_DMA_CSEI_REG(lch) =3D src_ei;
@@ -293,7 +293,7 @@
=20
 void omap_set_dma_src_index(int lch, int eidx, int fidx)
 {
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		REVISIT_24XX();
 		return;
 	}
@@ -317,13 +317,13 @@
 	case OMAP_DMA_DATA_BURST_DIS:
 		break;
 	case OMAP_DMA_DATA_BURST_4:
-		if (cpu_is_omap24xx())
+		if (cpu_class_is_omap2())
 			burst =3D 0x1;
 		else
 			burst =3D 0x2;
 		break;
 	case OMAP_DMA_DATA_BURST_8:
-		if (cpu_is_omap24xx()) {
+		if (cpu_class_is_omap2()) {
 			burst =3D 0x2;
 			break;
 		}
@@ -332,7 +332,7 @@
 		 * fall through
 		 */
 	case OMAP_DMA_DATA_BURST_16:
-		if (cpu_is_omap24xx()) {
+		if (cpu_class_is_omap2()) {
 			burst =3D 0x3;
 			break;
 		}
@@ -363,7 +363,7 @@
 		OMAP1_DMA_CDSA_L_REG(lch) =3D dest_start;
 	}
=20
-	if (cpu_is_omap24xx())
+	if (cpu_class_is_omap2())
 		OMAP2_DMA_CDSA_REG(lch) =3D dest_start;
=20
 	OMAP_DMA_CDEI_REG(lch) =3D dst_ei;
@@ -372,7 +372,7 @@
=20
 void omap_set_dma_dest_index(int lch, int eidx, int fidx)
 {
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		REVISIT_24XX();
 		return;
 	}
@@ -396,19 +396,19 @@
 	case OMAP_DMA_DATA_BURST_DIS:
 		break;
 	case OMAP_DMA_DATA_BURST_4:
-		if (cpu_is_omap24xx())
+		if (cpu_class_is_omap2())
 			burst =3D 0x1;
 		else
 			burst =3D 0x2;
 		break;
 	case OMAP_DMA_DATA_BURST_8:
-		if (cpu_is_omap24xx())
+		if (cpu_class_is_omap2())
 			burst =3D 0x2;
 		else
 			burst =3D 0x3;
 		break;
 	case OMAP_DMA_DATA_BURST_16:
-		if (cpu_is_omap24xx()) {
+		if (cpu_class_is_omap2()) {
 			burst =3D 0x3;
 			break;
 		}
@@ -430,7 +430,7 @@
 	/* Clear CSR */
 	if (cpu_class_is_omap1())
 		status =3D OMAP_DMA_CSR_REG(lch);
-	else if (cpu_is_omap24xx())
+	else if (cpu_class_is_omap2())
 		OMAP_DMA_CSR_REG(lch) =3D OMAP2_DMA_CSR_CLEAR_MASK;
=20
 	/* Enable some nice interrupts. */
@@ -441,7 +441,7 @@
=20
 static void omap_disable_channel_irq(int lch)
 {
-	if (cpu_is_omap24xx())
+	if (cpu_class_is_omap2())
 		OMAP_DMA_CICR_REG(lch) =3D 0;
 }
=20
@@ -475,7 +475,7 @@
 		OMAP_DMA_CLNK_CTRL_REG(lch) |=3D 1 << 14;
 	}
=20
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		omap_disable_channel_irq(lch);
 		/* Clear the ENABLE_LNK bit */
 		OMAP_DMA_CLNK_CTRL_REG(lch) &=3D ~(1 << 15);
@@ -488,7 +488,7 @@
 {
 	u32 val;
=20
-	if (!cpu_is_omap24xx())
+	if (!cpu_class_is_omap2())
 		return;
=20
 	val =3D omap_readl(OMAP_DMA4_IRQENABLE_L0);
@@ -522,7 +522,7 @@
 	if (cpu_class_is_omap1())
 		clear_lch_regs(free_ch);
=20
-	if (cpu_is_omap24xx())
+	if (cpu_class_is_omap2())
 		omap_clear_dma(free_ch);
=20
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
@@ -534,7 +534,7 @@
=20
 	if (cpu_class_is_omap1())
 		chan->enabled_irqs |=3D OMAP1_DMA_TOUT_IRQ;
-	else if (cpu_is_omap24xx())
+	else if (cpu_class_is_omap2())
 		chan->enabled_irqs |=3D OMAP2_DMA_MISALIGNED_ERR_IRQ |
 			OMAP2_DMA_TRANS_ERR_IRQ;
=20
@@ -551,7 +551,7 @@
 		OMAP_DMA_CCR_REG(free_ch) =3D dev_id;
 	}
=20
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		omap2_enable_irq_lch(free_ch);
=20
 		omap_enable_channel_irq(free_ch);
@@ -588,7 +588,7 @@
 		OMAP_DMA_CCR_REG(lch) =3D 0;
 	}
=20
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		u32 val;
 		/* Disable interrupts */
 		val =3D omap_readl(OMAP_DMA4_IRQENABLE_L0);
@@ -626,7 +626,7 @@
 		status =3D OMAP_DMA_CSR_REG(lch);
 	}
=20
-	if (cpu_is_omap24xx()) {
+	if (cpu_class_is_omap2()) {
 		int i;
 		u32 lch_base =3D OMAP_DMA4_BASE + lch * 0x60 + 0x80;
 		for (i =3D 0; i < 0x44; i +=3D 4)
@@ -662,7 +662,7 @@
=20
 			cur_lch =3D next_lch;
 		} while (next_lch !=3D -1);
-	} else if (cpu_is_omap24xx()) {
+	} else if (cpu_class_is_omap2()) {
 		/* Errata: Need to write lch even if not using chaining */
 		OMAP_DMA_CLNK_CTRL_REG(lch) =3D lch;
 	}
@@ -753,7 +753,7 @@
 		offset =3D (dma_addr_t) (OMAP1_DMA_CSSA_L_REG(lch) |
 				       (OMAP1_DMA_CSSA_U_REG(lch) << 16));
=20
-	if (cpu_is_omap24xx())
+	if (cpu_class_is_omap2())
 		offset =3D OMAP_DMA_CSAC_REG(lch);
=20
 	return offset;
@@ -775,7 +775,7 @@
 		offset =3D (dma_addr_t) (OMAP1_DMA_CDSA_L_REG(lch) |
 				       (OMAP1_DMA_CDSA_U_REG(lch) << 16));
=20
-	if (cpu_is_omap24xx())
+	if (cpu_class_is_omap2())
 		offset =3D OMAP_DMA_CDAC_REG(lch);
=20
 	return offset;
@@ -919,7 +919,7 @@
 #define omap1_dma_irq_handler	NULL
 #endif
=20
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
=20
 static int omap2_dma_handle_ch(int ch)
 {
@@ -1385,7 +1385,7 @@
 			w &=3D ~(1 << 8);
 			omap_writew(w, OMAP1610_DMA_LCD_CTRL);
 		}
-	} else if (cpu_is_omap24xx()) {
+	} else if (cpu_class_is_omap2()) {
 		u8 revision =3D omap_readb(OMAP_DMA4_REVISION);
 		printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
 		       revision >> 4, revision & 0xf);
@@ -1428,7 +1428,7 @@
 		}
 	}
=20
-	if (cpu_is_omap24xx())
+	if (cpu_class_is_omap2())
 		setup_irq(INT_24XX_SDMA_IRQ0, &omap24xx_dma_irq);
=20
 	/* FIXME: Update LCD DMA to work on 24xx */
