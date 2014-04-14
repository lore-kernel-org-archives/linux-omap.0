From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 00/10] dma: edma: Fixes for cyclic (audio) operation
Date: Mon, 14 Apr 2014 14:41:55 +0300
Message-ID: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v2:
- Dropped patch 10 from v2 (simplify direction configuration...)
- Dropped the channel priority related patches since we are going to go via
  different route for configuring the priority.
- Added ACK from Joel for the patches since they are not changed since v2

Changes since v1:
- ASoC patches removed
- Comments from Andriy Shevchenko addressed
- patch added to fix cases when src/dst_maxburst is set to 0

The series contains now only:
Support for DMA pause/resume in cyclic mode
device_slave_caps callback and DMA_CYCLIC flag correction.
While debugging the edma to get things sorted out I noticed that the debug was
too verbose and the important information was hidden even when the we did not
asked for verbose dmaengine debug.
I have included some debug cleanups for the edma dmaengine driver also.

Regards,
Peter
---
Peter Ujfalusi (10):
  platform_data: edma: Be precise with the paRAM struct
  arm: common: edma: Save the number of event queues/TCs
  dmaengine: edma: Correct the handling of src/dst_maxburst == 0
  dmaengine: edma: Add support for DMA_PAUSE/RESUME operation
  dmaengine: edma: Set DMA_CYCLIC capability flag
  dmaengine: edma: Implement device_slave_caps callback
  dmaengine: edma: Reduce debug print verbosity for non verbose
    debugging
  dmaengine: edma: Prefix debug prints where the text were identical in
    prep callbacks
  dmaengine: edma: Add channel number to debug prints
  dmaengine: edma: Print the direction value as well when it is not
    supported

 arch/arm/common/edma.c             |  4 ++
 drivers/dma/edma.c                 | 87 ++++++++++++++++++++++++++++++--------
 include/linux/platform_data/edma.h | 18 ++++----
 3 files changed, 83 insertions(+), 26 deletions(-)

-- 
1.9.2
