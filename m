Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F2F3C0637
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936097; cv=none; b=ocOsAyaDc2+knFTKctjxPr8voS+9/hlVL5EHel2OFyJKa7V1ei6ADnShsoETrl8134yEFdse2UZvHk8EOQw+pjLgQZZg9bKeFP2Qtx2cq5NfyclCE3EgVJieAqKH5pvc0ShD5VuO/RU3D6dVUVwcP4gqfLMxrwhemu7wLC+5sj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936097; c=relaxed/simple;
	bh=S0ipnO5wrlAcFNqCKHMx+FEOuLRTeZ+oUs7NkobUGiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqkEJ7ChkCqEm0oSe3gm4eDBZrMyVrhpN/e0/mVGx1NB6v3koKPPe8rdFeHajWot3PrHaisaHaVKSUgD4s9UxxyyMMvDAIe9BqMl/ZCP//PcaCgCgTlTSMFhWyBjtZctH/IXt+Npnz+3xxc6N9bVtl2XlVgqjtM4wsCjv1DTTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLIqeYLS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLIqeYLS"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso811138a12.3
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 16:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784936095; x=1785540895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EP6rR9CWK23oREV+ZXcAua+XCVkE4sgQcGJz6xnN9pQ=;
        b=eLIqeYLS4rduNsn3iIOcy5KZez49lsipFZSOiqyqzFN7uaucE5IsNJwenmYShue5bC
         MNPRv2G2u/7B/xfLb4hU7VKqfFY1b9w5YF2bzjUH0rx0kWTKyTPWrKy6td6Bcv+aYEdc
         +1URrwzZWmkIZ/hgt0gTKzypB6hEz0xQ09kfXkC+PQlTjCWG7kYTYNJBrUvGJKUalFA0
         2UIuns8CzOqJXyWDFy/aY3sN+WqhIupex96wN8Tz4oy5F3nGcg3dxPfxEQ2DpNE6uUqZ
         CCrN6HyuFT1yAGVszyF0uVAGrO4wz2yCGKSOUp+OQ1BpaKOdp2mFYVLj2zEP4ywAR1aP
         BEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784936095; x=1785540895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EP6rR9CWK23oREV+ZXcAua+XCVkE4sgQcGJz6xnN9pQ=;
        b=qt5sI8Ka0WUUZTqq/Arrx5HmJZjH//mBvMK5eDcWbSVZ4QYJo1wkr1gbm2ZISV7VqA
         ty/RYRDXsfFG5JsXWXTxcLrtZf43hZtzxPSRVv3s5U+F8dW1EJkmFqQ5gCzOiF+A0CjM
         HJWuA2D0qqgiVhxOsklcSj6pOotOpHWOqp6JRjribs2g/LveTPUWPb8tEgiMy8BD0/dX
         ath2vrI1o85VzkgDW4faM/sdDZU8M3m0lIUiTWVQjKfGisXYV3pqfhXRphyjuzroF9Pp
         HkH2i6ySHIASRpspZ3P3E0rUFbyU8De0gTgA3ypMHbiq1OVZ+X/az0RsqWx0RQ7HMgqD
         HcEg==
X-Forwarded-Encrypted: i=1; AHgh+RrHT02/jZKpBEjG9FuAfoblk/bnE68SXHHEH6A5cY33BvmIMdgX9EwrtjqS5jN2HFamp/pWL+wHnDZF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Yea4Ov9i5R9ipd1DNeVcBKIaPvce+I3YofuWhQAksFhX+A5W
	jxaPS0JhFWQ3pp9TqxhLytiFonxDqAjy+utMqD6MdmMOmac4EKwhfIBi
X-Gm-Gg: AR+sD13Z4vzhrrOYevQn8+VWRpOW/taifDv453qZadPIFpNzCK+tID7IZYOQLYfjnRl
	tz6tR72/SMhDaCLocIit1oaQzZnYNJZR8uWXSD0/rX8Mpl2vbcVXcQniEqMGnoujOp4uXbKpD52
	w6S9AnY9LyUoeTe+6PIy8m3OWFKkakUptRqbgHLODK13kgmIzO60JxkRw2R8Pc33bymoynDOBoB
	ZouaOK18heGSHIv9qtkV5vcPKhDAKGmBRAB6D2W1Se+wlcIg7hNsN4X/voE3PV23XDN/nGgy2vM
	8uz9lsJOtnR9S3w8zPHxQ7Jj+REXNL7jWkowWapLAUQhFKl56pNyOFDV/+3kmjV6oj0zP6K7sTb
	u/aTV7FLdvmdJRGYfjUA37DmTrSWm5SmaEFrwuUdTCNuaqHxn75OQFtqR6EX+ofVQLoi9QtkiIM
	bh9vUeMPKlT4ok3ZNhAyVuU4a/C9LIkeAEuTcVjK6C6WTA0x2TbzsdwSfBndfzNgmSLg==
