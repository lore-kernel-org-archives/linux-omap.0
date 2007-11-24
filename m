From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 1/1] OMAP: DMA: Attribution necessary only if the ch is not
 chained.
Date: Sat, 24 Nov 2007 18:29:43 -0400
Message-ID: <4748A5D7.2040509@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Attribution necessary only if the ch is not chained on arch/arm/plat-omap/dma.c

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
---
 arch/arm/plat-omap/dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index dd0c874..a3c5d4f 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1709,9 +1709,9 @@ static int omap2_dma_handle_ch(int ch)
 
 		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
 			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
-	}
 
-	status = OMAP_DMA_CSR_REG(ch);
+		status = OMAP_DMA_CSR_REG(ch);
+	}
 
 	if (likely(dma_chan[ch].callback != NULL)) {
 		if (dma_chan[ch].chain_id != -1)
-- 1.5.3.GIT
