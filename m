From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 484/493] arm: remove use of __devexit
Date: Mon, 19 Nov 2012 13:27:13 -0500
Message-ID: <1353349642-3677-484-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41506 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338Ab2KSSfX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 13:35:23 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Russell King <linux@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Tony Lindgren <tony@atomide.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Eric Miao <eric.y.miao@gmail.com> 
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> 
Cc: Tony Lindgren <tony@atomide.com> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: davinci-linux-open-source@linux.davincidsp.com 
Cc: linux-omap@vger.kernel.org 
Cc: linux-samsung-soc@vger.kernel.org 
---
 arch/arm/common/scoop.c                  | 2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c | 2 +-
 arch/arm/mach-davinci/cdce949.c          | 2 +-
 arch/arm/mach-mmp/sram.c                 | 2 +-
 arch/arm/mach-omap1/mailbox.c            | 2 +-
 arch/arm/mach-omap2/gpmc.c               | 6 +++---
 arch/arm/mach-omap2/mailbox.c            | 2 +-
 arch/arm/mach-pxa/tosa-bt.c              | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c  | 2 +-
 arch/arm/mach-sa1100/neponset.c          | 2 +-
 arch/arm/mach-u300/dummyspichip.c        | 2 +-
 arch/arm/plat-omap/dma.c                 | 2 +-
 arch/arm/plat-omap/dmtimer.c             | 2 +-
 arch/arm/plat-pxa/ssp.c                  | 2 +-
 arch/arm/plat-samsung/adc.c              | 2 +-
 15 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index 2b62571..a5c3dc3 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -243,7 +243,7 @@ err_ioremap:
 	return ret;
 }
 
-static int __devexit scoop_remove(struct platform_device *pdev)
+static int scoop_remove(struct platform_device *pdev)
 {
 	struct scoop_dev *sdev = platform_get_drvdata(pdev);
 	int ret;
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 9211e88..6e2f163 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -358,7 +358,7 @@ static int cpld_video_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit cpld_video_remove(struct i2c_client *client)
+static int cpld_video_remove(struct i2c_client *client)
 {
 	cpld_client = NULL;
 	return 0;
diff --git a/arch/arm/mach-davinci/cdce949.c b/arch/arm/mach-davinci/cdce949.c
index 5086cbc..abafb92 100644
--- a/arch/arm/mach-davinci/cdce949.c
+++ b/arch/arm/mach-davinci/cdce949.c
@@ -256,7 +256,7 @@ static int cdce_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int __devexit cdce_remove(struct i2c_client *client)
+static int cdce_remove(struct i2c_client *client)
 {
 	cdce_i2c_client = NULL;
 	return 0;
diff --git a/arch/arm/mach-mmp/sram.c b/arch/arm/mach-mmp/sram.c
index 7e5765b..bf5e649 100644
--- a/arch/arm/mach-mmp/sram.c
+++ b/arch/arm/mach-mmp/sram.c
@@ -125,7 +125,7 @@ out:
 	return ret;
 }
 
-static int __devexit sram_remove(struct platform_device *pdev)
+static int sram_remove(struct platform_device *pdev)
 {
 	struct sram_bank_info *info;
 
diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index f2109dd..efc8f20 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -165,7 +165,7 @@ static int omap1_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit omap1_mbox_remove(struct platform_device *pdev)
+static int omap1_mbox_remove(struct platform_device *pdev)
 {
 	omap_mbox_unregister();
 	iounmap(mbox_base);
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2fc3dd4..e0d7982 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -684,7 +684,7 @@ static int gpmc_setup_irq(void)
 	return request_irq(gpmc_irq, gpmc_handle_irq, 0, "gpmc", NULL);
 }
 
-static __devexit int gpmc_free_irq(void)
+static int gpmc_free_irq(void)
 {
 	int i;
 
@@ -702,7 +702,7 @@ static __devexit int gpmc_free_irq(void)
 	return 0;
 }
 
-static void __devexit gpmc_mem_exit(void)
+static void gpmc_mem_exit(void)
 {
 	int cs;
 
@@ -804,7 +804,7 @@ static int gpmc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static __devexit int gpmc_remove(struct platform_device *pdev)
+static int gpmc_remove(struct platform_device *pdev)
 {
 	gpmc_free_irq();
 	gpmc_mem_exit();
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 1e48d5e..0b08026 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -395,7 +395,7 @@ static int omap2_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit omap2_mbox_remove(struct platform_device *pdev)
+static int omap2_mbox_remove(struct platform_device *pdev)
 {
 	omap_mbox_unregister();
 	iounmap(mbox_base);
diff --git a/arch/arm/mach-pxa/tosa-bt.c b/arch/arm/mach-pxa/tosa-bt.c
index 968f284..fc3646c 100644
--- a/arch/arm/mach-pxa/tosa-bt.c
+++ b/arch/arm/mach-pxa/tosa-bt.c
@@ -102,7 +102,7 @@ err_reset:
 	return rc;
 }
 
-static int __devexit tosa_bt_remove(struct platform_device *dev)
+static int tosa_bt_remove(struct platform_device *dev)
 {
 	struct tosa_bt_data *data = dev->dev.platform_data;
 	struct rfkill *rfk = platform_get_drvdata(dev);
diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index 08bd8fc..45e7436 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -126,7 +126,7 @@ err_nogpio:
 	return ret;
 }
 
-static int __devexit osiris_dvs_remove(struct platform_device *pdev)
+static int osiris_dvs_remove(struct platform_device *pdev)
 {
 	dev_info(&pdev->dev, "exiting\n");
 
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 195d8bb..c229d25 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -368,7 +368,7 @@ static int neponset_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int __devexit neponset_remove(struct platform_device *dev)
+static int neponset_remove(struct platform_device *dev)
 {
 	struct neponset_drvdata *d = platform_get_drvdata(dev);
 	int irq = platform_get_irq(dev, 0);
diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
index f7a2a92..2785cb6 100644
--- a/arch/arm/mach-u300/dummyspichip.c
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -251,7 +251,7 @@ out_dev_create_looptest_failed:
 	return status;
 }
 
-static int __devexit pl022_dummy_remove(struct spi_device *spi)
+static int pl022_dummy_remove(struct spi_device *spi)
 {
 	struct dummy *p_dummy = dev_get_drvdata(&spi->dev);
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index d33e814..b7d78ba 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2116,7 +2116,7 @@ exit_dma_lch_fail:
 	return ret;
 }
 
-static int __devexit omap_system_dma_remove(struct platform_device *pdev)
+static int omap_system_dma_remove(struct platform_device *pdev)
 {
 	int dma_irq;
 
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 97903e9..35acfab 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -762,7 +762,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
  * In addition to freeing platform resources it also deletes the timer
  * entry from the local list.
  */
-static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
+static int omap_dm_timer_remove(struct platform_device *pdev)
 {
 	struct omap_dm_timer *timer;
 	unsigned long flags;
diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index caa33eb..8e11e96 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -164,7 +164,7 @@ err_free:
 	return ret;
 }
 
-static int __devexit pxa_ssp_remove(struct platform_device *pdev)
+static int pxa_ssp_remove(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct ssp_device *ssp;
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 010dde6..99ca1e6 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -433,7 +433,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit s3c_adc_remove(struct platform_device *pdev)
+static int s3c_adc_remove(struct platform_device *pdev)
 {
 	struct adc_device *adc = platform_get_drvdata(pdev);
 
-- 
1.8.0

