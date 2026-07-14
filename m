Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEAE38D3E3
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030513; cv=none; b=UVpI+E57gNOPW7tO7ELCY5a1lXkMTM78t5AWONSbIgOztsw0+6derTPQGFCNVfvDJq9XViSTwNLI3H8ceXCkcpoSt7v39sOp+atbcR6X0fo1yYu2dmlwQIELk7bOh+NPcu0JCShcpnlGPGikJYfVaDGelaveNkTLcLZ06zOSci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030513; c=relaxed/simple;
	bh=NlZQx6KPJISsvePRiMm0PBiUSEWHpGunU/pVPrI4mRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/vZcry/DpIbYWzKsZDMF0+TDlWKZoBgNLj07xgFgrDTG+/5xC8s7UGXFe7NU+j5FH0GM1oiNN3ywOZ3kkkPX4wT3j0m97JJkXKbn80xsFdEVKB4lJCfVYA3jcVcDO/5lh2iAYr61WTdxXj1hMwg8Bt9gfbuf5eCGTdb7MMS/9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTLtVHC3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTLtVHC3"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3811f512167so4897799a91.3
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030512; x=1784635312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTW54cnVPNSCwVojo3KgK7fYFiTbsUNispplbthzJs8=;
        b=bTLtVHC36W76B18qbINjai2S8kVf9kOnIE1ULc5w8p+oBkquJ7dAZWU22seUfqBLOF
         YDwm088A1K+VM/9n2wRJRUZr0/D3nt4pyVwsHRpgkqDYsD/ueCbBtQJRfLWrFOz7oho0
         kzYp20cuxOrV1ziHqABVb5UA+AhnljiKOVn4pbLeNrRiyfsHbfToHlMQSSKZ3o0qvGYZ
         /AvJ64rRKdpMRihflvmxybz4yGPM7pkfWwzM+nhB9p3gXeFllBuvtwFEOX+dBqAW5D7a
         M7M2l7AU7oL9EpR+NIlvA9FFLUTZcni5eWUdqumF26ffLE47qWQw3tCMq9AvStYciSrV
         rn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030512; x=1784635312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gTW54cnVPNSCwVojo3KgK7fYFiTbsUNispplbthzJs8=;
        b=X8vQCXK4V+WusXoDUtGRO0GDQVXTgi6zAGAL8JK+QdCXR8uEfCso71XPyDsK1BrFe/
         OD6sK68nuSBfebYZD+0q4WYRnBC3PooUm0ead3Mhg275vGXCA9oqYDAviniKyjQy6GK7
         LYLTu5DOaHQ0BPndE+x5Ln5R0ppqfIh8t0iD3HL/jVDbzWP03M6fKYjLpNTnjd5Cn/k2
         BEEfh6xHnHeGDc8845X63llF+aOS6aWyYmjEXDOteh744Y7ZN4rLa06GwJHVnpYdWgVH
         sQ1xknrYgHIV11m2Pf64s1sx+zNG6g4lWOJJd+pj5cm6URRzW/BeWsIB7iwTIFIQEOZx
         R23Q==
X-Forwarded-Encrypted: i=1; AHgh+RogHz81zEW0d9F3dVyMmOhTskQfC2YrCZhDxhDcYn1IUOYNLnSXQJ1UY36b/Ca9UAeGnTR6eqiu4+d3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5xPHhotCnRY361FW4o0zas6AAbUJJ+J6uecQfRo3H+plRk3yv
	vW64OMFAtssRkXVwg3y6uh1nyHxF6lo/HBk96GVUnlNGU0wKVGCtDQur
X-Gm-Gg: AfdE7cnEmB5QSmsv/q6GD17mnNW5l5LicJ6b6i8p+LrvqR4PhnM40mcPVv4zrRpuqhq
	NeEtptxzgHU7SI1aU9dFpj1pRxm2/0FRqqrjYCifu5BCG1c69VClOwGIdlJuJDkFeZm7Y23ymCk
	Zqh56K/zLskiMzB08XW8U1IxYiy1K8KCaZCizFJ3NIF1SFdjr8ex6xpXxb9Wd4lbi1ji726yvvQ
	w3qcvYUkc18eA/d6GqKF5K9E2+mvCsKjmn2CFjm1ann5TAsmUSc0QcH7hNJeDozHE4zSNcnk1/C
	KtjurOQuq7sxDTPNgMmVWHoi8ADASE4/J91WmGGzczElSvO/9Kg2lyOrcDvh+2DxVzwuXSguy6y
	Zw2/QDlKZIr+ZpDah5rVgJPjN4bHHmsXw2UodJSaqeyGP6Zz3/57Wyv+8BkXbaaFH7FRN6o0f+v
	kHGNvgYZN3GCJmhsqWlc7/J+tQNRncxFOIXgOtTJ1wogJgYyI=
X-Received: by 2002:a17:90b:184b:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-38e1ae9fabcmr2492460a91.11.1784030511824;
        Tue, 14 Jul 2026 05:01:51 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm86725093eec.19.2026.07.14.05.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:01:51 -0700 (PDT)
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
Subject: [PATCH 05/10] ASoC: ti: omap-abe-twl6040: Use dev_err_probe() for error handling
Date: Tue, 14 Jul 2026 19:00:37 +0700
Message-ID: <20260714120042.491712-6-phucduc.bui@gmail.com>
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

Replace dev_err() with dev_err_probe() when reporting
devm_snd_soc_register_card() failures. This suppresses
unnecessary log messages for deferred probe errors.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/omap-abe-twl6040.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/ti/omap-abe-twl6040.c b/sound/soc/ti/omap-abe-twl6040.c
index dfa931071d81..d86cdd312efe 100644
--- a/sound/soc/ti/omap-abe-twl6040.c
+++ b/sound/soc/ti/omap-abe-twl6040.c
@@ -296,8 +296,7 @@ static int omap_abe_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
-		dev_err(&pdev->dev, "devm_snd_soc_register_card() failed: %d\n",
-			ret);
+		dev_err_probe(&pdev->dev, ret, "devm_snd_soc_register_card() failed\n");
 
 	return ret;
 }
-- 
2.43.0

