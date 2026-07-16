Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859AE40A93B
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198378; cv=none; b=pRRFgIgCpGbPJSBkTN7UGl0GdvDpgCCl8xXJmimHrj0alvJhQkB4NbxQ/Qz13U2HzrfNWLwirkYx/K9Uj6iEjraa5bcZtalWDy+5Byvk0J5AZOdWR7r6A6QOSwcN7AJ6Avzs/ZCXh2BXRbE67h/k3s7yK75uSMkvDotNToPDT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198378; c=relaxed/simple;
	bh=bly5g/vrF4ctQv0fYWIQy5hsDFKEKRsbvFXr7VSnXeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vm/fLdhDVzwy+UsV/41D5lpHJXLTeFEkl0C8EohQUAjWNhlT9Si7igUm9/YSHekl8YTtm7DOsz0KV7S8vTT4u4Hkl9+OIX18Qb9SOFcs1URSM2rfTzxZMUadKKoi1dKBBacaee9c55A/SMUoEkUZTWZxoD89GdJG0DG6irkSN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvacTViq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvacTViq"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8485ef63b68so6015786b3a.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198376; x=1784803176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yEt6Uvr9Ac4AHA1sp4pMgGGdcdpdh8Mxz+CChY0s25Q=;
        b=ZvacTViqIdpWo3wkTyzvzAbYaL0F0Q/wJvRx2V/eJwDhcnrv62pYLsVduZWcmNWv5d
         /2fmvWp2ZY5kvpXOCLXdxaJ8DekV8W1zBEux55WMiSrZqpNG1ZLHvRAsSz4OhdLRicUX
         k2LXUHbBYC4NS6f9aZ/d4VV/cCUtykXtz+5nqYCoGva6axl2XT3PMho4Jn3tAB7ybRN2
         ns3TIBOcP2oUA++NnYY6OGZyp3nT4IZTOw2VdB9mxlLqedggs42QXxR141HSQQXJfTFs
         z6VcIzdPi/RvSJ6M3GnJs2r/7Bz4snfXGtlYIyHUptqGtJGoV5rfDHqidhtDh6gOOBCy
         LUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198376; x=1784803176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yEt6Uvr9Ac4AHA1sp4pMgGGdcdpdh8Mxz+CChY0s25Q=;
        b=XGyuCkDi+7JQbY3gPmuRhyutiovVxUytP9ISbXk9ZOeF6puNBWgcnkCFO5qYxrMmrE
         mSYBecJKTErjPiDMthUBQ9YSlMVi5LVt9H7oL7bP3NIsC+a9xY2fp3AZkbHcHCSnZQRA
         HlxZ5ey/3YSK7RRucSjDTYFcakjQmxEPcC2e6YJyTiPaQCJhQJdZ/sMsimfCKAD19nma
         iqqE2X85Ga8euUd4k3ZLvfLNzy3grzO+AW9hOEMbXmLd38/kgixijNR0ICKRv8ShGPFn
         R6ALDJp9OaQHOfPt5gHJh0FjsWg0lL4LWZoqwOmkQM8n22aEwUQe/FTW9HG7sZBtOnJ7
         yc8A==
X-Forwarded-Encrypted: i=1; AHgh+RqjTsGdZBP1ERvFvkI8W6NrcfboPmd8iF15jFpPMxpHei59B9MUG57143aRqb3aQCp1ZJlru1lehAFV@vger.kernel.org
X-Gm-Message-State: AOJu0YyHOaEukBJPFsXmh/Ve2xrouyZeTDgBQQj0auCNZkcI48/1o3Vz
	Ajg9pRf80xbNTpxN9ZgGbT4l2e16SqfaboiGFFhbuQx0uxsAa8Usm+tYbP9cKg==
X-Gm-Gg: AfdE7clv07tzcsiaz5E5b63EDhZiLgrJ8kxMYe8A9Y/d7JmDIs+9heyCwcnMnbPOxGY
	yvytil5U4qgLP8jTZlCcZum3WG2WUOGu8YZotvTn7cW7EsvdIKx8NiKcVaFxOM+11Ke/6h6ue+y
	GRLG9yAwPJxMPdY3yyFvwjFopSk5rw9s/XkW8O5u5rTWC7UIAXqzkp0OdotGt2rRSr+8RbX2Jie
	jvajOrzIPFWd9Qz6kwTUNfn42+HKTCW0anvuDgi256noSmOXd8Vh13+J+2gi6Vhqj6A8D05vdwY
	d4UazUaGugjGmHo+Fz8cTh45lHEjIMy+ls7xHDqEPIn2fx4h+NBMSLZEQHQFYvoL5TvtiAzdZTc
	X6xreeT9IivpZLwfpqRX49oSCQArstWhpbSfVhCElSPnQiJwSekh5YcqACGKnQz0ljpn1CvRQV+
	iObQ/+fZdCZVPom2pdyXS5RjVfk+FRAcXLaOKx
X-Received: by 2002:a05:6a00:a883:b0:848:54ff:a2bb with SMTP id d2e1a72fcca58-84a55850472mr9104210b3a.61.1784198376026;
        Thu, 16 Jul 2026 03:39:36 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f266724sm4757331b3a.15.2026.07.16.03.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:39:35 -0700 (PDT)
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
Subject: [PATCH v3 02/10] ASoC: ti: davinci-evm: Use dev_err_probe() for error handling
Date: Thu, 16 Jul 2026 17:39:03 +0700
Message-ID: <20260716103911.77652-3-phucduc.bui@gmail.com>
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

Changes in v2:
 - Add missing parentheses to `snd_soc_register_card()` (Christophe).
 - Remove an extra blank line (Christophe).

 sound/soc/ti/davinci-evm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
index ad514c2e5a25..3156d87a3a12 100644
--- a/sound/soc/ti/davinci-evm.c
+++ b/sound/soc/ti/davinci-evm.c
@@ -245,9 +245,8 @@ static int davinci_evm_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(&evm_soc_card, drvdata);
 	ret = devm_snd_soc_register_card(&pdev->dev, &evm_soc_card);
-
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		dev_err_probe(&pdev->dev, ret, "snd_soc_register_card() failed\n");
 		goto err_put;
 	}
 
-- 
2.43.0