X-Received: by 2002:a05:6a20:a11d:b0:3c3:9070:96bf with SMTP id adf61e73a8af0-3c67d9b2a90mr391754637.9.1784936095052;
        Fri, 24 Jul 2026 16:34:55 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548e63sm3361657eec.19.2026.07.24.16.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 16:34:45 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Sen Wang <sen@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: ti: omap-twl4030: drop support for platform data
Date: Fri, 24 Jul 2026 16:34:29 -0700
Message-ID: <20260724233432.31325-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no users of omap_tw4030_pdata in the mainline kernel so
remove support for it from the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/platform_data/omap-twl4030.h |  42 -------
 sound/soc/ti/omap-twl4030.c                | 134 +++++++--------------
 2 files changed, 44 insertions(+), 132 deletions(-)
 delete mode 100644 include/linux/platform_data/omap-twl4030.h

diff --git a/include/linux/platform_data/omap-twl4030.h b/include/linux/platform_data/omap-twl4030.h
deleted file mode 100644
index 7fcb55fe21c9..000000000000
--- a/include/linux/platform_data/omap-twl4030.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/**
- * omap-twl4030.h - ASoC machine driver for TI SoC based boards with twl4030
- *		    codec, header.
- *
- * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com
- * All rights reserved.
- *
- * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
- */
-
-#ifndef _OMAP_TWL4030_H_
-#define _OMAP_TWL4030_H_
-
-/* To select if only one channel is connected in a stereo port */
-#define OMAP_TWL4030_LEFT	(1 << 0)
-#define OMAP_TWL4030_RIGHT	(1 << 1)
-
-struct omap_tw4030_pdata {
-	const char *card_name;
-	/* Voice port is connected to McBSP3 */
-	bool voice_connected;
-
-	/* The driver will parse the connection flags if this flag is set */
-	bool	custom_routing;
-	/* Flags to indicate connected audio ports. */
-	u8	has_hs;
-	u8	has_hf;
-	u8	has_predriv;
-	u8	has_carkit;
-	bool	has_ear;
-
-	bool	has_mainmic;
-	bool	has_submic;
-	bool	has_hsmic;
-	bool	has_carkitmic;
-	bool	has_digimic0;
-	bool	has_digimic1;
-	u8	has_linein;
-};
-
-#endif /* _OMAP_TWL4030_H_ */
diff --git a/sound/soc/ti/omap-twl4030.c b/sound/soc/ti/omap-twl4030.c
index 4d80f8a7a947..950879fc7275 100644
--- a/sound/soc/ti/omap-twl4030.c
+++ b/sound/soc/ti/omap-twl4030.c
@@ -17,7 +17,6 @@
  */
 
 #include <linux/platform_device.h>
-#include <linux/platform_data/omap-twl4030.h>
 #include <linux/module.h>
 #include <linux/of.h>
 
@@ -133,20 +132,12 @@ static struct snd_soc_jack_gpio hs_jack_gpios[] = {
 	},
 };
 
-static inline void twl4030_disconnect_pin(struct snd_soc_dapm_context *dapm,
-					  int connected, char *pin)
-{
-	if (!connected)
-		snd_soc_dapm_disable_pin(dapm, pin);
-}
-
 static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_dapm_context *dapm = snd_soc_card_to_dapm(card);
-	struct omap_tw4030_pdata *pdata = dev_get_platdata(card->dev);
+
 	struct omap_twl4030 *priv = snd_soc_card_get_drvdata(card);
-	int ret = 0;
+	int ret;
 
 	/*
 	 * This is a bit of a hack, but the GPIO is optional so we
@@ -170,29 +161,7 @@ static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 			return ret;
 	}
 
-	/*
-	 * NULL pdata means we booted with DT. In this case the routing is
-	 * provided and the card is fully routed, no need to mark pins.
-	 */
-	if (!pdata || !pdata->custom_routing)
-		return ret;
-
-	/* Disable not connected paths if not used */
-	twl4030_disconnect_pin(dapm, pdata->has_ear, "Earpiece Spk");
-	twl4030_disconnect_pin(dapm, pdata->has_hf, "Handsfree Spk");
-	twl4030_disconnect_pin(dapm, pdata->has_hs, "Headset Stereophone");
-	twl4030_disconnect_pin(dapm, pdata->has_predriv, "Ext Spk");
-	twl4030_disconnect_pin(dapm, pdata->has_carkit, "Carkit Spk");
-
-	twl4030_disconnect_pin(dapm, pdata->has_mainmic, "Main Mic");
-	twl4030_disconnect_pin(dapm, pdata->has_submic, "Sub Mic");
-	twl4030_disconnect_pin(dapm, pdata->has_hsmic, "Headset Mic");
-	twl4030_disconnect_pin(dapm, pdata->has_carkitmic, "Carkit Mic");
-	twl4030_disconnect_pin(dapm, pdata->has_digimic0, "Digital0 Mic");
-	twl4030_disconnect_pin(dapm, pdata->has_digimic1, "Digital1 Mic");
-	twl4030_disconnect_pin(dapm, pdata->has_linein, "Line In");
-
-	return ret;
+	return 0;
 }
 
 /* Digital audio interface glue - connects codec <--> CPU */
