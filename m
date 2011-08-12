From: Kyle Manna <kyle@kylemanna.com>
Subject: [PATCH v2 2/4] mfd: twl4030-madc: turn on the MADC clock
Date: Thu, 11 Aug 2011 22:33:13 -0500
Message-ID: <1313119995-15382-3-git-send-email-kyle@kylemanna.com>
References: <CANOLnOPB=wFMPwqGbu9ufh__iM7TquUx3-o95R=gyJcae+gENg@mail.gmail.com>
 <1313119995-15382-1-git-send-email-kyle@kylemanna.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:43748 "EHLO
	homiemail-a67.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752282Ab1HLDeB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 23:34:01 -0400
In-Reply-To: <1313119995-15382-1-git-send-email-kyle@kylemanna.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kyle Manna <kyle@kylemanna.com>

Without turning the MADC clock on, no MADC conversions occur.

$ cat /sys/class/hwmon/hwmon0/device/in8_input
[   53.428436] twl4030_madc twl4030_madc: conversion timeout!
cat: read error: Resource temporarily unavailable

Signed-off-by: Kyle Manna <kyle@kylemanna.com>
---
 drivers/mfd/twl4030-madc.c       |   22 ++++++++++++++++++++++
 include/linux/i2c/twl4030-madc.h |    4 ++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
index cb44b53..99dd611 100644
--- a/drivers/mfd/twl4030-madc.c
+++ b/drivers/mfd/twl4030-madc.c
@@ -739,6 +739,28 @@ static int __devinit twl4030_madc_probe(struct platform_device *pdev)
 			TWL4030_BCI_BCICTL1);
 		goto err_i2c;
 	}
+
+	/* Check that MADC clock is on */
+	ret = twl_i2c_read_u8(TWL4030_MODULE_INTBR, &regval, TWL4030_REG_GPBR1);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to read reg GPBR1 0x%X\n",
+				TWL4030_REG_GPBR1);
+		goto err_i2c;
+	}
+
+	/* If MADC clk is not on, turn it on */
+	if (!(regval & TWL4030_GPBR1_MADC_HFCLK_EN)) {
+		dev_info(&pdev->dev, "clk disabled, enabling\n");
+		regval |= TWL4030_GPBR1_MADC_HFCLK_EN;
+		ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, regval,
+				       TWL4030_REG_GPBR1);
+		if (ret) {
+			dev_err(&pdev->dev, "unable to write reg GPBR1 0x%X\n",
+					TWL4030_REG_GPBR1);
+			goto err_i2c;
+		}
+	}
+
 	platform_set_drvdata(pdev, madc);
 	mutex_init(&madc->lock);
 	ret = request_threaded_irq(platform_get_irq(pdev, 0), NULL,
diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/twl4030-madc.h
index 6427d29..530e11b 100644
--- a/include/linux/i2c/twl4030-madc.h
+++ b/include/linux/i2c/twl4030-madc.h
@@ -129,6 +129,10 @@ enum sample_type {
 #define REG_BCICTL2             0x024
 #define TWL4030_BCI_ITHSENS	0x007
 
+/* Register and bits for GPBR1 register */
+#define TWL4030_REG_GPBR1		0x0c
+#define TWL4030_GPBR1_MADC_HFCLK_EN	(1 << 7)
+
 struct twl4030_madc_user_parms {
 	int channel;
 	int average;
-- 
1.7.4.1

