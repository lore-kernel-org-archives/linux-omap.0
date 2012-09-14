From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 01/15] dmaengine: omap: Support for element
	mode in cyclic DMA
Date: Fri, 14 Sep 2012 15:05:44 +0300
Message-ID: <1347624358-25582-2-git-send-email-peter.ujfalusi@ti.com>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Ricardo Neri <ricardo.neri@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

When src_maxburst/dst_maxburst is set to 0 by the users of cyclic DMA
(mostly audio) indicates that we should configure the omap DMA to element
sync mode instead of packet mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index ae05618..b77a40d 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -413,7 +413,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	d->dev_addr = dev_addr;
 	d->fi = burst;
 	d->es = es;
-	d->sync_mode = OMAP_DMA_SYNC_PACKET;
+	if (burst)
+		d->sync_mode = OMAP_DMA_SYNC_PACKET;
+	else
+		d->sync_mode = OMAP_DMA_SYNC_ELEMENT;
 	d->sync_type = sync_type;
 	d->periph_port = OMAP_DMA_PORT_MPUI;
 	d->sg[0].addr = buf_addr;
-- 
1.7.12
