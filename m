Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C24071D1
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198392; cv=none; b=imx6pJc52oTFflMtPe2I7K8uE+GBr3XMm5fp6CFHWz/tdlgsg9+KhY9yKQKqDK9Ckjc4SkuKct1hRClek9KJ4fAlPtDcA7NMN1Ef2jooKFbPkiZUeU5gaWkByLO32DofUREx75wpzMBun+JNo4pa288c2NO3C1Glee7xSuDOEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198392; c=relaxed/simple;
	bh=+/YqiGn7cykJAzG8bjIMCJHbbdXednP2qib+QW4GpCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTgVe5TBesvPx8zgB1G/pmfcAh4Jnro/rIBtp0KxCNbuLsDlQktdtetO1sRGLwVQhTHA1UCdIShvaemjzokhoflvIzR46vfpop6fO6Oyz07FEPCje7MzQNGT65BJcbKr3TGomgRcLN9oFCzCgAMrjZ4BtlLlcWTZGi71QmNLdZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVo5fh9K; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVo5fh9K"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so442378b3a.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198390; x=1784803190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2J+VREtQ4n4G6L6SKO8vPnjuq5ltVfgrR5RTZCU3biM=;
        b=JVo5fh9KUslZTmDvh3qiwKcM2KBMtLegBEHjH6pqw/dwdVqSo+yljXGvj4kec/gytr
         kiBkpnrEK/V/dyH/lNiZ7Iq9oGbBc8NSKUlfA++XEoQdVYEYJPyWqjl5aLo2ApbNR7pA
         yxGiF3gvnoRsmwbcT52buNQNeAp8fD3HSPbNiX3n/YVaTBu/wQ9WsA/NjMWDSn9/2zaT
         Wx6B3qGlS/q3MMZqf8LJ+FPEY9T6uQDxxsliZw7VVMpEFWaURvUy5yExFgoj012dkWrX
         RxMKoyX/JNYbETj+IfbVBDCGWHDz+91G3bMtJSjjbEgRACdRXktpHDLZbRoxt79PARKV
         6lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198390; x=1784803190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2J+VREtQ4n4G6L6SKO8vPnjuq5ltVfgrR5RTZCU3biM=;
        b=Mk8NfvknTWfKL/tsgUZDl8v5TV7QtiC0D3mMBWbU0is5+mtNHZVtDkUbDE/cS+hVzM
         BJum3/omm95dA2QpaiQuOawproXGfnHpuT9oCnZvw3PCmN2DSwa2nxijg8uN5M21agTG
         fbMcF5IEIx86Ds5c1QIqpL20XJkW8EeP5nClNFejNMxiS+4tkk4heMNlfqsrqKXQR7eY
         ibH1YlJIGt0e8ei5RvjgoivD4J8jnHwpvQOe2O7hpTrhUCpNs6LQfoEeJ24CoDgeGkha
         QFZjUd8vOLh8/1qHuJs5gEilwGWBVsl9rX838YH21n8Y/t7T+Rs5IKsdf3oGobXSIDDl
         Ayng==
X-Forwarded-Encrypted: i=1; AHgh+Rp6jMUwo0s3yAIM3hpq34XV3OQrSMQkczaP0rpXtCo3diITp3gW65j3xjWZNl+WNTjE6WKMSaWK0osL@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsr0VZa478QJXCXjX3KbCxl9OrgSITpK6uhxABf619Zrkr8nP2
	Ep0mTy5674FvZjNil+rAZbu5jd0Bq4HPtB9UxDauLGpZw9x941xfR/MV
X-Gm-Gg: AfdE7ckRPzalLHO9sSGlqt5j5GEulMeFFiWltOpvTTgYLw6dIcFW43lVl2u3H8yoKyz
	xU8Uk3X8Vs2fBh4V/IxCoJHD4nr9yF4lvQAqEL+zoZ3xJQrkmQ69HWo3jMIHL8Lhh20eScmjaMw
	7aGCYOlFedYtL82zURMrZrVWoMEiWs/+lYtAjZylF5p8VB6VCa83N8O8h78nZKFcYn5c32AHCJF
	Q8vi66jtw3HXfZUwRghmsV2a1aoNspA8vcAF1YxY7id+5qCRG3ij8GO4kQw9gxY9wlgX3ODHI6J
	D/vSh0xwJK0jrjdg2X6HaFvMuSkmP3+AIwML6GYWKheGLwHTQTocPbXelBE9zjNt0wuaLouA8c9
	JbpKkloWOm8rkXcOj0+dxQUq/ixcLk8JlLwGsuJoAV/VCa/r1rRBCueG4r6IS1k9LMNDCuQAK4Q
	q66FszepefteaZWqZXNWBWyp4Jan2lq68+fBgg
X-Received: by 2002:a05:6a00:4f93:b0:847:7cf2:a8ff with SMTP id d2e1a72fcca58-84beb43958amr1937445b3a.30.1784198390379;
        Thu, 16 Jul 2026 03:39:50 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f266724sm4757331b3a.15.2026.07.16.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:39:50 -0700 (PDT)
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
Subject: [PATCH v3 06/10] ASoC: ti: omap-dmic: Use dev_err_probe() for error handling
Date: Thu, 16 Jul 2026 17:39:07 +0700
Message-ID: <20260716103911.77652-7-phucduc.bui@gmail.com>
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

