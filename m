Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697B03B52F8
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936107; cv=none; b=DAHh0SOKEpQWamLtNT6/sDODCvFLF4FBTVF+CRuA/30LlSrWRm+/MqLWCLai04m3Xb69U0aa5wBcO7bMsP8H2ddgaGazG+8r+hzBQX90mUUKlLU2J90N8NBVTj96PLTMPwOWWmrzlKeMp7RmONiD2/egGdooJPtdBD3sC0qykj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936107; c=relaxed/simple;
	bh=dXMIxjXjmxxXQstTQm3Ckd0xFmG0qWHwHchTz7R80v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpDw5kxcmss7+c0amqAy7noPzIGFePCBunTLwaQmDekUUUlqvUT/yl7bC3VJP2iG87z36V00B4zekF7wTKRjKrOlfTJhuKRcYDA+lnrNtrWn/LsPyk60sJ8umxNs3FfdEdfuUAUQ1niLBt3GdftdZ9C3X6eMKOK6O5dPIVZOfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBvCbfsj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBvCbfsj"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caea3f742bso12948875ad.0
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 16:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784936106; x=1785540906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/NhkTg0a3A8bbWIDY7lGJm4c2N5hYTi0tSxfBMW/aU=;
        b=IBvCbfsjl54Dx36TF6Fj/YAYuYkI0M8ePgXJPTbeJ8ixlObg9hiwaxWz8Tm8w58Ch4
         8LGL45V3dGjFEXEmYfv4oaYOiz8yI3Q/PCwLvFwGTlL855wIkrq2+l9NCa2Q2tsLNqsS
         aKuTvgaDt0/Pt2zL09vtTrfgtAvl1Ngkr0qv+CZ1F7Ps2mSHEsZdUzuf6+NY8I6FmAff
         wtcaQx7SerozXsoTrkkmQVw2/El++DnH0Kniimdw85zLJ7h1QBgZ/eNe/rUUFywcCIGj
         xnnUzNus5gIsbal0NDerAY9Bcfr2CT2oHIkLN9pmXnWvd1NvGLpd5bHT9SYVs9IxG7WO
         1Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784936106; x=1785540906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l/NhkTg0a3A8bbWIDY7lGJm4c2N5hYTi0tSxfBMW/aU=;
        b=bpBsNedO8wrrgpfd9DLul5HhqZpogUWe3H6uaV8K0vyILvUDga8vqDF7HQDA5Q0Nfu
         GVnfW2reh85Q15AOTdUYuQm6ur6jrrb6Yk9ppWNNJPl26GbNdnmw7w72mzG9i4J6WwE3
         jPQzNBuTIPhW8FmB8hjM39ojb4JtO9SfY9XavJJaJXfNypQXSHMEZ0tzpsQQVaovStQC
         P+MCMpOMhF8a21h67gLcrxZ0/HRDpKNOafQuZT4d5PD5m4GkL7ikJGGY60chQ5vnu5+b
         9MiPqkQ00FNBtiKvhzx+RZLcAFNTNoUBGtfdXbTSmUieL89xhQ8FwlTJht9nu1eCh/AB
         Rn5Q==
X-Forwarded-Encrypted: i=1; AHgh+RqCnXwLBqbLUz5aJ0/QVXFP6EDsb5KQb5pxgPaUzeaqteR1bvkm+4nq/hsOmxAKWw1fX9FUjCzOBicI@vger.kernel.org
X-Gm-Message-State: AOJu0YzCGy9fNkiYz9pgkuq1iB14i64jC2lnuf7djpSfM6CrbcwqeGcw
	9wOgiAE8tHwvskG/ZwgoyBKkhfRAuyz595rqBoh+4DLLM7RjBNONkiYDu36jyA==
