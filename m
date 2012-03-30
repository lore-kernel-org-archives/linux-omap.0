From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 4/6] spi: omap2-mcspi: use devm_* functions
Date: Fri, 30 Mar 2012 15:50:20 +0530
Message-ID: <1333102822-17171-5-git-send-email-shubhrajyoti@ti.com>
References: <1333102822-17171-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1333102822-17171-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Shubhrajyoti, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The various devm_* functions allocate memory that is released when a driver
detaches. This patch uses devm_request_and_ioremap
to request memory in probe function. Since the freeing is not
needed the calls are deleted from remove function.Also use
use devm_kzalloc for the cs memory allocation.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |   24 ++++--------------------
 1 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 66cbf22..1907ed2 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -787,7 +787,7 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 
 	if (!cs) {
-		cs = kzalloc(sizeof *cs, GFP_KERNEL);
+		cs = devm_kzalloc(&spi->dev , sizeof *cs, GFP_KERNEL);
 		if (!cs)
 			return -ENOMEM;
 		cs->base = mcspi->base + spi->chip_select * 0x14;
@@ -828,7 +828,6 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 		cs = spi->controller_state;
 		list_del(&cs->node);
 
-		kfree(spi->controller_state);
 	}
 
 	if (spi->chip_select < spi->master->num_chipselect) {
@@ -1160,17 +1159,12 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 	r->start += regs_offset;
 	r->end += regs_offset;
 	mcspi->phys = r->start;
-	if (!request_mem_region(r->start, resource_size(r),
-				dev_name(&pdev->dev))) {
-		status = -EBUSY;
-		goto free_master;
-	}
 
-	mcspi->base = ioremap(r->start, resource_size(r));
+	mcspi->base = devm_request_and_ioremap(&pdev->dev, r);
 	if (!mcspi->base) {
 		dev_dbg(&pdev->dev, "can't ioremap MCSPI\n");
 		status = -ENOMEM;
-		goto release_region;
+		goto free_master;
 	}
 
 	mcspi->dev = &pdev->dev;
@@ -1185,7 +1179,7 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 			GFP_KERNEL);
 
 	if (mcspi->dma_channels == NULL)
-		goto unmap_io;
+		goto free_master;
 
 	for (i = 0; i < master->num_chipselect; i++) {
 		char dma_ch_name[14];
@@ -1235,10 +1229,6 @@ disable_pm:
 	pm_runtime_disable(&pdev->dev);
 dma_chnl_free:
 	kfree(mcspi->dma_channels);
-unmap_io:
-	iounmap(mcspi->base);
-release_region:
-	release_mem_region(r->start, resource_size(r));
 free_master:
 	kfree(master);
 	platform_set_drvdata(pdev, NULL);
@@ -1250,8 +1240,6 @@ static int __devexit omap2_mcspi_remove(struct platform_device *pdev)
 	struct spi_master	*master;
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma	*dma_channels;
-	struct resource		*r;
-	void __iomem *base;
 
 	master = dev_get_drvdata(&pdev->dev);
 	mcspi = spi_master_get_devdata(master);
@@ -1259,12 +1247,8 @@ static int __devexit omap2_mcspi_remove(struct platform_device *pdev)
 
 	omap2_mcspi_disable_clocks(mcspi);
 	pm_runtime_disable(&pdev->dev);
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(r->start, resource_size(r));
 
-	base = mcspi->base;
 	spi_unregister_master(master);
-	iounmap(base);
 	kfree(dma_channels);
 	destroy_workqueue(mcspi->wq);
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.1


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
