From: ahemaily@gmail.com
Subject: [PATCH 1/1] arm :omap :DMA: fix a bug on reserving the omap SDMA
 channels
Date: Sat, 29 Dec 2012 22:43:20 +0200
Message-ID: <1356813800-4705-1-git-send-email-ahemaily@gmail.com>
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
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ahemaily <ahemaily@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: ahemaily <ahemaily@gmail.com>

The variable  dma_lch_count  used for comparison  (omap_dma_reserve_channels <= dma_lch_count)
before it initialized to the value from omap_dma_dev_attr : d->lch_count.

I change the place of dma_lch_count initialization to be before the comparison.

Signed-off-by: Abdelrahman Hemaily <ahemaily@gmail.com>
---
 arch/arm/plat-omap/dma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c76ed8b..cb3e321 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2014,12 +2014,12 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 
 	d			= p->dma_attr;
 	errata			= p->errata;
-
+	dma_lch_count           = d->lch_count;
+
 	if ((d->dev_caps & RESERVE_CHANNEL) && omap_dma_reserve_channels
 			&& (omap_dma_reserve_channels <= dma_lch_count))
 		d->lch_count	= omap_dma_reserve_channels;
 
-	dma_lch_count		= d->lch_count;
 	dma_chan_count		= dma_lch_count;
 	dma_chan		= d->chan;
 	enable_1510_mode	= d->dev_caps & ENABLE_1510_MODE;
-- 
1.7.9.5
