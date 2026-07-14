Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997C38E5D4
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030532; cv=none; b=QXkMzPQ+6j20r56AAY9wuYpfU9eDvoYwfwzym57aENg4C586r3kT+PfoZwqTN7wg0AwyesarmfXYuXCLBbgW60EU0iv20x1eVMVkTxSTE8VblACBamcHfoQq7/lFmwkOEUAKg7DCjiwsAGRjx0Ek26pInJKOtqSOG9JVwavmGy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030532; c=relaxed/simple;
	bh=jIfPIVoUyA/INjY1+gAHyG2GIm/f5J9x2F0XjC4jOCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2JXEkPXJgh0w+ABv9tHJEFCI4SoPaKFxDyEu4gykodsojJ+4dJC8Yb4zuNukSeX9MOAs8kZPoouAoA4iVcGdAkKKI2UO+cd9vZJbh6DLh5CZGARdNdOFRkfHNQ9DKIemeEfv9eyYAdry3fwAjf40WzXJVfQj9onIZpuUbK31m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc0ypmdV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc0ypmdV"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-382ef647e20so3845468a91.1
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 05:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030530; x=1784635330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lw8PXA7wjdfb1NxXEkfmxp6s+NoOp/15t2UE0ixUT2w=;
        b=jc0ypmdVzkntjQQrxMAgQ1BsHLLIbMhbZWIRa2w9f2Emx7tpng6+k57A10OICM05lE
         7U+TLB7MUTFz/o2qNYS44HbfwPZzvkkuC4uweof+MmqIskki1wPWkWWI7ng73EUfRbFR
         yQ3IntEHjYardwWdpiQIvbhJCETvbzMJTDWBryspNVAx4aMM5oy4R1EgZRIThisWA6kw
         zhqvIvSZPowdJ5vtULreX5nmz5zWx0ktn1jhuj8hN9cwMeW1/vFnptEotlil4D1W+uWK
         S0rAm7Qj6bohXgpq35NjL4RoBIfcx0WamKjFB+ZC3yWKuyomihs0JStX13/D+7sgatV1
         Zu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030530; x=1784635330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lw8PXA7wjdfb1NxXEkfmxp6s+NoOp/15t2UE0ixUT2w=;
        b=eTT64c2hDnmS+/B5Ifgypr+aJuXGqkmuxnwdRWNXziHqzV+9r9h9Wg4XjztudQTjQk
         rZT+Yld7wpn0PNZTOKhxLrR0JRp/tG1h2JBVhfRHjOF8wjTd7fIaUENbQb/6BUJFAuCN
         x2aGJ1Vz3JcbSooaVIMKUnJARG8Go7VbWdHukTJbCq30wXHYcmJanMGIojhEoCrF0Ktc
         Vaf3dLa9RF/vbFCeBNvpp32wjDY3PcPa9UeDxZdFnT1/VNalK5TKfuQIYURxBLtjIxpE
         983Y47pcdy8CqHVX6HfHqp2D5vxjKisiIxcDtQbVRWgJrQRTW0/iVgnKk41WBdQ0fOkM
         by4Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro+ItF+yaRgp8xP1YCHYFdcvGGFSvMlMhViktC1CjsQbWc4bzoTiNVbe8k8tGTJ+fwbYw5PE7oaTvxq@vger.kernel.org
X-Gm-Message-State: AOJu0YzgpPEje+9T8478hlWg5eeCdMR/p47ip4dY2Ao62vB8DKQbqAW1
	vdN0zWAHeE4SyZ0o7VK3Gz8IWWjGHXZzt9xpUQe5YNxTEYF1vp3Lv3Tf
