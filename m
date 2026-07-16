Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304F40EB82
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198399; cv=none; b=UOUhAefg1vqYOugDuF0cZqwULJ8+6MRkzbrJBKE8ERTdW+ptqCZEw6pgxm6DNzNN0EhqxR9sZeQLhjvh7cOCldwWgaY2XaLd0eIVTaIlnZwtXPlzeLYuFUmCh8oAFWqGLsCjLrNk4WevdcQRltB+7r+lXpWNwOlWOG0lMJXBEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198399; c=relaxed/simple;
	bh=NWzTd6xiPdBaZy/6UXtXar/YN26w4vS061xIq15Rj1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlbLHV0B+c7I3x3jOfkTTb4cUx0UncE0N8d9Z0W2kocA8jVXrZXQKY1KK6XqcnPFzMz0b9qdy/GKQO59NHQduFR7vcqrqnCG1yqeWDTP+EWC/cvLWD8UXmFJBKVy95TyKGqIzTfD4FvdRqFVI9rljwpQA281SxNnoaZ7OJF/lTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=raQ7mgYX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raQ7mgYX"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8487b7b3fc7so2948425b3a.0
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198397; x=1784803197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xl+ER8kJy0jFgleq1xDqpQH2nfl1PFzj8+QKjTW72EA=;
        b=raQ7mgYXNCUszLug0CCTWJGXVXk7xGdxf7GvGCWzutUD+DbOpRkL9gZb8eDIVEtwqU
         ZwV9OAK+2w9vJ5Tvoe7UQBmbQob0cl9xOuTzB8q4x/be3C2Vorz5KVh4JCw+0s7yaD2s
         CYjlabHw4i+aeOxUMtnurFcfajCXZlKA1H4wled+jipOatBYzT2Jb/4lI1L6Td9Q1sNi
         EdbI7vBIKf4Kb01+VwZd/7P9ZYbxWwkSiN2fWgZnSR70wQDfnTiDjJUV2SU7k4lKINfn
         ZNYJ2G0bVBF8OB8rXA2jVUCJ2+UcDVpVPSm8CWrVWedpinwGgicwLLc1ThLm4OItftkK
         uGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198397; x=1784803197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xl+ER8kJy0jFgleq1xDqpQH2nfl1PFzj8+QKjTW72EA=;
        b=nCDeXKY7iHnlHlyr5Lwe+q1wAHHMdGWkVold7H0KvzVjrwdMhi5GKsIBghsU4hqTyL
         ASxnJb1VR47+UeAL76KndAHtEbTipObJ4gPmeH968EPmDS7mfDgpYqez3ybFkeCuRKU9
         nAoofV0RKgNoYbt5Ih/kTD7XH/x3ogNB3+mf8Gz0Asemz+RZQDkKTFGwE82Viui6wGqv
         BrBtVB4hEfQB05i5GqqhHLh7yZ2yjSYM1NPotuGZgw+RjB6YPA2g5CVvXal0m7fiyYZ4
         F++C+G12pgMHgWekwDMUlitCMKvLn0pXIFwdMcMmVaF0KZZVNt+5bOZlLHtPdpUPBTa6
         +0GA==
X-Forwarded-Encrypted: i=1; AHgh+RrneRdk4Oop7Ip2X0C8tPBkPo/eLv1gNCr2TdvnHC9+NK0oWPAF5DneyeR7UsL5oFjpfOKLkoSBlXIc@vger.kernel.org
X-Gm-Message-State: AOJu0YwV9t22K6md7ucLlgmwyaf4D5a2gT+ZfW+XmbdnQjxE6Ut4dByp
	IQ0AiR3wmMl7KuErrWH765x9xPJtedsB9fiYzb9C0cH/ihU6DquPsPg2
X-Gm-Gg: AfdE7cnuAQyGsmq8v9sIvlwLokBMPbVVDvRf+S8eJ6viCuHT7WwgJwlq36nXtGna2oO
	GK85K+I7F/c4awOMsAyD0OhMGIYU9Hwwgboregp2Nu9ZV0b4Ck1GdyDjxBoBPBtMBVOgyvDBqs9
	htEksGs1EVHUx2JqY5orTa6OL/e6pbbFQnkUgFRNUNSC4yJ/qq5KZYZKj5JnJj6oGyCnT7xAFpf
	VMUWlO/+3MCJ/+M3MDzWtMlHbAjFwr9b0at0YAft6lx80DkUmiRIIANvauU+8di3gm0RsjVlvgR
	B/YxoiXuSohZSrdxtJS4VeYFaqRpuuNSDYGnv04w8IJK1qG362H+fPk0XFTHy87ksDxu6NnOZfK
	bHuhuUgGoT1vl8L2ewF6WfIO+hMSjy3j2U0rDIHYrLIgImRgCyREtrSMOSgrtbVVRjAhNYI80nH
	xm5QpoqQENSSPZ9F7GWwvNDWcBPd2VMH0brQVY
X-Received: by 2002:a05:6a00:94f6:b0:847:980d:71f8 with SMTP id d2e1a72fcca58-84a6723fba1mr5824597b3a.15.1784198397507;
        Thu, 16 Jul 2026 03:39:57 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f266724sm4757331b3a.15.2026.07.16.03.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:39:57 -0700 (PDT)
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
Subject: [PATCH v3 08/10] ASoC: ti: omap-twl4030: Return the original error code
Date: Thu, 16 Jul 2026 17:39:09 +0700
Message-ID: <20260716103911.77652-9-phucduc.bui@gmail.com>
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

