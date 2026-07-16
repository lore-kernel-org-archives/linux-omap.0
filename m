Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FB3F9F3D
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192969; cv=none; b=fbDi9r7cOmo+T+HNOGQIPaz9QmTBPqd+mSyHje4tBgjn8QBcFQpkUyHTHK3vX+oAbOuymiNtpif3mUwd9nPgTxBBraj/ni6VE6NQhMAxQqt028UniVFWFSHlKqmnoEn9W1q+M70ZxxeL1MSN8fq0PoQcFb6ZpDE0U+pavdkeX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192969; c=relaxed/simple;
	bh=jIfPIVoUyA/INjY1+gAHyG2GIm/f5J9x2F0XjC4jOCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nghBeVApM+Z1fIsTzb3g9w8xzfjW7La2yQHW7ArP6gqKSzX5X9NPDptkwV8LnoWDUHhZZDnHz8G2xF9caw/tSaYtoS8OMILqmXbAxemN+TtQT2NU8eM3D1uBsrONIZR3VuZXujwhhUAjXyaTzEpxyMh5gkJtCF8++vL+nHfpo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqjm+y45; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqjm+y45"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423f236418so2541495b3a.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 02:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192963; x=1784797763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lw8PXA7wjdfb1NxXEkfmxp6s+NoOp/15t2UE0ixUT2w=;
        b=iqjm+y45yqLaYETrXoU7CWLav91rgBl9xAqdNzK1PHiyZ6Xu/9aAwpLCJkYU2DvgBb
         PKocRQFzFa0R2Hu3yc6Uxo1eCIubIacVozsqWhqzcD46A+pejWhCYhL3ovYA1cUrUKWj
         R+o0JsiI+aNIGGXxf+iPU/oBowW1Zbu5mf2R9w0XiXYCp9lzgS/0o8z4gfMemI+Gc0zV
         a329ICA9s/LjQK+eEU2droo45f6u3G4scWMjsMsiDgTV+WyZTJei/Wb0efI04e9ywl3N
         Oop/EJ8cBQprtQAifECb9ZB7AVpF8U1hvFkjW3duXLvnXbuUu2nFe0jeIEamN4LdYIRD
         kJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192963; x=1784797763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lw8PXA7wjdfb1NxXEkfmxp6s+NoOp/15t2UE0ixUT2w=;
        b=Ww+IhRKadyzEHYAxza0oXiPNjxpgxT2Ch6TG+Ni7Wa/IDDFGC2tdKUVbaANsyQP3Ds
         NSnS7eo7p8ZGozGBk2qESH22HLXBFqCrZ1sJmdg6LNgmIKPHh9VILibsQfU4m9IhfxgN
         O1pG5iyrO3Tns+eO9qdi2IANQiMgHpNlUPO7lInRha45orKgzseVelRKs3GWniK6tj59
         GNEOs+7rCxs0eQIOggD9CfXAn+/KeGhiRqQfBisJNcD/J82ypzW0piyECV2p5zLV6oMj
         2cHySzp990rJmC1SDxMHpejsIjA9xjny9KgdXXzoskAJkNKY0JYkkxkOpQ5y4vxfe1Nl
         GQdA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0txaI+O0ZMyNMv2OEy+7btu/yyujmHiseM9oigqbPH2bbNCASbhl/DRA/T/y7hn6q7L3fr1iWEi12@vger.kernel.org
X-Gm-Message-State: AOJu0YwsxCVAZs80ywi8slLzjsWV6hQx57WWK1MxiHg7I3IyihzMgANi
	XewAVP3zRGeDnSsRYK83oMlsZ+i+W5WKGDegT6Pe5w6iDsrYfMaY1DQT
