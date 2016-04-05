From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/2] dmaengine: omap-dma: Fix polled completion
Date: Tue, 5 Apr 2016 15:20:19 +0300
Message-ID: <1459858821-25191-1-git-send-email-peter.ujfalusi@ti.com>
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
To: vinod.koul@intel.com, linux@arm.linux.org.uk
Cc: dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v2:
- series rebased on -rc1 for resending

Cover letter from v2:

Based on the discussion on the first version:
https://lkml.org/lkml/2016/2/25/167

I have fixed the omap_dma_tx_status() - first patch and added the second patch
to not disable the interrupts for memcpy so multiple transfers can be queued.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: omap-dma: Fix polled channel completion detection and
    handling
  dmaengine: omap-dma: Do not suppress interrupts for memcpy

 drivers/dma/omap-dma.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
2.8.0
