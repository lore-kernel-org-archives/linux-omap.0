Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF52E8897
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192940; cv=none; b=GAK6xKYwAzLSAJMxnb47+lF2FQOSS2Mb6orSMP25z9BHrrRWm+pwzcvvp5kerHB5YSX6EyjI4PJMulC+PUt6Xp1IAxmzgx3q3isX9VgJLDto6//TuUxLTKvlicydB2YpRKOrddn40sf19qCTOjsqqprXJaEVa1i2j7/cqgCIc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192940; c=relaxed/simple;
	bh=JnU7UlQSbchu2TYcv0iygOEto1dGJRIqdXNTolT4xaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxGXCCtfL47kqoi0sQaee1sPIGEaM82dzgxSB5/wRjt9ql8aAFHN7CSbtAz2XcNSThaS87yggWSBjOSwibKSlDr2YY2BI0jyCNqCmRrw+yTx7na+vdxQ9Y0y8RDkx0T6bBuGbu6a8/pw5CJVMYQ96KnhNhvr7XgUXGxKXvRmob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auGZPALE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auGZPALE"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso3185344b3a.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 02:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192937; x=1784797737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcj/2QWjWsxOQT4KfGLw5iUUwUVIUq7Ov2ZMhZrhSSo=;
        b=auGZPALEpBILaqn/rjPpBiodNTJrsoViTzgj+/+sRawC0fps402THHy9YhNE1r8rf/
         QIErs/rEIcrMhXUIiSyB/w59QBt6NcIlz6O3w6/wd2A3jJ0PMM4d32mXlhgW688mCA+z
         eWCuaUwosneXkWFvISr6GmKfOJ+SpoAxbNwpmJzaoK8vypIM9iMezXmS/akMs+WuMhTO
         5VwEr4mTdKyRsFkKBPf0+Mg0lV/lnMvCYb++GPRnuvPJER+2JdlQaOisWYchhEEcuU8r
         l4HSiw4CpdQXm1QOoZQ5Hp4GLVzMeXFQcFyCbpzZKAT047me4GMbYIxFVkjzvRwCpd4y
         jGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192937; x=1784797737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mcj/2QWjWsxOQT4KfGLw5iUUwUVIUq7Ov2ZMhZrhSSo=;
        b=kA06eu06DfCd+ofo25Sx4hwisDmNmE/K2HK3hu4DLlxDyl/m2aKdP9gNM0EIbbxhmk
         CW/MnSrhEKW5+ykEjfmp0wvy8VPdsgJh3ZyqRSIPsonaW4KJH2Yw70D8a7MsO5mOmQOp
         Nsep7NGgAF0u2pqJf/rSPWk09ySBIsMPhH7BVNnl3in4yKZk2MSFkJSzs4s9XKUj5Fjb
         m+aIwPMqOWvAsZzC4EVyP8fO/1SRc1n3rLWleRVV+PNKUNrXfqbBWKWKkqXgMGNWf/5d
         I5oGIiYdkp1R7WHjDEgt9rALZUSvyn191gtrEd5Qlpl1KjH5n3uC1rC0difZHcqpEakC
         n4Fw==
X-Forwarded-Encrypted: i=1; AHgh+RrwSVPsYPSMIaVy78LJ5FCTqCK4oX7dUA+Ujii/7CxtOlAPKvLS0yAuPB9l6bo03TwAmHIy9UM7G9iB@vger.kernel.org
X-Gm-Message-State: AOJu0YydinBiFD9CqXdJL5inT171hMF3ZQgSwsw7GfzO4hAapbRHnwWs
	m6+CyasFSs5uVB9/kJbWm/WwYzEWRHEh9+VzdZmNllInJ39G4Vu1x9FO
X-Gm-Gg: AfdE7clZmi0HqDz5BvRNCQ53qN/Gvino0Eyyt9mmDkRXHmZ4UHDZL3NXBoDAPORLv21
	/2GUx2dZaCepbCvJNC69qWbFB7OAIglugZi2x1VHkw0P7prMLbuBQ3g4jIve3OOHinAeAnhCkTF
	NQ7U7m0wQuEUF3BFPG5bkt0PvQTI9HAphvoVMmsOVsPL7GclnTwwqdX4b5oL4+70ueAUyH1YkpZ
	gAjl6L7VJ2NMOyVJoHYXuoqt1CcK5inVFcDvsI7fZzE+Mp0dp0OxTWAhANfUxZF1xGmbih/VVKs
	Ev8MH8CT8XFw88h05oCGPm5ncK7A+GzGgUWDTuT0cZIZ8gfcGcD0fWxSzEjQo4/uQq+istCdqBM
	Z6PoglFfwcgULPVrqb+gzyjRcXgdCwRWF1VaUY6jaXDi81PLutW8uuovHn3+BhHPQDXyLFvL2Zi
	xoXVAOdgYDjrhl99rEmtw2+sjFEgqw4bExUb3J
X-Received: by 2002:a05:6a00:2341:b0:848:2f84:f429 with SMTP id d2e1a72fcca58-84a6738a72fmr5729566b3a.66.1784192937232;
        Thu, 16 Jul 2026 02:08:57 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf5ecsm4511800b3a.29.2026.07.16.02.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:08:56 -0700 (PDT)
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
Subject: [PATCH v2 03/10] ASoC: ti: j721e-evm: Return the original error from card name parsing
Date: Thu, 16 Jul 2026 16:08:22 +0700
Message-ID: <20260716090829.72082-4-phucduc.bui@gmail.com>
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

