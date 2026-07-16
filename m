Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9373F870C
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192954; cv=none; b=oyjl8UrmZ/jWoc7eIONNlWNjKmKkmAt5031DkOuPxP7etGfkdpDA427Cn/kCrJMdDfP9x90I4h7YFixuiawoygCBayDlDIQlJ5Nc2+MwClpSlfdzEGBaizPPbIjy4haaagBBGPVbTjBwinEnanHt3zP/HXRpwYleHoxr4cbbuJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192954; c=relaxed/simple;
	bh=+/YqiGn7cykJAzG8bjIMCJHbbdXednP2qib+QW4GpCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8e+Qs7exOTd+Pvup0cOXgY/epCvtlc0vJUFHHVEp12movlDkZmYG8gOSpBUsleKiWmpI1+ZeCnNHLYHsgS7Z8bkWG0B6nYspPT0MWLaAW5jeasXHdM2qpEgyDIZNkLrU4SNV4teaxm0gWIuAIEQ1Uk5yOsH36LK5OVMKPJw5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLrcm5CV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLrcm5CV"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848595b338cso7455371b3a.0
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 02:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192948; x=1784797748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2J+VREtQ4n4G6L6SKO8vPnjuq5ltVfgrR5RTZCU3biM=;
        b=kLrcm5CV0TJRe8Yhf9Tf5K6LGU/NfMgs5iOcQ3a6UYHbxstUqLuwmblrlQORZVtZDt
         GMjxDw4a0y4vLlGmqTkQ0O3XX2oDrAUoZTjug7GeAnuW3yTdhpPB1M2flOY0HadbFnHk
         0222vGaLTXKCcqS7TT6F4+5eO4yf6nvjlpkz4AdY9xxHSjjoIHSZ3FGJ1d+ARhMT9sg5
         pqVw2IBR14bidhvk8BTjbDjUyDfqw6xlw9/xKOaH67otZYiVGrTEEdMMnYhLGK0pQvp7
         Q8qdqdyh+E0SqHUutsNLrdc+DTflMBXLmI+7F5YwMZUJgCespIHVX8gRZGNsTWPjMQpA
         YQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192948; x=1784797748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2J+VREtQ4n4G6L6SKO8vPnjuq5ltVfgrR5RTZCU3biM=;
        b=h/duJ9rTizwF7KfO0xJIbR5viSu1+198YEsjJL0fP7DREP0NCs/hjw5QsbbT+ROQyp
         ys0NKpGlwIUnWfdxC0xQtZpIaphUprlxSxzqPWpzNstzRkOdeW9MQlYcrksjZFRIBMbP
         hnUKt/cENokraQwkELXkdNh4/PXAhB1o1R5iCfBJBLU4j9WiZs4XCgljRNkTwLffV2WH
         WV6op+zFv7xgBzgOHkD4ZCPaoqc1WVPX42RZjYCWbVRMP3QdAB6gQTa+jLNNBWIMFafk
         PWJi2P+lxlEintuHDDW+HbWpNIdTDLnmqlugK9oeTdsHey9tNCPgoxf2b5WfxilrVuSa
         Rxxw==
X-Forwarded-Encrypted: i=1; AHgh+RowWaIMalVkwJFjOaCaG9N4DEpE8abFEfJVc6bzy45vTagS9qG32aLmrYrFI3eocldWD8WJ/932nc2w@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqkCUY13sTf1o5gJIRm+3Qhza7JjD0vxVUqW1uZvpxaQ5Ujuu
	NLP2t/z2wB+9n4rGdbYYrKwD5WjXKe81JiyGlWlnfUGNlhvXnyO/eMzX
X-Gm-Gg: AfdE7cnCfIj9NIzO2znyBROaWVZ/5snBmPw5VBa8BjlWzBFeZHm4ytSaLnvvdHcRykZ
	79KyvXE4NfBFM6XE+Lt3Qny7Kpk+Ux/5qo97TeaZI2pdZDnZ8FXOVmLCKKNUlTfioLbkzb9q+ey
	KP0NDNnJd5rRTRAYGhBTXxBTCzekGwh6D27vOziG/u4wB4nXGnIimlpDm2Vzj+p9HkreG49JkRM
	3xz4bKCDMVJCufFRB8u020jOe+Lk0oeFRzKkcLx6gyl+ae7IjVPZ8WvnzCxQBIAeIC4dTIaBuqA
	W3jDmaXvBBtNxcfJpQqbrI04cT5x4Wj7nf97YMQLM+EV4XiTViusTKi6bAwXTs/u+6i7o9GYvAm
	p5cen0YhBSQ1TrOVD6x+l3u+WOLirUkk1hhdrk7j1JLJYM5pkkmDxKKA4LyOqRuQM0qqyv+RAe8
	rzvlFdaXMmMJ2HDFs7I31eYC0bRoaAttIGy9U10+pC6ICP44E=
X-Received: by 2002:a05:6a00:3e12:b0:848:2f6e:e537 with SMTP id d2e1a72fcca58-84a5588c65amr9075061b3a.75.1784192948259;
        Thu, 16 Jul 2026 02:09:08 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf5ecsm4511800b3a.29.2026.07.16.02.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:09:07 -0700 (PDT)
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
Subject: [PATCH v2 06/10] ASoC: ti: omap-dmic: Use dev_err_probe() for error handling
Date: Thu, 16 Jul 2026 16:08:25 +0700
Message-ID: <20260716090829.72082-7-phucduc.bui@gmail.com>
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

