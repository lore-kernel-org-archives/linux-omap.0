From: Scott Ellis <scott@jumpnowtek.com>
Subject: [PATCH] DMA: OMAP: Remove extra looping from omap_request_dma
Date: Wed, 29 Jun 2011 10:09:09 -0400
Message-ID: <1309356549.3995.13.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Break from dma channel search when a free one is found.

Signed-off-by: Scott Ellis <scott@jumpnowtek.com>
---
 arch/arm/plat-omap/dma.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c22217c..3d36fcf 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -678,10 +678,9 @@ int omap_request_dma(int dev_id, const char *dev_name,
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	for (ch = 0; ch < dma_chan_count; ch++) {
-		if (free_ch == -1 && dma_chan[ch].dev_id == -1) {
+		if (dma_chan[ch].dev_id == -1) {
 			free_ch = ch;
-			if (dev_id == 0)
-				break;
+			break;
 		}
 	}
 	if (free_ch == -1) {
