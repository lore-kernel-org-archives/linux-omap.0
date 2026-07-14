Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFB8390CB8
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030517; cv=none; b=gpg1PnQ0LRXBmLFac3e8XvO/ixD23bwi37VXvntO3LZ8OBRh4tcNPmIPTGwskn3VbSjE1+CX6zGZslTN3ER+e2KBxpVELlJebbLoJqQ+ZGQZFsae4jy86fuMU5fKtsUY67R4i5TKhUSbO/hTcr5LS+T0tc8jsM1RI63RVa76Q18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030517; c=relaxed/simple;
	bh=+/YqiGn7cykJAzG8bjIMCJHbbdXednP2qib+QW4GpCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZJnHQToVNYDklbAjYn+ZcGMnzYPIR6rsyBsPcU44Jc5i/9coAogj/6teGV7XSmgJFZrW15O3VFIuNaN+5Wt4er71+Q2wMVIdAHglqJzuJAJs1vOG7BOXzv2BA/NpAlDDDH8s0W/hLRQerlmYehul5XobOcp7kYu0Jf/MH2p1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx1UWEGI; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx1UWEGI"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3847e8b0f3aso3493009a91.3
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 05:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030515; x=1784635315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2J+VREtQ4n4G6L6SKO8vPnjuq5ltVfgrR5RTZCU3biM=;
        b=hx1UWEGIPJXKPdD4XNmt1t6qytP+1sjFsNjIeUzi5ZNUCCkXP4unsRuwuqFXqxb8WK
         IgRq97O+s3gXd1PYHs8ZjlbyW1XvZb3odN7/baq5O5s9L7UU3aCS1KtU25veYQsteaVp
         1zDSZGwolOnIgY+uS1J3OWx6N/AQ4lW6SWwXJp7c02zPME6WIe28bFYA+q5yvTQDhbUl
         S+mcQnU2Thfb0+q6aF68IAbqKKQ9sSe8hfdkxjT8eqw+Tul2aYBB6o3TUVlWgmdT8mzi
         akydoQwC5xldNkVZp787wQI0Gw2zOkr/rYcGcB7Ptmd8wqxxtmDf8LUR4szR0AABP3ln
         lggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030515; x=1784635315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2J+VREtQ4n4G6L6SKO8vPnjuq5ltVfgrR5RTZCU3biM=;
        b=ILNfZjKnDUJVvvxH+ehrF+i0RAomUXB+KuxavcAR7EkUQ0eQPHTWTJiY3/4leqW9w0
         Yrny9f9KsjZ+YizBZzhxkqDdJRHT13EwB45xbaxGQ3gJRN+M8bAeiictupl54SBAW4wV
         2QB+5xCRAJYNUO/dGfsAodVCNEOac5olE0mSa47TEOn0GTT+6dSOEJKUzbCIJorsw0SZ
         +IGTxwXzP3L+jPvT2jGEkk6LGX5TCd9/R5LVb12o2eG0GxUqixjRdNsdhk7oKjLpnhQn
         2+Hobu6qxdsnZlglLtx4LNvikRSIA4IV/mQFwA8gG4qquI1Fm1StImVfrR/ZX+6gD0vc
         E6wQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZdMdFjTH21l6q0t0j26nBigrV2T7HYslfjNLo5d1+bJRV5mrZJeMMP/U8pMVPxW4td7SDZTjLaLZq@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1o1XdGVpQQS+SdxwxKG8xA5nuaiLqtM4DTAFu9guk3L1HrCQ
	CpIFdXF8RBtH5viWo5jLjMyI+bndrDoAXwj4k8s31VGqsDIAf/RBpy83
X-Gm-Gg: AfdE7clVSIv0LAJNKhRbVM9/QrAcrZJB6aF6d2Z51rrf+3O/MaxI8xdid6Ne5qqS1qN
	wWLIwiqGHhlnXzvavocvl+Mz25blpwUUlq7pEJBgsY+mU9U74n9US87deW3b/iIVB6BT3ZW5l45
	/gJ2tC+YKDrc/6pH8xKAKJ2bEpDdcF1XPPA+r88FitAfqn9GVM5eSVXoWWhIutEflpLybj1CQrJ
	niH64Gvkl1ImuyTiozzJu1EBFq0WIG9euB/AOuDQ1eRJWaDrY1f/hgu/XTe6sTHo09rqgPbYabM
	NigM35eF8Mc8FxblmL9qRaJAQbrYiSRToiz0nww7JaO+td7LBrLw17jBd/sn3Qd2ATNNGXZqSlC
	MPbrSBx/UiKzuYrPS6AvlCOIMkXJDuCH72n1PD/c7rrr4LpDZMUunySZndmEK9CusGKa3y0o2TC
	2SorXmJQ+gO1cjjVarb2uc4yvOdAtL9b4n5dSQqaBMA6zQHl0=
X-Received: by 2002:a17:90b:3903:b0:387:df8f:1409 with SMTP id 98e67ed59e1d1-38dc77d8a8fmr11601452a91.42.1784030515408;
        Tue, 14 Jul 2026 05:01:55 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm86725093eec.19.2026.07.14.05.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:01:54 -0700 (PDT)
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
Subject: [PATCH 06/10] ASoC: ti: omap-dmic: Use dev_err_probe() for error handling
Date: Tue, 14 Jul 2026 19:00:38 +0700
Message-ID: <20260714120042.491712-7-phucduc.bui@gmail.com>
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

Replace dev_err() with dev_err_probe() when handling clock lookup
failures. This preserves the original error code and suppresses
unnecessary deferred probe error messages.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/omap-dmic.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ti/omap-dmic.c b/sound/soc/ti/omap-dmic.c
index b795b9f66b0e..c8d791f05ae4 100644
--- a/sound/soc/ti/omap-dmic.c
+++ b/sound/soc/ti/omap-dmic.c
@@ -465,10 +465,9 @@ static int asoc_dmic_probe(struct platform_device *pdev)
 	mutex_init(&dmic->mutex);
 
 	dmic->fclk = devm_clk_get(dmic->dev, "fck");
-	if (IS_ERR(dmic->fclk)) {
-		dev_err(dmic->dev, "can't get fck\n");
-		return -ENODEV;
-	}
+	if (IS_ERR(dmic->fclk))
+		return dev_err_probe(dmic->dev, PTR_ERR(dmic->fclk),
+				     "can't get fck\n");
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
 	if (!res) {
-- 
2.43.0

