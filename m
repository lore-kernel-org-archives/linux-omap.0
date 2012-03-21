From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] spi: omap2_mcspi: Make the runtime functions depend on
	CONFIG_PM_RUNTIME
Date: Wed, 21 Mar 2012 11:33:15 +0530
Message-ID: <1332309795-5075-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Shubhrajyoti, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Makes the function omap_mcspi_runtime_resume depend on CONFIG_PM_RUNTIME.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |   41 +++++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index cb2c0e3..f9d694d 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -248,23 +248,6 @@ static void omap2_mcspi_set_master_mode(struct spi_master *master)
 	omap2_mcspi_ctx[master->bus_num - 1].modulctrl = l;
 }
 
-static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
-{
-	struct spi_master *spi_cntrl;
-	struct omap2_mcspi_cs *cs;
-	spi_cntrl = mcspi->master;
-
-	/* McSPI: context restore */
-	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
-			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl);
-
-	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
-			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
-
-	list_for_each_entry(cs, &omap2_mcspi_ctx[spi_cntrl->bus_num - 1].cs,
-			node)
-		__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
-}
 static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
 {
 	pm_runtime_put_sync(mcspi->dev);
@@ -1066,6 +1049,26 @@ static int __init omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
+{
+	struct spi_master *spi_cntrl;
+	struct omap2_mcspi_cs *cs;
+
+	spi_cntrl = mcspi->master;
+
+	/* McSPI: context restore */
+	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
+			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl);
+
+	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
+			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
+
+	list_for_each_entry(cs, &omap2_mcspi_ctx[spi_cntrl->bus_num - 1].cs,
+			node)
+		__raw_writel(cs->chconf0, cs->base + OMAP2_MCSPI_CHCONF0);
+}
+
 static int omap_mcspi_runtime_resume(struct device *dev)
 {
 	struct omap2_mcspi	*mcspi;
@@ -1077,7 +1080,9 @@ static int omap_mcspi_runtime_resume(struct device *dev)
 
 	return 0;
 }
-
+#else
+#define	omap_mcspi_runtime_resume	NULL
+#endif
 
 static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 {
-- 
1.7.1


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
