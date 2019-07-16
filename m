From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] dmaengine: ti: omap-dma: Improved polling support
Date: Tue, 16 Jul 2019 11:24:57 +0300
Message-ID: <20190716082459.1222-1-peter.ujfalusi@ti.com>
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

changes since v1:
- New preparation cleanup patch
- Simplified code for the main patch to be easier to read

This series fine-tunes the omap-dma polled memcpy support to be inline with how
the EDMA driver is handling it.

The polled completion can be tested by applying:
https://patchwork.kernel.org/patch/10966499/

and run the dmatest with polled = 1 on boards where sDMA is used.

Or boot up any dra7 family device with display enabled. The workaround for DMM
errata i878 uses polled DMA memcpy.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: ti: omap-dma: Readability cleanup in omap_dma_tx_status()
  dmaengine: ti: omap-dma: Improved memcpy polling support

 drivers/dma/ti/omap-dma.c | 52 +++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 19 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
