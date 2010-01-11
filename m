From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 1/1] Regulator: Registering USB internal LDOs for TWL4030
Date: Mon, 11 Jan 2010 14:55:18 +0530
Message-ID: <1263201918-8185-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57417 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914Ab0AKJZa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 04:25:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

Adding member variables for USB internal LDOs in twl4030_platform_data
and registering them in twl-core.c if the variables are populated
from board-evm file.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 drivers/mfd/twl-core.c  |   12 ++++++++++++
 include/linux/i2c/twl.h |    4 ++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 2a76065..6cde051 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -791,6 +791,18 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 		child = add_regulator(TWL4030_REG_VAUX4, pdata->vaux4);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
+
+		child = add_regulator(TWL4030_REG_VUSB1V5, pdata->vusb1v5);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL4030_REG_VUSB1V8, pdata->vusb1v8);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL4030_REG_VUSB3V1, pdata->vusb3v1);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
 	}
 
 	/* twl6030 regulators */
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index bf1c5be..7be0b34 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -578,6 +578,10 @@ struct twl4030_platform_data {
 	struct regulator_init_data		*vintana1;
 	struct regulator_init_data		*vintana2;
 	struct regulator_init_data		*vintdig;
+	struct regulator_init_data		*vusb1v5;
+	struct regulator_init_data		*vusb1v8;
+	struct regulator_init_data		*vusb3v1;
+
 	/* TWL6030 LDO regulators */
 	struct regulator_init_data              *vmmc;
 	struct regulator_init_data              *vpp;
-- 
1.6.2.4

