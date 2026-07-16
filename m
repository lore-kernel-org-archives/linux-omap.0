Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E063BED11
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192947; cv=none; b=ekJ79638yYn0oNhGiusEry3VNWV9NO/utCoALsq6qVkjgK0FIiCoxyegQ6ZX5XJeb3SRuQRt714/TT38OOpmhCNqWtzw6EoLjyNMuU5MVb37ZeTPa4cELmVLasC/Gw6Cm3PVuWwXAEdH8pKZd7sEZELMJ/lA32VnpMSIDyBrcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192947; c=relaxed/simple;
	bh=CoOWwx3COYYV6QKb4PIOurNZuXUVvz9Dj5UwRk88Cfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igVYmE3qpJCZ0tRGEiyzE1s3wyo5090sJWJWDpxq5xN7ntYqdUuscz/cY2rApXEFcOKYzP6zSzfNEhWFHANNG8dbbzrYYwni+/SpgqfgCDA95XcGLAIQj+Omb7UyGCNrPgr/LDNuoTR06c1egEDvDEJXtbW524zoYYKUFE7tzZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn8bSOAP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn8bSOAP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8484f229529so2190652b3a.2
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 02:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192944; x=1784797744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8RPHamdnITVkuNj/ZkeTHvpdSQod9yZXbGMbztdv1oI=;
        b=cn8bSOAP+olGB7CpaILMFcOGxJGd0cLnhwAtKkek9rcElfDv/qxfy9HHOG5Q/vIMgt
         dTDvbyqpOwyqBTvIfS5lzpGB7HQKRSrUYiC9MWlbjFaJFwaMph3Y1M8fbbDAH2DQqk12
         qXEcc1Poq2iezhUijw18XhKtmIvtYSutDLl2JKa6zIOyUnZ52VGIJ4jwRgjcRA8m0ubu
         u7gadyiczI8a6REMh8Gt9asjTsJTe1KtyKGgCvbz82icmv9303I4J/cWp+++fDaHSqy9
         UB4wB0Vy8y1UpetRz2QpM6qHF0UR1wtm9JCd2a9xoaIaFb4HvNVDNGRAa3X8No4TJaaj
         O1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192944; x=1784797744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8RPHamdnITVkuNj/ZkeTHvpdSQod9yZXbGMbztdv1oI=;
        b=pT2hZC/23kd5gxEeK+FHqEM/uMNj2TEBAT1BGvlPo4hCj7QgQkJxwMDVgDldd9BQXg
         MI8oz8K7UBS9WWYCB+IGydxJ69C6djaRBcNArxjfi31J/T2n+ddsfZf4m2bpKSCPg0+a
         7rodaMjC//EOM81OoTBLO10V/bvKcGHaQu06JLWfqhWn1YMgeHNE8s+myEQ0NzAYcZPg
         G8mAAXXuKXlOSKUbxHuMfmsjZk3lTguXI7q7s2G0YZBZqBq8PmCsZy+lZ1VpLncX//xM
         X/ZmUj5urLfoofPM56kbz9khFkmUp8Tu67H6IBsVl9Wnft+W0WSMotSkByWzG48GdUke
         7iCA==
X-Forwarded-Encrypted: i=1; AHgh+Rri6mwcvJKe2iiqv+iqFxndF2lfN4aCOY0GhU69UuJqdRtRFiCy8p2vkDGmpkxgvgnARSO4zHpkOQC6@vger.kernel.org
X-Gm-Message-State: AOJu0YxulhSqo+gu2a125rZjNd4sSHNuSC/PtI7Jg2XBgUGYTwqmiabj
	3cXiDBWLqjdH5c0EOlccFBA191j8MelcsSXnguey4BxX0wyexNyy5AtA
X-Gm-Gg: AfdE7cnEV/u/bqQW0ADDk9IxDaIyzz11qDWANNdlPoMtj6Ia06enUd87HSjCeXc4I0Z
	6qkug2lVUSmE+NFjShgDRTMfeEBqKG6/ao3OohUZnhpeMwMAhPuDLtZociq/a0iE/VAw3RtqJFH
	Ulld9sZtJV71Nhgca10u8J9x8bf7fY3RJX4bDjBwE6/T/cX2W1N8wL2ja7Cv7404KoiheVSnHW9
	Bo/AdOdq/xiHo0gKrpxIN+Opy3kqIDf2hcBDaxxbA0i5tgFkzc+7ceJ5jekmedOjAUWAeVty+81
	ePY1Y6DV9jZC1FfAiirnqPzTgPpAJ4DVr8uHNV0lbUWP8/nnAvBwVyeNxofl+rxzAev0M8cPErY
	pdStGW/qWgcpaw92oVNhy00JyIjGm6Az9u7w96rV3CYbUQD5Sjfi7l5OEBnUqfCWzHdqLopWdv4
	hUu2t0bkVVXz6tl50Xc2va2tUKSIULSi0G8LmY
X-Received: by 2002:a05:6a00:3388:b0:847:7010:f3e4 with SMTP id d2e1a72fcca58-8488971543fmr20770811b3a.25.1784192944447;
        Thu, 16 Jul 2026 02:09:04 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf5ecsm4511800b3a.29.2026.07.16.02.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:09:04 -0700 (PDT)
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
Subject: [PATCH v2 05/10] ASoC: ti: omap-abe-twl6040: Use dev_err_probe() for error handling
Date: Thu, 16 Jul 2026 16:08:24 +0700
Message-ID: <20260716090829.72082-6-phucduc.bui@gmail.com>
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