@@ -237,11 +206,15 @@ static struct snd_soc_card omap_twl4030_card = {
 
 static int omap_twl4030_probe(struct platform_device *pdev)
 {
-	struct omap_tw4030_pdata *pdata = dev_get_platdata(&pdev->dev);
-	struct device_node *node = pdev->dev.of_node;
 	struct snd_soc_card *card = &omap_twl4030_card;
+	struct device_node *node, *dai_node;
 	struct omap_twl4030 *priv;
-	int ret = 0;
+	struct property *prop;
+	int ret;
+
+	node = pdev->dev.of_node;
+	if (!node)
+		return -ENODEV;
 
 	card->dev = &pdev->dev;
 
@@ -249,62 +222,43 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 	if (priv == NULL)
 		return -ENOMEM;
 
-	if (node) {
-		struct device_node *dai_node;
-		struct property *prop;
-
-		if (snd_soc_of_parse_card_name(card, "ti,model")) {
-			dev_err(&pdev->dev, "Card name is not provided\n");
-			return -ENODEV;
-		}
-
-		dai_node = of_parse_phandle(node, "ti,mcbsp", 0);
-		if (!dai_node) {
-			dev_err(&pdev->dev, "McBSP node is not provided\n");
-			return -EINVAL;
-		}
-		omap_twl4030_dai_links[0].cpus->dai_name  = NULL;
-		omap_twl4030_dai_links[0].cpus->of_node = dai_node;
-
-		omap_twl4030_dai_links[0].platforms->name  = NULL;
-		omap_twl4030_dai_links[0].platforms->of_node = dai_node;
-
-		dai_node = of_parse_phandle(node, "ti,mcbsp-voice", 0);
-		if (!dai_node) {
-			card->num_links = 1;
-		} else {
-			omap_twl4030_dai_links[1].cpus->dai_name  = NULL;
-			omap_twl4030_dai_links[1].cpus->of_node = dai_node;
-
-			omap_twl4030_dai_links[1].platforms->name  = NULL;
-			omap_twl4030_dai_links[1].platforms->of_node = dai_node;
-		}
-
-		/* Optional: audio routing can be provided */
-		prop = of_find_property(node, "ti,audio-routing", NULL);
-		if (prop) {
-			ret = snd_soc_of_parse_audio_routing(card,
-							    "ti,audio-routing");
-			if (ret)
-				return ret;
-
-			card->fully_routed = 1;
-		}
-	} else if (pdata) {
-		if (pdata->card_name) {
-			card->name = pdata->card_name;
-		} else {
-			dev_err(&pdev->dev, "Card name is not provided\n");
-			return -ENODEV;
-		}
-
-		if (!pdata->voice_connected)
-			card->num_links = 1;
-	} else {
-		dev_err(&pdev->dev, "Missing pdata\n");
+	if (snd_soc_of_parse_card_name(card, "ti,model")) {
+		dev_err(&pdev->dev, "Card name is not provided\n");
 		return -ENODEV;
 	}
 
+	dai_node = of_parse_phandle(node, "ti,mcbsp", 0);
+	if (!dai_node) {
+		dev_err(&pdev->dev, "McBSP node is not provided\n");
+		return -EINVAL;
+	}
+	omap_twl4030_dai_links[0].cpus->dai_name  = NULL;
+	omap_twl4030_dai_links[0].cpus->of_node = dai_node;
+
+	omap_twl4030_dai_links[0].platforms->name  = NULL;
+	omap_twl4030_dai_links[0].platforms->of_node = dai_node;
+
+	dai_node = of_parse_phandle(node, "ti,mcbsp-voice", 0);
+	if (!dai_node) {
+		card->num_links = 1;
+	} else {
+		omap_twl4030_dai_links[1].cpus->dai_name  = NULL;
+		omap_twl4030_dai_links[1].cpus->of_node = dai_node;
+
+		omap_twl4030_dai_links[1].platforms->name  = NULL;
+		omap_twl4030_dai_links[1].platforms->of_node = dai_node;
+	}
+
+	/* Optional: audio routing can be provided */
+	prop = of_find_property(node, "ti,audio-routing", NULL);
+	if (prop) {
+		ret = snd_soc_of_parse_audio_routing(card, "ti,audio-routing");
+		if (ret)
+			return ret;
+
+		card->fully_routed = 1;
+	}
+
 	snd_soc_card_set_drvdata(card, priv);
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
-- 
2.55.0.229.g6434b31f56-goog

