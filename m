Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4803F8ED6
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198374; cv=none; b=EEbHM13dKO49oBLmzQGOZ+W6gUIFq2geXp0EIB52FbD3nb7jxUSuCiLRiBgkSmXe4LcFUFThM+R+z7WVbTJt1xPJhW2d6c9qZ1JM2tj8KfHqG9derbZYEZyisAUAQX7X27vMxz9OsYfr8bepNY+dG0OeXHUlPQF6l0VJlXobMYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198374; c=relaxed/simple;
	bh=RLI1cm6vDJ/qvHX01qZ5rV7ItrD31X33omgghTgOklQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPSvtQYk5W7hHIh0YfQ2IWbjjrjiNonFm4BWUQmtPXcKzkdrKagtG+cDl3jX/jENqpqA+FYkqduPHs/7sPAD/jMGZz0ZXWW9AWgOzAubmbJpORrdilD+sj3UJIkoyLXxfF9BPEQEnv4/scd7BlWDJD0Fr6owxyq/fpB2Nh2SQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJENy9pt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJENy9pt"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8487b7b4066so6650929b3a.1
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198372; x=1784803172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W80Qi/i0Jf8/TxgRoeUGM/YWj0mtv1cGhzixKatKYRY=;
        b=AJENy9pt4MTkwYyDBe8SU1J4ZpvRcorXyNfsTFXTTc+s3QMpH/hpVa3t8imByrAQs8
         lh3pF6l6cSsA7b1E6GR0GudG8pZVCzhSbRhTpNl27e2C3sJaPz+jd4aBmXkZjuDpp9p6
         eNNA8MzK0d9D/lYGdWp97I6cGc/PIPvPR6NElcI+9ZHILQrBe+khFfFW1MLqoYp19uNq
         Dg/mNNkr7gJqTYMlldglJsmnSeyNIDdKBN1xvO/V9eZm57GUpUPl4iTSRIyPDVHVAMSf
         7OBCwMPxa2vXsYj4Ss5X/JN5LNObFP524BHH+nk4d0jIqy64Qgkc099fMNFbuP7M9QyP
         L8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198372; x=1784803172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W80Qi/i0Jf8/TxgRoeUGM/YWj0mtv1cGhzixKatKYRY=;
        b=gaYZviiUDnRTwAcukwTPMoKZe6uL2JkVhhO6eOr5WUMe70YOetzJrSB+ifj/Iig9qp
         2T6xB4QhhHvIY26KSan7DyEdHDEGwR3mBB7zC4FDC4AfyPNqzjkOv8Sd5ru2e78D9OdQ
         JzXDwNpkwCGwC6LFvG4NYRReqbFA686bFsQuFrSHbIyoPzcJX+GUG/OVVctb7b3rqGFJ
         FAIFJl+HdrVPrHNW7xEKBzGiekTwtEZPLzHriMu2ypV8GjY1NZobb+adlWcGcoPyKRg0
         lImPMnJdolyU7vL0GfGpcwQxY44fEHQLFfwhuZDHlrWCwq4LmkJKgbZfwo60lv3QO1xQ
         wwcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrAbAqRLgxwMKbH3cMdSwhUVu/GZShbIKhTxjFkY/bo4MArvxt7HUoTdj8Egi+lnZwzU0eR4x1/oxik@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKNqciGqfESx9nfaJlolL0x+shKxEDaiRbWhiwGzO/1vmtXXN
	nwrm1LgFXmYBZDPBvkzTF8BypQdX0dV2ghcuEQa1Y9xTKNEjCRIb4oIBjOEnAg==
X-Gm-Gg: AfdE7ckRA2kSlGOVDeXbaYa5Tjcs9Qb9xmjHT4MI3eFm9oA5m6P2kG4l3k40kcOVK8q
	Y4Ln0DzNjKPyJvudqvD8ZUVhEpFMm6V/PNobhfwM0WtluKZMgq2LcQEjGlsQzI4idQ2ZqxmhPgw
	61fRcj+w89K80GJLnIgTvdSGNKtHQwo6ycbgllvBuTLUleZVyZwTknP9tOw1XMrbkkPKfR3NhGY
	CphSZqsD623tKQX8bXr0WjktrODjSABf+3z1aGPpRr/2Ag9TC5NOmrpLvAHQzG3rGQeTo5Xn8FZ
	M9XsRJWR5UNf8DaTGkp2NkQ4YkJvz2ANHFuruKvnNtESeoQ0yllDK/d9oQ1kV0HQJGqjcE5Clmp
	pYVWLcgljaumWhOl4Ou+hzgom3fXXiVeSs9lQ2Y2pOAGNRAxua/eGnhhCiSIXzWFBsY8jFw8RH1
	mCOeW4tlO08pHzwm1yD8ui6TLvgtY3kTKt/dq61lm+Xza4suI=
X-Received: by 2002:a05:6a00:2303:b0:847:9bdb:2cd1 with SMTP id d2e1a72fcca58-84a672eab57mr6647502b3a.54.1784198372351;
        Thu, 16 Jul 2026 03:39:32 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f266724sm4757331b3a.15.2026.07.16.03.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:39:32 -0700 (PDT)
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
Subject: [PATCH v3 01/10] ASoC: ti: ams-delta: Use dev_err_probe() for error handling
Date: Thu, 16 Jul 2026 17:39:02 +0700
Message-ID: <20260716103911.77652-2-phucduc.bui@gmail.com>
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

