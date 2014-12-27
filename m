From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 6/7] mfd: menelaus: make vcore and regulator controls internal
Date: Sat, 27 Dec 2014 19:52:58 +0200
Message-ID: <1419702779-16001-7-git-send-email-aaro.koskinen@iki.fi>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:45563 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbaL0RxW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Dec 2014 12:53:22 -0500
In-Reply-To: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Make vcore and regulator control functions internal to the driver.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mfd/menelaus.c       | 13 +++++++++++--
 include/linux/mfd/menelaus.h | 12 ------------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 4a900cc..8660adf 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -163,6 +163,15 @@
 #define MCT_PIN_ST_S1_CD_ST		(1 << 0)
 #define MCT_PIN_ST_S2_CD_ST		(1 << 1)
 
+#define EN_VPLL_SLEEP			(1 << 7)
+#define EN_VMMC_SLEEP			(1 << 6)
+#define EN_VAUX_SLEEP			(1 << 5)
+#define EN_VIO_SLEEP			(1 << 4)
+#define EN_VMEM_SLEEP			(1 << 3)
+#define EN_DC3_SLEEP			(1 << 2)
+#define EN_DC2_SLEEP			(1 << 1)
+#define EN_VC_SLEEP			(1 << 0)
+
 static void menelaus_work(struct work_struct *_menelaus);
 
 struct menelaus_chip {
@@ -534,7 +543,7 @@ static const struct menelaus_vtg_value vcore_values[] = {
 	{ 1450, 18 },
 };
 
-int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int floor_mV)
+static int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int floor_mV)
 {
 	int fval, rval, val, ret;
 	struct i2c_client *c = the_menelaus->client;
@@ -743,7 +752,7 @@ int menelaus_get_slot_pin_states(void)
 }
 EXPORT_SYMBOL(menelaus_get_slot_pin_states);
 
-int menelaus_set_regulator_sleep(int enable, u32 val)
+static int menelaus_set_regulator_sleep(int enable, u32 val)
 {
 	int t, ret;
 	struct i2c_client *c = the_menelaus->client;
diff --git a/include/linux/mfd/menelaus.h b/include/linux/mfd/menelaus.h
index 21eeff5..bcabc03 100644
--- a/include/linux/mfd/menelaus.h
+++ b/include/linux/mfd/menelaus.h
@@ -18,17 +18,5 @@ extern int menelaus_set_vaux(unsigned int mV);
 extern int menelaus_set_vdcdc(int dcdc, unsigned int mV);
 extern int menelaus_set_slot_sel(int enable);
 extern int menelaus_get_slot_pin_states(void);
-extern int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int floor_mV);
-
-#define EN_VPLL_SLEEP	(1 << 7)
-#define EN_VMMC_SLEEP	(1 << 6)
-#define EN_VAUX_SLEEP	(1 << 5)
-#define EN_VIO_SLEEP	(1 << 4)
-#define EN_VMEM_SLEEP	(1 << 3)
-#define EN_DC3_SLEEP	(1 << 2)
-#define EN_DC2_SLEEP	(1 << 1)
-#define EN_VC_SLEEP	(1 << 0)
-
-extern int menelaus_set_regulator_sleep(int enable, u32 val);
 
 #endif
-- 
2.2.0

