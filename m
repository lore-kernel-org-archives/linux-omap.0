From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] omap: SDMA: Fixing bug in omap_dma_set_global_params()
Date: Tue, 13 Oct 2009 17:14:18 -0700
Message-ID: <20091014001418.6116.82370.stgit@localhost>
References: <20091014001233.6116.84749.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091014001233.6116.84749.stgit@localhost>
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
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Anuj Aggarwal <anuj.aggarwal@ti.com>

Argument tparams was not being used to program
global register GCR.HI_THREAD_RESERVED. This patch fixes the same.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index fd3154a..0eb676d 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -829,10 +829,10 @@ EXPORT_SYMBOL(omap_free_dma);
  *
  * @param arb_rate
  * @param max_fifo_depth
- * @param tparams - Number of thereads to reserve : DMA_THREAD_RESERVE_NORM
- * 						    DMA_THREAD_RESERVE_ONET
- * 						    DMA_THREAD_RESERVE_TWOT
- * 						    DMA_THREAD_RESERVE_THREET
+ * @param tparams - Number of threads to reserve : DMA_THREAD_RESERVE_NORM
+ * 						   DMA_THREAD_RESERVE_ONET
+ * 						   DMA_THREAD_RESERVE_TWOT
+ * 						   DMA_THREAD_RESERVE_THREET
  */
 void
 omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
@@ -844,11 +844,14 @@ omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
 		return;
 	}
 
+	if (max_fifo_depth == 0)
+		max_fifo_depth = 1;
 	if (arb_rate == 0)
 		arb_rate = 1;
 
-	reg = (arb_rate & 0xff) << 16;
-	reg |= (0xff & max_fifo_depth);
+	reg = 0xff & max_fifo_depth;
+	reg |= (0x3 & tparams) << 12;
+	reg |= (arb_rate & 0xff) << 16;
 
 	dma_write(reg, GCR);
 }
