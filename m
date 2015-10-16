From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 2/3] iio:adc:palmas: add DT support
Date: Fri, 16 Oct 2015 14:53:39 +0200
Message-ID: <79429ca1a6d0465b6b19ede16d90de23e4363431.1445000017.git.hns@goldelico.com>
References: <cover.1445000017.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1445000017.git.hns@goldelico.com>
In-Reply-To: <cover.1445000017.git.hns@goldelico.com>
References: <cover.1445000017.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Marek Belisko <marek@goldelico.com>, Pradeep Goudagunta <pgoudagunta@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Graeme Gregory <gg@slimlogic.co.uk>, jic23@jic23.retrosnub.co.uk, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-iio@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

From: Marek Belisko <marek@goldelico.com>

Code was found at:
https://android.googlesource.com/kernel/tegra/+/a90856a6626d502d42c6e7abccbdf9d730b36270%5E%21/#F1

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Marek Belisko <marek@goldelico.com> [Fixed minor typos + add channels list to documentation]
---
 .../devicetree/bindings/iio/adc/palmas-gpadc.txt   | 48 ++++++++++++++++++++
 drivers/iio/adc/palmas_gpadc.c                     | 52 +++++++++++++++++++---
 2 files changed, 95 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
new file mode 100644
index 0000000..a6de996
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
@@ -0,0 +1,48 @@
+* Palmas general purpose ADC IP block devicetree bindings
+
+Channels list:
+	0 battery type
+	1 battery temp NTC (optional current source)
+	2 GP
+	3 temp (with ext. diode, optional current source)
+	4 GP
+	5 GP
+	6 VBAT_SENSE
+	7 VCC_SENSE
+	8 Backup Battery voltage
+	9 external charger (VCHG)
+	10 VBUS
+	11 DC-DC current probe (how does this work?)
+	12 internal die temp
+	13 internal die temp
+	14 USB ID pin voltage
+	15 test network
+
+Required properties:
+- compatible : Must be "ti,palmas-gpadc".
+- #io-channel-cells: Should be set to <1>.
+
+Optional sub-nodes:
+ti,channel0-current-microamp: Channel 0 current in uA.
+	Values are rounded to derive 0uA, 5uA, 15uA, 20uA.
+ti,channel3-current-microamp: Channel 3 current in uA.
+	Valid are rounded to derive 0uA, 10uA, 400uA, 800uA.
+ti,enable-extended-delay: Enable extended delay.
+
+Example:
+
+pmic {
+	compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
+	...
+	gpadc {
+		compatible = "ti,palmas-gpadc";
+		interrupts = <18 0
+			      16 0
+			      17 0>;
+		#io-channel-cells = <1>;
+		ti,channel0-current-microamp = <5>;
+		ti,channel3-current-microamp = <10>;
+		};
+	};
+	...
+};
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 71763c5..f42eb8a 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -21,6 +21,8 @@
 #include <linux/pm.h>
 #include <linux/mfd/palmas.h>
 #include <linux/completion.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/machine.h>
 #include <linux/iio/driver.h>
@@ -460,6 +462,34 @@ static const struct iio_chan_spec palmas_gpadc_iio_channel[] = {
 	PALMAS_ADC_CHAN_IIO(IN15, IIO_VOLTAGE, IIO_CHAN_INFO_PROCESSED),
 };
 
+static int palmas_gpadc_get_adc_dt_data(struct platform_device *pdev,
+	struct palmas_gpadc_platform_data **gpadc_pdata)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct palmas_gpadc_platform_data *gp_data;
+	int ret;
+	u32 pval;
+
+	gp_data = devm_kzalloc(&pdev->dev, sizeof(*gp_data), GFP_KERNEL);
+	if (!gp_data)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(np, "ti,channel0-current-microamp", &pval);
+	if (!ret)
+		gp_data->ch0_current = pval;
+
+	ret = of_property_read_u32(np, "ti,channel3-current-microamp", &pval);
+	if (!ret)
+		gp_data->ch3_current = pval;
+
+	gp_data->extended_delay = of_property_read_bool(np,
+					"ti,enable-extended-delay");
+
+	*gpadc_pdata = gp_data;
+
+	return 0;
+}
+
 static int palmas_gpadc_probe(struct platform_device *pdev)
 {
 	struct palmas_gpadc *adc;
@@ -469,12 +499,17 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 	int ret, i;
 
 	pdata = dev_get_platdata(pdev->dev.parent);
-	if (!pdata || !pdata->gpadc_pdata) {
-		dev_err(&pdev->dev, "No platform data\n");
-		return -ENODEV;
-	}
 
-	gpadc_pdata = pdata->gpadc_pdata;
+	if (pdata && pdata->gpadc_pdata)
+		gpadc_pdata = pdata->gpadc_pdata;
+
+	if (!gpadc_pdata && pdev->dev.of_node) {
+		ret = palmas_gpadc_get_adc_dt_data(pdev, &gpadc_pdata);
+		if (ret < 0)
+			return ret;
+	}
+	if (!gpadc_pdata)
+		return -EINVAL;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
 	if (!indio_dev) {
@@ -790,12 +825,19 @@ static const struct dev_pm_ops palmas_pm_ops = {
 				palmas_gpadc_resume)
 };
 
+static const struct of_device_id of_palmas_gpadc_match_tbl[] = {
+	{ .compatible = "ti,palmas-gpadc", },
+	{ /* end */ }
+};
+MODULE_DEVICE_TABLE(of, of_palmas_gpadc_match_tbl);
+
 static struct platform_driver palmas_gpadc_driver = {
 	.probe = palmas_gpadc_probe,
 	.remove = palmas_gpadc_remove,
 	.driver = {
 		.name = MOD_NAME,
 		.pm = &palmas_pm_ops,
+		.of_match_table = of_palmas_gpadc_match_tbl,
 	},
 };
 
-- 
2.5.1
