Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF5394462
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030529; cv=none; b=KON2FohlE2V8i4iSzmDYP7zsNbTRjoVOk8XqUi1yKEa9dH1UKFcCrVvcnsUttsIxHROgvYf/toYNVfZh6m+EdXymwMNf0o745lSnpPx35IBssvFn9rLOHtgX8P3uzT1LoJXi5XBArNeCRRotZ0WtJ+UxbaDfdJAoki6Z3yn9k3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030529; c=relaxed/simple;
	bh=evBDQ8LUTdIbeMm3xfd3E5UnVCKuP9AXVeeKznBrDQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdxIFtxcp1caPJdk0mjNNhdbx84J3ttWHwSpQDsi/BDQ+tCeQbylHZs8FGb88H21lOiydBfwCoGjisYnIJaG9RFoSvS8WFT0SQcnjk1fRnMpLLSjm57CZYdmj0oEVJrxbJJ148mL+Lb55IqymCc4ivNH2UnlyclxUzfwG0r50tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWBN1Iay; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWBN1Iay"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381018b9375so4699940a91.0
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 05:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030527; x=1784635327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6457K6STfYP0yfng2102Li6Fjdx/uvYow/tpgSviBkc=;
        b=aWBN1IayDiVe3EwuzvKBJcJgxpAx4Bwb+5U0/3dRAQbahphBSOsH2ZRUHmAuPL3KYM
         fYuqw8BOt9NqL2bzFNspFZqEEZ7I2NbvqVJZ25kMYNygf8OQgnt5zO9zpvyNneoh8q7o
         8v7JyzDJL91LTGBLwKxj/1IGdQx0WsRFG/IaW9f3mHfZ6t/GhCf8ypIP5F45vHJVQJdX
         G0KqCzYTR9n3uS6A+Db0SibjEOPJItM/P14LXB3SXL0sJ+GKEkEx8ULrW2WOfTdoPRlz
         QIwRM+YOU55RK1Hu5H5kcVQDnA3t3wTZI8FoCw5n8DCHMj9KuYggS9+BYEXipygXuCH4
         XMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030527; x=1784635327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6457K6STfYP0yfng2102Li6Fjdx/uvYow/tpgSviBkc=;
        b=SI3Ih1J7VOfxviiAxuMK2YMAqPMqtXhX5fjqV7aSNYWFzqHK22sR5FfBn4A1HQTT+k
         Z79edNNzDBw/LUo7UDLSNXJUINXtv7z3dovdNWqJmTaIuxDcskYAI5PABftKTUOk0Jj2
         UXHStKgsktDpggKKV0qBdeWKDqmRlGuzZY3cRSZuTXehbkErcRHrXczI6LZwOnkyv4mi
         rjbyAnP0PU47MBTxhrgarnrZpnK+DhtyK9g3qOWHGNoyAEKXKLlTnHSXURYTLZWF5FdE
         i3dWt8tI4a9O9SOsoUj/OejQU+CBdXP8Dq73GJNpAos/63u7nS9uM9dPVGMwVUy+K+uM
         5hYw==
X-Forwarded-Encrypted: i=1; AHgh+Rog3bZKbRicpEddfE+P4+3dkjzwujqIFa+tzk/8ndb3pujJXFou18/d8/Tb2rTDD1Vf8pnY89QxHBa0@vger.kernel.org
X-Gm-Message-State: AOJu0YyuiPUWWusF/xEED9gRHY0U11TPzOz0jbXEdmFTqkgXrzixxZhr
	xyDcSb9S5nvY++hNDY+WII9yxGoZMo+e9Gs90orlgT2PWaJhAlJVXTVvoNvYZQ==
X-Gm-Gg: AfdE7clldhKpTEG+sUqcFr2tHSbBe5KEEAMomISqWaPnDeKnR+/F3yyYt6Bq3ixJMj0
	DIc4HJxHwFagRu3iwXPwPj0MSAJKfTeDb3KlNXBVWzJG+TRWBIbq4kNhjoCt4f2ZPH4XjtBvFWp
	9uDOZjJVF0d/vktGXG2IbNC+zbXYdmyN5/6OhCF9XE/xxnbmvNj5v9riSB4yBzRwotuaIAFnwTW
	fB9NtCzF7A1EQzohpNkBD1MuQoe3UNWr4Txx/8WRGLTW3XAineYvJVd6iEX3wr8YkRXgvSW3e1g
	NipKWH1N6Vw8JImn31NeUlzvzqLB45zhODZQUOnTnlOTTKV1F3uWdXAsqdtiWeCoqVkUnllhejj
	f39jvuuWWsLuzr87uRkZlbDI4qkfexrYYpE7pqsmUJGGbhh88OvhUWdDMyo9/DjEG98wqykFa0H
	GcSYIzK0E9IAw3Qu13x18fx26JNG9TzYItSNcJ7NJeMfmk6V03sHJQwYgiaA==
X-Received: by 2002:a17:90b:58ce:b0:367:d850:6a5f with SMTP id 98e67ed59e1d1-38dc7769df5mr12509755a91.25.1784030526404;
        Tue, 14 Jul 2026 05:02:06 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm86725093eec.19.2026.07.14.05.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:02:05 -0700 (PDT)
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
Subject: [PATCH 09/10] ASoC: ti: omap-twl4030: Use dev_err_probe() for error handling
Date: Tue, 14 Jul 2026 19:00:41 +0700
Message-ID: <20260714120042.491712-10-phucduc.bui@gmail.com>
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

