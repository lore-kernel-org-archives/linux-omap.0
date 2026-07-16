Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F13F54CA
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192944; cv=none; b=CDVZeXVhVxvYlIgaJDZ4Dx7EvcBtrg0mY78P53Z/eFPgwlv2ATHJSinkVjwYIRbYfeLBZWlMkee9PBkPRN1ZVYTUfXPzPgH0BJgznHGqbEr7+2yB1UOzNvXWvU6074xuFoiB9aQaizLyspqU9Vzv2NvBz4ky8/Y26vXztSlbO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192944; c=relaxed/simple;
	bh=57NVq0S2AlHmeh0L3SJpPKysGLjaiNdhbzGWZRlh98Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qggSvpb+lUV4C3s8Y33ZV6LJBj3/pVE8rv2T4VJJWekyZ4GKsC+pDEfDhpdiR154fAD26lWw003/WcyzN33qTpn0MtjQHmVQfJbSki2ZYJ2n3aVP8uC+KEq2MCI5uG7WtUkkXt975OkE1QQIrq5YnLt16Red6eQM5UWvxJzpqIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3BKqW3K; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3BKqW3K"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so3695315a12.3
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192941; x=1784797741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QAFG2wBH9r9TrXOu1Xguqk4pZPLZGhj2LPXn115L7c4=;
        b=Z3BKqW3KMGONdfARxNOWYPOm94NOVsspQ9PIf53shbrG7PrJaFxwSviZwfWPh5uIbf
         aQ48uTvCHPviRtyMdJG0U8wboQmHoolpc+vn2jdloUMq7pnxP7nbpdw2eID0gqPyzyHX
         vkI9TO/tDACTpy6N7ZxHieWUqcIgRtWHSFtG41wrGvMEiMIPN0TREVxL/bmhaaMM91Q5
         gEwpo5NCUDDCZZODf4MXbI2N0l7u4SrYuIwdNn4mls+aqNHMfmXjbLWKDNcLkRgx5q4c
         NSe8Nl8o282NtvG4JlsVx11wjt91CKYlkLfNhdt4ekyLHHendl+OvDCf/yP0ZfGwXWQf
         mMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192941; x=1784797741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QAFG2wBH9r9TrXOu1Xguqk4pZPLZGhj2LPXn115L7c4=;
        b=kTXPk9lVnQazuqs6DUMsgwxHRiWjdXYOhAZNmPXXCNr97MYJkySUqF5DJeMs0YUSsM
         RLwKcHikd+BqMskyeuiypzW1SxR+UQB3NWF/j6nO+v4zNcACYvD7d9tJc4GAYzoqjQ5W
         P8D2v5rOtrHJkcvaYGJOFXxdt+NfbRwaFn6V6sGGNo9OI1uPvl87D+whK3rJict8CnMp
         sULQRepoR0by6j7Yd1CEYUhql30yDX1TBGZMJgdf2k2RD14F5YtFU86EzhpO31mYIuoC
         dJ1Df4/eybdf7sbXu2h9Ne21vaVUVImPpIScv8rQ6jali1h6OUu2RrkckpYa6+tn8zmf
         5+vg==
X-Forwarded-Encrypted: i=1; AHgh+Roh/u5I+m09kYwJZtESIcAKJZK6BvtyFYnL7dKjoPABDiuy844tqJ22dWilLJtTo4x6ne6/ehqWINCF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+n20l3ZcnFuJg3Cxak/SC4R0ZdZjMztesScCWE5yDC/N3UcUE
	CGCEcWy1RVSBf3/ccIooL/GjJ6RSXxbtw67qHqmzCbZYeAmHwLLxU1B6YWvpkA==
X-Gm-Gg: AfdE7ckZ7Kqx0siYs+KN+Na4G+dRidJ1JDW9VQLDBSRKHvPtlDLE1ISPnRE7dLtsLkR
	6bKx4UjTlJu8HFL1cawDjnJ/Q2sj12GgXhW5WXhn7uekgFjjFTz/uEXxH8R9fc1daf9UBmvG1qu
	JSfXjn5f8Fn2jbb47FG1Yl/NWr6MXKzpydDS8y/uVSKnqfhDmZpxHds6W5fnTRbG4ImiitO16l6
	3qZdo39+qtfBK+oEcGRGnRvCqZBQh2LfYYEbjbhzraVtnnCGzB+jbgo/MhDklUAK7w/NJM9GjEN
	MNsAL/r8Vyw159sH0An4pQ0twTwlc/RBu7MVbWk8TmEIykfwAKWOB2odelmPUU7tWl7ACOk3lAj
	pHZ+Bj3IqPfDCGeMHolQwem0bGkEDat0c0+OCKRMNq0rxnP5tWlh5K1XuCQBL4oF3TbU6MMvEWd
	XmsLnolZQmh6GBvsfuy+MMLIcINF3Ie9s7NtX9
X-Received: by 2002:a05:6a00:f92:b0:847:80c8:dfdb with SMTP id d2e1a72fcca58-84a6739cf29mr5798838b3a.55.1784192940913;
        Thu, 16 Jul 2026 02:09:00 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf5ecsm4511800b3a.29.2026.07.16.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:09:00 -0700 (PDT)
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
Subject: [PATCH v2 04/10] ASoC: ti: omap-abe-twl6040: Preserve error code and drop redundant log
Date: Thu, 16 Jul 2026 16:08:23 +0700
Message-ID: <20260716090829.72082-5-phucduc.bui@gmail.com>
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

