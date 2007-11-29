From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Check the get_cover_state function pointer if
	not set
Date: Thu, 29 Nov 2007 17:01:11 +0900
Message-ID: <20071129080111.GA879@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

If the get_cover_state is not set, it occurs the oops.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index cf9d31c..d7ecece 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -238,7 +238,9 @@ static void mmc_omap_release_slot(struct mmc_omap_slot *slot)
 static inline
 int mmc_omap_cover_is_open(struct mmc_omap_slot *slot)
 {
-	return slot->pdata->get_cover_state(mmc_dev(slot->mmc), slot->id);
+	if (slot->pdata->get_cover_state)
+		return slot->pdata->get_cover_state(mmc_dev(slot->mmc), slot->id);
+	return 0;
 }
 
 static ssize_t
