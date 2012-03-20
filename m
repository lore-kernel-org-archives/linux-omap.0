From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] spi: omap2-mcspi: make it behave as a module
Date: Tue, 20 Mar 2012 15:59:47 +0530
Message-ID: <1332239389-1897-2-git-send-email-shubhrajyoti@ti.com>
References: <1332239389-1897-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1332239389-1897-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

move probe away from __init section and use
platform_driver_register() instead of
platform_driver_probe().

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 0b0dfb7..5f4419e 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1080,7 +1080,7 @@ static int omap_mcspi_runtime_resume(struct device *dev)
 }
 
 
-static int __init omap2_mcspi_probe(struct platform_device *pdev)
+static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 {
 	struct spi_master	*master;
 	struct omap2_mcspi_platform_config *pdata = pdev->dev.platform_data;
@@ -1212,7 +1212,7 @@ free_master:
 	return status;
 }
 
-static int __exit omap2_mcspi_remove(struct platform_device *pdev)
+static int __devexit omap2_mcspi_remove(struct platform_device *pdev)
 {
 	struct spi_master	*master;
 	struct omap2_mcspi	*mcspi;
@@ -1287,13 +1287,14 @@ static struct platform_driver omap2_mcspi_driver = {
 		.owner =	THIS_MODULE,
 		.pm =		&omap2_mcspi_pm_ops
 	},
-	.remove =	__exit_p(omap2_mcspi_remove),
+	.probe =	omap2_mcspi_probe,
+	.remove =	__devexit_p(omap2_mcspi_remove),
 };
 
 
 static int __init omap2_mcspi_init(void)
 {
-	return platform_driver_probe(&omap2_mcspi_driver, omap2_mcspi_probe);
+	return platform_driver_register(&omap2_mcspi_driver);
 }
 subsys_initcall(omap2_mcspi_init);
 
-- 
1.7.1


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
