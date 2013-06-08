From: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] spi: omap2-mcspi: Skip platform_get_resource_byname() for dt
	case
Date: Sat, 8 Jun 2013 22:05:38 +0530
Message-ID: <1370709338-19810-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, r.sricharan-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-omap@vger.kernel.org

McSPI driver probe will abort for DT case because of failed
platform_get_resource_byname() lookup. Fix it by skipping resource
byname lookup for device tree build.

Issue comes out when dma entries are removed from the hwmod data.

Signed-off-by: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e4829aa..99172d2 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1275,25 +1275,31 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		struct resource *dma_res;
 
 		sprintf(dma_rx_ch_name, "rx%d", i);
-		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-				dma_rx_ch_name);
-		if (!dma_res) {
-			dev_dbg(&pdev->dev, "cannot get DMA RX channel\n");
-			status = -ENODEV;
-			break;
+
+		if (!pdev->dev.of_node) {
+			dma_res = platform_get_resource_byname(pdev,
+					IORESOURCE_DMA, dma_rx_ch_name);
+			if (!dma_res) {
+				dev_dbg(&pdev->dev, "cannot get DMA RX channel\n");
+				status = -ENODEV;
+				break;
+			}
+			mcspi->dma_channels[i].dma_rx_sync_dev = dma_res->start;
 		}
 
-		mcspi->dma_channels[i].dma_rx_sync_dev = dma_res->start;
 		sprintf(dma_tx_ch_name, "tx%d", i);
-		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-				dma_tx_ch_name);
-		if (!dma_res) {
-			dev_dbg(&pdev->dev, "cannot get DMA TX channel\n");
-			status = -ENODEV;
-			break;
-		}
 
-		mcspi->dma_channels[i].dma_tx_sync_dev = dma_res->start;
+		if (!pdev->dev.of_node) {
+			dma_res = platform_get_resource_byname(pdev,
+					IORESOURCE_DMA, dma_tx_ch_name);
+
+			if (!dma_res) {
+				dev_dbg(&pdev->dev, "cannot get DMA TX channel\n");
+				status = -ENODEV;
+				break;
+			}
+			mcspi->dma_channels[i].dma_tx_sync_dev = dma_res->start;
+		}
 	}
 
 	if (status < 0)
-- 
1.7.9.5


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
