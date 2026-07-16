Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12413382CD
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192932; cv=none; b=dsB04/h7rkYjea5RlZwpoir3TKzZzZdwsZFucuGmvyv0hcEnZaSGL1bImVSJFokGU4FYM3+0JeOyrn1fnN8aJNhSHdfDJybZSyXpozLTBVambjT/mIWcD7R+Fcuats5WijRSr43imhzLM4bQCAn2EBJPIZS23xtlDJtVo23cRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192932; c=relaxed/simple;
	bh=RLI1cm6vDJ/qvHX01qZ5rV7ItrD31X33omgghTgOklQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgyPnZ6UOfdVtPTGY8VO9bS0iFwcE1BXD7JuXNdk924SJX5GPZwwEUw4kfVWEJ01YgC47pTkLQbLrSsRvtqz4JnKJH4Eohu/7Vn5kZJhVhtqwnsOb3V9i0JnH2YHiB52ZrN8GHHkZQnNUoheS53rPIm4hJM3NAK5sMNCrInKq6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gg3D4hPy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg3D4hPy"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-848882fdb18so3272061b3a.0
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192930; x=1784797730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W80Qi/i0Jf8/TxgRoeUGM/YWj0mtv1cGhzixKatKYRY=;
        b=Gg3D4hPybJz52Zjf+xdmp4uQwPjkocB0vJLCn7nzf7REkWJQFBoO4v6p0qo0v6HtKD
         8nJfeKJ2Z2UEzfqB3ju2l9IYsMjyuIGSvf8ZlJrqXImUDh5DxEyIndadofe9XVqpZ/L1
         1s1B8qmUH/GCOhuheuFxukYfzU4dC8lQxXNiLdY6mprokTl6A/cS8ZkG02suhU9VFoda
         5/OR2PJgjjm8EwdYuNsDnf8ifpHNUdTVrkt7isauOFjmuGyX0W5H+mm+Wo+K9HRLr8r/
         +PSmTCJtFebYbZTzSasEqZI8SXQEm5sn5RucnTmCypnepurA6n3H5rNdw5VjPGDwypQv
         xgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192930; x=1784797730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W80Qi/i0Jf8/TxgRoeUGM/YWj0mtv1cGhzixKatKYRY=;
        b=J4FmeSnIxmHb0RUFgjfSJRvFkexR++gqMQVqzx390jGu0+2zERkcICiY3oeD+3+Tyk
         crjnem23f2HzX/1VxbW1bUo77ZJV9WYWrWommgtDden+Uzq+ih+GQU5dy2WOZGYZaIVv
         wLX+HEc7yHUrFjQdoVkoe/QCcLlo2vHDK3dypqeTuKv4V+i9yYBSCCu8fHG+uqG1lS4b
         nL1AcEF+PvRfriThDj/pj/17Cf2aZebP1sShqY3Xgp5lvWFludNhzCy/fTmL6L+U5zn/
         LEP7CUmC5Otq0IIcqgKtpb/9cqDsznxPodg4qlyNr0lyOvdGanr9moYNfN/Pbrr/giTE
         aHog==
X-Forwarded-Encrypted: i=1; AHgh+Rp+2kh/HwLCMp1n7rUFiIM0BfKFSzOHVZCLT6piTr5lLfFtXYr6q8PR7sDxWYoiGYZmt0Xq94CtFvMU@vger.kernel.org
X-Gm-Message-State: AOJu0YzvCjldze7/zJZ7GCAdcnoFguO31i8SvSNsmx9Bpm1DXSM3vcuH
	TN9yg4Uof95rAGK2XNDVd1pkJ9/QDTpPOrzVSEz+3Y8q0D68hoT7jC1a
X-Gm-Gg: AfdE7ckEnOuOBgFf1ZKnjAnn3XCP1W0/FoMAgLx9FFFes6ioDE7poD8G/TppyqqpD9Z
	k8L+LOjyJf4YQxAEBdbNSafzHkzEhIVjMzB4pBJPEUcppETBxhoaA5gAkAHpr+krD2tzU5QBYWA
	o5Ew5CH8g9u1BLOqJ43vceaIJI71i4JkV29akmspQpZkktOZhO4092N3r6yD5kxN9rrFZbwIA6i
	SFWElsNpCndUcYdU7qSkjoccmjQYl3khNW/VFrzwJ4vknuQyhSuoxPkfSK7ngLsA7FlrXLHGg2r
	nF2/PcjHE/R7f/Y+0jgMGUxWz8/3+B1vvheL9FRRbvjRwyysU3J9nOMW1befCHzvk2qv5Uph+uf
	L3XD/IDKqXOEIAFmxdjlAI027l4a9zHg7HnySCkcQV7TLo1pxVheqKQdB7zG0CCs21x++a9iSwj
	lb1ge30RNzXyAY0DI4RxS7h3Q62DjbNwxf5Rxk//yzlQDiKe4=
X-Received: by 2002:a05:6a00:8c2:b0:848:3e74:85eb with SMTP id d2e1a72fcca58-84a6723f511mr6037108b3a.1.1784192929938;
        Thu, 16 Jul 2026 02:08:49 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf5ecsm4511800b3a.29.2026.07.16.02.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:08:49 -0700 (PDT)
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
Subject: [PATCH v2 01/10] ASoC: ti: ams-delta: Use dev_err_probe() for error handling
Date: Thu, 16 Jul 2026 16:08:20 +0700
Message-ID: <20260716090829.72082-2-phucduc.bui@gmail.com>
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

Use dev_err_probe() to replace dev_err() followed by returning
the error code. This keeps the error handling concise and
suppresses log messages for deferred probe errors.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Add missing parentheses to `snd_soc_register_card()` (Christophe).

 sound/soc/ti/ams-delta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 61252359d5cb..2759b39c4ebe 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -574,9 +574,9 @@ static int ams_delta_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_card(card);
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
 		card->dev = NULL;
-		return ret;
+		return dev_err_probe(&pdev->dev, ret,
+				     "snd_soc_register_card() failed\n");
 	}
 	return 0;
 }
-- 
2.43.0

