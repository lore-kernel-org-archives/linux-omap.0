From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: Pending patches mostly pushed, please check
Date: Tue, 3 Jan 2006 14:36:57 -0800
Message-ID: <20060103223657.GA30294@slurryseal.ddns.mvista.com>
References: <43B10E92.4060203@de.bosch.com> <20051230222808.GJ4415@atomide.com>
	<20060103191356.GR6034@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060103191356.GR6034@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 03, 2006 at 11:13:56AM -0800, Tony Lindgren wrote:
> 
> Also reply to this thread if you know if a patch that you think
> should be pushed and has not been pushed yet. 

Here's one that probably should go in, although del_mtd_partitions +
mtdblock is known broken
(http://lists.infradead.org/pipermail/linux-mtd/2004-November/011007.html).

---------- snip

OMAP MTD NOR mapping driver remove partitions created from platform data.

Signed-off-by: Todd Poynor <tpoynor@mvista.com>

---
commit 54131af1a43d5ddabfd5b96fd74e51de86943894
tree 94686025ea41abb2ecd102e3bb15f93b3e77f09f
parent 91b3e09b5720c0ed00d059a3b95cdf3a4c1a18fb
author Todd Poynor <tpoynor@mvista.com> Tue, 03 Jan 2006 14:31:59 -0800
committer Todd Poynor <tpoynor@mvista.com> Tue, 03 Jan 2006 14:31:59 -0800

 drivers/mtd/maps/omap_nor.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/maps/omap_nor.c b/drivers/mtd/maps/omap_nor.c
index a6e705f..6614e97 100644
--- a/drivers/mtd/maps/omap_nor.c
+++ b/drivers/mtd/maps/omap_nor.c
@@ -137,11 +137,12 @@ out_free_info:
 static int __devexit omapflash_remove(struct platform_device *pdev)
 {
 	struct omapflash_info *info = platform_get_drvdata(pdev);
+	struct flash_platform_data *pdata = pdev->dev.platform_data;
 
 	platform_set_drvdata(pdev, NULL);
 
 	if (info) {
-		if (info->parts) {
+		if (info->parts || (pdata && pdata->parts)) {
 			del_mtd_partitions(info->mtd);
 			kfree(info->parts);
 		} else
