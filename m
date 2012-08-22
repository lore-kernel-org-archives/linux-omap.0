From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 1/3] spi: omap2-mcspi: Call pm_runtime_* functions directly
Date: Wed, 22 Aug 2012 11:35:12 +0530
Message-ID: <1345615515-26745-2-git-send-email-shubhrajyoti@ti.com>
References: <1345615515-26745-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1345615515-26745-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Call the pm_runtime functions directly making room for possible
pm optimisations. Also the runtime functions aren't just about
enabling and disabling of clocks though it does enable clocks also.

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |   28 +++++++++++-----------------
 1 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index b2fb141..f542f3d 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -260,16 +260,6 @@ static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 	list_for_each_entry(cs, &ctx->cs, node)
 		__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
 }
-static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
-{
-	pm_runtime_mark_last_busy(mcspi->dev);
-	pm_runtime_put_autosuspend(mcspi->dev);
-}
-
-static int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
-{
-	return pm_runtime_get_sync(mcspi->dev);
-}
 
 static int omap2_prepare_transfer(struct spi_master *master)
 {
@@ -848,12 +838,13 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 			return ret;
 	}
 
-	ret = omap2_mcspi_enable_clocks(mcspi);
+	ret = pm_runtime_get_sync(mcspi->dev);
 	if (ret < 0)
 		return ret;
 
 	ret = omap2_mcspi_setup_transfer(spi, NULL);
-	omap2_mcspi_disable_clocks(mcspi);
+	pm_runtime_mark_last_busy(mcspi->dev);
+	pm_runtime_put_autosuspend(mcspi->dev);
 
 	return ret;
 }
@@ -1067,7 +1058,7 @@ static int __devinit omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
 	int			ret = 0;
 
-	ret = omap2_mcspi_enable_clocks(mcspi);
+	ret = pm_runtime_get_sync(mcspi->dev);
 	if (ret < 0)
 		return ret;
 
@@ -1076,7 +1067,8 @@ static int __devinit omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
 	ctx->wakeupenable = OMAP2_MCSPI_WAKEUPENABLE_WKEN;
 
 	omap2_mcspi_set_master_mode(master);
-	omap2_mcspi_disable_clocks(mcspi);
+	pm_runtime_mark_last_busy(mcspi->dev);
+	pm_runtime_put_autosuspend(mcspi->dev);
 	return 0;
 }
 
@@ -1252,7 +1244,8 @@ static int __devexit omap2_mcspi_remove(struct platform_device *pdev)
 	mcspi = spi_master_get_devdata(master);
 	dma_channels = mcspi->dma_channels;
 
-	omap2_mcspi_disable_clocks(mcspi);
+	pm_runtime_mark_last_busy(mcspi->dev);
+	pm_runtime_put_autosuspend(mcspi->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	spi_unregister_master(master);
@@ -1278,7 +1271,7 @@ static int omap2_mcspi_resume(struct device *dev)
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
 	struct omap2_mcspi_cs	*cs;
 
-	omap2_mcspi_enable_clocks(mcspi);
+	pm_runtime_get_sync(mcspi->dev);
 	list_for_each_entry(cs, &ctx->cs, node) {
 		if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_FORCE) == 0) {
 			/*
@@ -1291,7 +1284,8 @@ static int omap2_mcspi_resume(struct device *dev)
 			__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
 		}
 	}
-	omap2_mcspi_disable_clocks(mcspi);
+	pm_runtime_mark_last_busy(mcspi->dev);
+	pm_runtime_put_autosuspend(mcspi->dev);
 	return 0;
 }
 #else
-- 
1.7.5.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
