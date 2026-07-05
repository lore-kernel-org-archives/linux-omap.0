Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA236492C
	for <linux-omap@vger.kernel.org>; Sun,  5 Jul 2026 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783242872; cv=none; b=tYLBAZ/YzRumde7HPagY0As1mBxo1PDH4FYBPOYascRMDK1K1EpUgSHkMN+yGdpVbaqzexU8vW5tgJse+Sm5Xsi8Qpp05ate4ygbd4lUQskyy0tWVtEUXC2jtkKoqpkTdD6nRmqyDmwNzAx45LoE72F7ceCnpedKRgtG9kkz8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783242872; c=relaxed/simple;
	bh=97MuJ7f+ic8uPc7AIBf0dHxydppiGKw022sKqKsKEgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSXh0pCefu0a+qs4KmLYzATEN/S9iMVgbM/7FC4Ga+12Ct34plMYz7oriQ7s7tJlXssi1HzGa2mt8i1BSVBpSbwPHIzQZ74NSUQcDJTiRzGq2IbCNAZBvPhYAR7AstNyTJSJw6INyoYCKUdmfewAXAj3QIcAGF/JXO6pc/qnS3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DM+rijJy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM+rijJy"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caea3f742bso23743235ad.0
        for <linux-omap@vger.kernel.org>; Sun, 05 Jul 2026 02:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783242870; x=1783847670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1NsTEE3ehjkH33SSz+73WgxvLlmUtSGRdlF6FJ50lg=;
        b=DM+rijJyyFfaYhMRcpzKdI6NXNquCtl9zzsjRlIbhrtdcVF53kqJK0MGZ4+We+byAk
         KvWJvWMytE3Cj05GLLwAxOtAOmJrmWeQdubwStwTOgXU/KWjsDC7H6xCL28CQOgOf8u4
         zIRkiL1KbATkZ7U+PwyX+as+y9IYD3C0cEdMFggLqZCauXd9NOCfx+QTwXW0kO7dQLDa
         hDd4WnlWMc9LvjGdQj/WHP7xlgSIR+ey97My0iLPf0dXYj7yKGy3ZM+pol8Nkk2H9Ha3
         8vOYNKfPSaOlqVwyYaHQXv5vfVmwU81/u0QqPWbBUqmRRMk183MjykDDLLBpbax2xG0H
         gkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783242870; x=1783847670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1NsTEE3ehjkH33SSz+73WgxvLlmUtSGRdlF6FJ50lg=;
        b=f7rm6xiPblIxgrF3Ofy6T612QWQQF1wx+JgyoNsdjXjqikly7dkJDapSX4o7tO6uUy
         l/wfGHsPYXNHeVlNk4gHZuKbJdsFFbAPFw+3qHnIs3VItRRke/ezyRuG7dsce+uvhLea
         2G4IDV6iVcdJ1ZVU/GDC5ZaWHb+j29K2dsH+3SuPrQS5OYoPXg11RP+yfPXw0nXpF7Z5
         IYnswCwvWCA2+ASliMhAdvs3wc3MJmsPDgA5fYWsxLBLhkyCAEqe2IQxxn69C+LLf72S
         VEmxEOGvH4pQkxwojjCZocw5yOT4oaA0cH73nIqMDgKLfa0BlyITaSJIzD2u6qZGXgP3
         0V/w==
X-Forwarded-Encrypted: i=1; AHgh+RpY84gBp6l8aO6ErYi3wGzPMFTrGr9Ds7sYiIzVOXmWIunablkdY1rHI9frBigsnlo3Cr1dia0Beiyg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy86hs/k0ztn50Z3Q/YXO8Ed3jkKeDEmynrusQeDcTI1k2w07zq
	5lUO1eOdnB088BUrnb7nvJQigorjxEpdB+60vWvtMeUL5tre9wY1KcN+
X-Gm-Gg: AfdE7cmCJxOqjpRxDp6MhYACBYQtQYFGEr0GHqRTArDvRHfNxDMyGenrYzhJjoWj7jU
	zxuXC/f+0e3MfCumBG7oq9Ls1e0k/TFrHagbKGgrO0J0EtzyFfabAKFFFs0PzHz8eQ/P6dx7BUC
	nRTVTpFzMTA5+fa5V1AAgT2Nn9Y+w56NF8upMczwQ17J4DkIgigoX3gor3evq+PY5NaFY6+iy32
	K7kaBhNBMs5tVhtNzqoJHq3xZ/ZrcItGcX1vSzSaH0fAUgfVPIabDQFdcbT56LOSy3R9bLCq2We
	ck58mUIN4OhM/qUySaM/0AsHdoAoSgBJkYbmyctdx+ZTuyJNOVqqGay39oI0d3ttY7v8A5MPrUv
	75BFjF2m+ROgtJUc4HkRNYHiop4UwRGO5Mn8P/8T5idetp0zCnPINTNZLiQa0Oor1C/iNokoFLN
	SXvF43P+hRZRu8NQ==
X-Received: by 2002:a17:903:120e:b0:2c9:97a8:8c17 with SMTP id d9443c01a7336-2cbb9ee3835mr58177745ad.42.1783242870253;
        Sun, 05 Jul 2026 02:14:30 -0700 (PDT)
Received: from lgs.. ([152.32.214.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad712706esm32368965ad.20.2026.07.05.02.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 02:14:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] usb: musb: omap2430: Do not put borrowed of_node in probe
Date: Sun,  5 Jul 2026 17:14:11 +0800
Message-ID: <20260705091411.282560-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap2430_probe() stores pdev->dev.of_node in a local np variable. This is
a borrowed pointer and the probe function does not take a reference to
it.

The success and error paths nevertheless call of_node_put(np). This drops
a reference that is owned by the platform device, and can leave
pdev->dev.of_node with an unbalanced reference count.

Do not put the borrowed platform device node from omap2430_probe().
References taken for the child MUSB device are handled by the device core,
and the ctrl-module phandle reference is still released separately.

Fixes: e194ce048f5a ("usb: musb: omap2430: Fix use-after-free in omap2430_probe()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/usb/musb/omap2430.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 333ab79f0ca9..6e749faac33c 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -454,7 +454,6 @@ static int omap2430_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to register musb device\n");
 		goto err_disable_rpm;
 	}
-	of_node_put(np);
 
 	return 0;
 
@@ -464,7 +463,6 @@ static int omap2430_probe(struct platform_device *pdev)
 	if (!IS_ERR(glue->control_otghs))
 		put_device(glue->control_otghs);
 err_put_musb:
-	of_node_put(np);
 	platform_device_put(musb);
 
 	return ret;
-- 
2.43.0

