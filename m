From: Adam YH Lee <adam.yh.lee@gmail.com>
Subject: [PATCH] [TWL4030 MADC] Fix ADC[3:6] readings
Date: Thu, 16 Jul 2015 15:20:27 -0700
Message-ID: <1437085227-28845-2-git-send-email-adam.yh.lee@gmail.com>
References: <1437085227-28845-1-git-send-email-adam.yh.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437085227-28845-1-git-send-email-adam.yh.lee@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Adam YH Lee <adam.yh.lee@gmail.com>
List-Id: linux-omap@vger.kernel.org

MADC[3:6] reads incorrect values without these two following changes:

- enable the 3v1 bias regulator for ADC[3:6]
- configure ADC[3:6] lines as input, not as USB

Signed-off-by: Adam YH Lee <adam.yh.lee@gmail.com>
---
 drivers/iio/adc/twl4030-madc.c | 14 ++++++++++++++
 drivers/phy/phy-twl4030-usb.c  |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 94c5f05..b5020ab 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -45,6 +45,7 @@
 #include <linux/types.h>
 #include <linux/gfp.h>
 #include <linux/err.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
 
@@ -52,6 +53,7 @@
  * struct twl4030_madc_data - a container for madc info
  * @dev:		Pointer to device structure for madc
  * @lock:		Mutex protecting this data structure
+ * @regulator:		Pointer to bias regulator for madc
  * @requests:		Array of request struct corresponding to SW1, SW2 and RT
  * @use_second_irq:	IRQ selection (main or co-processor)
  * @imr:		Interrupt mask register of MADC
@@ -60,6 +62,7 @@
 struct twl4030_madc_data {
 	struct device *dev;
 	struct mutex lock;	/* mutex protecting this data structure */
+	struct regulator *usb3v1;
 	struct twl4030_madc_request requests[TWL4030_MADC_NUM_METHODS];
 	bool use_second_irq;
 	u8 imr;
@@ -848,6 +851,14 @@ static int twl4030_madc_probe(struct platform_device *pdev)
 		goto err_i2c;
 	}
 
+	madc->usb3v1 = devm_regulator_get(madc->dev, "vusb3v1");
+	if (IS_ERR(madc->usb3v1))
+		return -ENODEV;
+
+	ret = regulator_enable(madc->usb3v1);
+	if (ret)
+		dev_err(madc->dev, "could not be enable 3v1 bias regulator\n");
+
 	return 0;
 
 err_i2c:
@@ -867,6 +878,9 @@ static int twl4030_madc_remove(struct platform_device *pdev)
 	twl4030_madc_set_current_generator(madc, 0, 0);
 	twl4030_madc_set_power(madc, 0);
 
+	regulator_disable(madc->usb3v1);
+	regulator_put(madc->usb3v1);
+
 	return 0;
 }
 
diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 7b04bef..88fc7d7 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -144,6 +144,9 @@
 #define PMBR1				0x0D
 #define GPIO_USB_4PIN_ULPI_2430C	(3 << 0)
 
+#define TWL4030_USB_SEL_MADC_MCPC	(1<<3)
+#define TWL4030_USB_CARKIT_ANA_CTRL	0xBB
+
 struct twl4030_usb {
 	struct usb_phy		phy;
 	struct device		*dev;
@@ -459,6 +462,10 @@ static int twl4030_phy_power_on(struct phy *phy)
 		twl4030_i2c_access(twl, 0);
 	schedule_delayed_work(&twl->id_workaround_work, 0);
 
+	twl4030_usb_write(twl, TWL4030_USB_CARKIT_ANA_CTRL,
+		twl4030_usb_read(twl, TWL4030_USB_CARKIT_ANA_CTRL) |
+		TWL4030_USB_SEL_MADC_MCPC);
+
 	return 0;
 }
 
-- 
2.1.4
