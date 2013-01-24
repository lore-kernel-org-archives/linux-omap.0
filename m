From: "Patil, Rachna" <rachna@ti.com>
Subject: [PATCH v4 7/8] IIO: ti_am335x_adc: Add DT support
Date: Thu, 24 Jan 2013 09:15:11 +0530
Message-ID: <1358999112-31192-8-git-send-email-rachna@ti.com>
References: <1358999112-31192-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1358999112-31192-1-git-send-email-rachna@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Rob Herring <rob.herring@calxeda.com>, Jonathan Cameron <jic23@cam.ac.uk>, Tony Lindgren <tony@atomide.com>, Benit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, gururaja.hebbar@ti.com, "Patil, Rachna" <rachna@ti.com>
List-Id: linux-omap@vger.kernel.org

From: "Patil, Rachna" <rachna@ti.com>

Add DT support for client ADC driver.

Signed-off-by: Patil, Rachna <rachna@ti.com>
---
Changes in v4:
	Non-standard properties prefixed with vendor name.

 drivers/iio/adc/ti_am335x_adc.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index cd030e1..8e7b089 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -22,6 +22,8 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/iio/iio.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 #include <linux/platform_data/ti_am335x_adc.h>
@@ -141,11 +143,12 @@ static int tiadc_probe(struct platform_device *pdev)
 	struct iio_dev		*indio_dev;
 	struct tiadc_device	*adc_dev;
 	struct ti_tscadc_dev	*tscadc_dev = pdev->dev.platform_data;
-	struct mfd_tscadc_board	*pdata;
+	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
+	struct device_node	*node = tscadc_dev->dev->of_node;
 	int			err;
+	u32			val32;
 
-	pdata = tscadc_dev->dev->platform_data;
-	if (!pdata || !pdata->adc_init) {
+	if (!pdata && !node) {
 		dev_err(&pdev->dev, "Could not find platform data\n");
 		return -EINVAL;
 	}
@@ -159,7 +162,22 @@ static int tiadc_probe(struct platform_device *pdev)
 	adc_dev = iio_priv(indio_dev);
 
 	adc_dev->mfd_tscadc = tscadc_dev;
-	adc_dev->channels = pdata->adc_init->adc_channels;
+
+	if (pdata)
+		adc_dev->channels = pdata->adc_init->adc_channels;
+	else {
+		node = of_find_node_by_name(node, "adc");
+		if (!node)
+			return  -EINVAL;
+		else {
+			err = of_property_read_u32(node,
+					"ti,adc-channels", &val32);
+			if (err < 0)
+				goto err_free_device;
+			else
+				adc_dev->channels = val32;
+		}
+	}
 
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->name = dev_name(&pdev->dev);
-- 
1.7.9.5

