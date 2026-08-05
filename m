Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668733D6FC
	for <linux-omap@vger.kernel.org>; Wed,  5 Aug 2026 04:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905188; cv=none; b=M1Ya21XEwNUw/AF3QBIPgGsupBF8jfNuLXOGfMWtKvf4LCQ/slcL213FHEoeekM/Ps+Rfi+T8ltnSVZ0m55vdBOlBFDsbR+1tW//P/MfIQiFsKEkOSyqIcLP+qAjc3JpnXrwkWNscSU0/W79hGtsFfxRjgTb10PcMMtQbSFfHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905188; c=relaxed/simple;
	bh=qCdOOz664G2wrMq4qg8yXIPqaSSxslpwDWsC/l8CCE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1sN9ijyhMj+EhbX/+xhd1CCxBZwIbhXno7n2FhNe4vX2hIQx2SYk/ElhvMYILZ7lpxMUQtk7WI+A2SLyTiC5rBUgVbEgDvrp0zxlWjoDDNSUgej8l9kRIs9i8SXpbc5TzEPCkfWoz/4+3Yri8AjLiYOAGnyyIZyzCOspir5oao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQl+C2xu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQl+C2xu"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso529652a91.3
        for <linux-omap@vger.kernel.org>; Tue, 04 Aug 2026 21:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785905185; x=1786509985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bE5UiVHPiiftCS1Al49sgBYUPZJgNfnsBnv57EVE2E4=;
        b=qQl+C2xurkIKXyA1SOTZaafFlbUMdV6ZZH8zLbYdST2h4uF5ftgZKGKtcrnevNuVdo
         8VSw5Mz86ik9AmFLE094SUKQpp+s7p/xTx2WNYK9T9dOlqHPcYbQwkvQ4kGpFHcVnqpF
         NAMLKZ9fdoNfRQSP6oE57yQQD7kT/KFz2rl7grcC1gZlybn1PpNYUbmdCa+uhPp0iMUd
         ukmWmwkjcV6lJXVMyJgDGWRQRlRVA5fMOTBvlNLZxc9UGgj+RYSIDH2J26YhKL1oKPKO
         JRmm+64rAkFi7bt4VPeIMWclKxymlyVVRSjwY/4U4EzHPTHTdBPkg5hUuE5Jf0vVXJ01
         u4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785905185; x=1786509985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bE5UiVHPiiftCS1Al49sgBYUPZJgNfnsBnv57EVE2E4=;
        b=gGYEJAHi4N74xXJkj4xi0tzD0/C7Z6q7p0OfoWTUx8DUYRybu2OkQ67gtOFfmU1QKH
         EXUIhfPwON8W1OUF8aOiweIbhXjD21ljdIzv2RwQHxW58LbbyCnZCK6ywQW0W6BgXol1
         U+GAcDSg6vSGqmdyWlhI/1FcKRQkCyZwts7o7LhRWKYqqPgoolXh5e9sVQREmTEnaQTZ
         NLYHoi6en9Rh72H+92DQ4G97aV4aSrYsQHcH6XSwBGYUdobLFdxU/PgN8hay3ZGPOKAC
         w0CrBc3IV6oCEEmkzlhv1RBaEY2kwe3NPjx8fvqHnl0oPBpFMOGQrDM0td/y/3QQ6WSC
         /leQ==
X-Forwarded-Encrypted: i=1; AHgh+RqTpOG+3AsTBIbHA2i8bDySGn29GztY8v8vlHAT/tbxpgfbI1CHy/xY5MRUeH2LqOT1JESgQMmmHuGx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+iVCQwAibt8xlw+ENnTxEch9zDhkDcB4Gk0pMolcvVauB2nQv
	sJnQapXRhQIDaMcE6cEEgrkOsYA5fanP+vzjV6b26jTiT3XFXSN4jWD+
X-Gm-Gg: AR+sD119j6msdJT0gO6CoBGtMn5gg8tE/hyf2H8hTnTiHao3FPrccMdHHdE2Xph1RQE
	nVm0i4ICofKMzrZ63B3ONPvuUaH77IOH2kNs+irSX1zuqZfuJ6KHOgzMWJ4RiR0QQmiQooXlwrV
	EVOphq1m6Q1iIswHUsqRAagL56ceTPtmYylrI8fH9Ydg+w00y0pob2Vdl81qIcVl0ADmVu5ac8u
	dYKpjBx8xGC+zbF0cKEiRs+YuXxAgZQHvMD13P8DBEJL9mvF1CbSIkLTwVWaIl3kzDB7EzOGxnz
	wzavvfHbrrIiwAV6yXDCrPoYBGRlZqI9XVJNUiGLmaDGd79Hj2Yu/r3ANHOSGTk47D754gd91od
	PTihdh9fXclP5CVrmy6MqdxPn3QLZUkPrZNImio7fOHWj0AlzOyolTDbUtdI7hJZQTEKuFUKMfh
	2o69aV7Mv2Q39xmfrAMfOjHUNwqVR9zxdKHRpwmtNHD59mUlD229sZbtYI/GcvI/chL3B2mYB1u
	2XRc1gJsJ3T7HfPwuId3xawp8sd7tY7FOncbn6HEYXqi8U+WD4bRMPD/uDKI3G+YjfbO1XnoVJX
	Jert
X-Received: by 2002:a17:90b:4d91:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-3903c53799cmr3711654a91.1.1785905184818;
        Tue, 04 Aug 2026 21:46:24 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903d2f97fbsm915871a91.1.2026.08.04.21.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 21:46:23 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>,
	Sen Wang <sen@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] ASoC: ti: omap-twl4030: Check for missing card name after parsing
Date: Wed,  5 Aug 2026 11:45:56 +0700
Message-ID: <20260805044556.38183-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Return any error from snd_soc_of_parse_card_name() directly. If the
helper returns successfully but card->name remains unset, report the
missing card name explicitly before returning -ENODEV.

Suggested-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/omap-twl4030.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/ti/omap-twl4030.c b/sound/soc/ti/omap-twl4030.c
index 8a3a792a21c6..a3ab52b2b64e 100644
--- a/sound/soc/ti/omap-twl4030.c
+++ b/sound/soc/ti/omap-twl4030.c
@@ -216,7 +216,11 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 	if (priv == NULL)
 		return -ENOMEM;
 
-	if (snd_soc_of_parse_card_name(card, "ti,model")) {
+	ret = snd_soc_of_parse_card_name(card, "ti,model");
+	if (ret)
+		return ret;
+
+	if (!card->name) {
 		dev_err(&pdev->dev, "Card name is not provided\n");
 		return -ENODEV;
 	}
-- 
2.43.0

