From: Steve Sakoman <sakoman@gmail.com>
Subject: [PATCH RFC] mfd: twl4030-madc: Enable ADC channels 3-6
Date: Thu, 8 Dec 2011 15:13:59 -0800
Message-ID: <CAGDS+n=QJNjCyfQ2zvPweC=aBDWt=n+y1ccgTAafqJCYt991yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63847 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab1LHXOA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 18:14:00 -0500
Received: by vcbfk14 with SMTP id fk14so1875732vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Dec 2011 15:14:00 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>, Kyle Manna <kyle@kylemanna.com>

Currently the driver does not explicitly set the TWL4030_USB_SEL_MADC_MCPC
bit to enable madc input channels 3 through 6.  This results in readings near
zero for these channels since the inputs are grounded if this bit is not set.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---

diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
index 834f824..56a8e9b 100644
--- a/drivers/mfd/twl4030-madc.c
+++ b/drivers/mfd/twl4030-madc.c
@@ -725,6 +725,23 @@ static int __devinit twl4030_madc_probe(struct
platform_device *pdev)
 	if (ret < 0)
 		goto err_current_generator;

+	/* Enable ADCIN3 through 6 */
+	ret = twl_i2c_read_u8(TWL4030_MODULE_USB,
+			      &regval, TWL4030_USB_CARKIT_ANA_CTRL);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to read reg CARKIT_ANA_CTRL 0x%X\n",
+			TWL4030_USB_CARKIT_ANA_CTRL);
+		goto err_i2c;
+	}
+	regval |= TWL4030_USB_SEL_MADC_MCPC;
+	ret = twl_i2c_write_u8(TWL4030_MODULE_USB,
+			       regval, TWL4030_USB_CARKIT_ANA_CTRL);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to write reg CARKIT_ANA_CTRL 0x%X\n",
+			TWL4030_USB_CARKIT_ANA_CTRL);
+		goto err_i2c;
+	}
+
 	ret = twl_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
 			      &regval, TWL4030_BCI_BCICTL1);
 	if (ret) {
diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/twl4030-madc.h
index 530e11b..f017495 100644
--- a/include/linux/i2c/twl4030-madc.h
+++ b/include/linux/i2c/twl4030-madc.h
@@ -120,6 +120,9 @@ enum sample_type {
 #define CURR_PSR_R1		44
 #define CURR_PSR_R2		88

+#define TWL4030_USB_CARKIT_ANA_CTRL	0xBB
+#define TWL4030_USB_SEL_MADC_MCPC	(1<<3)
+
 #define TWL4030_BCI_BCICTL1	0x23
 #define TWL4030_BCI_CGAIN	0x020
 #define TWL4030_BCI_MESBAT	(1 << 1)
