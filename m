Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B440860C
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198403; cv=none; b=itnhnF1BBieuv0F47CtbiQxS/gIXvxbrsozEtKmoOR/xbECsJYRLoxeELcv/MeTmkoI5f+mwTI7CiMsJapswdQ1M0pkEjXvxJKOSeQ0jMA1tT5It1hKv/OzdPD9h2LyVnSe5lmyfhJZnHPKP+SKlBF9NkcOQGmXSEGJgs3rSsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198403; c=relaxed/simple;
	bh=evBDQ8LUTdIbeMm3xfd3E5UnVCKuP9AXVeeKznBrDQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PL+F/YAMUnI/2Yn3C13DY2bPQV0z3lxbiVw+4b7qrbXiAV1jkqDdswHacoAGnjpULkJVq06p8s+dMFgGHYxvK32LGjVifoYYBxE+ojnoKMgEYSojn2976UVJsby39dD7TKluVNmZryw5TP0Zi+zspWDdKxu88fXShDagdvEG4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAmozNN2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAmozNN2"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848882fdb18so3345578b3a.0
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198401; x=1784803201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6457K6STfYP0yfng2102Li6Fjdx/uvYow/tpgSviBkc=;
        b=iAmozNN2p2+7+UwbFfByQOZ9TfAeySKrSWqtACGh2bdJC+ExlGJYq1ZRGHYJxm7emf
         50bZ/8JEjUmslLmvjhkmYy9ONP0vIkBf2OwKttiZO5UcDa7ncAZWM5xs4UyEcAEJNoqs
         E0leGx/4QIbQvAkw+EUIKIn1IL4U2eIGowhGOYHUVinDh8VzHHzF9iClJlMgmeRN++j3
         J3hLzQ7RAOx7DqAcPDx322HXv/Cm0Trg+g5ThbfKbxkVkpLKFD5afOdjXd6vptrq0esb
         2u7Pe7uK3D0zhi3fWTLetjC/uweq30NtF5DgO9q27+Th+Cs85OBcDHT8mDV2m4H5LVF9
         K8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198401; x=1784803201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6457K6STfYP0yfng2102Li6Fjdx/uvYow/tpgSviBkc=;
        b=AlLjzGHqO2RreuMZFZnavxK2g2EVzlYbjQijFFMgLI1olAZhm32VJijAQfC9hEu/vn
         MWIJVYyT1r354g145Dg8YLBVnr+W0yjR3m0aUb/TxoW6gOmpoEw+YAO9W2f1wOlv15hH
         JDicDLsWKcBvJqpZsu5f13pMfEPPzt7WcacCo7uzhY6Hgm59qw8yuYLzhMmbKU1vMLl6
         1H647OvAqiNAsFW9/xc15l25pdr6j+cntz19ifu8YC54Z0zXqFk6OU2uaJuG02XzSNwG
         qtakn/IPLvojtqXKn20KKW4PjZzYK7UplyliTYn80U4DmpiHmNinHdCYR59ZfHTDUkLV
         Bx+Q==
X-Forwarded-Encrypted: i=1; AHgh+RqGSydBkoVmb2BCLexWNxmXTpOtjQjs5Pxc4zoyWcTaQ9JK8eEzbhGnXoFbbZSHBaeD82iiyoiURt+l@vger.kernel.org
X-Gm-Message-State: AOJu0YzO7OD7Uh+Y2yf8XnmqR7v+U0O2wymvSI+RyUV4NtoizzUHgRcf
	k631ZDHG1faV5MMxKQawCoBt7lgAnk+zbPfwKgzVOQ3P0uUdCRQ4vq1K
X-Gm-Gg: AfdE7clQHw0HBr7KjIfe7SIEF4VP84eQ5F5BRZjG7/ZIIqUwa3VU/IvRZVhVgxBLA0D
	YXF16LhaKDMVwzVHrzdTdhJKDV2m9H/EESAsp77MG1dD1o+fF/RXVaXSuexyPkxTlbqy32/ArQn
	X0+ZCqyRjB9601SWQkhHXOpfgHd5A90owxTrib3EhqQgUcYQysyRhEV3o21F8cfoF5bxQ9jYLP4
	d5cpYdYXnjxvedLb8gQjmvXL2Ae4kv9YDRgi3g9HgsCp2bt1a+p5WJZRJ1yIHQLHwM6gVeMHP+Y
	e6Og6DRFZQEFUxMLMZThq30t7G5I6Mx6fgii+Kw0gHpXxCLuAR+ozVIQPvj8rF8BFyTRdMnV9jh
	PeI1Eal8OpAph/Gv/aJ1QgsM6OdN1hIefZyGSLULVwBC3v6EukaqgHlVef6ffOitoW3l7aj12Ld
	dRGv8WUtTvLsCx/DLe7Vr2LYpmbq24uYwTX0XL
X-Received: by 2002:a05:6a00:1250:b0:848:59fd:2f4d with SMTP id d2e1a72fcca58-84a67390c1cmr5652750b3a.73.1784198401098;
        Thu, 16 Jul 2026 03:40:01 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f266724sm4757331b3a.15.2026.07.16.03.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:40:00 -0700 (PDT)
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
Subject: [PATCH v3 09/10] ASoC: ti: omap-twl4030: Use dev_err_probe() for error handling
Date: Thu, 16 Jul 2026 17:39:10 +0700
Message-ID: <20260716103911.77652-10-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716103911.77652-1-phucduc.bui@gmail.com>
References: <20260716103911.77652-1-phucduc.bui@gmail.com>
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
 sound/soc/ti/omap-twl4030.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ti/omap-twl4030.c b/sound/soc/ti/omap-twl4030.c
index 2a80e44035d7..576f4d3615e8 100644
--- a/sound/soc/ti/omap-twl4030.c
+++ b/sound/soc/ti/omap-twl4030.c
@@ -306,11 +306,9 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(card, priv);
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		dev_err(&pdev->dev, "devm_snd_soc_register_card() failed: %d\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "devm_snd_soc_register_card() failed\n");
 
 	return 0;
 }
-- 
2.43.0