X-Gm-Gg: AfdE7cl6X0OO/Z7Xfsa5tdjRg23EiKD1oGsg7DZI0pMHTr1XJ7JZrG4rDy6kq4Qjt6m
	NDFpKDKPcmBsj8KxOG7LSf7dGr1JOlruCvIozIYoDz1NPAq/bSbTXDbsWiwmmZS83uRl+KzkODm
	XCe5hvVDGRxprGLf1l3qzBZsuSmJ1r+xq9s0utXO3RT4wtvuvLCXdQOQ8K8ke2pKIKDpk8eVFcS
	XQ0nNC+xzF36DG14TZW6qPDJxlvBzo2JXuxD7aS/JdRpmdPL2Np0hQLIj60JNDNrH0K3yLPGa+m
	+MUPUvN6JWCcuSxM4G+UwS4cEoL5pAn7khsKo4XZzFYW5dlYZ0wvyNVtj8exq4o74G+yTlbl4O9
	+Vt7bUcm+950IaVqBX71VIJuAL3NeliDTAwpJq7POBl2a6P9G6oSFPsds3GQzBmQs1HO3uJx9iH
	ZC2uEA2lQF4753uQtDM5ln5yfC+istvv4DBLl5CZDHOBRU8qE=
X-Received: by 2002:a05:6a00:27a5:b0:848:7f8a:8d0e with SMTP id d2e1a72fcca58-848896eda57mr18762333b3a.55.1784192963447;
        Thu, 16 Jul 2026 02:09:23 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf5ecsm4511800b3a.29.2026.07.16.02.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:09:23 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>,
	Sen Wang <sen@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 10/10] ASoC: ti: rx51: Use dev_err_probe() for error handling
Date: Thu, 16 Jul 2026 16:08:29 +0700
Message-ID: <20260716090829.72082-11-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716090829.72082-1-phucduc.bui@gmail.com>
References: <20260716090829.72082-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Replace dev_err() with dev_err_probe() when reporting probe
failures. This preserves the original error code and suppresses
unnecessary log messages for deferred probe errors.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/rx51.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/sound/soc/ti/rx51.c b/sound/soc/ti/rx51.c
index cfc23e0838c2..46053b8f3202 100644
--- a/sound/soc/ti/rx51.c
+++ b/sound/soc/ti/rx51.c
@@ -418,31 +418,27 @@ static int rx51_soc_probe(struct platform_device *pdev)
 	pdata->tvout_selection_gpio = devm_gpiod_get(card->dev,
 						     "tvout-selection",
 						     GPIOD_OUT_LOW);
-	if (IS_ERR(pdata->tvout_selection_gpio)) {
-		dev_err(card->dev, "could not get tvout selection gpio\n");
-		return PTR_ERR(pdata->tvout_selection_gpio);
-	}
+	if (IS_ERR(pdata->tvout_selection_gpio))
+		return dev_err_probe(card->dev, PTR_ERR(pdata->tvout_selection_gpio),
+				     "could not get tvout selection gpio\n");
 
 	pdata->eci_sw_gpio = devm_gpiod_get(card->dev, "eci-switch",
 					    GPIOD_OUT_HIGH);
-	if (IS_ERR(pdata->eci_sw_gpio)) {
-		dev_err(card->dev, "could not get eci switch gpio\n");
-		return PTR_ERR(pdata->eci_sw_gpio);
-	}
+	if (IS_ERR(pdata->eci_sw_gpio))
+		return dev_err_probe(card->dev, PTR_ERR(pdata->eci_sw_gpio),
+				     "could not get eci switch gpio\n");
 
 	pdata->speaker_amp_gpio = devm_gpiod_get(card->dev,
 						 "speaker-amplifier",
 						 GPIOD_OUT_LOW);
-	if (IS_ERR(pdata->speaker_amp_gpio)) {
-		dev_err(card->dev, "could not get speaker enable gpio\n");
-		return PTR_ERR(pdata->speaker_amp_gpio);
-	}
+	if (IS_ERR(pdata->speaker_amp_gpio))
+		return dev_err_probe(card->dev, PTR_ERR(pdata->speaker_amp_gpio),
+				     "could not get speaker enable gpio\n");
 
 	err = devm_snd_soc_register_card(card->dev, card);
-	if (err) {
-		dev_err(card->dev, "snd_soc_register_card failed (%d)\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(card->dev, err,
+				     "snd_soc_register_card failed\n");
 
 	return 0;
 }
-- 
2.43.0

