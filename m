From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 032/493] arm: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:19:41 -0500
Message-ID: <1353349642-3677-32-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Tony Lindgren <tony@atomide.com> 
Cc: Eric Miao <eric.y.miao@gmail.com> 
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: davinci-linux-open-source@linux.davincidsp.com 
Cc: linux-omap@vger.kernel.org 
Cc: linux-samsung-soc@vger.kernel.org 
---
 arch/arm/common/scoop.c                 | 2 +-
 arch/arm/mach-davinci/cdce949.c         | 2 +-
 arch/arm/mach-omap1/mailbox.c           | 2 +-
 arch/arm/mach-omap2/gpmc.c              | 2 +-
 arch/arm/mach-omap2/mailbox.c           | 2 +-
 arch/arm/mach-pxa/tosa-bt.c             | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
 arch/arm/mach-sa1100/neponset.c         | 2 +-
 arch/arm/mach-u300/dummyspichip.c       | 2 +-
 arch/arm/plat-omap/dma.c                | 2 +-
 arch/arm/plat-omap/dmtimer.c            | 2 +-
 arch/arm/plat-pxa/ssp.c                 | 2 +-
 arch/arm/plat-samsung/adc.c             | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index 0c616d5..7cac8dd 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -268,7 +268,7 @@ static int __devexit scoop_remove(struct platform_device *pdev)
 
 static struct platform_driver scoop_driver = {
 	.probe		= scoop_probe,
-	.remove		= __devexit_p(scoop_remove),
+	.remove		= scoop_remove,
 	.suspend	= scoop_suspend,
 	.resume		= scoop_resume,
 	.driver		= {
diff --git a/arch/arm/mach-davinci/cdce949.c b/arch/arm/mach-davinci/cdce949.c
index f2232ca..5086cbc 100644
--- a/arch/arm/mach-davinci/cdce949.c
+++ b/arch/arm/mach-davinci/cdce949.c
@@ -274,7 +274,7 @@ static struct i2c_driver cdce_driver = {
 		.name	= "cdce949",
 	},
 	.probe		= cdce_probe,
-	.remove		= __devexit_p(cdce_remove),
+	.remove		= cdce_remove,
 	.id_table	= cdce_id,
 };
 
diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index e962926..e7e1f2a 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -174,7 +174,7 @@ static int __devexit omap1_mbox_remove(struct platform_device *pdev)
 
 static struct platform_driver omap1_mbox_driver = {
 	.probe	= omap1_mbox_probe,
-	.remove	= __devexit_p(omap1_mbox_remove),
+	.remove	= omap1_mbox_remove,
 	.driver	= {
 		.name	= "omap-mailbox",
 	},
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index bf6117c..b4226a4 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -814,7 +814,7 @@ static __devexit int gpmc_remove(struct platform_device *pdev)
 
 static struct platform_driver gpmc_driver = {
 	.probe		= gpmc_probe,
-	.remove		= __devexit_p(gpmc_remove),
+	.remove		= gpmc_remove,
 	.driver		= {
 		.name	= DEVICE_NAME,
 		.owner	= THIS_MODULE,
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 0d97456..64308f4 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -404,7 +404,7 @@ static int __devexit omap2_mbox_remove(struct platform_device *pdev)
 
 static struct platform_driver omap2_mbox_driver = {
 	.probe = omap2_mbox_probe,
-	.remove = __devexit_p(omap2_mbox_remove),
+	.remove = omap2_mbox_remove,
 	.driver = {
 		.name = "omap-mailbox",
 	},
diff --git a/arch/arm/mach-pxa/tosa-bt.c b/arch/arm/mach-pxa/tosa-bt.c
index b9b1e5c..968f284 100644
--- a/arch/arm/mach-pxa/tosa-bt.c
+++ b/arch/arm/mach-pxa/tosa-bt.c
@@ -125,7 +125,7 @@ static int __devexit tosa_bt_remove(struct platform_device *dev)
 
 static struct platform_driver tosa_bt_driver = {
 	.probe = tosa_bt_probe,
-	.remove = __devexit_p(tosa_bt_remove),
+	.remove = tosa_bt_remove,
 
 	.driver = {
 		.name = "tosa-bt",
diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index 5876c6b..b7b712b 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -167,7 +167,7 @@ static const struct dev_pm_ops osiris_dvs_pm = {
 
 static struct platform_driver osiris_dvs_driver = {
 	.probe		= osiris_dvs_probe,
-	.remove		= __devexit_p(osiris_dvs_remove),
+	.remove		= osiris_dvs_remove,
 	.driver		= {
 		.name	= "osiris-dvs",
 		.owner	= THIS_MODULE,
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 266db87..c408b8b 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -420,7 +420,7 @@ static const struct dev_pm_ops neponset_pm_ops = {
 
 static struct platform_driver neponset_device_driver = {
 	.probe		= neponset_probe,
-	.remove		= __devexit_p(neponset_remove),
+	.remove		= neponset_remove,
 	.driver		= {
 		.name	= "neponset",
 		.owner	= THIS_MODULE,
diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
index 03f7936..7c06188 100644
--- a/arch/arm/mach-u300/dummyspichip.c
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -269,7 +269,7 @@ static struct spi_driver pl022_dummy_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= pl022_dummy_probe,
-	.remove	= __devexit_p(pl022_dummy_remove),
+	.remove	= pl022_dummy_remove,
 };
 
 static int __init pl022_init_dummy(void)
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c288b76..3317867 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2140,7 +2140,7 @@ static int __devexit omap_system_dma_remove(struct platform_device *pdev)
 
 static struct platform_driver omap_system_dma_driver = {
 	.probe		= omap_system_dma_probe,
-	.remove		= __devexit_p(omap_system_dma_remove),
+	.remove		= omap_system_dma_remove,
 	.driver		= {
 		.name	= "omap_dma_system"
 	},
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 82231a7..4a40f25 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -782,7 +782,7 @@ static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
 
 static struct platform_driver omap_dm_timer_driver = {
 	.probe  = omap_dm_timer_probe,
-	.remove = __devexit_p(omap_dm_timer_remove),
+	.remove = omap_dm_timer_remove,
 	.driver = {
 		.name   = "omap_timer",
 	},
diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 584c9bf..def0648 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -199,7 +199,7 @@ static const struct platform_device_id ssp_id_table[] = {
 
 static struct platform_driver pxa_ssp_driver = {
 	.probe		= pxa_ssp_probe,
-	.remove		= __devexit_p(pxa_ssp_remove),
+	.remove		= pxa_ssp_remove,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "pxa2xx-ssp",
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index b1e05cc..010dde6 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -538,7 +538,7 @@ static struct platform_driver s3c_adc_driver = {
 		.pm	= &adc_pm_ops,
 	},
 	.probe		= s3c_adc_probe,
-	.remove		= __devexit_p(s3c_adc_remove),
+	.remove		= s3c_adc_remove,
 };
 
 static int __init adc_init(void)
-- 
1.8.0
