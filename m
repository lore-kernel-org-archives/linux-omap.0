From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/10] omap: SDMA: Fix omap_stop_dma() API for channel linking
Date: Thu, 22 Oct 2009 15:11:37 -0700
Message-ID: <20091022221136.27408.73433.stgit@localhost>
References: <20091022221013.27408.443.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091022221013.27408.443.stgit@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Venkatraman S <svenkatr@ti.com>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hari n <hari.zoom@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP sDMA driver API omap_stop_dma() doesn't really stop the dma when used
in linking scenario.

The DMA channel needs to be disabled before resetting the chain.
Also fix clearing of the OMAP_DMA_ACTIVE status in the linked case.

Cc: Hari n <hari.zoom@gmail.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 0eb676d..b53125f 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -978,6 +978,14 @@ void omap_stop_dma(int lch)
 {
 	u32 l;
 
+	/* Disable all interrupts on the channel */
+	if (cpu_class_is_omap1())
+		dma_write(0, CICR(lch));
+
+	l = dma_read(CCR(lch));
+	l &= ~OMAP_DMA_CCR_EN;
+	dma_write(l, CCR(lch));
+
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
 		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
@@ -995,18 +1003,8 @@ void omap_stop_dma(int lch)
 			next_lch = dma_chan[cur_lch].next_lch;
 			cur_lch = next_lch;
 		} while (next_lch != -1);
-
-		return;
 	}
 
-	/* Disable all interrupts on the channel */
-	if (cpu_class_is_omap1())
-		dma_write(0, CICR(lch));
-
-	l = dma_read(CCR(lch));
-	l &= ~OMAP_DMA_CCR_EN;
-	dma_write(l, CCR(lch));
-
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
 }
 EXPORT_SYMBOL(omap_stop_dma);
