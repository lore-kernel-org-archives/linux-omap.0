From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 0/3] dmaengine: ti: edma: Polled completion support
Date: Tue, 18 Jun 2019 16:21:45 +0300
Message-ID: <20190618132148.26468-1-peter.ujfalusi@ti.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Change since v3:
- fix DMA pointer tracking for memcpy
- completion polling is only done when it is asked by not providing
  DMA_PREP_INTERRUPT for memcpy

Changes since v2:
- Fix typo in the comment for patch 0

Changes since v1:
- Cleanup patch for the array register handling
- typo fixed in patch2 commit message

The code around the array register access was pretty confusing for the first
look, so clean them up first then use the cleaner way in the polled handling.

When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
does not want to use interrupts for DMA completion or because it can not
rely on DMA interrupts due to executing the memcpy when interrupts are
disabled it will poll the status of the transfer.

Since we can not tell from any EDMA register that the transfer is
completed, we can only know that the paRAM set has been sent to TPTC for
processing we need to check the residue of the transfer, if it is 0 then
the transfer is completed.

The polled completion can bve tested by applying:
https://patchwork.kernel.org/patch/10966499/

Enabling the memcpy for EDMA and run the dmatest with polled = 1.

Or, enable the EDMA memcpy support and boot up any dra7 family device with
display enabled. The workaround for DMM errata i878 uses polled DMA memcpy.

Regards,
Peter
---
Peter Ujfalusi (3):
  dmaengine: ti: edma: Clean up the 2x32bit array register accesses
  dmaengine: ti: edma: Correct the residue calculation (fix for memcpy)
  dmaengine: ti: edma: Support for polled (memcpy) completion

 drivers/dma/ti/edma.c | 174 ++++++++++++++++++++++++++++--------------
 1 file changed, 117 insertions(+), 57 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
