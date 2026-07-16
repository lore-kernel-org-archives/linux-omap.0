Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84640B363
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198388; cv=none; b=XNwq2xOr9NA5J0pcrHNuKENTIP5vSIFogoRdCE+cImEiiGrjwOyb29WQUHisNqWdB6lBRCkzvlRy7YMbtXf34gaclemoSrXMwNmgkT2gD4y82P6RxBCFJZgnwsvfwsfR+sAPy1+XKaMD07L8hfvYEXT3XYFDndqY537KqErXLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198388; c=relaxed/simple;
	bh=CoOWwx3COYYV6QKb4PIOurNZuXUVvz9Dj5UwRk88Cfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEpoHpV9JxvwIXF0zNyApbMd9ldetcI3ESOBVcZG46uM6qdf+i+quMWz3+TautuRtlwdIZ77b7h/Yj0VCzPowxPcsxtGknahka7IERniEaw5K4OiDMGfpASRNPXO/lccFm8ytXacvVLDngWgip/jSnM619xKFplndytufa5lx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdqDD6Ww; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdqDD6Ww"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so7526705b3a.2
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 03:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198386; x=1784803186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8RPHamdnITVkuNj/ZkeTHvpdSQod9yZXbGMbztdv1oI=;
        b=jdqDD6WwqHh085l4TM67AqBHSiQqvps8LR0ymxrZ6l4IJlrJl4q/BUEoH0c33GplAC
         M0RMnjrpaJMP3iENjGGELu+NQEl5b2x9Khk65HHm+2zLWBk+a6xcARB/DER8Iy0zdxZP
         aqfXDgWzxlMjUHouGw5RE/3/B9Sm3qgfpenLZn8BAifxzxIKQ37erWGLZhaIdYvsT9gT
         iM2sum+8COuXcMSHBaBOxdJzJjhHs1GM7mBrpTnzvs8a74kWD5jHzmvqExtP29rNOUjx
         fBXF5aoscoLBgiK7pgQcVpV1n5uzLjvjLokzbmpLF7KFU0OPnUEI0wIKpQRq1ql8t1gz
         o2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198386; x=1784803186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8RPHamdnITVkuNj/ZkeTHvpdSQod9yZXbGMbztdv1oI=;
        b=p2QfExTKbPtG0CNIKtQO/aHcY8LveMke7QwjqubXmZXxLttRF0Hiqs4WvC2wItXlss
         J3YVdNYJNyb5IrsUzuGErqFKOwjgsBeJLTU2vFjTWCCsA5dVqdzqDZFrUxk4a/ncFs+J
         6jxjGJtXb6NQJzvwS+C69EElhymdum55EOAu+yW29GwEHEuwsBktBQLU0a9R2/1m1Fxb
         Wzma1Zi4lTDL0zGEn/Eg6F4FtA6jpsnQiUghYJPG8HfEBAw6iMpd7QS3W6ZRQTQyJGDY
         +NLkpiobCLEtRSt5xIGFK5nqj1tWqgy3K3knJB79u/aOWFuwppaB1rPpBGl87kUdgF2R
         ScIA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8WPaCri0wqYV85JHg/7VAsD5wUR6Lem19U3PdkUR8jeyEncBXM8VpaVt84/kOe6uKl0TwPCExX/tl@vger.kernel.org
X-Gm-Message-State: AOJu0YwlaZo//wFA8VRejqJpCZQuL6m1GvnDO62s1BXCqhQpgTq0p25T
	GqhTmRZFxaWNzcACkFtPjcjq87Qc1jWAYWwxjqJLgbqNJBHluNIO+IHG
X-Gm-Gg: AfdE7cmwKKWbPni6m3JStgebgqanhWNHAh074wpNisOyB4ZLO3DowLdsyFgGOnQf06t
	HmxSnO/fgttExvLaxygtDzXVn6ILSLE6j82ZhbHoP2BnAL2cjuUKDh9NFDTN/Znb6OY0AKv/f+B
	HP/xAFXzz7W+fbWDwOkBTe0gOg/ZGVCa89egbzMhsi6t4PfNtS671opSKJdKFlXTo5zkSF99859
	imMWQQT2kSdZ/A0mwbO4fTN+wc5m6JY0PGvHeOym3N2pYX4BO4PvSf6yMyx6ScrARdwGUUO/oZm
	tA4ieIQ+weWlY+l80LwLsI3Te8CSLliwoLZaC9gF0nKcPw+IZiV//0+eaZJ5zr88wWsv9uahbSv
	wHHZviemGDGWLel2ddvWNO51L4aPxLUbfUhOXO/itEzUdIkpQ0gXnibrH7kb5pGZrut2j/Z4jWx
	8s+S8AZcyBpbB5V7QiqfG5gWLVhKxtf1bIXxNC
X-Received: by 2002:a05:6a00:1492:b0:848:727f:2c90 with SMTP id d2e1a72fcca58-84a5163090amr11894976b3a.64.1784198386606;
        Thu, 16 Jul 2026 03:39:46 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f266724sm4757331b3a.15.2026.07.16.03.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:39:46 -0700 (PDT)
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
Subject: [PATCH v3 05/10] ASoC: ti: omap-abe-twl6040: Use dev_err_probe() for error handling
Date: Thu, 16 Jul 2026 17:39:06 +0700
Message-ID: <20260716103911.77652-6-phucduc.bui@gmail.com>
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
 sound/soc/ti/omap-abe-twl6040.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/omap-abe-twl6040.c b/sound/soc/ti/omap-abe-twl6040.c
index dfa931071d81..05239ccc1f41 100644
--- a/sound/soc/ti/omap-abe-twl6040.c
+++ b/sound/soc/ti/omap-abe-twl6040.c
@@ -296,8 +296,8 @@ static int omap_abe_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
-		dev_err(&pdev->dev, "devm_snd_soc_register_card() failed: %d\n",
-			ret);
+		dev_err_probe(&pdev->dev, ret,
+			      "devm_snd_soc_register_card() failed\n");
 
 	return ret;
 }
-- 
2.43.0

