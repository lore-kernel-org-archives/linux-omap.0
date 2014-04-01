From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 00/14] dma: edma: Fixes for cyclic (audio) operation
Date: Tue, 1 Apr 2014 16:06:01 +0300
Message-ID: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This is basically a resend of the previous series:
https://lkml.org/lkml/2014/3/13/119
with removed ASoC patches (most of them are applied already).

Changes since v1:
- ASoC patches removed
- Comments from Andriy Shevchenko addressed
- patch added to fix cases when src/dst_maxburst is set to 0

Adding support for DMA pause/resume
Possibility to select non default event queue/TC for cyclic (audio) dma
channels: all devices using the eDMA via dmaengine was assigned to the default
EQ/TC (mmc, i2c, spi, etc, and audio). This is not optimal from system
performance point of view since sharing the same EQ/TC can cause latency spikes
for cyclic channels (long DMA transfers for MMC for example).

While debugging the edma to get things sorted out I noticed that the debug was
too verbose and the important information was hidden even when the we did not
asked for verbose dmaengine debug.
I have included some debug cleanups for the edma dmaengine driver also.

Regards,
Peter
---
Peter Ujfalusi (14):
  platform_data: edma: Be precise with the paRAM struct
  dma: edma: Correct the handling of src/dst_maxburst == 0
  dma: edma: Add support for DMA_PAUSE/RESUME operation
  dma: edma: Set DMA_CYCLIC capability flag
  arm: common: edma: Select event queue 1 as default when booted with DT
  arm: common: edma: Save the number of event queues/TCs
  arm: common: edma: API to request non default queue for a channel
  DMA: edma: Use different eventq for cyclic channels
  dma: edma: Implement device_slave_caps callback
  dma: edma: Simplify direction configuration in edma_config_pset()
  dma: edma: Reduce debug print verbosity for non verbose debugging
  dma: edma: Prefix debug prints where the text were identical in prep
    callbacks
  dma: edma: Add channel number to debug prints
  dma: edma: Print the direction value as well when it is not supported

 arch/arm/common/edma.c             | 34 +++++++++++++-
 drivers/dma/edma.c                 | 96 +++++++++++++++++++++++++++++---------
 include/linux/platform_data/edma.h | 20 ++++----
 3 files changed, 119 insertions(+), 31 deletions(-)

-- 
1.9.1