X-Gm-Gg: AR+sD11TnE1KfQB1TcosaqkpJDk1KASDrTZw9ichsDxwwnwz0Y2/jGnYK3DvEn84Ede
	l3feq7xap8Mp7WQ6GllZ1X07Ca9oNXTjNxU4gD2uPqcxTITxFDTTn1971IXJXNwYNTRFs3RwjVZ
	ZZxd5ZISVigtCFzoGhUsiAmK4omPNDCqZJ68/sQ+Npt8rhxKl2eAdg8zIL8DPsoB6DSVlZ+3fDl
	afCBfeQgsol6P7PT4KPI3LLQRNx50HbC1aLcnupWMZzVQuaCh4v9TNMovDlWwcAh684UeLjgaS6
	vSH5UuVYGDI+CD4Kg9W9NfLtHiZcmJX22CnfuICnHDwH0SQZEo/Eoh64lt6l3+pKZOyfLfV2WNs
	iDnZ381bvYUXp/hAj5jujGqBRlIZmYrsmmdtk9BSv3iwtFUHWpwE0eZEQ9897V/tL8aX3NymOPB
	Isr7LfvsAgZz/nFNP/KkRILWdx3qAEUIIAWE7M1j21f7my6PcZt977qd4Qkz64/RQJWQ==
X-Received: by 2002:a05:6a20:4305:b0:3c3:8aa8:6caf with SMTP id adf61e73a8af0-3c67dd8a496mr347939637.27.1784936105616;
        Fri, 24 Jul 2026 16:35:05 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548e63sm3361657eec.19.2026.07.24.16.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 16:34:57 -0700 (PDT)
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
Subject: [PATCH 2/2] ASoC: ti: omap-twl4030: use per-device instance of headset jack gpio
Date: Fri, 24 Jul 2026 16:34:30 -0700
Message-ID: <20260724233432.31325-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260724233432.31325-1-dmitry.torokhov@gmail.com>
References: <20260724233432.31325-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hs_jack_gpios is being potentially shared among several instances of the
same device, and is being modified. This is not the best approach to
structuring the code (even if the device is in fact a singleton).
Change it to allocate a per-device instance.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 sound/soc/ti/omap-twl4030.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/sound/soc/ti/omap-twl4030.c b/sound/soc/ti/omap-twl4030.c
index 950879fc7275..4abcfff04bc7 100644
--- a/sound/soc/ti/omap-twl4030.c
+++ b/sound/soc/ti/omap-twl4030.c
@@ -28,6 +28,7 @@
 #include "omap-mcbsp.h"
 
 struct omap_twl4030 {
+	struct snd_soc_jack_gpio hs_jack_gpio;
 	struct snd_soc_jack hs_jack;
 };
 
@@ -123,15 +124,6 @@ static struct snd_soc_jack_pin hs_jack_pins[] = {
 	},
 };
 
-/* Headset jack detection gpios */
-static struct snd_soc_jack_gpio hs_jack_gpios[] = {
-	{
-		.name = "ti,jack-det",
-		.report = SND_JACK_HEADSET,
-		.debounce_time = 200,
-	},
-};
-
 static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
@@ -144,9 +136,6 @@ static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 	 * only want to add the jack detection if the GPIO is there.
 	 */
 	if (of_property_present(card->dev->of_node, "ti,jack-det-gpio")) {
-		hs_jack_gpios[0].gpiod_dev = card->dev;
-		hs_jack_gpios[0].idx = 0;
-
 		ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
 						 SND_JACK_HEADSET,
 						 &priv->hs_jack, hs_jack_pins,
@@ -154,9 +143,14 @@ static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 		if (ret)
 			return ret;
 
-		ret = snd_soc_jack_add_gpios(&priv->hs_jack,
-					     ARRAY_SIZE(hs_jack_gpios),
-					     hs_jack_gpios);
+		priv->hs_jack_gpio.name = "ti,jack-det";
+		priv->hs_jack_gpio.report = SND_JACK_HEADSET;
+		priv->hs_jack_gpio.debounce_time = 200;
+		priv->hs_jack_gpio.gpiod_dev = card->dev;
+		priv->hs_jack_gpio.idx = 0;
+
+		ret = snd_soc_jack_add_gpios(&priv->hs_jack, 1,
+					     &priv->hs_jack_gpio);
 		if (ret)
 			return ret;
 	}
-- 
2.55.0.229.g6434b31f56-goog

