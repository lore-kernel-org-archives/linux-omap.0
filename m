Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481D38AC9A
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030510; cv=none; b=mB3ypS3qK1XfMiYnRT4Xe0A7XcGIHKJ7jGeLldaW2cnHBCV29VYsWUvtTOTCICVno5bXsgfqXzO3wsndxHQgQsECPegMBy7x+fq2i0EFhqD1EKJUDP++gMGI9o+ShQuroYhCX3ys2PEgS9jZN930vemGFhRz6irwReMnmQr4Dqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030510; c=relaxed/simple;
	bh=57NVq0S2AlHmeh0L3SJpPKysGLjaiNdhbzGWZRlh98Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUGEQQPJ8Kc/BRk/vP/PR8qwr+jNTm+23WCVBVd944KD+9VEImBygnk7yUh4mxRbu0gIr9Fpa7MqkIBgNUGZQiaJ792tXqLNOJr3WgGdXrh5tfLoBXFrkhT7ey6F9roSpSmKr6v0NC29lX3IQ30Cv4o0GrMjieZiKcRQ9hafcOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCyDn4l0; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCyDn4l0"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383adaa461fso637640a91.3
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 05:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030508; x=1784635308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QAFG2wBH9r9TrXOu1Xguqk4pZPLZGhj2LPXn115L7c4=;
        b=fCyDn4l0xHubwValWrLKKkd4agGqrr6elKU5JUUO4KnWA2A7F1tvtRMeqAhGyXiV6I
         99wMxaoWJ1yyUFRfJbEeKsoYjDvyk+ZgyKNb0sIWjO1kVdi071/IWY2D71dJqKvVvGHD
         3sg9HpNEj/iyxHsa+GohRxzeYG6Xk1VL0KZqsdWC2wZbMaqO3y0gCvLv/Ka+9r0cv5Ue
         kOrmtoWKJApzvF4sPkZ01CAKrhpBfIgeU1yIYdDDtculUj5FZ/SZu/6Ro2WPnlThhwqQ
         vVzr1Owa6LPTGXfB7+y2UsjhLtFSARuXtO5DUB8kQRBxWWyGuh0ZkNGWnLDp+9gSw3xJ
         Fd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030508; x=1784635308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QAFG2wBH9r9TrXOu1Xguqk4pZPLZGhj2LPXn115L7c4=;
        b=Fedku9l1UOIes1pxAjhquPWyzqq45K29qZaDOGDYEQbEPvx52Fu64r1ixFTL9TPQFS
         5dsu8PDbh8gdYmSEHXt6b5Z0iy3dVZqKOPkf78EwHCFNfNFRKR8ekZWG+Zakq/bCnAjz
         Y2dBmchiC7wULKJpOw5ZqcBwsLSPSxT1J3m/SrjFaNfklKGSgACONEJ9MDZZR7Ww4RHK
         h+emx/1jdGrnuDovD78JxvTNVaxxeAsVgpb36/Ck8M3iFFyy0co8SC9lldDy6rqwvhT0
         jEASqywZz5jHu/jcwIZIWw3rUUih9f6opUdbwFa93l39MY/nn2/xNK33eXDbNXPbZu8R
         emDg==
X-Forwarded-Encrypted: i=1; AHgh+RpFkwuNtY+MfBxkGe/xWxPaeGxBqpECJxVOeSgay3g8vvadupeuF6rI+0Tmoq+NcPie8YKwLRWgCJc1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0yFmOjyW8HXlvRM/ZC9RsNCvE8phHl5jpzfTiuRji7+JKZIKX
	3wwHsq+LoSbW+fqa3Icd784VimHSEpUoM+4H4/X4e49MSK+cDhyQd+nw
X-Gm-Gg: AfdE7ckzDMbXPpGiGN3pFpWZkPVME5sn5FNUZsUK5rER2VmjiQ2J0SHiVuluHvWoBA6
	NuZOVgZTI1nxw3UI5jwY5jxc6HbN9SxtrTVvCfmMYrdqCT9F/qanmoisE4HdVMb55ec8ko/+HED
	bZXNQYAqfUDqw2XDsYj0qvWg6mYV7kQNxvJEIrdJe+Xiu+GchXXEN34/JKQ5ckUMmexqUpSXA74
	9QD2vaypFYPXSgTFOHSYdErLNKJgNK+eMTcoXVqM7iUhafI5ihioDTqkE25S6a0yENap0feksTp
	GzgTyls8Pp2C5Dg8oHquDbqWihedVE4/8JiUVIxEPZ7j7XUAGiiCLLsP3lcBX0jwoULLA1jduz0
	/5o8ZubUokkRPVcGI4H8uSfJ/k29MbDWJ2JVqY/xgRgLvCP7nx4hIy6cjv3qdFTh3h+x5Ky+Lg5
	NreTpUbK0iOai1efAMfYgDwiHU2tGliOOAunCN83M+oIVO4OY=
X-Received: by 2002:a17:90b:5626:b0:37f:9cdf:f03a with SMTP id 98e67ed59e1d1-38dc7b85e20mr12463148a91.29.1784030508278;
        Tue, 14 Jul 2026 05:01:48 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm86725093eec.19.2026.07.14.05.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:01:47 -0700 (PDT)
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
Subject: [PATCH 04/10] ASoC: ti: omap-abe-twl6040: Preserve error code and drop redundant log
Date: Tue, 14 Jul 2026 19:00:36 +0700
Message-ID: <20260714120042.491712-5-phucduc.bui@gmail.com>
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

Return the original errors from the OF parsing helpers and remove the
redundant error messages, as the helpers already report failures.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/omap-abe-twl6040.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/ti/omap-abe-twl6040.c b/sound/soc/ti/omap-abe-twl6040.c
index 56aa4b22083b..dfa931071d81 100644
--- a/sound/soc/ti/omap-abe-twl6040.c
+++ b/sound/soc/ti/omap-abe-twl6040.c
@@ -234,16 +234,13 @@ static int omap_abe_probe(struct platform_device *pdev)
 	card->dapm_routes = audio_map;
 	card->num_dapm_routes = ARRAY_SIZE(audio_map);
 
-	if (snd_soc_of_parse_card_name(card, "ti,model")) {
-		dev_err(&pdev->dev, "Card name is not provided\n");
-		return -ENODEV;
-	}
+	ret = snd_soc_of_parse_card_name(card, "ti,model");
+	if (ret)
+		return ret;
 
 	ret = snd_soc_of_parse_audio_routing(card, "ti,audio-routing");
-	if (ret) {
-		dev_err(&pdev->dev, "Error while parsing DAPM routing\n");
+	if (ret)
 		return ret;
-	}
 
 	dai_node = of_parse_phandle(node, "ti,mcpdm", 0);
 	if (!dai_node) {
-- 
2.43.0

