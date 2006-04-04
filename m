From: Tony Lindgren <tony@atomide.com>
Subject: Omap MMC driver merged to mainline, patches needed
Date: Tue, 4 Apr 2006 14:15:09 -0700
Message-ID: <20060404211507.GG15266@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
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


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I've just updated the linux-omap tree to 2.6.17-rc1, and it now has the
omap MMC driver integrated based on the patch done by Carlos.

This driver is a stripped down version of MMC driver with all our
workarounds left out. We now need to patch this driver and make sure
that it works on all omap hardware. Then we need to figure out which
workarounds we still need from the old driver.

As I managed to lose the old driver version history with the merge,
I've set up a linux-omap-2.6.16 tree at kernel.org where you can view
the old driver [1]. I've also attached a little patch against the MMC
driver.

Please note that all patches against the MMC driver will be sent to
RMK immediately. All the patches must contain the Signed-off-by.
Otherwise we'll spend time unnecessarily redoing patches.

BTW, the same goes for all the omap core stuff as we're now quite well
in sync with mainline kernel.

[1] http://master.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.16.git;a=tree;h=2eb478be1cd7ff80d80728a1934e1740aedb9fa1;hb=8c6cfface78a77ed68788216d5fecdac7d8d09c3;f=drivers/mmc

Cheers,

Tony

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-omap-mmc-fixes

diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index becb3c6..197fa3b 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -61,6 +63,7 @@ struct mmc_omap_host {
 	unsigned char		id; /* 16xx chips have 2 MMC blocks */
 	struct clk *		iclk;
 	struct clk *		fclk;
+	struct resource		*res;
 	void __iomem		*base;
 	int			irq;
 	unsigned char		bus_mode;
@@ -973,20 +976,20 @@ static int __init mmc_omap_probe(struct 
 	struct omap_mmc_conf *minfo = pdev->dev.platform_data;
 	struct mmc_host *mmc;
 	struct mmc_omap_host *host = NULL;
+	struct resource *r;
 	int ret = 0;
+	int irq;
 	
-	if (platform_get_resource(pdev, IORESOURCE_MEM, 0) ||
-			platform_get_irq(pdev, IORESOURCE_IRQ, 0)) {
-		dev_err(&pdev->dev, "mmc_omap_probe: invalid resource type\n");
-		return -ENODEV;
-	}
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (!r || irq < 0)
+		return -ENXIO;
 
-	if (!request_mem_region(pdev->resource[0].start,
+	r = request_mem_region(pdev->resource[0].start,
 				pdev->resource[0].end - pdev->resource[0].start + 1,
-				pdev->name)) {
-		dev_dbg(&pdev->dev, "request_mem_region failed\n");
+			       pdev->name);
+	if (!r)
 		return -EBUSY;
-	}
 
 	mmc = mmc_alloc_host(sizeof(struct mmc_omap_host), &pdev->dev);
 	if (!mmc) {
@@ -1003,6 +1006,8 @@ static int __init mmc_omap_probe(struct 
 	host->dma_timer.data = (unsigned long) host;
 
 	host->id = pdev->id;
+	host->res = r;
+	host->irq = irq;
 
 	if (cpu_is_omap24xx()) {
 		host->iclk = clk_get(&pdev->dev, "mmc_ick");
@@ -1032,7 +1037,7 @@ static int __init mmc_omap_probe(struct 
 	host->dma_ch = -1;
 
 	host->irq = pdev->resource[1].start;
-	host->base = ioremap(pdev->res.start, SZ_4K);
+	host->base = ioremap(r->start, SZ_4K);
 	if (!host->base) {
 		ret = -ENOMEM;
 		goto out;
@@ -1100,7 +1105,7 @@ static int __init mmc_omap_probe(struct 
 				device_remove_file(&pdev->dev, &dev_attr_cover_switch);
 		}
 		if (ret) {
-			dev_wan(mmc_dev(host->mmc), "Unable to create sysfs attributes\n");
+			dev_warn(mmc_dev(host->mmc), "Unable to create sysfs attributes\n");
 			free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
 			omap_free_gpio(host->switch_pin);
 			host->switch_pin = -1;

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--LZvS9be/3tNcYl/X--
