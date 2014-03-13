From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 13/18] dma: edma: Print the direction value as well when it is not supported
Date: Thu, 13 Mar 2014 11:18:35 +0200
Message-ID: <1394702320-21743-14-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com, joelf@ti.com, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, Jyri Sarha <jsarha@ti.com>, mporter@linaro.org, vinod.koul@intel.com, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

In case of not supported direction it is better to print the direction also.
It is unlikely, but in such an event it helps with the debugging.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 47abaac7eb18..69dd4e3de67e 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -426,7 +426,7 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 		dev_width = echan->cfg.dst_addr_width;
 		burst = echan->cfg.dst_maxburst;
 	} else {
-		dev_err(dev, "%s: bad direction?\n", __func__);
+		dev_err(dev, "%s: bad direction: %d\n", __func__, direction);
 		return NULL;
 	}
 
@@ -519,7 +519,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 		dev_width = echan->cfg.dst_addr_width;
 		burst = echan->cfg.dst_maxburst;
 	} else {
-		dev_err(dev, "%s: bad direction?\n", __func__);
+		dev_err(dev, "%s: bad direction: %d\n", __func__, direction);
 		return NULL;
 	}
 
-- 
1.9.0
