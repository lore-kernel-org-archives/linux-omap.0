Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D733FA5FD
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198381; cv=none; b=Z8HtLGmYbKXhOLyT24R2CGTc4vLkDnejRannX8XEe2dUaYg0VaK51KDZ8UJPRjfrl7LN3lVc2SUc7TnXvlw/T3RUFM6fVuPU24ZQn08qOwCWb3lEaUpxZrp8yvq9qbHPBMeepKEXyG7VeLsjOX023a96NpnY7jOXn9Wn9LrAp3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198381; c=relaxed/simple;
	bh=JnU7UlQSbchu2TYcv0iygOEto1dGJRIqdXNTolT4xaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7lzZxPXsDtayLFAwtKk7/GPnF6IqR11BqT/aK7/IoKrOW6ydH/T4STFshyBrfQtwppnIis+XU6IZj59mgJl1ewD+pyU6hdNGC9nTe1PzFKNN1Sx8bIvb60AbQuePdGcPGOmGNkcbnlc8QuE819r6Iqu2TcI/kGuUlh5np58i64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qR5tA46R; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qR5tA46R"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487b7b3fc7so2948306b3a.0
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198379; x=1784803179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcj/2QWjWsxOQT4KfGLw5iUUwUVIUq7Ov2ZMhZrhSSo=;
        b=qR5tA46RKrz872Qxk7vWUdQAcVwTzXO/Kz1zk9XsLfdD+SUfRCEZTWyFgAkKgAHXwg
         OhxxOexh5bOgc+TGseEbTU9O/d5iP1wZn6KPPPCxhWAHt6mIXjCD5/x+IqqckC1EEp44
         5lgDfkhY/Wd3WQaRUBxi4Ekbd9bOfiy/DceaiKA5seKpvH5WbBWLYe7whrNwpanPOQzS
         vT1Lh5Aojq4P6zldNseRB4u7uhXE8tlmjbenodn+cjzuucx2bSQZ/p1O5cnLPRdbdU8d
         bR2FXGpXHvPjbehj47yQpS8lH5Fh/iPb60KNfG93jbLuXdnPamSmkHaBVb6mMYWUQWOt
         av1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198379; x=1784803179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mcj/2QWjWsxOQT4KfGLw5iUUwUVIUq7Ov2ZMhZrhSSo=;
        b=WFSlzMhm2keAVoRLz+cxCImfXVBUSzfL/uo9BpW9I3EvuqwGk9ABrEvTFabWbGo12e
         qmvU6pYRE1YMIKhsOgXLyEExSeSFNAuN4+2l3oDYvO0xnZ6pGcBE2satqYXrHHjPHIN2
         HuwqoLDGP23U2Yb0t3Deu1iEro789gPjuiwVHvQ4BBKg3ZlASq1o7qU8lAkcnTBG2vT+
         9fBFPex8ZYQogWQsy1wCvDssdU2iWz3DgM8s5hDmufcxtrql2cQeps43MYPFQexA5eS9
         aN5VNjGnTnGxUYxfinwSw41ijVCjefmWFOa6gqUd2F2U4W7FewqtJJB2XN8yEz0vw+0w
         7/iQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrml9jeL2wK1sVf0WaLLKQWLfPgFF7RhP67Lfo2vEQOtImFvGle+30cY1JUy4zG91d0xd//hxp6pJD6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6w4CnpNgWMhi0oo/70Vv5VQfPWIXcOeYqYT+UFnvpHCczf0kl
	pZde0Ftv1ioVOwl3mZ4tdaPiItm3yxS3EHlSHvNv1inUvKVzZSBhRWE0
X-Gm-Gg: AfdE7cn8YPet9UB0xdrDlJdqxBvW2rv0TrO5MNcXv9qPwYEjrf/rTHreSZT0wBx+/5j
	amQJP7RkFi+GpKOU5n/YAuLNx8h4BVUQKc5aizCNBz0J9MEHtl8HOqB37hW2ciD9+/p6xfZR4Xy
	17W+mPofNbJn7dyovY/Kbkbu2IRf2i9Tvv8Mb7e+okR34b7W4n9zsCuNziMNZ0ap0924Ih/525N
	/mJDZd4pzn1wIesTyCXhVO56KVRaa6dH32+fw+Em1URj0vUnpgvUHG47NOdXsPi/yzqslXLd5Cz
	oqn/xC+MsS29pvJDKxRsmwPX5Z0T8Ul/xe1Oi+O157Ji/SO7YKFOT59pe1Ej0oW/mMTW6Aw61g5
	6SgwmQhw0bDjLizdpu8wXAGP6VyJ2DNcXEbfeJyZgR14H0A8QW/6XWSVicR/+qckXyzQM09TBrZ
	uNxFwhE/1h3tdnQlU9ZaibTivjl3FyzNw1VMry
X-Received: by 2002:a05:6a00:a114:b0:847:439b:ae30 with SMTP id d2e1a72fcca58-84a6726fb07mr6037340b3a.20.1784198379613;
        Thu, 16 Jul 2026 03:39:39 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f266724sm4757331b3a.15.2026.07.16.03.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:39:39 -0700 (PDT)
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
Subject: [PATCH v3 03/10] ASoC: ti: j721e-evm: Return the original error from card name parsing
Date: Thu, 16 Jul 2026 17:39:04 +0700
Message-ID: <20260716103911.77652-4-phucduc.bui@gmail.com>
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

Return the error from snd_soc_of_parse_card_name() directly instead of
converting it to -ENODEV. The helper already logs the error, so drop the
redundant dev_err().

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/j721e-evm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index 312298e0b004..600897a3e1c5 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -870,10 +870,9 @@ static int j721e_soc_probe(struct platform_device *pdev)
 	card->num_dapm_routes = ARRAY_SIZE(j721e_cpb_dapm_routes);
 	card->fully_routed = 1;
 
-	if (snd_soc_of_parse_card_name(card, "model")) {
-		dev_err(&pdev->dev, "Card name is not provided\n");
-		return -ENODEV;
-	}
+	ret = snd_soc_of_parse_card_name(card, "model");
+	if (ret)
+		return ret;
 
 	link_cnt = 0;
 	conf_cnt = 0;
-- 
2.43.0

