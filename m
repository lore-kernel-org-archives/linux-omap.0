From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] dmaengine: edma: Document variables used for residue
	accounting
Date: Mon, 28 Apr 2014 15:48:47 -0500
Message-ID: <1398718128-22647-1-git-send-email-joelf@ti.com>
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
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The granular residue accounting code uses certain variables specifically
for residue accounting. Document these in the structure declaration.
Also move around some elements and group them together.

Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
---
 drivers/dma/edma.c |   26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 4c574f60..8926078 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -70,12 +70,34 @@ struct edma_desc {
 	int				cyclic;
 	int				absync;
 	int				pset_nr;
+	struct edma_chan		*echan;
 	int				processed;
+
+	/*
+	 * The following 4 elements are used for residue accounting.
+	 *
+	 * - processed_stat: the number of SG elements we have traversed
+	 * so far to cover accounting. This is updated directly to processed
+	 * during edma_callback and is always <= processed, because processed
+	 * refers to the number of pending transfer (programmed to EDMA
+	 * controller), where as processed_stat tracks number of transfers
+	 * accounted for so far.
+	 *
+	 * - residue: The amount of bytes we have left to transfer for this desc
+	 *
+	 * - residue_stat: The residue in bytes of data we have covered
+	 * so far for accounting. This is updated directly to residue
+	 * during callbacks to keep it current.
+	 *
+	 * - sg_len: Tracks the length of the current intermediate transfer,
+	 * this is required to update the residue during intermediate transfer
+	 * completion callback.
+	 */
 	int				processed_stat;
-	u32				residue;
 	u32				sg_len;
+	u32				residue;
 	u32				residue_stat;
-	struct edma_chan		*echan;
+
 	struct edma_pset		pset[0];
 };
 
-- 
1.7.9.5
