From: Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 125/144] dmaengine: edma: fix memory leak when
 terminating running transfers
Date: Tue, 21 Apr 2015 16:31:50 +0100
Message-ID: <1429630329-21748-126-git-send-email-luis.henriques@canonical.com>
References: <1429630329-21748-1-git-send-email-luis.henriques@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-team-bounces@lists.ubuntu.com>
In-Reply-To: <1429630329-21748-1-git-send-email-luis.henriques@canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/options/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/kernel-team>
List-Post: <mailto:kernel-team@lists.ubuntu.com>
List-Help: <mailto:kernel-team-request@lists.ubuntu.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=subscribe>
Errors-To: kernel-team-bounces@lists.ubuntu.com
Sender: kernel-team-bounces@lists.ubuntu.com
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: Petr Kulhavy <petr@barix.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: linux-omap@vger.kernel.org

3.16.7-ckt10 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Kulhavy <petr@barix.com>

commit 5ca9e7ce6eebec53362ff779264143860ccf68cd upstream.

If edma_terminate_all() was called while a transfer was running (i.e. after
edma_execute() but before edma_callback()) the echan->edesc was not freed.

This was due to the fact that a running transfer is on none of the
vchan lists: desc_submitted, desc_issued, desc_completed (edma_execute()
removes it from the desc_issued list), so the vchan_dma_desc_free_list()
called at the end of edma_terminate_all() didn't find it and didn't free it.

This bug was found on an AM1808 based hardware (very similar to da850evm,
however using the second MMC/SD controller), where intense operations on the SD
card wasted the device 128MB RAM within a couple of days.

Peter Ujfalusi:
The issue is even more severe since it affects cyclic (audio) transfers as
well. In this case starting/stopping audio will results memory leak.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: <linux-omap@vger.kernel.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
[ luis: backported to 3.16: adjusted context ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/dma/edma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index d08c4dedef35..3c58df963e06 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -256,6 +256,12 @@ static int edma_terminate_all(struct edma_chan *echan)
 	 * echan->edesc is NULL and exit.)
 	 */
 	if (echan->edesc) {
+		/*
+		 * free the running request descriptor
+		 * since it is not in any of the vdesc lists
+		 */
+		edma_desc_free(&echan->edesc->vdesc);
+
 		echan->edesc = NULL;
 		edma_stop(echan->ch_num);
 	}
