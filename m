Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9A38D40B
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030503; cv=none; b=g0bbLf0QAZR3wVYClVBvU0aLcayiExNeBXekROBy3a/KEU93pISR/K4p7KpQcAlxvghXINV9Mobb2iIV219ihcD/Hi1GL2wHMNEdnhAZ2RfbhF5waNHBqnar9KS/F/Syii7BjGs11ZyPTaHxh4vJcPFmfLuL992EtS/0nTOfmTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030503; c=relaxed/simple;
	bh=M/Z00Ke3yA1+9MMYqSqHiOnhjV5+iqJfuV5rIzAEClw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otdfMAsQmSfJ9/03USBsduhjbYwZpEXWYyAi4qi/YTIGyWjib1L0xkajMnrWOB506r7sSKCgX/I8j4nPyg5M7PvPszEMdf4/CHOnaLVeLnup3Qe8gcjS+p+E/nJZ+AuKwqswXiJpl6RRRRwKC5ZkPDGfBoxQURhKpxGKjnnNkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy1ysrJ2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy1ysrJ2"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381891a9525so4555988a91.3
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 05:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030501; x=1784635301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=urodHme3YpZA6FdePUZQkhb9Ku6VHGO5pVP1oYHnDDg=;
        b=cy1ysrJ2UYXKSjJ/fUfRCRY51hEHLdujz6PaNpx4CA+Mzs5csN6PRcSZhWSLr4rIVj
         V9jdyiiHyF8YjV9Gv1EV2Mi426N7+s+mRG8/aEFq8MW2Rwm+ecx94p9PLmfrTRhsh8pU
         5ASKUeIDqAAuw8DGl7kYqA0KEFDi+1/AsJoxY9059Xb3mXGJTvOTRhw7fAdZpuTbTWiX
         BeoxQ4h/Mb2ZMWqXKkKG7S9nyFppxXRHsAut+7/zL4lNzMWiAFRESWjtr3Milvup3wcj
         eiJTJd2wybLmP1UFKSdzhIFXzkXjNbaGZ/VI5wctPsu2LMrUu9hpsKhPl36Xqj6VnKq9
         J5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030501; x=1784635301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=urodHme3YpZA6FdePUZQkhb9Ku6VHGO5pVP1oYHnDDg=;
        b=ZZyvyWrB39DiOvf32gnJ3Rms1UtlMwyRb7cqhqIRzzqKn8UHtTAOGMyeSz1dSsfkv+
         ryFcUfLneAN5wD2Q6YpBx9H0MqDQivj6nASlbfjM2k8BWYKgHaV9hMj6/UmWFcxASfbU
         UsYbKjVBsFdwTDted1YhDBqYxpFPZa5h1p4kgy0uCgwc5EqLZ8Xh79aW00ZwhJ/VFI4O
         si/RHEazbuoHT/ZXtjszzjhRD038EoqLkbXVb0Mavn4q2gDLaz+helztV3Ta/UAdGrod
         I3Wz32ZNCZF8wDdQI1lwuhCVmzgyrA+NMvK19jul9A1sG4OYL0W8yOVjWcmkfYIryiDt
         OxRA==
X-Forwarded-Encrypted: i=1; AHgh+RqpeDt0/UJ+C5SFMVuPmD3P2nlb13BhwTAxFxoCKebqn37CPZ6P1AAppfDxJp76NshLwDgoHmt9N5gG@vger.kernel.org
X-Gm-Message-State: AOJu0YxLvJLtpY5QsuFZn3aizMflbGrHf2OsO8gkULPqfyd8jxj5Sh48
	/JOXb0673mRrV29nIZjGpnv/JeO59miDkL7hBjPbu08mcQ+S+VD2bOeJ
X-Gm-Gg: AfdE7cl0Rwl+XOOsV66QWLnSq9bjxFZQ0FUTrz1nWI/azMueHUTRaBEK5hx0DoogGua
	TxcsQr5VW0kWVjcRa4NKknabDW2XuXWKcBTWK3v/ikgdKPvsgfgDw4cazmE8+wUXumtZzVa+9bh
	HI5Ti5W8T2Dwu1rhBdNKhL0uYh8daSudE4SRkACjBGL+IhSEAESN0JJh6C/882xr1hIPTN40yVX
	sl+bqinbyz9Qv8gSpwAocFcVL12Gz9HHp4YEtd7cNZen7RlH9gyB4aUZ3yhB3eZSaVvA/PKQEMl
	RRcwYlL5p7yKrEbUPwlpKgUgITeNFaH8QtmpJYQ65NtS7zGL9Be1cxmvYdBac1McaVtWS5jFhlz
	myhUtwDt0hFpe6O+r77hF8tNU7nxxb+xhWz/0o7dKzcB7VwKAp3yUlN3E5/gvFzbUgwzAzx8lmg
	z7LW4+9FM7VVGe7ne1qmlQ3eQHXzILV5k/smzL4nUG6+UNyiQ=
X-Received: by 2002:a17:90b:3b8b:b0:380:a568:cc4e with SMTP id 98e67ed59e1d1-38e1add8e69mr2181907a91.9.1784030501158;
        Tue, 14 Jul 2026 05:01:41 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm86725093eec.19.2026.07.14.05.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:01:40 -0700 (PDT)
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
Subject: [PATCH 02/10] ASoC: ti: davinci-evm: Use dev_err_probe() for error handling
Date: Tue, 14 Jul 2026 19:00:34 +0700
Message-ID: <20260714120042.491712-3-phucduc.bui@gmail.com>
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
 sound/soc/ti/davinci-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
index ad514c2e5a25..7bcbb0067e25 100644
--- a/sound/soc/ti/davinci-evm.c
+++ b/sound/soc/ti/davinci-evm.c
@@ -247,7 +247,7 @@ static int davinci_evm_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_card(&pdev->dev, &evm_soc_card);
 
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		dev_err_probe(&pdev->dev, ret, "snd_soc_register_card failed\n");
 		goto err_put;
 	}
 
-- 
2.43.0

