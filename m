From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 8/8] ASoC: tpa6130a2: Control vdd using regulator framework
Date: Thu,  8 Oct 2009 14:58:57 +0300
Message-ID: <1255003137-1034-9-git-send-email-eduardo.valentin@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55113 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757854AbZJHMBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 08:01:20 -0400
In-Reply-To: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch adds regulator framework control over vdd for tpa6130a2 driver.

Vdd refcount is increased every time the device
is power on and decreased when device is power off. If driver
fails to get regulator for "vdd" supply, then it will assume
its regulator is always on.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index d246aad..35720ce 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/sysfs.h>
+#include <linux/regulator/consumer.h>
 #include <sound/tpa6130a2-plat.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
@@ -42,6 +43,7 @@ struct tpa6130a2_data {
 	unsigned char regs[TPA6130A2_CACHEREGNUM];
 	unsigned char power_state;
 	int (*set_power)(int state);
+	struct regulator *regulator;
 };
 
 static int tpa6130a2_i2c_read(int reg)
@@ -121,6 +123,8 @@ void tpa6130a2_power(int power)
 
 	mutex_lock(&data->mutex);
 	if (power) {
+		if (data->regulator)
+			regulator_enable(data->regulator);
 		/* Power on */
 		if (data->set_power) {
 			data->set_power(1);
@@ -141,6 +145,8 @@ void tpa6130a2_power(int power)
 			data->set_power(0);
 			data->power_state = 0;
 		}
+		if (data->regulator)
+			regulator_disable(data->regulator);
 	}
 	mutex_unlock(&data->mutex);
 }
@@ -292,6 +298,12 @@ static int tpa6130a2_probe(struct i2c_client *client,
 	}
 
 	pdata = (struct tpa6130a2_platform_data *)client->dev.platform_data;
+	data->regulator = regulator_get(dev, "vdd");
+	if (IS_ERR(data->regulator)) {
+		dev_info(dev, "Could not get regulator for vdd. "
+					"Executing without regulator.\n");
+			data->regulator = NULL;
+	}
 	/* Set default register values */
 	data->regs[TPA6130A2_REG_CONTROL] = TPA6130A2_SWS |
 					    TPA6130A2_HP_EN_R |
@@ -326,6 +338,8 @@ static int tpa6130a2_probe(struct i2c_client *client,
 	return 0;
 fail3:
 	tpa6130a2_power(0);
+	if (data->regulator)
+		regulator_put(data->regulator);
 fail2:
 	kfree(data);
 	i2c_set_clientdata(tpa6130a2_client, NULL);
@@ -340,6 +354,8 @@ static int tpa6130a2_remove(struct i2c_client *client)
 	struct tpa6130a2_data *data = i2c_get_clientdata(client);
 
 	tpa6130a2_power(0);
+	if (data->regulator)
+		regulator_put(data->regulator);
 	kfree(data);
 	tpa6130a2_client = 0;
 
-- 
1.6.4.183.g04423

