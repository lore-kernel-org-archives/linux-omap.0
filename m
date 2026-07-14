Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DED385D61
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030506; cv=none; b=AB+k6G4UvLIWxNOo2sKWCUOP211G9LLaD0YXvD8ajBP4JRq9+9Z5WBeaEed4qHnXswgOoMS7nJ+l3JGfIGLw6YNWqDH73tzM5ZgUtmqOTjHrde1TOmcQCC8CV81DxiHEiGfQROB03fMbKtxZMGKQksTRhPklOxul7KyaltdW9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030506; c=relaxed/simple;
	bh=JnU7UlQSbchu2TYcv0iygOEto1dGJRIqdXNTolT4xaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1io7aE33gwm+opC4Rd6J0ug6W9IuGIEqij8a/WhELOztHWVsnW2V3Np2V3xkno2tbFplCckSu9raaNe4K374DOgrQ4WdGWaBhUb4LBIhAvolUEGd/wKmfOiB4FecxpwDhIugD6xt+q+iUv9zHHCsytS6sUYm0y/+S0Cn4zbu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwo6L5OT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwo6L5OT"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381216921aaso4516373a91.1
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030505; x=1784635305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcj/2QWjWsxOQT4KfGLw5iUUwUVIUq7Ov2ZMhZrhSSo=;
        b=iwo6L5OTHCBiv35bYo7eVAqFwhdrcm5dzLW+cyBN1AkuSwZvfx2PDcnIYrI/WEDXEx
         JLjFp1WxuI2CSO4mVaRbCRdA3NU6m1vBonu1M2EFtLNDbSItwhR2gh+LJG61YphgZlAI
         8H+UylMHOfgZEAUcEQ1yHBcKdqet6ZLZHgXl6vggFQV6iwrVi729cU6FiL6nSVVxmLDg
         RO4Z5272DStjkoeBpAMlIAgTfUwN/Z/twBfdgXFTCAb9hNGsExdbM7jS60x14SLy+Tj2
         /bPeF39m/yFvY1J7S/USrX20jmKIPGPvBQ8lwcmoNMv3BU9rCsrMoXrm8VF2SuJL3AwI
         5byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030505; x=1784635305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mcj/2QWjWsxOQT4KfGLw5iUUwUVIUq7Ov2ZMhZrhSSo=;
        b=ScaPfjb11SPcZImZ6wL5DtlUhFY0129Jmn7zaUHgyFtfI9jcdmzXeSrl+9/qjGeFAV
         pw8V1s8e9Q9rjbi2H4eID3ihzrocMYpdE4PEw7yudG1eAD7l4OSkgtXReF6lsf2vPd/C
         LEOVpcnq9RAjWG4wdtK+MyapXqh3SClmHJ2owFSgzOFRMTG6R70sPPMH5dxWmtzIyjhu
         /mAaI3lm7lvucn8GiLlc0WryNDDXuZMm2VscLQvEN/Ptf4fw3onQGVzxQg5Vq6475Bzl
         HwG8JjqtqsbPxJrXXGzeoP7TmPq0/zuiE3bTJ+oQWkdhZn9G8y7m3A327oxuu21nkcE1
         BSZA==
X-Forwarded-Encrypted: i=1; AHgh+Rrq6zxUaS2A8gEK0Mk9mQ4rQhNUzuJC9dTNtxSy2WlpEsHVSfVII1nuv6TXQsKHxe0fDHr8SVCn0k4X@vger.kernel.org
X-Gm-Message-State: AOJu0YzeC/Hs/rAdr0HTbLMlBCWSnTD4ouTF1n4hwTSQAq9CGaAyld59
	+3k4zIdyc4zFaYR3M7kKkDGKxRkgO+H3U/9Y9Ha48ocEROsYxLFC6GeG23sySw==
X-Gm-Gg: AfdE7cmBg7cr9kkwdnEn1WhN/gJDRuvyb9c97u13AGTN+0HaLBQ+moVHvhB5knKw9Zs
	uIF1ocI5dHLR8qFkfZ3gx1RPvxO04VdQskBTayqlRMCHByHehID5btO9EVO0a4R2j+5tm2zBeUe
	I9a+pZhqOPzw0LHXfvzPtvQL+YtZPf6FixLAcIwcX2G8TshW/BT4R7A9AGK1eHajpA9//oMWC3O
	2LK1/EMeqOSZZf/iTSSfCS5wPkqTKCLQv2gmlr/AntytzncEZgFLMv4O5Kfmm4+2duQCaB2okQB
	xSBePsuaOCysCvlJMF9AWiVpXxGt90QM78SiZtGAL9qoe5Mvb49bq/47U4o2CVp5E8eFnMKMcB8
	3Q19EBrOtxLoTxLMhjOVNqYAwSl7Z/NrFoHJrD79Vm33y4KtXUptcurjZj+98SmqKJ7vGF2V75o
	CxAnPIf38kdEu39Gadlhs44Hn8MVKjd3V94tSybFPQuKRMxQk=
X-Received: by 2002:a17:90b:4f84:b0:38d:eaec:4383 with SMTP id 98e67ed59e1d1-38e1afbf3d3mr2279874a91.22.1784030504713;
        Tue, 14 Jul 2026 05:01:44 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm86725093eec.19.2026.07.14.05.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:01:44 -0700 (PDT)
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
Subject: [PATCH 03/10] ASoC: ti: j721e-evm: Return the original error from card name parsing
Date: Tue, 14 Jul 2026 19:00:35 +0700
Message-ID: <20260714120042.491712-4-phucduc.bui@gmail.com>
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

