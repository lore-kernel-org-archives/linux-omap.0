Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA173F8892
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192959; cv=none; b=O/IydspxgfMeSsCL+lwpYTD9bRCUCRG5AMj5Ez0zDRQiMhsYvZyI+7mcA/hanToXw7rPsuF9Jxwcs+1TYwpfTCfOOfbLgTAXUs0P2Xt2gEWGXV5sVIIEPXM8qdI/yiP38cSyXs18A2MGR6qZ9RruopdcbJbHElBg6xbiBH6nkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192959; c=relaxed/simple;
	bh=NWzTd6xiPdBaZy/6UXtXar/YN26w4vS061xIq15Rj1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aH2GXPgcP8mZMI0X2G7aSV+h7HvvUM7YK8Ywp0ttVSlTqPY+Hj094op1affJ0URBTnaMfFzkWQd98cMmprx9bpcAcmckXZoqCvrSNRxCZlidz5fl5XVl/eUy2c+AHiTCO/IEF9bmjrsIAO4ZReyqgsFlphniA/fLgVY1R1apRwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkBJ/PsS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkBJ/PsS"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a2dcec51cso4958115b3a.3
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192956; x=1784797756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xl+ER8kJy0jFgleq1xDqpQH2nfl1PFzj8+QKjTW72EA=;
        b=CkBJ/PsSvYlTocYbpxWPb1kLxj+ySE0n860uasqfAX9lxj5OirIbG7fDRepzh3f6g8
         Wcdeic3b5x2WjISBvJ59hR5JyfrDnonCHKs5n9olT6x+PNgaFr1hj3JxSlhrVvln3is9
         U5rbihT9SzGbEgicQ55hIXXeexPFED2Yj7Dc2El6byqerD7ykIYWZECXVXisDgIZFmyV
         9yPsT+3HA+gEl6c9Yc82g2BGzTA/luL4K37NNitMq2c9CaVZbHAcf7mrSZs7QbcA4mVo
         Ys3sLEHmj7LhNhoIeV+y5cCYgQgiS0t/F38pNuvnxtYgg4sa9fT6TtljiUW1FYd+NxXg
         ONTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192956; x=1784797756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xl+ER8kJy0jFgleq1xDqpQH2nfl1PFzj8+QKjTW72EA=;
        b=c16o7Y3GVWq7zEV3Ar67IrgclfNFXTtz59vm9ZmwSC59vbLfe3krCTnUOB6aO17rFI
         4Sq42OtCtLuZTTFOv1i8HNbX/oGrppnjT+0ckZNxTD2kDrJiauFlIwcWugyn0k8+RUGO
         j1YzBjMy+f+c0TLWLjY1ak9aDpiEKgW3GtE3FLXgPVxACgCrhuCXI0VTjs858zCGbLHS
         P9893bj7B1bqe0O4nIEhCptKBAqjFKSBGsDyv23wu3GIyg16rMDEBgXSgnrN+VO3kF9f
         gh07MGps6CN/66LGHmFL79AftQNMabWvXv7OA+HydJLqRCTksIogaE7VrQa0DMCcscoL
         txUg==
X-Forwarded-Encrypted: i=1; AHgh+Roq+W1md3D7jtqs+nAkmzf+QJO2ROTqmjoOXOh3vAac7J79ecm6BtENTc7pT7H1u0lN2ysUyZQLpjfq@vger.kernel.org
X-Gm-Message-State: AOJu0YzCNnX1iOXfdNZTA7YA1HzvvnCb/N+lDl0mBCKso821zN3drPNj
	cgUGtifDOJNrVN/xW8fyesEhxYidK6YhytWTy9TJ/EIWMgXhzU3H0k5V
X-Gm-Gg: AfdE7cnihuBOi2ADKEFJI9GNgX2wylRRIeSJ9mmuA4WiLhizg1Coahfu5odV9vK+umN
	cxEgsr99XgTv2U2KHwOKIaLFYks/5j7Z80tJCbakPtP/auTl7UAWTrn5+vybLBZWjqwpyoC0kIK
	Z7ipC8m1cB5Vr9EZlY9gAJhIO3DsKqWeauo2UyJmmVqLCD3RLh5Ty7LgMx1PlRK+bhxb7ENieXD
	Df9BlqDI2APvjpUegDofccYYmwNTxz2tRdp7HszTTaYHtQVEzNyP51Njhk1PpLC1KwUHUc//jKP
	ke57hqYHPlVj4n4oEkrG7h0f9eEnpTOieCvlBDcTxhNr0RETD9mkFUEaOeu8uNkUxPc/sle0X5p
	BIoB2/ATnmPzYIEcuOg4AtyGT8pJyEXuqHm3DDWi1fMrd4cnh8lYvjcZHhhDCBjCEaGa12lRYlL
	VbCtaye2KzbY3dk7MxciTKLvHQ1qEwwNBbII/r
X-Received: by 2002:a05:6a00:189b:b0:848:5d22:b513 with SMTP id d2e1a72fcca58-84a559b0cb9mr9683324b3a.53.1784192955782;
        Thu, 16 Jul 2026 02:09:15 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf5ecsm4511800b3a.29.2026.07.16.02.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:09:15 -0700 (PDT)
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
Subject: [PATCH v2 08/10] ASoC: ti: omap-twl4030: Return the original error code
Date: Thu, 16 Jul 2026 16:08:27 +0700
Message-ID: <20260716090829.72082-9-phucduc.bui@gmail.com>
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

Return the error from snd_soc_of_parse_card_name() directly and drop
the redundant error message since the helper already logs the failure.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/ti/omap-twl4030.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ti/omap-twl4030.c b/sound/soc/ti/omap-twl4030.c
index 4d80f8a7a947..2a80e44035d7 100644
--- a/sound/soc/ti/omap-twl4030.c
+++ b/sound/soc/ti/omap-twl4030.c
@@ -253,10 +253,9 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 		struct device_node *dai_node;
 		struct property *prop;
 
-		if (snd_soc_of_parse_card_name(card, "ti,model")) {
-			dev_err(&pdev->dev, "Card name is not provided\n");
-			return -ENODEV;
-		}
+		ret = snd_soc_of_parse_card_name(card, "ti,model");
+		if (ret)
+			return ret;
 
 		dai_node = of_parse_phandle(node, "ti,mcbsp", 0);
 		if (!dai_node) {
-- 
2.43.0

