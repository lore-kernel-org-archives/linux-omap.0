From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/7] mfd: menelaus: drop support for SW controller VCORE
Date: Sat, 27 Dec 2014 19:52:54 +0200
Message-ID: <1419702779-16001-3-git-send-email-aaro.koskinen@iki.fi>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:48109 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbaL0RxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Dec 2014 12:53:17 -0500
In-Reply-To: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Drop support for SW controlled VCORE, nobody uses it.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mfd/menelaus.c       | 23 -----------------------
 include/linux/mfd/menelaus.h |  1 -
 2 files changed, 24 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 9f01aef..917fa86 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -532,29 +532,6 @@ static const struct menelaus_vtg_value vcore_values[] = {
 	{ 1450, 18 },
 };
 
-int menelaus_set_vcore_sw(unsigned int mV)
-{
-	int val, ret;
-	struct i2c_client *c = the_menelaus->client;
-
-	val = menelaus_get_vtg_value(mV, vcore_values,
-				     ARRAY_SIZE(vcore_values));
-	if (val < 0)
-		return -EINVAL;
-
-	dev_dbg(&c->dev, "Setting VCORE to %d mV (val 0x%02x)\n", mV, val);
-
-	/* Set SW mode and the voltage in one go. */
-	mutex_lock(&the_menelaus->lock);
-	ret = menelaus_write_reg(MENELAUS_VCORE_CTRL1, val);
-	if (ret == 0)
-		the_menelaus->vcore_hw_mode = 0;
-	mutex_unlock(&the_menelaus->lock);
-	msleep(1);
-
-	return ret;
-}
-
 int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int floor_mV)
 {
 	int fval, rval, val, ret;
diff --git a/include/linux/mfd/menelaus.h b/include/linux/mfd/menelaus.h
index a1e12bf3..9e85ac0 100644
--- a/include/linux/mfd/menelaus.h
+++ b/include/linux/mfd/menelaus.h
@@ -24,7 +24,6 @@ extern int menelaus_set_vaux(unsigned int mV);
 extern int menelaus_set_vdcdc(int dcdc, unsigned int mV);
 extern int menelaus_set_slot_sel(int enable);
 extern int menelaus_get_slot_pin_states(void);
-extern int menelaus_set_vcore_sw(unsigned int mV);
 extern int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int floor_mV);
 
 #define EN_VPLL_SLEEP	(1 << 7)
-- 
2.2.0

