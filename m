From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH 3/4] DMA: Added utility APIs for setting DMA global
	parameters
Date: Wed, 24 Oct 2007 12:38:51 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804AF9866@dbde01.ent.ti.com>
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

Added DMA utility APIs for setting FIFO depth, arbitration rate and =
channel priority.
This patch depends on patch [2/4] "OMAP: DMA: Added support for OMAP3".

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/plat-omap/dma.c        |   68 =
++++++++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/dma.h |   22 ++++++++++++
 2 files changed, 90 insertions(+)

Index: omap-git/arch/arm/plat-omap/dma.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- omap-git.orig/arch/arm/plat-omap/dma.c	2007-10-22 03:17:24.094818864 =
-0400
+++ omap-git/arch/arm/plat-omap/dma.c	2007-10-23 03:28:51.072585880 =
-0400
@@ -289,6 +289,9 @@
 	omap_set_dma_dest_params(lch, params->dst_port,
 				 params->dst_amode, params->dst_start,
 				 params->dst_ei, params->dst_fi);
+	if (params->read_prio || params->write_prio)
+		omap_dma_set_prio_lch(lch, params->read_prio,
+				      params->write_prio);
 }
=20
 void omap_set_dma_src_index(int lch, int eidx, int fidx)
@@ -608,6 +611,67 @@
 	}
 }
=20
+/**
+ * @brief omap_dma_set_global_params : Set global priority settings for =
dma
+ *
+ * @param arb_rate
+ * @param max_fifo_depth
+ * @param tparams - Number of thereads to reserve : =
DMA_THREAD_RESERVE_NORM
+ * 						    DMA_THREAD_RESERVE_ONET
+ * 						    DMA_THREAD_RESERVE_TWOT
+ * 						    DMA_THREAD_RESERVE_THREET
+ */
+void
+omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int =
tparams)
+{
+	u32 reg;
+
+	if (!cpu_class_is_omap2()) {
+		printk(KERN_ERR "FIXME: no %s on 15xx/16xx\n", __FUNCTION__);
+		return;
+	}
+
+	if (arb_rate =3D=3D 0)
+		arb_rate =3D 1;
+
+	reg =3D (arb_rate & 0xff) << 16;
+	reg |=3D (0xff & max_fifo_depth);
+
+	omap_writel(reg, OMAP_DMA4_GCR_REG);
+}
+EXPORT_SYMBOL(omap_dma_set_global_params);
+
+/**
+ * @brief omap_dma_set_prio_lch : Set channel wise priority settings
+ *
+ * @param lch
+ * @param read_prio - Read priority
+ * @param write_prio - Write priority
+ * Both of the above can be set with one of the following values :
+ * 	DMA_CH_PRIO_HIGH/DMA_CH_PRIO_LOW
+ */
+int
+omap_dma_set_prio_lch(int lch, unsigned char read_prio,
+		      unsigned char write_prio)
+{
+	u32 w;
+
+	if (unlikely((lch < 0 || lch >=3D OMAP_LOGICAL_DMA_CH_COUNT))) {
+		printk(KERN_ERR "Invalid channel id\n");
+		return -EINVAL;
+	}
+	w =3D OMAP_DMA_CCR_REG(lch);
+	w &=3D ~((1 << 6) | (1 << 26));
+	if (cpu_is_omap2430() || cpu_is_omap34xx())
+		w |=3D ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
+	else
+		w |=3D ((read_prio & 0x1) << 6);
+
+	OMAP_DMA_CCR_REG(lch) =3D w;
+	return 0;
+}
+EXPORT_SYMBOL(omap_dma_set_prio_lch);
+
 /*
  * Clears any DMA state so the DMA engine is ready to restart with new =
buffers
  * through omap_start_dma(). Any buffers in flight are discarded.
@@ -1428,6 +1492,10 @@
 		}
 	}
=20
+	if (cpu_is_omap2430() || cpu_is_omap34xx())
+		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
+				DMA_DEFAULT_FIFO_DEPTH, 0);
+
 	if (cpu_class_is_omap2())
 		setup_irq(INT_24XX_SDMA_IRQ0, &omap24xx_dma_irq);
=20
Index: omap-git/include/asm-arm/arch-omap/dma.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- omap-git.orig/include/asm-arm/arch-omap/dma.h	2007-10-22 =
03:17:22.830011144 -0400
+++ omap-git/include/asm-arm/arch-omap/dma.h	2007-10-22 =
03:18:23.902726680 -0400
@@ -407,6 +407,21 @@
 #define OMAP_DMA_AMODE_SINGLE_IDX	0x02
 #define OMAP_DMA_AMODE_DOUBLE_IDX	0x03
=20
+#define DMA_DEFAULT_FIFO_DEPTH		0x10
+#define DMA_DEFAULT_ARB_RATE		0x01
+/* Pass THREAD_RESERVE ORed with THREAD_FIFO for tparams */
+#define DMA_THREAD_RESERVE_NORM		(0x00 << 12) /* Def */
+#define DMA_THREAD_RESERVE_ONET		(0x01 << 12)
+#define DMA_THREAD_RESERVE_TWOT		(0x02 << 12)
+#define DMA_THREAD_RESERVE_THREET	(0x03 << 12)
+#define DMA_THREAD_FIFO_NONE		(0x00 << 14) /* Def */
+#define DMA_THREAD_FIFO_75		(0x01 << 14)
+#define DMA_THREAD_FIFO_25		(0x02 << 14)
+#define DMA_THREAD_FIFO_50		(0x03 << 14)
+
+#define DMA_CH_PRIO_HIGH		0x1
+#define DMA_CH_PRIO_LOW			0x0 /* Def */
+
 /* LCD DMA block numbers */
 enum {
 	OMAP_LCD_DMA_B1_TOP,
@@ -456,6 +471,9 @@
 	int src_or_dst_synch;	/* source synch(1) or destination synch(0) */
=20
 	int ie;			/* interrupt enabled */
+
+	unsigned char read_prio;/* read priority */
+	unsigned char write_prio;/* write priority */
 };
=20
=20
@@ -506,6 +524,10 @@
 extern int omap_get_dma_src_addr_counter(int lch);
 extern void omap_clear_dma(int lch);
 extern int omap_dma_running(void);
+extern void omap_dma_set_global_params(int arb_rate, int =
max_fifo_depth,
+				       int tparams);
+extern int omap_dma_set_prio_lch(int lch, unsigned char read_prio,
+				 unsigned char write_prio);
=20
 /* LCD DMA functions */
 extern int omap_request_lcd_dma(void (* callback)(u16 status, void =
*data),
