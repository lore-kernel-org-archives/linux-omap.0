From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v4 08/12] ARM: OMAP: DMA: use constant array maximum,
 drop some LCD DMA code
Date: Tue, 10 Apr 2012 18:35:52 -0600
Message-ID: <20120411003548.27059.29101.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43936 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759916Ab2DKAiW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:38:22 -0400
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

gcc can apparently handle stack-allocated arrays that use a dynamic
variable as the array maximum.  Rather than using a mutable quantity,
simply use a constant maximum possible size.  To me, code clarity is
improved; and it also avoids the following sparse warnings:

arch/arm/plat-omap/dma.c:886:40: error: bad constant expression
arch/arm/plat-omap/dma.c:892:17: error: cannot size expression
arch/arm/plat-omap/dma.c:970:40: error: bad constant expression
arch/arm/plat-omap/dma.c:972:17: error: cannot size expression

Also drop some dead code from the OMAP1 LCD DMA code:

arch/arm/mach-omap1/lcd_dma.c:80:6: warning: symbol 'omap_set_lcd_dma_src_port' was not declared. Should it be static?

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/lcd_dma.c |    5 -----
 arch/arm/plat-omap/dma.c      |   13 +++++++++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap1/lcd_dma.c b/arch/arm/mach-omap1/lcd_dma.c
index 86ace9a..9237576 100644
--- a/arch/arm/mach-omap1/lcd_dma.c
+++ b/arch/arm/mach-omap1/lcd_dma.c
@@ -77,11 +77,6 @@ void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16 fb_yres,
 }
 EXPORT_SYMBOL(omap_set_lcd_dma_b1);
 
-void omap_set_lcd_dma_src_port(int port)
-{
-	lcd_dma.src_port = port;
-}
-
 void omap_set_lcd_dma_ext_controller(int external)
 {
 	lcd_dma.ext_ctrl = external;
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index ecdb3da..612227e 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -41,6 +41,15 @@
 
 #include <plat/tc.h>
 
+/*
+ * MAX_LOGICAL_DMA_CH_COUNT: the maximum number of logical DMA
+ * channels that an instance of the SDMA IP block can support.  Used
+ * to size arrays.  (The actual maximum on a particular SoC may be less
+ * than this -- for example, OMAP1 SDMA instances only support 17 logical
+ * DMA channels.)
+ */
+#define MAX_LOGICAL_DMA_CH_COUNT		32
+
 #undef DEBUG
 
 #ifndef CONFIG_ARCH_OMAP1
@@ -883,7 +892,7 @@ void omap_start_dma(int lch)
 
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
-		char dma_chan_link_map[dma_lch_count];
+		char dma_chan_link_map[MAX_LOGICAL_DMA_CH_COUNT];
 
 		dma_chan_link_map[lch] = 1;
 		/* Set the link register of the first channel */
@@ -967,7 +976,7 @@ void omap_stop_dma(int lch)
 
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
-		char dma_chan_link_map[dma_lch_count];
+		char dma_chan_link_map[MAX_LOGICAL_DMA_CH_COUNT];
 
 		memset(dma_chan_link_map, 0, sizeof(dma_chan_link_map));
 		do {


