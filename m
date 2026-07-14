Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822738AC9A
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030499; cv=none; b=Q50mbfeOCGkddQYfOXWUawtHe7jWur/rKqoxc2aI3ABW8guQPdJu1TVTwn6srfygHhnYRBMsZTOnpvEhWZvRRoETG/cGci+Z6B/U7q6fqIlkeK85+45S9Wyn8CP4UGNws7qcMpROKbObo8SpkZfg04h/VmokdpEh0uKQk7NbbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030499; c=relaxed/simple;
	bh=IP2A4NG1iSAJCV7o+iplwQjKgP9oqVqfntMy+uTxAxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXVgDNlTumoG5dtcfBPirXuh7ujWbG9z2YSDaGmtf+RzO+neNydbikWJsS6TH51EArhVPLKOJPFRFlDCieL3JuJA2ROHQdsG/BVPyamvHwE5WNGct79cMf7BI/v2G27sR+rEn5XWNQ3oKoJaMQcsdbc0c0CtQMSUQrq0s4Ybt80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvmsXbMf; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvmsXbMf"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381018b9375so4699083a91.0
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030498; x=1784635298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tax8xN+PuIBXPCnVnoDq4zkyzvX1SMkIQO4uphx4hsY=;
        b=CvmsXbMf9QNjaJsgFqXMS8DauqLBveVWXa1iylQXrlmk8Taco1nt054vbjXYDEuPL7
         RbUl6BDwBqBlfhJGYUEB0S2hVYrALg5hhYUkeZF9heZLz5rsQseayvyPDGUX6Q7upoZ5
         Q2e5+TtE2xv7y44GC57xkbUENI3mPKVjLLWWPwrbDGjmJvpRlsyLSkCDNlS480AlXWyk
         Cnr8kvizNoliGfnQfZU52EoRGmG2XHBZt49K7hOYlNotNUDuypyu4Nt/l1M3rtSq/f0d
         ebkz8JePMXfYRn6q+TOKiZ8W/cMYZ7c132WOdh2ANcsUo+b4XBcHcbN24f68CYI9X43P
         lYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030498; x=1784635298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tax8xN+PuIBXPCnVnoDq4zkyzvX1SMkIQO4uphx4hsY=;
        b=Zws55ON08OIDztziPXq2cjXdMYWjaVGIBrWE3nIkFcUnvZakz1H9CtP5F73YSsi7Hy
         p6gqjgZVWwyW/4k9tVdMbAZY54Bf2xj/CXtvvwRf94EU7PIS1ApoheofRgsohwctwU4G
         ywdc8lM84A8Piqt4DwEgy705PopwVCGMIEg6lmi8WQCTSDSHUsHUnMJIgKAsB7NB0gou
         QCYTJuF/TY5zUOdFMqkjP3T8uU3/xeHdro7YPow9iMWGMh/90Ia/LiX1piejfhl2nC00
         ToqzU6XsX4L6aZJexkr8+eKlo3sT6JsxhXH8TmcLzqhFA6B+B2TAFtLX7AImAnMahFed
         q74g==
X-Forwarded-Encrypted: i=1; AHgh+RqzvyKrhJoyFSo9sE3IM7+0JffxwdPR7AwHrbd2GrIIFU9xIDrV40sNJV1lOM7OPRxVCOnSaYR/NYtk@vger.kernel.org
X-Gm-Message-State: AOJu0YzHdnjfF5oxKl7dgWyRoKpUpSd2PyC+pIT0iZP29EAjtp55bAul
	3QacMym+iSXF3p4MLDLC4XMMbf7RwA7/Rt0qnhEc+duPwmGzV3S0D23R
X-Gm-Gg: AfdE7cmPy4dl80s6GaAY0zSokTKEt52We5R/jjD5QZWncft85jtRSJV0EJ1R9/AD4dQ
	MsZt0SUYNX9oxqKl9V0WP+XL4UsXg/rh+mMo6hw4h9PbFFTBVNrqIf9zsdndo1vKKzzkCdjLkmd
	yOpdOBHidokHBwC1japD6xXfATSUrpxTfgxqRb/MWajimscdBJw+byHiZAnITKcQEkxaHv66+fr
	CLDOY3HgUMw25Y5KRA8D89Pvpe7ye6h8haGFKhJUCe/OmGeDDynmDcf3FyG74YYwFOE54K+fjPY
	v6ZsvD5MzhsgNUdkBRkiAKD0Puy0k20UEceQLns2qR9d9YFyNxPmkAZmq8UQ5xdmdrYJBYmvMFL
	UI/Oyafc4BsxuqFx+ZQYg8ES5DikckRntBxIxhD1zSIx6w3/dAFoFzdhrDUIyBSSKolhffL7iba
	Vm7MwrlwjwTPvA8Poz4FAvJpLw2Kp+h3g6MKamHgU9PpvE5SE=
X-Received: by 2002:a17:90b:1a8a:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-38e251761camr279497a91.9.1784030497086;
        Tue, 14 Jul 2026 05:01:37 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm86725093eec.19.2026.07.14.05.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:01:36 -0700 (PDT)
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
Subject: [PATCH 01/10] ASoC: ti: ams-delta: Use dev_err_probe() for error handling
Date: Tue, 14 Jul 2026 19:00:33 +0700
Message-ID: <20260714120042.491712-2-phucduc.bui@gmail.com>
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

Use dev_err_probe() to replace dev_err() followed by returning
the error code. This keeps the error handling concise and
suppresses log messages for deferred probe errors.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/ams-delta.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 61252359d5cb..1c9342ceaf56 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -574,9 +574,8 @@ static int ams_delta_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_card(card);
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
 		card->dev = NULL;
-		return ret;
+		return dev_err_probe(&pdev->dev, ret, "snd_soc_register_card failed\n");
 	}
 	return 0;
 }
-- 
2.43.0

