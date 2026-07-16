Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448213F789C
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192965; cv=none; b=h0IGFgOnzMNnEDHwqBqu+h6NClRSTsRlWIkB+Vc3EyV1thuuElNtHzXigEVTbtfDfr7tY7sIQsOP9V1blVmpH3PLnH8fBzndljSQyUn7XQDog5eEbndT+R+DsBhf1NtOLhpjreETQxyW29lyh/zCgUDiONTFO1d6izckN4Vd6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192965; c=relaxed/simple;
	bh=evBDQ8LUTdIbeMm3xfd3E5UnVCKuP9AXVeeKznBrDQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLSmNTtMAC7voAOa6Z0hduA+I7CcBAY9ad3F0w6agLMVGkoXeFyyy1Qq2qdy+cxd+DGUbF6fGIA7yFjLXv+xbQxBD8DZnfbTfNWuirR1KK4MgWgpUp3TT/03sBYm21qtgd3dDEinULplJJKmA6xkVAJ6nHSgahLagY7Gwn70EVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVw6SXPi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVw6SXPi"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8487214ad2bso4293425b3a.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192960; x=1784797760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6457K6STfYP0yfng2102Li6Fjdx/uvYow/tpgSviBkc=;
        b=OVw6SXPikmHJYBRjyP+ncEe9ZTbo5/Rx7La0f53gzXsf0p8S1uBYx+6PgpO5ehqPFO
         GTpp5gvvIqjYcKxVs3nPPhl69UDlCQ0+cD0v41so5PHVao5GwKebMKeo0S4XIl+j9gc0
         bp2sTJRhRywTlMqzYg9jiP1GmM6i2Uwa2CUDoNETnCFVBucYYAMf55SbqvLURbNlFuTm
         bUbZ3H2Jc2nnz+hp7yvXPfqywfB42ucLHJXU9yei/K4dJJm+FfS3uih9knsdznat6xRF
         tNDf/+Cpf0dAB/7+4rppf+/qpCsgi+jv5H2CS0zaFZsCYP6ULHjtpzMPA0jhWDF8fu2a
         kGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192960; x=1784797760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6457K6STfYP0yfng2102Li6Fjdx/uvYow/tpgSviBkc=;
        b=gyY7O39VLrGaV1lMnWFarwRupjOK0rnYW96tnC8Filf4dayrHXWuXX1b8JGo3VuB1T
         ctaGtytYt4AxOShd+wJ91dh23+EtNACVjGuDwF0NZ896oSeir4FR6/jtSLbysAoiBvii
         3aZsYDrcB3Kgm/PCIrFf3ySpL4MzwFLWz30nguxA1hby2u0R02nWQLjRtfF0gskhRDB1
         8AUBXs1D5KwF/7THlIA1DW4pmnsDrwGJR8beUXuAI7M7FAsO11VInT7EpansqyneilVo
         Fc9SHu8pNIZBjGujQWaMUL8IZCzhB8fxVYAjUzREqht3Dckv23m7evctN/KGYBi7dQOF
         Tl5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq4GvccLtS7XuuBu9/6gc6E6GC8BhLkEevNi1uCA6Nmv6ODt0PxIJhcaYxTglb4/xmWE4lNIhritWNh@vger.kernel.org
X-Gm-Message-State: AOJu0YwKjiFUK3grzVYegeiyA274OC6P/X1d/4xdXrhqjMaTq3Hy4NHC
	HBRsjmU+wa+myK/EwLQsogLMlFnancnWMkYNE3gHCVHB5tfXQatL1FpT
X-Gm-Gg: AfdE7cmGNC0NdAQ8eVqhjr3Wwrkv6xFJM9XZyUPbiHqYgk+SVx52sDAaDo5zkXvEoyi
	neS/XHRtzuIgtROTpLiQa1+UrxDaIGZWg01t/9TpP5tk4pcoU1EeAQ1B+12R6lLzykVqOe+7Am+
	bfzbmVzwGX9SfvJT75iRnNvJLpGMKKFMtR65f0HKnxtPMjjCKoaK7073h8B2AMRl2Kz8X5lsPpF
	cEe14fawAo9Z4jyRjLBE6WGkE0ELEIj0tlklA3DAUUMPGwL+bHrevSZjXWREEVBW5j7coRT+Ucj
	ySq7RMLFmF9sISTNfAgUNMqg9AsJLp0Tb3jTioHjzH3iNYk+5/EqHt+fzC1mCw5PYglyD4QWH1d
	Y2+sEYYuG67tePVFOPCdPS5TmxnQu0CGYTCPi+7gn11e/hqF3cryehaPnXPKL97LIu9kmDOtqeU
	PN0e6pCV8PMiRF5AVHOzXXbjOjmlOKOQK5kVJl
X-Received: by 2002:a05:6a00:22ce:b0:847:8f0d:cc09 with SMTP id d2e1a72fcca58-8488970ab05mr19553580b3a.44.1784192959721;
        Thu, 16 Jul 2026 02:09:19 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf5ecsm4511800b3a.29.2026.07.16.02.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:09:19 -0700 (PDT)
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
Subject: [PATCH v2 09/10] ASoC: ti: omap-twl4030: Use dev_err_probe() for error handling
Date: Thu, 16 Jul 2026 16:08:28 +0700
Message-ID: <20260716090829.72082-10-phucduc.bui@gmail.com>
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
 sound/soc/ti/omap-twl4030.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ti/omap-twl4030.c b/sound/soc/ti/omap-twl4030.c
index 2a80e44035d7..576f4d3615e8 100644
--- a/sound/soc/ti/omap-twl4030.c
+++ b/sound/soc/ti/omap-twl4030.c
@@ -306,11 +306,9 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(card, priv);
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
-		dev_err(&pdev->dev, "devm_snd_soc_register_card() failed: %d\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "devm_snd_soc_register_card() failed\n");
 
 	return 0;
 }
-- 
2.43.0

