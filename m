From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH] ARM: OMAP: dma transfer param patch
Date: Fri, 12 May 2006 19:55:37 +0300
Message-ID: <4464BE09.3010402@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090203090301020208040600"
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090203090301020208040600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>From Peter Ujfalusi <peter.ujfalusi@nokia.com>

ARM: OMAP: DMA transfer parameter configuration fix

Fix for re-using OMAP DMA channel with different transfer parameters.
Bits in the CCR register need to be cleaned as well in some cases.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>


--------------090203090301020208040600
Content-Type: text/x-patch;
 name="omap-dma-transferparams.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap-dma-transferparams.diff"

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 5dac423..1f0edd8 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -166,18 +166,24 @@ void omap_set_dma_transfer_params(int lc
 	if (cpu_is_omap24xx() && dma_trigger) {
 		u32 val = OMAP_DMA_CCR_REG(lch);
 
+		val &= ~(3 << 19);
 		if (dma_trigger > 63)
 			val |= 1 << 20;
 		if (dma_trigger > 31)
 			val |= 1 << 19;
 
+		val &= ~(0x1f);
 		val |= (dma_trigger & 0x1f);
 
 		if (sync_mode & OMAP_DMA_SYNC_FRAME)
 			val |= 1 << 5;
+		else 
+			val &= ~(1 << 5);
 
 		if (sync_mode & OMAP_DMA_SYNC_BLOCK)
 			val |= 1 << 18;
+		else
+			val &= ~(1 << 18);
 
 		if (src_or_dst_synch)
 			val |= 1 << 24;		/* source synch */

--------------090203090301020208040600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090203090301020208040600--
