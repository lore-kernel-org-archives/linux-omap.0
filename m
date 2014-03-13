From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 07/18] DMA: edma: Use different eventq for cyclic channels
Date: Thu, 13 Mar 2014 11:18:29 +0200
Message-ID: <1394702320-21743-8-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com, joelf@ti.com, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, Jyri Sarha <jsarha@ti.com>, mporter@linaro.org, vinod.koul@intel.com, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

To improve latency with cyclic DMA operation it is preferred to
use different eventq/tc than the default which is used by all
other drivers (mmc, spi, i2c, etc).
When preparing the cyclic dma ask for non default queue for the
channel which is going to be used with cyclic mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 86d6a3fb0d92..604c7c94c731 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -624,6 +624,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 		edesc->pset[i].opt |= TCINTEN;
 	}
 
+	/* Use different eventq/tc for cyclic DMA to reduce latency */
+	edma_request_non_default_queue(echan->ch_num);
+
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
 
-- 
1.9.0
