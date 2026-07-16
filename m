Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5E3F4DF8
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192937; cv=none; b=KYiJyr0hMCsEcOQLssCmor0FJ7Lp5OWiy+9unfxig3s8UCNVWoDY9LsgdoTokYKwSo9lcAH7Q6EVfZRfE9RhxfWJ602uY4VTx9sNFVnuRk6b1usM/Y3OGKwgHtUb5FMrjOSaRr+TY8G8WrMeQEJgArhW1KJoby1Oya9J9yl2Pqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192937; c=relaxed/simple;
	bh=bly5g/vrF4ctQv0fYWIQy5hsDFKEKRsbvFXr7VSnXeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDyOWyPM6F51Ww5V7yJvmvJ6uAczqso7hsxYaz7p0eDNwm5NoA4aIxAb85KA77cAIbvpswdLJ7HbBcaAWnl3N64dwO+ZVz8+CnlT++BWaKSIcCQRJD/GIJRsLpTLsDafVTmOBg/sFPIgdIFL3bCHaE0+oM12PYFTQDmGT/oqiBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0sgALZ7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0sgALZ7"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso6938242b3a.2
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 02:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192933; x=1784797733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yEt6Uvr9Ac4AHA1sp4pMgGGdcdpdh8Mxz+CChY0s25Q=;
        b=E0sgALZ7k4NTsQOoWRFyZWdErZyX6dIAPflc6KnehuFV7T4Mk1Z0aXyLl9Zov5SOHW
         744JbBMlSVeyz0+U4yC3R30bfBPq1r0SO7Zyh1e5u6T2jGt0tdD7QjvD43QZBg6de5mn
         8TJuMFGiCWByd2mRIbHjPUoMV+LPqMbJ5s3jcNPiXksxkzCI7g50CxNEu/0oDlmYVql+
         UC6cQ6xvKB9w6yLZIEZUIl05z92tEYIVTl4vvzGtXmCx8YmVZJXRl45NpOFJiXX2MP3C
         svWaSXit0JnMYdb/njPML74j5YRZeo2AZQo7ldnFLJCwAgmcbj9sbR143ONiJXvHu2oZ
         lleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192933; x=1784797733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yEt6Uvr9Ac4AHA1sp4pMgGGdcdpdh8Mxz+CChY0s25Q=;
        b=d/Sa7K/64uV9lXAOkUqnEPMdiBCaKgFnDxycB6OD4fgrxSLwLhD6GFND+aBEbkGCPu
         W6vyGQ3CDIgYUS/eY2Ml0KSahiKhDGhFlDw/mCprLTgW+gbEHrOTqvphtsO77HJfS9gt
         t+CVb8GLupS14ruXT9sW34UW/SX6ijgqTM/CUN6KN0y1KmTLxsj3EbpD/3BktnMCzGH6
         AeBcElUIQP6MAZfxuBmWhaHuiJvX749wD/tcIbq1vCJdL99AHtcwVAJ25+rIVvb28IOn
         /0Fdozx0d2ivEpWIlgO5u0aOuPU9vgPyLYmQYby2ADz5t96n2UPbWaa3IScdJQA7YGQR
         91DA==
X-Forwarded-Encrypted: i=1; AHgh+RpCgwZo3hBvFxN2IGLdyzpEkcbe82HMHXGj2zT9lQV7bkbct164m8CyG3sbjlleRxwKPfdvvwx98fwC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1iuDlZl5DXk29hk63ocwYkjYzN3Er0PwXvvGLL1lSlhf017BS
	FHeH2ho5mRY2mV5lJtK78uIo9XFRMODyFmaoAUWqBZZE7BWHYNTEIpOS
X-Gm-Gg: AfdE7cm0nROMaS02TGRk7EFE7tFN7DrroaoEXN6eq5P0JPN+1bGyEUXsCa9IFEnm+fS
	z2rCAcYwkqlleYX4vsNvBcD3l1NlDWZbBIiQpD7GaX7v9EfPFGdujNIg8PTNyUcCMBZ5SMFHEk5
	fkq3FGKdJ/mJqPPoxyBQOf7EQ8uKanrR658tUGjLcVdJljFFsKWdtBxTo/ECfO9as481iAVls/6
	zcJ3IxN4TaxysB5U065fGz17gaUjEIl0mL/lEkhhYWaIiSZIDCNK4o5QtWqnoYXsRkZ+ak0PnGF
	1OPrJw8M7EfvZkUpssoykorxohpaC6Ls5Rb4t2la0DQVyLKVFzIqfJZD0BTBZXuS/voRPe1N/s+
	zf6nvP45+oxOZyZUm9hD4HixYksG1GBE/DagUBcA36VphZooczgi5m5m15MzQu2cIb/BmpXj3WX
	lxa2r1thqOOgvRRlPgVujjevKJMS/6YqJ6e0IWVwcwzJ8kMdc=
X-Received: by 2002:a05:6a00:1495:b0:845:ce5f:c926 with SMTP id d2e1a72fcca58-84a554fa572mr9058478b3a.1.1784192933594;
        Thu, 16 Jul 2026 02:08:53 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf5ecsm4511800b3a.29.2026.07.16.02.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:08:53 -0700 (PDT)
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
Subject: [PATCH v2 02/10] ASoC: ti: davinci-evm: Use dev_err_probe() for error handling
Date: Thu, 16 Jul 2026 16:08:21 +0700
Message-ID: <20260716090829.72082-3-phucduc.bui@gmail.com>
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

Changes in v2:
 - Add missing parentheses to `snd_soc_register_card()` (Christophe).
 - Remove an extra blank line (Christophe).

 sound/soc/ti/davinci-evm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
index ad514c2e5a25..3156d87a3a12 100644
--- a/sound/soc/ti/davinci-evm.c
+++ b/sound/soc/ti/davinci-evm.c
@@ -245,9 +245,8 @@ static int davinci_evm_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(&evm_soc_card, drvdata);
 	ret = devm_snd_soc_register_card(&pdev->dev, &evm_soc_card);
-
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		dev_err_probe(&pdev->dev, ret, "snd_soc_register_card() failed\n");
 		goto err_put;
 	}
 
-- 
2.43.0

