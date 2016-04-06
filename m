From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RESEND 0/2] dmaengine: edma: cyclic slot limitation wa and TPTC pm
 fix
Date: Wed, 6 Apr 2016 13:01:45 +0300
Message-ID: <1459936907-23920-1-git-send-email-peter.ujfalusi@ti.com>
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
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: john.ogness@linutronix.de, tony@atomide.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Vinod,

I just noticed that the following two patch got lost somehow. If it is still
possible, it would be great to send them for 4.6 as they are correcting
important issues in the driver.

Thanks,
Peter
---
John Ogness (1):
  dmaengine: edma: special case slot limit workaround

Peter Ujfalusi (1):
  dmaengine: edma: Remove dynamic TPTC power management feature

 drivers/dma/edma.c | 63 ++++++++++++++++++++++--------------------------------
 1 file changed, 25 insertions(+), 38 deletions(-)

-- 
2.8.0
