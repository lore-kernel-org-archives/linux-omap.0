From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 5/5] spi: omap2-mcspi: add support for pm_runtime
	autosuspend
Date: Mon, 26 Mar 2012 19:14:40 +0530
Message-ID: <1332769480-28069-6-git-send-email-shubhrajyoti@ti.com>
References: <1332769480-28069-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1332769480-28069-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
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

Adds support for configuring the omap2-mcspi driver use autosuspend for
runtime power management. This can reduce the latency in starting an
spi transfer by not suspending the device immediately following
completion of a transfer. If another transfer then takes place before
the autosuspend timeout (2 secs), the call to resume the device can
return immediately saving some save/ restore cycles.

Acked-by: Govindraj.R <govindraj.raja-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 1907ed2..0b0da2f 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -44,6 +44,7 @@
 #include <plat/mcspi.h>
 
 #define OMAP2_MCSPI_MAX_FREQ		48000000
+#define SPI_AUTOSUSPEND_TIMEOUT		2000
 
 #define OMAP2_MCSPI_REVISION		0x00
 #define OMAP2_MCSPI_SYSSTATUS		0x14
@@ -265,7 +266,8 @@ static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
 }
 static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
 {
-	pm_runtime_put_sync(mcspi->dev);
+	pm_runtime_mark_last_busy(mcspi->dev);
+	pm_runtime_put_autosuspend(mcspi->dev);
 }
 
 static int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
@@ -1212,6 +1214,8 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 	if (status < 0)
 		goto dma_chnl_free;
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_enable(&pdev->dev);
 
 	if (status || omap2_mcspi_master_setup(mcspi) < 0)
-- 
1.7.1


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
