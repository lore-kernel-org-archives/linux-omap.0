From: Todd Poynor <tpoynor@mvista.com>
Subject: NOR flash delete mtd partitions created from platform data
Date: Mon, 5 Dec 2005 14:35:40 -0800
Message-ID: <20051205223540.GA5242@slurryseal.ddns.mvista.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Whatever gets the nod of approval I'll commit it to linux-mtd.

OMAP NOR flash driver give back mtd partitions created from platform data.

Signed-off-by: Todd Poynor <tpoynor@mvista.com>

---
commit d8e4727af4eabea65bba81a9bcf62ffc1dbda33b
tree 006bf94a2296051b291e46c7146865695caa259d
parent a0f7a1e5640376ffb1e4a01d601a24fb05bed5d7
author Todd Poynor <tpoynor@mvista.com> Mon, 05 Dec 2005 14:31:26 -0800
committer Todd Poynor <tpoynor@mvista.com> Mon, 05 Dec 2005 14:31:26 -0800

 drivers/mtd/maps/omap_nor.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/maps/omap_nor.c b/drivers/mtd/maps/omap_nor.c
index a6e705f..0ab9bc8 100644
--- a/drivers/mtd/maps/omap_nor.c
+++ b/drivers/mtd/maps/omap_nor.c
@@ -137,14 +137,21 @@ out_free_info:
 static int __devexit omapflash_remove(struct platform_device *pdev)
 {
 	struct omapflash_info *info = platform_get_drvdata(pdev);
+#ifdef CONFIG_MTD_PARTITIONS
+	struct flash_platform_data *pdata = pdev->dev.platform_data;
+#endif
 
 	platform_set_drvdata(pdev, NULL);
 
 	if (info) {
+#ifdef CONFIG_MTD_PARTITIONS
 		if (info->parts) {
 			del_mtd_partitions(info->mtd);
 			kfree(info->parts);
-		} else
+		} else if (pdata->parts) 
+			del_mtd_partitions(info->mtd);
+		else
+#endif
 			del_mtd_device(info->mtd);
 		map_destroy(info->mtd);
 		release_mem_region(info->map.phys, info->map.size);
