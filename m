Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1850387585
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030521; cv=none; b=shBW306EbmwP//QmYRiX8Wl6+MSMZUsy/0jTL20ooy/ye0tj+wc7jSiUY5HdSErxxdstCT7WRF7A0vgB/1aif+VT3wrTLFiBdRiyoGWY3N9Nsn7yJAKaGBptUpoPKoKl/mBdTS4vN7TICViDtP2vGIRQv54e/bSEeO1eM8BAr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030521; c=relaxed/simple;
	bh=XWDzYN/QmDeP+BMWU96Wibo8K6xDaS1cOUFjBPJXQQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMj33YSYYoTh0s4h1Z6/4F0AnANcO+8yKG6gcwV7768+aZjoM97MpO8CwUldwdjEIYX7TuNwckFh4gD2GS59LuFDGK2NQ2kinCbMWaS2HmcftZb86dP49LLPjcJAEWHaKxWBjyOD39pSxP/AUIT80h+gu/kv8GhO9pYKXoCrVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ouusHWBs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouusHWBs"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38511175ad3so3359474a91.2
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 05:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030519; x=1784635319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06ntY9whyt2Zuo8Uv5yBesP3vRYcbp6uEAMZexttM1Q=;
        b=ouusHWBswmaecj71e2raeNOShvorAgvc96mxNOAX11kw7qXObLOORcHn6h4GwTHKCf
         XuHgXoIMtsCtlGzPHURjPtHPOnj7NY3xathGCaPQpMiriEHZ377ScgafqT2K8ubdHmbP
         ak8s9Vy3R+orYn0woJ/d4CALuot8Z4nLIxQaMrugY44+xwd1gtOyXxhzvc9E2UrMYxAN
         bujFdUnD+hCYvQ/rpMiyFt5bp+RnPhBmwPoY4P9WqYkczWKdV4lIIhFNhXHJjsYp1tE5
         RwVw3ZWvWQ2fnFAr3bZgVJjJiPqizEDAzCzJERnHZtTNY1M9eDdsmSq/ECCBavTGT059
         9wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030519; x=1784635319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=06ntY9whyt2Zuo8Uv5yBesP3vRYcbp6uEAMZexttM1Q=;
        b=qdyNWDbKNSlEvAU3M8UIO522lUxdHUAz43iKpJbexPg/Zk5QP/yBT5L2FTwaErXor4
         03XNVhrVQGBiYsO5XiOjkUSLwcezDOSQ4ceUTEkgjZmV5CLF7e1KNnvGT6wCnBod39Z+
         2nVphb/+2Y7yNzWRX90zYLk6IKreiEzGu8vdGVith+uZ0MMiMaCwWB7DF68mgbna1L/Y
         cZF6353IEFZzn1TGMQp3UaQf4181DN//EFyyvVRLQcizKONsgZQRnyoUI/qbGuSWzFFY
         IQz5icGi50Y/Ry9y2LnR9g7wtS4cuvNpHg6MsA0msZhlfOO8v7lkGzauk6J0c8k/Mi+V
         68KA==
X-Forwarded-Encrypted: i=1; AHgh+RpvaWjT9lLLqhictlQzkqqiMr69R8pOzWVWanWAil5cAyW8Tig3bKHKVYThUGq9Xq/bf1KoMeZvL47F@vger.kernel.org
X-Gm-Message-State: AOJu0YxzoMiSuqJ697HBm3xmeRHjaBRUv0gxdDkCa2jWBpVukVsrrCWk
	SCpClFwE0s+EtrHXX+UFSuJbcpkUNbHDGBSpjpQHwQ5CNYLE7RekfLST
X-Gm-Gg: AfdE7cl5kmHOkjMD+/mqShdgvjm2YGQ6eOayChZ4OQAl6kPwRe4yU5Tg04mUjDaUPm9
	9zpNN9QS1N60GD3JdOiLOPNbUxH9YMaWXKP5bewLat/1aWqMUp2DFbgV7n9Tv5ZFQgn9Ex8HKG7
	G18nCxZr5bY+NazngLqjJKZDSSHfz8FsU+215RJiG0WT/1cxbbLPvPHAgu8Z9wq5x1Wdlewgqvu
	jWp+ceinEeTo/2cPbb+0k18A8wtia+rfyuNy+z1RO6T0Wtx8LGmbSLifoZsSiLaw3uPXhcKMiB6
	qadCk1bgWIsWbqo6mniThvKZ3RggqfHvs3oaxStbqgjC1jebdfT8MJ9fiZwYaoAj1bZtDaZh8iV
	nPBAAukyCbZ6rlcDfet0Qqk0/OjalsRoEZzjBg7H2AbjNK7oFqSu7kPWcIwYkIkx2PC5txQovGK
	DRkOTSb3ztmy8q7P45iyNCcJkWyfmjftdPyCViwF/9EMeuzjE=
X-Received: by 2002:a17:90b:35c8:b0:387:e0cb:c8dc with SMTP id 98e67ed59e1d1-38e1b00c165mr2212750a91.37.1784030518918;
        Tue, 14 Jul 2026 05:01:58 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm86725093eec.19.2026.07.14.05.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:01:58 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>,
	Sen Wang <sen@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 07/10] ASoC: ti: omap-hdmi: Use dev_err_probe() for error handling
Date: Tue, 14 Jul 2026 19:00:39 +0700
Message-ID: <20260714120042.491712-8-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714120042.491712-1-phucduc.bui@gmail.com>
References: <20260714120042.491712-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Replace dev_err() with dev_err_probe() when reporting
devm_snd_soc_register_card() failures. This suppresses
unnecessary log messages for deferred probe errors.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/omap-hdmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
index e60f5b483fc5..72114965c37d 100644
--- a/sound/soc/ti/omap-hdmi.c
+++ b/sound/soc/ti/omap-hdmi.c
@@ -375,10 +375,8 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	card->dev = dev;
 
 	ret = devm_snd_soc_register_card(dev, card);
-	if (ret) {
-		dev_err(dev, "snd_soc_register_card failed (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "snd_soc_register_card failed\n");
 
 	ad->card = card;
 	snd_soc_card_set_drvdata(card, ad);
-- 
2.43.0

