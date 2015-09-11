From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 17/23] dmaengine: edma: Use the edma_write_slot instead
 open coded memcpy_toio
Date: Fri, 11 Sep 2015 15:27:16 +0300
Message-ID: <1441974442-8233-18-git-send-email-peter.ujfalusi@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

edma_write_slot() is for writing an entire paRAM slot.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index ed67206626e9..fcd612fbf00d 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -949,8 +949,7 @@ static void edma_free_channel(struct edma_cc *ecc, unsigned channel)
 	edma_setup_interrupt(ecc, channel, NULL, NULL);
 	/* REVISIT should probably take out of shadow region 0 */
 
-	memcpy_toio(ecc->base + PARM_OFFSET(channel), &dummy_paramset,
-		    PARM_SIZE);
+	edma_write_slot(ecc, channel, &dummy_paramset);
 	clear_bit(channel, ecc->edma_inuse);
 }
 
-- 
2.5.1
