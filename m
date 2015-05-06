From: pascal.huerst@gmail.com
Subject: [PATCH v4] i2c: omap: Add calls for pinctrl state select
Date: Wed,  6 May 2015 15:07:04 +0200
Message-ID: <1430917624-18164-1-git-send-email-pascal.huerst@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36124 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbEFNHP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2015 09:07:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wsa@the-dreams.de
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, nsekhar@ti.com, Pascal Huerst <pascal.huerst@gmail.com>

From: Pascal Huerst <pascal.huerst@gmail.com>

This adds calls to pinctrl subsystem in order to switch pin states
on suspend/resume if you provide a "sleep" state in DT.

If no "sleep" state is provided in the DT, these calls turn
to NOPs, so we don't need error checking here.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 0e89419..8261941 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>

 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -1423,6 +1424,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 		omap_i2c_read_reg(_dev, OMAP_I2C_STAT_REG);
 	}

+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }

@@ -1431,6 +1434,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);

+	pinctrl_pm_select_default_state(dev);
+
 	if (!_dev->regs)
 		return 0;

--
2.1.0

