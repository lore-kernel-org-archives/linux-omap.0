From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 2/2] iio: adc: ti_am335x_tscadc: Improve accuracy of measurement
Date: Mon, 3 Dec 2018 13:31:18 +0530
Message-ID: <20181203080118.17504-3-vigneshr@ti.com>
References: <20181203080118.17504-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203080118.17504-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Vignesh R <vigneshr@ti.com>, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When performing single ended measurements with TSCADC, its recommended
to set negative input (SEL_INM_SWC_3_0) of ADC step to ADC's VREFN in the
corresponding STEP_CONFIGx register.
Also, the positive(SEL_RFP_SWC_2_0) and negative(SEL_RFM_SWC_1_0)
reference voltage for ADC step needs to be set to VREFP and VREFN
respectively in STEP_CONFIGx register.
Without these changes, there may be variation of as much as ~2% in the
ADC's digital output which is bad for precise measurement.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---

v2: No change

 drivers/iio/adc/ti_am335x_adc.c      | 5 ++++-
 include/linux/mfd/ti_am335x_tscadc.h | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index cafb1dcadc48..9d984f2a8ba7 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -142,7 +142,10 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 			stepconfig |= STEPCONFIG_MODE_SWCNT;
 
 		tiadc_writel(adc_dev, REG_STEPCONFIG(steps),
-				stepconfig | STEPCONFIG_INP(chan));
+				stepconfig | STEPCONFIG_INP(chan) |
+				STEPCONFIG_INM_ADCREFM |
+				STEPCONFIG_RFP_VREFP |
+				STEPCONFIG_RFM_VREFN);
 
 		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MASK) {
 			dev_warn(dev, "chan %d open delay truncating to 0x3FFFF\n",
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index b9a53e013bff..483168403ae5 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -78,6 +78,8 @@
 #define STEPCONFIG_YNN		BIT(8)
 #define STEPCONFIG_XNP		BIT(9)
 #define STEPCONFIG_YPN		BIT(10)
+#define STEPCONFIG_RFP(val)	((val) << 12)
+#define STEPCONFIG_RFP_VREFP	(0x3 << 12)
 #define STEPCONFIG_INM_MASK	(0xF << 15)
 #define STEPCONFIG_INM(val)	((val) << 15)
 #define STEPCONFIG_INM_ADCREFM	STEPCONFIG_INM(8)
@@ -86,6 +88,8 @@
 #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
 #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
 #define STEPCONFIG_FIFO1	BIT(26)
+#define STEPCONFIG_RFM(val)	((val) << 23)
+#define STEPCONFIG_RFM_VREFN	(0x3 << 23)
 
 /* Delay register */
 #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
-- 
2.19.2
