From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 7/8] ASoC: tlv320aic3x: add initial usage of regulator framework to control avdd_dac
Date: Thu,  8 Oct 2009 14:58:56 +0300
Message-ID: <1255003137-1034-8-git-send-email-eduardo.valentin@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45208 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757712AbZJHMBG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 08:01:06 -0400
In-Reply-To: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch adds initial usage of regulator framework to control avdd_dac
inside tlv320aic3x ASoC codec driver.

The  refcount to avdd_dac is increased / decreased
only during probe and remove. Here it is still needed to implement
proper enable/disable regulator depending on chip usage. Now if driver
can get regulator for avdd_dac, then it will just let it on on probe
and then leave it off on remove.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 3395cf9..82e0a64 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regulator/consumer.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -56,6 +57,7 @@ struct aic3x_priv {
 	struct snd_soc_codec codec;
 	unsigned int sysclk;
 	int master;
+	struct regulator *regulator;
 };
 
 /*
@@ -1286,6 +1288,11 @@ static int aic3x_unregister(struct aic3x_priv *aic3x)
 	snd_soc_unregister_dai(&aic3x_dai);
 	snd_soc_unregister_codec(&aic3x->codec);
 
+	if (aic3x->regulator) {
+		regulator_disable(aic3x->regulator);
+		regulator_put(aic3x->regulator);
+	}
+
 	kfree(aic3x);
 	aic3x_codec = NULL;
 
@@ -1320,6 +1327,25 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	codec->control_data = i2c;
 	codec->hw_write = (hw_write_t) i2c_master_send;
 
+	aic3x->regulator = regulator_get(&i2c->dev, "avdd_dac");
+	if (IS_ERR(aic3x->regulator)) {
+		dev_warn(&i2c->dev, "No regulator to supply avdd_dac."
+					" Assuming always on.\n");
+		aic3x->regulator = NULL;
+	}
+
+	/*
+	 * REVISIT: Need to add proper code to put into sleep mode
+	 * avdd_dac regulator. For now, just leave it on.
+	 */
+	if (aic3x->regulator) {
+		int err;
+
+		err = regulator_enable(aic3x->regulator);
+		if (err < 0)
+			return err;
+	}
+
 	i2c_set_clientdata(i2c, aic3x);
 
 	return aic3x_register(codec);
-- 
1.6.4.183.g04423

