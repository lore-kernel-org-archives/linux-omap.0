Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147953F7A9A
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192956; cv=none; b=nljP8tfTanDZKi8aToAS//tinPJURwu3SWA95ApcF/8KdGPk1i8nccdDLGBcHzsSeWsIebaTvZ7Bem7beYZt6EqQRNWuIq1Vs41g4xlBNYPOZ7NKk+DGjobL9UXgwMms4oBBXq1ucD2SF52M+7+un8sEwHo9wWQP72BvJtO8fPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192956; c=relaxed/simple;
	bh=XWDzYN/QmDeP+BMWU96Wibo8K6xDaS1cOUFjBPJXQQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzgbbOg/lcPwCEBDMXPCNc1MXaN31+nFZEOeoGDeXvwrLQHIz+d7r0LUDed1LQQNImpcxTTH4zagYOw9L59QeKbVgwYYw0yGh3LwHSIpNH/n7BA96MMSG1q29TOExW7r/dBAOIqVuLlZU2uf7V3m95FoUJ4O5bg8mMt51rJEdpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzacJy+K; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzacJy+K"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84864086bfeso6765850b3a.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192952; x=1784797752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06ntY9whyt2Zuo8Uv5yBesP3vRYcbp6uEAMZexttM1Q=;
        b=dzacJy+KZKitdMVk3tWUe5PsGtZCnxSbYMrAUEwQN/gxwb9fpNW1XC9QSJ0wyzNXdZ
         Yo4AzFYBTYsseZLtrwbA7lrrpF7ihSox6oGYtsWPF+KUtZBxvN8q6c33PEOwNmYU2EK/
         C4ePNYDIAv0XfpjSkAImVmGrMQkznqw0nE28j/LVBck+Bkm2T7XKXHNQMdmfnITfkFRc
         WcrpXLgVV+eR0Q/54zg6MXuGmQFamfwaQD6J8f3zX9DACAJGUsq3ArSx3mcV4GXkC2go
         5tbQXWZFDdlWbYCjQOVqToHwB2q3TxhcAWI5vou9QgTvZxBtSdRTLIMrQOL6puLtBANU
         U2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192952; x=1784797752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=06ntY9whyt2Zuo8Uv5yBesP3vRYcbp6uEAMZexttM1Q=;
        b=oBukT5lMN9g41SiQf9llplDnW/0gimnUwnmEF4uqPCrqiguPForhVtnCxizvrnsy2D
         BiFAQYQULZdWn+s4Km3m7demLo0z66eXEh5KKm8R7vwgDodzShkMoVUaGBIHv1x9QTKY
         KKDzPiPBafGZXND/vOLiVkVE40OfEPfA5NhTbJxUSUHeH0to2w4HFSRD+Ha7mFLJE1R7
         tMoHuEk3OkZlzZLB7FigHJklmps27Up+y3fw+8boHLrDZkc5s/MsqLFHx7LAsfIS2PJj
         1ITQSzPQwEuqQg65+mCoM+yVdngee14Zh7awlIHBRWafCxDBGkNkXFAw0p//CEjiCkZO
         9U1A==
X-Forwarded-Encrypted: i=1; AHgh+RqYx9bL5f6EWvqS8bX/4QtPi2yy+Is/q/LeFs3pkK5oGxUyG8dY7APevpjSfoWPUstcS9ZNJg7/N3ko@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp9f3hDOK23er1lWevvBSYUvHORMxpsPiJvzwWLv6ta2BZgFwi
	X+b71N736UlW2Fvy0upP/thBQtL/N2Wm9XbT6C84EePnL68HAT90d7qt
X-Gm-Gg: AfdE7clZdNDyMQcAGRdL4wONxuFMcca+zgSnFm8YxZ2XQvQoOPPQfJWrLISp5LfhdWi
	af4wbYgM6TZF4pFxymDAS8HhR7ywwEJ5/idUtp7ER+8khQGD3LuugTUfH/LJCEq3hfFu4bmVTsl
	VQsjITLoj3nuDM78yU7v2mV2jH6Ncr00hyjfy6G1p6mnPDyz71KO5IZcVjbph9HniRcupDkwzcw
	s2kSqRm8OQCCWlSDUmu62gyG0ZsgdeagHSfFXIVQN9NBgx6RU2WfWQimNSn2ixuP7+EH1QkbhUl
	UtpyjIOiC2cvsIDHFvTmCzuEgdNOjAdCq2TqhiOP0QUHyKubXaagtMm50aQO6nAwRUtWxtZgCYH
	+bqQCNhL2qWTNpDhW1DF4y/kIq/uYvUcKvi3Reusy1sJPjnz2xILFrWjfvX9V2g+CmKbmjYJ3ON
	NPARP/iISBFxuhf7qIWJHvI5bYG57IUJMZCVOM4fd/OHUs9ts=
X-Received: by 2002:a05:6a00:f92:b0:845:4cb5:2343 with SMTP id d2e1a72fcca58-84a557abe36mr10198232b3a.19.1784192951929;
        Thu, 16 Jul 2026 02:09:11 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf5ecsm4511800b3a.29.2026.07.16.02.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:09:11 -0700 (PDT)
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
Subject: [PATCH v2 07/10] ASoC: ti: omap-hdmi: Use dev_err_probe() for error handling
Date: Thu, 16 Jul 2026 16:08:26 +0700
Message-ID: <20260716090829.72082-8-phucduc.bui@gmail.com>
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

