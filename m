From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 7/8] IIO: ti_am335x_adc: Add DT support
Date: Fri, 18 Jan 2013 16:18:49 +0530
Message-ID: <cd7783f3c96ef38f95c1ee85736f115754feec68.1358502134.git.rachna@ti.com>
References: <cover.1358502134.git.rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <cover.1358502134.git.rachna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>

Add DT support for client ADC driver.

Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
---
 drivers/iio/adc/ti_am335x_adc.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index cd030e1..81ca8e5 100644
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
+					"adc-channels", &val32);
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
