From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi/omap100k: Convert to runtime PM
Date: Wed, 10 Dec 2014 18:16:52 +0000
Message-ID: <1418235412-10867-1-git-send-email-broonie@kernel.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently the omap100k driver uses prepare and unprepare transfer hardware
to enable and disable clocks for the IP block. Since these functions are
called along with runtime PM and end up duplicating its functionality in a
less flexible fashion we are trying to phase them out so convert this
driver to do runtime PM instead.

While doing so add missing error handling and remove a redundant NULL
assignment.

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap-100k.c | 101 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 79399ae9c84c..ea70494aae12 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -29,6 +29,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -299,16 +300,6 @@ static int omap1_spi100k_setup(struct spi_device *spi)
 	return ret;
 }
 
-static int omap1_spi100k_prepare_hardware(struct spi_master *master)
-{
-	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
-
-	clk_prepare_enable(spi100k->ick);
-	clk_prepare_enable(spi100k->fck);
-
-	return 0;
-}
-
 static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 					      struct spi_message *m)
 {
@@ -377,16 +368,6 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 	return status;
 }
 
-static int omap1_spi100k_unprepare_hardware(struct spi_master *master)
-{
-	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
-
-	clk_disable_unprepare(spi100k->ick);
-	clk_disable_unprepare(spi100k->fck);
-
-	return 0;
-}
-
 static int omap1_spi100k_probe(struct platform_device *pdev)
 {
 	struct spi_master       *master;
@@ -407,14 +388,12 @@ static int omap1_spi100k_probe(struct platform_device *pdev)
 
 	master->setup = omap1_spi100k_setup;
 	master->transfer_one_message = omap1_spi100k_transfer_one_message;
-	master->prepare_transfer_hardware = omap1_spi100k_prepare_hardware;
-	master->unprepare_transfer_hardware = omap1_spi100k_unprepare_hardware;
-	master->cleanup = NULL;
 	master->num_chipselect = 2;
 	master->mode_bits = MODEBITS;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->min_speed_hz = OMAP1_SPI100K_MAX_FREQ/(1<<16);
 	master->max_speed_hz = OMAP1_SPI100K_MAX_FREQ;
+	master->auto_runtime_pm = true;
 
 	spi100k = spi_master_get_devdata(master);
 
@@ -439,22 +418,96 @@ static int omap1_spi100k_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	status = clk_prepare_enable(spi100k->ick);
+	if (status != 0) {
+		dev_err(&pdev->dev, "failed to enable ick: %d\n", status);
+		goto err;
+	}
+
+	status = clk_prepare_enable(spi100k->fck);
+	if (status != 0) {
+		dev_err(&pdev->dev, "failed to enable fck: %d\n", status);
+		goto err_ick;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+
 	status = devm_spi_register_master(&pdev->dev, master);
 	if (status < 0)
-		goto err;
+		goto err_fck;
 
 	return status;
 
+err_fck:
+	clk_disable_unprepare(spi100k->fck);
+err_ick:
+	clk_disable_unprepare(spi100k->ick);
 err:
 	spi_master_put(master);
 	return status;
 }
 
+static int omap1_spi100k_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
+	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
+
+	pm_runtime_disable(&pdev->dev);
+
+	clk_disable_unprepare(spi100k->fck);
+	clk_disable_unprepare(spi100k->ick);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int omap1_spi100k_runtime_suspend(struct device *dev)
+{
+	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
+	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(spi100k->ick);
+	clk_disable_unprepare(spi100k->fck);
+
+	return 0;
+}
+
+static int omap1_spi100k_runtime_resume(struct device *dev)
+{
+	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
+	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
+	int ret;
+
+	ret = clk_prepare_enable(spi100k->ick);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable ick: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(spi100k->fck);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable fck: %d\n", ret);
+		clk_disable_unprepare(spi100k->ick);
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops omap1_spi100k_pm = {
+	SET_RUNTIME_PM_OPS(omap1_spi100k_runtime_suspend,
+			   omap1_spi100k_runtime_resume, NULL)
+};
+
 static struct platform_driver omap1_spi100k_driver = {
 	.driver = {
 		.name		= "omap1_spi100k",
+		.pm		= &omap1_spi100k_pm,
 	},
 	.probe		= omap1_spi100k_probe,
+	.remove		= omap1_spi100k_remove,
 };
 
 module_platform_driver(omap1_spi100k_driver);
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
