From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 07/17] MMC: OMAP: Using setup_timer instead of init_timer
Date: Mon, 26 Nov 2007 12:01:31 -0400
Message-ID: <474AEDDB.9090901@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Using setup_timer() instead of init_timer on omap.c file.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 drivers/mmc/host/omap.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 92bcafb..97b123e 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1265,9 +1265,8 @@ static int __init mmc_omap_new_slot(struct mmc_omap_host *host, int id)
 			goto err_remove_slot_name;
 
 		INIT_WORK(&slot->switch_work, mmc_omap_cover_handler);
-		init_timer(&slot->switch_timer);
-		slot->switch_timer.function = mmc_omap_switch_timer;
-		slot->switch_timer.data = (unsigned long) slot;
+		setup_timer(&slot->switch_timer, mmc_omap_switch_timer,
+			    (unsigned long) slot);
 		schedule_work(&slot->switch_work);
 	}
 
@@ -1343,18 +1342,13 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	}
 
 	INIT_WORK(&host->cmd_abort, mmc_omap_abort_command);
-	init_timer(&host->cmd_timer);
-	host->cmd_timer.function = mmc_omap_cmd_timer;
-	host->cmd_timer.data = (unsigned long) host;
+	setup_timer(&host->cmd_timer, mmc_omap_cmd_timer, (unsigned long) host);
 
 	spin_lock_init(&host->dma_lock);
-	init_timer(&host->dma_timer);
+	setup_timer(&host->dma_timer, mmc_omap_dma_timer, (unsigned long) host);
 	spin_lock_init(&host->slot_lock);
 	init_waitqueue_head(&host->slot_wq);
 
-	host->dma_timer.function = mmc_omap_dma_timer;
-	host->dma_timer.data = (unsigned long) host;
-
 	host->pdata = pdata;
 	host->dev = &pdev->dev;
 	platform_set_drvdata(pdev, host);
-- 1.5.3.GIT
