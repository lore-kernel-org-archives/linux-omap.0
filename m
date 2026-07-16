Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544F3932FF
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198370; cv=none; b=m8yizhA+WTI5o71+xQbSeo/QYTlPPySskzr2YL88KXjTVNsu/E2dQ+OMmhHWj2G9pHdF57knjJ9wtufh3ajTXGOyY8AeZUWBMxv91P1lNK/ew+pEljrWW96cfDR1yVuNwmHTs9fjcb/vUYQsdPzSAoYmgiMfiBlHMmwd6F/WNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198370; c=relaxed/simple;
	bh=HWp+w3zWLT/STA8qJtRJUsPudz8/gv6NAGmdGdKJKRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sr8QYEleWvf3HQsOPil2YGPkGnhIFaaDt3AAHMJe3BV4nWujZMGB9XD59XKuA1jWahWJ+HKu5qnLQp0qJySOMplucW//zX5BA5bdcw4zUibp8pAVmxzeZ2+hU0PX/X352/zuXQSYDYZ0UqcHY9VmdyAQk2KGj9OnWl0FjCKgfu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNtFc9BU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNtFc9BU"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a2c90e383so89214b3a.0
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 03:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198367; x=1784803167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nTjXyXh6ilqWafAhwi9/ETtAnvPu6wZfnYV8+FiwGAE=;
        b=JNtFc9BUsuOkgsF85Ojus+GdIDCEulWB3CMbEgbqXDtkNiizqWZvGItzuhOLxxqTY4
         s7olNUigBSMtYzClZywB1p2asNYcK71Sko/YBZOOG5/weN7nnqH/SDfoTr9MIP/qMWJH
         HOL/nPrz5jmWnT8Wf7vlGxjClajrZYDrUZXJdRLBbPDgfQs5JxyPqDVrpPOzMSyUyOKI
         wh4o6d1693geAsRiF5Dh9McWIDdHOkBmbB31WZQ0Z8cQ6cwfkWuXnUKasuJJHQYTiSE7
         xblhSDy8vj/1OLGq1dNJpYOCkTKyHtNKyDMkCICWpzgKH/S7d2Ky6l263s5mx8qho4Y9
         pEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198367; x=1784803167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nTjXyXh6ilqWafAhwi9/ETtAnvPu6wZfnYV8+FiwGAE=;
        b=VvNx+ZuiMe/uca9BBwUyHIv6I5Jqxx35Ga9SgxbUjby1oIRi+dQMGKti1QatOsATtL
         jsUc6Q2DzWzyINRVf14aLzyZpLzzfqO5/BXOA7VrH5V42Q4j7Zs86ucncWqvHPE2Pbbi
         ptuaV/Xf48mGTo86JhGEF0W0CxoLoxC4vJGXsbKDUTmBCTe4KxTzOynh/uEuwcj3UH5p
         H3I2j94GbkKfTQodXD/x8VJAsPNTFq80k9i5K5GseIQiExHWaL6yJfyYj6Tw7F8bJ6d7
         dkHsf+TTEV3/2C6JMfIbQiVxqzna0YwK3QpM4QErNGZEnF5U9/kzGSO5wpyNbMXTU+l7
         g5oA==
X-Forwarded-Encrypted: i=1; AHgh+RpX/bzNxXYVH3Dzwd2FA3hpydzkFPvenFsm5gqi6OBHKHv8fhUN61uH6619i1TzgQp66N1fIvYdPeE2@vger.kernel.org
X-Gm-Message-State: AOJu0YztRrdYuhOBEfRw0Q+Ue10JjVp+LLK6SAnPyHFUHUloQjECTmRj
	1k3WPnQzUKj/1Cf6iPPt2az5X5JaBe6p2Bs1UhhzbAX1g23eKUw2p8wH
X-Gm-Gg: AfdE7cnoF30wA/M5k3zJzcdUfJmpQi1CwHpYNaeRn5h7IlHpagRBotuDlURbg/5Y1k8
	YQTSS3pwcb0LsBieSCikhZvqavdmaLzXH0p6emW/nC3ji9cP2e+GJ/0gNabAmtCjuavfDcZABUR
	GY+KwR0cPa0PcPRu6iiVFdjCYAnwpzq22pFV/uY9SJCme9KhK/iXOL0SgCCECR2gL5oOUii1q1Q
	yfnBgk2hfSuDZmvBuWB/JOL8yW6FycL7qmWpJjdBhf7/BXYYdrtN+WOJ9a5E0sVGRsTWNCeObjp
	28ArEbe4g1oRcavB7O2kWreih9iH9BzCNe3loQMS3tX6uWg4xEzEFqEOn20omqPx5GYz1Z+ceJ3
	Comek5uUBOlshfdQFMrOgjn2bPBKtdrdBAdP4qfPVwcnNdy1+ikQr0QO0cRMENJ8G1/WLCvw5pE
	Ux+vqpu8syCEMlxXHHefyJh6IsuWMaLFBS0/hC
X-Received: by 2002:a05:6a00:f0f:b0:836:6f2e:bb6d with SMTP id d2e1a72fcca58-84beb18b699mr1948890b3a.14.1784198367073;
        Thu, 16 Jul 2026 03:39:27 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f266724sm4757331b3a.15.2026.07.16.03.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:39:26 -0700 (PDT)
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
Subject: [PATCH v3 00/10] ASoC: ti: Improve probe error handling
Date: Thu, 16 Jul 2026 17:39:01 +0700
Message-ID: <20260716103911.77652-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Hi all,

This series cleans up probe error handling across several TI ASoC
drivers.

The changes fall into two categories:
 1.Replace dev_err() with dev_err_probe() when reporting probe
   failures. This preserves the original error code while suppressing
   unnecessary log messages for deferred probe errors.
 2.Preserve the original error codes returned by helper functions
   instead of converting them to -ENODEV, and remove redundant error
   messages where the helper already reports the failure.

Build-tested only.

Changes in v2:
 - Add missing parentheses to `snd_soc_register_card()` (Christophe).
 - Remove an extra blank line (Christophe).
Changes in v3:
 - Add the remaining missing parentheses to `snd_soc_register_card()` 
   (Cezary).

Best regards,
Phuc

bui duc phuc (10):
  ASoC: ti: ams-delta: Use dev_err_probe() for error handling
  ASoC: ti: davinci-evm: Use dev_err_probe() for error handling
  ASoC: ti: j721e-evm: Return the original error from card name parsing
  ASoC: ti: omap-abe-twl6040: Preserve error code and drop redundant log
  ASoC: ti: omap-abe-twl6040: Use dev_err_probe() for error handling
  ASoC: ti: omap-dmic: Use dev_err_probe() for error handling
  ASoC: ti: omap-hdmi: Use dev_err_probe() for error handling
  ASoC: ti: omap-twl4030: Return the original error code
  ASoC: ti: omap-twl4030: Use dev_err_probe() for error handling
  ASoC: ti: rx51: Use dev_err_probe() for error handling

 sound/soc/ti/ams-delta.c        |  4 ++--
 sound/soc/ti/davinci-evm.c      |  3 +--
 sound/soc/ti/j721e-evm.c        |  7 +++----
 sound/soc/ti/omap-abe-twl6040.c | 15 ++++++---------
 sound/soc/ti/omap-dmic.c        |  7 +++----
 sound/soc/ti/omap-hdmi.c        |  6 ++----
 sound/soc/ti/omap-twl4030.c     | 15 ++++++---------
 sound/soc/ti/rx51.c             | 28 ++++++++++++----------------
 8 files changed, 35 insertions(+), 50 deletions(-)

-- 
2.43.0

