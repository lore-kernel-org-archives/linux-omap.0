Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E040A943
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198384; cv=none; b=uz/wgK7lTkqL+B984+Ge/+hc4gbxJBBcrurcidG8WJRm6Z3ZcO7x4MMl/s9Kxdi0BV8wMpeQdMLviEpeVpAEDhoywMZ9JLnwv8I8LUWt0tyISwCFcuuYBColj2MCgiTd02F1ufiLxiBGpobUNd65nn9ii1EqeCKc1mPbynuP9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198384; c=relaxed/simple;
	bh=57NVq0S2AlHmeh0L3SJpPKysGLjaiNdhbzGWZRlh98Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEASeHn514owVHLeT+IJDZrzZq0KA+6BaEFKXEiPz98aArrIlkBAJ3thtaal0YWdhELgcEDgiiowgdZmqq7oJefpcKLCZkm8Sh44jjFA6djCLuWcUPYB/6EPQPMHGKlDbKqUluEd6aV4ZPDR0FG9EGA3NwudfmNNa6MKL4AHlk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbuXCJV8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbuXCJV8"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8453427d3f4so5825916b3a.3
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198383; x=1784803183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QAFG2wBH9r9TrXOu1Xguqk4pZPLZGhj2LPXn115L7c4=;
        b=FbuXCJV8eJHyRZvMODS6/lWX/uNEKrTPr4Oz8G3DhGte/hjKH09rkEafJAM2XkZKLS
         JihlEhLhFhGsyeEv+TId7gw319opturN07orKSBLJPu48pXtIzzNeBlEPta4s5QMYimR
         njy12N7Dera4u++Qhew80vorkbGXPT1Hd0lyX49evvZk5smU82XcfWMUBeHZmA+jOwrU
         76ybt0ix7FDwy26fen/1BPjfhYqgNO/1jRMcQMYJGqfXgl1FOEB4quwvNF9l94KyZh7j
         d56guoQoVrnqVRgibgH91QncjZX+xzUd+kxvqFMd9F4R848F5Ku2GG3T0Q2A1WuYrTR1
         ZPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198383; x=1784803183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QAFG2wBH9r9TrXOu1Xguqk4pZPLZGhj2LPXn115L7c4=;
        b=oUiVtnzGtn1WHZTNvnSumuMcI/NGhy6IaiX+iYJW7d65lDepFh1MACNqQk0zIcrre4
         BeMputvp1PSzbGmJgItsz+/w9c3BNMuPVLyynhUFXjQ8X4m6g7fbC+R3n/AD9i1Onye9
         AFrC67UjTrd9/5j8yyO0TVRDzd6ycYeHONo+I5wCgygZNeZw0Gm1G9I5bBopwOtCnWKK
         xaXu3XxUSBNGn4e5hAs6dU6fGt6OKcLbF6ujY70SGVIvwiBrGwn+z+AXm1EyWbx4NmF3
         RdENm4kEL6PbUMY8roORguxf4Pm/Li4vpCb9Cbg90SLjEUVcJkVTj0kmqklnjInsjERI
         Sebw==
X-Forwarded-Encrypted: i=1; AHgh+RqP/QU0up1Zaxc3uNjweZDF34DfhdJOFYGp3UETXKmRIf4cSwH8HRW7geDApGJneMLxFauUZU0JI2ZR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw9KXMXU6kQlhUSC5FcZN9skLs56nFg1DItg6Y0TT45xW8JjGg
	LoQz5hmsHa+mKSSFj8wbUO3FLHTJ+poqfDgL3bXvYHg7kinPJcBhbrq3
X-Gm-Gg: AfdE7ckl0qOzyjNYgmjgZknF1G9rmqF9FP2+3FWhn5sHG7S07O1NqqV/HO1aqr0dBwa
	AKRlqDkXaOHXrWNEd+8rDCqAwS5+M5BSugM6o+ym1a168U2l7age2Bchjy5T17H9qwTDUf7ek2J
	Otq3ciHuZ8PYMKJzL2DiRINrwjHfeCZXZC5/M0Rbd0EVTqH3SJ5Vv0nwG43UunRJ+6tAkNyp/Uv
	IgUwjc0V3U6tqU+9EoHMMv+jWIE7ZBe47mRF6A2kM/n6Urp2Q+kb6DPOME9rgbDg9JlgrggCvAM
	rCFs9xf1JhmcNQmnBdueB9dnWnwYZ2UjQlVpUEkfQJiJ5NcoVZYfqDrWicxcoR8o0Z+6ncl4Nx5
	XRcDQTRXuBW1Iq0/xJzJNlrg8Ubl1I8X++iBXDVYldYD4DrUFVZN0fsc7RUSmZu3PbxbVekzcz2
	lNgLYSFiSIMGwnlq0yNIDLFbBfO1vThopvDyAXub7oWD44wFo=
X-Received: by 2002:a05:6a00:12e4:b0:848:6720:6fee with SMTP id d2e1a72fcca58-84a672b5a22mr6051225b3a.40.1784198383132;
        Thu, 16 Jul 2026 03:39:43 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f266724sm4757331b3a.15.2026.07.16.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:39:42 -0700 (PDT)
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
Subject: [PATCH v3 04/10] ASoC: ti: omap-abe-twl6040: Preserve error code and drop redundant log
Date: Thu, 16 Jul 2026 17:39:05 +0700
Message-ID: <20260716103911.77652-5-phucduc.bui@gmail.com>
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

