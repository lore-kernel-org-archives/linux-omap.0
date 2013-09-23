From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] dma: edma: Add cyclic DMA support
Date: Mon, 23 Sep 2013 18:05:12 -0500
Message-ID: <1379977515-3794-1-git-send-email-joelf@ti.com>
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
To: Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Lars Peter-Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The following series adds Cyclic DMA support to TI EDMA DMA Engine driver.

First we split out the calculations for the Slave DMA case into a separate
function so that we may reuse it for the calculations of Cyclic DMA parameters.
Next patch then adds the actual support for Cyclic DMA, enables interrupts
correctly and uses's the callbacks in virt-dma during interrupts thus
signalling back to the ALSA layer that a period was transmitted.

Some background on motivation for this series:
Currently, only user of Cyclic DMA in EDMA is davinci-pcm driver. As of today,
this driver directly calls into the EDMA private API (arch/arm/common/edma.c)
without going through the DMAEngine.

davinci-pcm in future will be modified to use DMA Engine framework for Cyclic
DMA instead of directly using the Private API. However that's a much larger
effort, involving dealing with ping-pong from SRAM on user's of the Davinci
McASP, etc. As a first step, we add Cyclic DMA support to the EDMA driver so
that this may be used when the actual conversion of davinci-pcm happens.

Tested series along with couple of hacks to davinci-pcm to work with DMA Engine:
git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:joelagnel/linux-kernel.git (branch dma/cyclic)

Joel Fernandes (3):
  dma: edma: Split out PaRAM set calculations into its own function
  dma: edma: Add support for Cyclic DMA
  dma: edma: Increase maximum SG limit to 20

 drivers/dma/edma.c | 350 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 273 insertions(+), 77 deletions(-)

-- 
1.8.1.2
