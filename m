From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: [PATCH 6/12] Allow framebuffer in SRAM and do not touch framebuffer
	SRAM on boot.
Date: Sat, 9 Jun 2007 20:41:40 +0200
Message-ID: <20070609184140.GF1889@varda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

On HTC smartphones, the LCD controller is already running in SRAM at boot time.
Therefore, clearing the SRAM before the controller is turned off will hang it,
and attemps to reset it later during the initialization of the LCD will not
work. This patch reserves the SRAM part where the framebuffer 'palette' is
located so that it is not cleared at boot time on HTC phones. It also fixes
support for LCD DMA in the SRAM region.

Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>

---
 arch/arm/plat-omap/dma.c  |   12 ++++++++++++
 arch/arm/plat-omap/sram.c |    2 ++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 05a3849..6e83f85 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -47,6 +47,8 @@
 
 #define OMAP_FUNC_MUX_ARM_BASE	(0xfffe1000 + 0xec)
 
+#define OMAP_SRAM_BASE          0x20000000
+
 static int enable_1510_mode = 0;
 
 struct omap_dma_lch {
@@ -1176,6 +1178,16 @@ static void set_b1_regs(void)
 	}
 
 	if (omap_dma_in_1510_mode()) {
+
+		if(top >= OMAP_SRAM_BASE && bottom >= OMAP_SRAM_BASE) {
+			omap_writew(1 << 6, OMAP1510_DMA_LCD_CTRL); /* SRAM */
+		} else if(top < OMAP_SRAM_BASE && bottom < OMAP_SRAM_BASE) {
+			omap_writew(0, OMAP1510_DMA_LCD_CTRL);     /* SDRAM */
+		} else {
+			printk(KERN_ERR "LCD DMA across SDRAM and SRAM\n");
+			BUG();
+		}
+
 		omap_writew(top >> 16, OMAP1510_DMA_LCD_TOP_F1_U);
 		omap_writew(top, OMAP1510_DMA_LCD_TOP_F1_L);
 		omap_writew(bottom >> 16, OMAP1510_DMA_LCD_BOT_F1_U);
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 1f23f04..2e0b267 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -33,6 +33,8 @@
 
 #if defined(CONFIG_ARCH_OMAP24XX)
 #define SRAM_BOOTLOADER_SZ	0x00
+#elif defined(CONFIG_MACH_TYPHOON) /* don't touch framebuffer until DMA off */
+#define SRAM_BOOTLOADER_SZ      0x1020
 #else
 #define SRAM_BOOTLOADER_SZ	0x80
 #endif
-- 
1.5.1.3
