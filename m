From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] fix recent MMC driver compile breakage
Date: Tue, 08 May 2007 17:20:29 -0600
Message-ID: <20070508232045.583862612@pwsan.com>
References: <20070508232028.416620727@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=fix-mmc-driver.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The OMAP MMC driver previously supported multiple cards per MMC host,
but upper-layer support for this was recently removed (commit
b855885e3b60cf6f9452848712a62517b94583eb).  So, remove this support from
this driver, and add a missing include.  

Compile-tested only.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 drivers/mmc/host/omap.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: linux-omap-2.6/drivers/mmc/host/omap.c
===================================================================
--- linux-omap-2.6.orig/drivers/mmc/host/omap.c
+++ linux-omap-2.6/drivers/mmc/host/omap.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 #include <linux/clk.h>
@@ -587,9 +588,8 @@ static void mmc_omap_switch_timer(unsign
 static void mmc_omap_switch_handler(struct work_struct *work)
 {
 	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host, switch_work);
-	struct mmc_card *card;
 	static int complained = 0;
-	int cards = 0, cover_open;
+	int cover_open;
 
 	if (host->switch_pin == -1)
 		return;
@@ -599,10 +599,6 @@ static void mmc_omap_switch_handler(stru
 		host->switch_last_state = cover_open;
 	}
 	mmc_detect_change(host->mmc, 0);
-	list_for_each_entry(card, &host->mmc->cards, node) {
-		if (mmc_card_present(card))
-			cards++;
-	}
 	if (mmc_omap_cover_is_open(host)) {
 		if (!complained) {
 			dev_info(mmc_dev(host->mmc), "cover is open\n");

-- 
