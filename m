From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] OMAP2 DMA burst support
Date: Wed, 07 Jun 2006 11:02:09 +0900
Message-ID: <00f601c689d6$62acdb60$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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


OMAP2 DMA burst setting support

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

--

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index aa1cf79..8e7c336 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -292,22 +292,39 @@ void omap_set_dma_src_data_pack(int lch,
 
 void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode
burst_mode)
 {
+	unsigned int burst = 0;
 	OMAP_DMA_CSDP_REG(lch) &= ~(0x03 << 7);
 
 	switch (burst_mode) {
 	case OMAP_DMA_DATA_BURST_DIS:
 		break;
 	case OMAP_DMA_DATA_BURST_4:
-		OMAP_DMA_CSDP_REG(lch) |= (0x02 << 7);
+		if (cpu_is_omap24xx())
+			burst = 0x1;
+		else
+			burst = 0x2;
 		break;
 	case OMAP_DMA_DATA_BURST_8:
-		/* not supported by current hardware
+		if (cpu_is_omap24xx()) {
+			burst = 0x2;
+			break;
+		}
+		/* not supported by current hardware on OMAP1
 		 * w |= (0x03 << 7);
 		 * fall through
 		 */
+	case OMAP_DMA_DATA_BURST_16:
+		if (cpu_is_omap24xx()) {
+			burst = 0x3;
+			break;
+		}
+		/* OMAP1 don't support burst 16
+		 * fall through
+		 */
 	default:
 		BUG();
 	}
+	OMAP_DMA_CSDP_REG(lch) |= (burst << 7);
 }
 
 /* Note that dest_port is only for OMAP1 */
@@ -354,22 +371,38 @@ void omap_set_dma_dest_data_pack(int lch
 
 void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode
burst_mode)
 {
+	unsigned int burst = 0;
 	OMAP_DMA_CSDP_REG(lch) &= ~(0x03 << 14);
 
 	switch (burst_mode) {
 	case OMAP_DMA_DATA_BURST_DIS:
 		break;
 	case OMAP_DMA_DATA_BURST_4:
-		OMAP_DMA_CSDP_REG(lch) |= (0x02 << 14);
+		if (cpu_is_omap24xx())
+			burst = 0x1;
+		else
+			burst = 0x2;
 		break;
 	case OMAP_DMA_DATA_BURST_8:
-		OMAP_DMA_CSDP_REG(lch) |= (0x03 << 14);
+		if (cpu_is_omap24xx())
+			burst = 0x2;
+		else
+			burst = 0x3;
 		break;
+	case OMAP_DMA_DATA_BURST_16:
+		if (cpu_is_omap24xx()) {
+			burst = 0x3;
+			break;
+		}
+		/* OMAP1 don't support burst 16
+		 * fall through
+		 */
 	default:
 		printk(KERN_ERR "Invalid DMA burst mode\n");
 		BUG();
 		return;
 	}
+	OMAP_DMA_CSDP_REG(lch) |= (burst << 14);
 }
 
 static inline void omap_enable_channel_irq(int lch)
diff --git a/include/asm-arm/arch-omap/dma.h b/include/asm-arm/arch-
omap/dma.h
index ca12023..e081400 100644
--- a/include/asm-arm/arch-omap/dma.h
+++ b/include/asm-arm/arch-omap/dma.h
@@ -315,11 +315,11 @@ enum {
 	OMAP_LCD_DMA_B2_BOTTOM
 };
 
-/* REVISIT: Check if BURST_4 is really 1 (or 2) */
 enum omap_dma_burst_mode {
 	OMAP_DMA_DATA_BURST_DIS = 0,
 	OMAP_DMA_DATA_BURST_4,
-	OMAP_DMA_DATA_BURST_8
+	OMAP_DMA_DATA_BURST_8,
+	OMAP_DMA_DATA_BURST_16,
 };
 
 enum omap_dma_color_mode {
