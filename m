From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 03/18] dma: edma: Set DMA_CYCLIC capability flag
Date: Thu, 13 Mar 2014 11:18:25 +0200
Message-ID: <1394702320-21743-4-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1394702320-21743-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Indicate that the edma dmaengine driver has support for cyclic mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/common/edma.c | 1 +
 drivers/dma/edma.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 41bca32409fc..86a8b263278f 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1574,6 +1574,7 @@ static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
 		return ERR_PTR(ret);
 
 	dma_cap_set(DMA_SLAVE, edma_filter_info.dma_cap);
+	dma_cap_set(DMA_CYCLIC, edma_filter_info.dma_cap);
 	of_dma_controller_register(dev->of_node, of_dma_simple_xlate,
 				   &edma_filter_info);
 
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index b54cd2dedde0..86d6a3fb0d92 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -887,6 +887,7 @@ static int edma_probe(struct platform_device *pdev)
 
 	dma_cap_zero(ecc->dma_slave.cap_mask);
 	dma_cap_set(DMA_SLAVE, ecc->dma_slave.cap_mask);
+	dma_cap_set(DMA_CYCLIC, ecc->dma_slave.cap_mask);
 
 	edma_dma_init(ecc, &ecc->dma_slave, &pdev->dev);
 
-- 
1.9.0
