From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] 24xx dma patch
Date: Fri, 06 Jan 2006 16:33:06 +0900
Message-ID: <0ISN000DPUB62T@mmp2.samsung.com>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi 

It reads DMA status too early and use callback function.
It's make dma error on 24xx when playing the music.

Regards,

Kyungmin Park

--

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -866,8 +866,10 @@ static int omap2_dma_handle_ch(int ch)
 	val = 1 << (ch);
 	omap_writel(val, OMAP_DMA4_IRQSTATUS_L0);
 
-	if (likely(dma_chan[ch].callback != NULL))
+	if (likely(dma_chan[ch].callback != NULL)) {
+		status = OMAP_DMA_CSR_REG(ch);
 		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
+	}
 
 	return 0;
 }
