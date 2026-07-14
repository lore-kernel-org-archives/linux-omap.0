Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A402B392C21
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030526; cv=none; b=YvpI4CQON+qMndJ9FcDWOLjbfe8sbUvtotVE7b9uk1tGNYrG8q4EGFgF2w5BjltFuojtWloBrdvSeYulbbKgYXajSRXSCySxWfIx7y0bgVNMfmy4ZjNf6kfQwOXAUWTDPoJZmaA/IWr8BBszXGiYuJcvvHVc57yxdkLnjn+9+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030526; c=relaxed/simple;
	bh=NWzTd6xiPdBaZy/6UXtXar/YN26w4vS061xIq15Rj1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYU/h/dofaaLxRoBIOdOsTdRm/IhWPjnkhSlGBEwb/MuA/eTJL6h7NNxrRvcBZ2kAy3KMxliUHWjF0zRfxJGCNdiQB2487sTk/R1ZlHLtE3vX/JNfzd3SXjg3TpFTp73SvmgNdtOD3RWeXqVERzaPWf3b0eft9SdNp0MKJC5Amw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GN/Ia07Y; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN/Ia07Y"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1618495a91.2
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 05:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030523; x=1784635323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xl+ER8kJy0jFgleq1xDqpQH2nfl1PFzj8+QKjTW72EA=;
        b=GN/Ia07YcGpVoDQ4OUKzp8IES2PA1Tk6bbOlBDV2lBJAiyErMNiUiHORK5Y+6ZxbTB
         gTm1rTctr686PvZJo/LTXWlNXvObxbnp08kMOzjG2TU20OwA9jx4rm46qEPvFs7loHZW
         8PBBvEG30P3ufhnt20htSKTgQpVkwtqrUTkg9Y/8Pw7D2Ss7HAncpKuPheOy2puhXDyv
         y8oLvrJBfM/QcanmnqW5NpxFdTg+2zPZOfx5rov09DEMG5fm6tDlO1/MZ9JSJPeBNzPS
         19ZonprahmuVh7DgqpiQW7cP/PIYApoOqEceaLNUYhUV59h58ZMaIKLX6bN1hJQRoCUa
         sPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030523; x=1784635323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xl+ER8kJy0jFgleq1xDqpQH2nfl1PFzj8+QKjTW72EA=;
        b=SJ50o094IGbxBYQnVRrzkdrIrT6G/ZI3JgAfSOoCQUugGSBo3RZ17Bcx4vMs+nFJVU
         sDOcMMqTJqSHRf4sCt3L5LfAZbYzUMB5ygMxsOQoaUMnpfH253PIUuEZTJb1/syWw5WD
         vh/WcdmUVYqLutzsOnxjo2yuFsDQPEnv2oWi7k5DhjLaQqhaVsuIGoHDX4bwJF3EKheq
         z4eGms93215PtCDN01NIajwIXVxFBkm74llVu60Xdc8cb5f6THiEpjTniJUuH9CGaYtN
         rIbjyqafPcwb+K9yWYmCVrPCUtvE7Jug04HWwN9lMRlgEtBGZv3xPTTmTQj/YrfHW7nJ
         7hdA==
X-Forwarded-Encrypted: i=1; AHgh+RrLF+h0P0c2LyORbofPWv1UZER55B1De9fwtvAr0tOtpafO4AtXxfECYWj+JHEZ1192eSl7kdlkdWv3@vger.kernel.org
X-Gm-Message-State: AOJu0YzTdI017tHDZuF85swc4ETQybO/S2IGq0nBGNs99RNaAwgOXCBE
	Icp0jUBxChexT0vGPevLM+UmVo2zBSEf+vhhxMulOq3pZufo9uFczFKp
X-Gm-Gg: AfdE7clPMt8JLvzBKfwGhDbBb4xtiGmgqlZHs6Dk+aAnQr+Ifz3YpTpr1dYv2iw4eaY
	Zt9SIMjT3scRtettPy9xg7mUjQ2JaYpErH7y0FHrPI2wlEYsY+m140KwUVqaNVAiXwrC9OEMtMJ
	efpOaXQoEcKOBv8AdO6jt4tx9dZe/QnzXYxgfih8QNVAe61l+ue/vWKkOYp6Ih6GE4GaP4YHkKG
	uCHbfT7daQYOXlSU4c295L4CBwuHU/EilKRRlcD+45ALz5BV0k8Z6CnbypKlScH0suBi63h2GE1
	4jo5erkr1BR4Y0VR0jPSo978fnb/KLuXwkZlZvJf1srXhGcJEpYgk3TbT03FSXMibMh+p6pqEUL
	w6BNTCo21fxXpqVR7UL7mOoJj9oSolF+JniUce5/ErJSKwVvAl6GCBV8evOg3C98I3UQASAGAYn
	E2jWEwJUG7OBdJ1VW6a3ve03vKI83+3S2UQmtnB+PkzKrNoNg=
X-Received: by 2002:a17:90b:5585:b0:37f:db06:229c with SMTP id 98e67ed59e1d1-38dc777b895mr12241476a91.22.1784030522664;
        Tue, 14 Jul 2026 05:02:02 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm86725093eec.19.2026.07.14.05.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:02:02 -0700 (PDT)
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
Subject: [PATCH 08/10] ASoC: ti: omap-twl4030: Return the original error code
Date: Tue, 14 Jul 2026 19:00:40 +0700
Message-ID: <20260714120042.491712-9-phucduc.bui@gmail.com>
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