X-Gm-Gg: AfdE7cn1y7VOUxqhMtCEA6Kv8YlXu7kih5OV6K76jsy1scuc6T8XBxjs5+YZu8Dh8jq
	YRxMrjP9nPjogO9yQpe5NXcJDeKWRhpwUUhul//O1dqfsoSdzL+vT8wqFCPxRxxJolDsPTreBeN
	IZ6MGFT06v9KrmYzTUOHctYy4bOgBcMFtNcimZDhv1G4P2ln2yu3eUF6Zev818RXZSQsqCSATEH
	RGy0rnLsbocXiK/ZM233MDWPyx5crzjUy8Sh620X8PImlVDg6VeV8CbiRvE5+O8p1vnzPK8b7oe
	oEuaDdtFFD2uXq+0oQY+u/rfRrUgrUJbZzJ194oTotPkbrXOo6U9/NdSZZlL4Ty6LyfDIaAqFnr
	oObJYzEou3gOF4df8Q/VmbId7RoC/7PGHMKlmYBk7MzaiYwArJMsVF2hNw+VhSwxQRGApEOVk6T
	OLwWtrm2qLvizyZHbx9iYyyg+HDIhQGEVfRZDtJrp7Hpsl3LY=
X-Received: by 2002:a17:90b:33c8:b0:387:e0db:3d8f with SMTP id 98e67ed59e1d1-38dc77c7e06mr11751817a91.42.1784030530297;
        Tue, 14 Jul 2026 05:02:10 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm86725093eec.19.2026.07.14.05.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:02:09 -0700 (PDT)
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
Subject: [PATCH 10/10] ASoC: ti: rx51: Use dev_err_probe() for error handling
Date: Tue, 14 Jul 2026 19:00:42 +0700
Message-ID: <20260714120042.491712-11-phucduc.bui@gmail.com>
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

Replace dev_err() with dev_err_probe() when reporting probe
failures. This preserves the original error code and suppresses
unnecessary log messages for deferred probe errors.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/rx51.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/sound/soc/ti/rx51.c b/sound/soc/ti/rx51.c
index cfc23e0838c2..46053b8f3202 100644
--- a/sound/soc/ti/rx51.c
+++ b/sound/soc/ti/rx51.c
@@ -418,31 +418,27 @@ static int rx51_soc_probe(struct platform_device *pdev)
 	pdata->tvout_selection_gpio = devm_gpiod_get(card->dev,
 						     "tvout-selection",
 						     GPIOD_OUT_LOW);
-	if (IS_ERR(pdata->tvout_selection_gpio)) {
-		dev_err(card->dev, "could not get tvout selection gpio\n");
-		return PTR_ERR(pdata->tvout_selection_gpio);
-	}
+	if (IS_ERR(pdata->tvout_selection_gpio))
+		return dev_err_probe(card->dev, PTR_ERR(pdata->tvout_selection_gpio),
+				     "could not get tvout selection gpio\n");
 
 	pdata->eci_sw_gpio = devm_gpiod_get(card->dev, "eci-switch",
 					    GPIOD_OUT_HIGH);
-	if (IS_ERR(pdata->eci_sw_gpio)) {
-		dev_err(card->dev, "could not get eci switch gpio\n");
-		return PTR_ERR(pdata->eci_sw_gpio);
-	}
+	if (IS_ERR(pdata->eci_sw_gpio))
+		return dev_err_probe(card->dev, PTR_ERR(pdata->eci_sw_gpio),
+				     "could not get eci switch gpio\n");
 
 	pdata->speaker_amp_gpio = devm_gpiod_get(card->dev,
 						 "speaker-amplifier",
 						 GPIOD_OUT_LOW);
-	if (IS_ERR(pdata->speaker_amp_gpio)) {
-		dev_err(card->dev, "could not get speaker enable gpio\n");
-		return PTR_ERR(pdata->speaker_amp_gpio);
-	}
+	if (IS_ERR(pdata->speaker_amp_gpio))
+		return dev_err_probe(card->dev, PTR_ERR(pdata->speaker_amp_gpio),
+				     "could not get speaker enable gpio\n");
 
 	err = devm_snd_soc_register_card(card->dev, card);
-	if (err) {
-		dev_err(card->dev, "snd_soc_register_card failed (%d)\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(card->dev, err,
+				     "snd_soc_register_card failed\n");
 
 	return 0;
 }
-- 
2.43.0

