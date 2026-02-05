Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC31170818
	for <linux-omap@vger.kernel.org>; Thu,  5 Feb 2026 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259649; cv=none; b=qMiRJQwvQwTUi2220t/+9z4hqzezqELKorCt7pwJ8IWVB7VIShxdzMLNuGF4W9l9/jUqZL+d+5h6v40gp0PF2MuOsFhxtiDaA0QVVpYxq1qQEvltZsM+VbKk7k6t24AgQ21Kk/WVFDV2c2T2jssU6Su5FdQpQR1rGRbhSGebeH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259649; c=relaxed/simple;
	bh=NkPq/s5BiXpj1kYu6RXFoEWhOuxRY6zyl5jkhvFJ5Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JC5J5wzbdX5AUQ/nizgF5M1/YgyFC89iZ6wvTbTkggMlOJ8ZymipFS1XvOvB40z4lubHw4aj/IYlIYU2PI/1tybEdvboYvl/z4HxYHt1E3BmDrNfDFFZj3ZhWCbkyO0gH4Qy/ATMk1MwzaN3Bd9WZfvfOLStLGPoBUdSCIdzqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LADdOVue; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LADdOVue"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8947ddce09fso4779916d6.3
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2026 18:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770259648; x=1770864448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLaqaSS4WB1Humpqpw9lfgDwEEvSzEjuIrUcj+p6NtY=;
        b=LADdOVuew6VF+LM4JwJCLAx66PNHpy0lQPoIzNonCJ0+o46ezKcE5hWUr0b62PAhfK
         w/4KpnhM/lTRDG6DT02HX50mt/ESqULUPw+F848WRFghtrNW+72YIlwNC46B1QNlDcTA
         NyLazLFkb/9jR82XHfI8jwT+azV2sPl5x938Z5cG3Xn/KHRon1lcGBxIggbQ/EDQmeE+
         jdy4eE3mTyab+DGI17gK4N6TbnucpBZNduTqW+HPImbQHFJQ0ZtImHZ+9AXUGO16402Q
         nPPfLT9KM5Ueu0jk07gvLa2IotNzxCI7zrhD/FOgC3v1H1lxAFHfecMnzALLVVe0iYVG
         9PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770259648; x=1770864448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yLaqaSS4WB1Humpqpw9lfgDwEEvSzEjuIrUcj+p6NtY=;
        b=IAgCl/9yr/xlxMPMWDWziy7065Ky0zrojkv9n/lE69/XiJx4tHSsyfiiTNBbWzKaAH
         43NWhihK7c0JEpiHdYrhgr5+pDpj2dQv1Ai3pWJrYSxhXNm4kyoNCenAr+KlxyT3oD1/
         Voa8lG4pFy+vIVNs38bY42h1Sh5kQEPhiBcVZlXcZI+/PaidfmAJVMZTH/jIlZ9TLWwU
         4Jqv90awFskv36khfz4xKfYJcoNjkPlg3Q1EKeyjWp8Vu9CUVG0gFu6YEzHbCYTWz+Zk
         NySPbk4vQ1xd/o71ULnavTQWcshLDQrN2kFbp2ciJvXhm5ilXdEn6N/MrfBNLJZuMq5s
         Q4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIP5AlxlSDTSgSwbQjU8iicU+rt3RYn4Npm6kbp83ZBBiwFuKs9j+vDdO+vibBfBIJqkPxMH/SB5gY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx24qVhaEj6yyk8qNkUl99K6JqvuJMvkd+AY339L0wNDGXhbu5u
	B4NfCnnxszrh14c2u0941Ut1pkzL4bdG2KBb+NzSAQzYSCKB+g2S4QLn
X-Gm-Gg: AZuq6aIy44ySKcyZ0vQMLJAbnohe81b51YhR7OYi8n3ETTxyl47+2Ev1Vo9t/If3twu
	5bROIlx8W4GEJCrniY+e/I402pSt8rmIIZWFSXya6LbY7vNpVGXxJsiki1mUmqtFoQKX6p5QXie
	iHfT7fFWR+gPdICG4l1THiF+wuYLVbOTJdFsn843mdw7tFNeUq0YngHx1iW4oZKPfSnqagY07W4
	P0+iOYouJv7SNpovcZ2+Ldnt7xXX3bMC9sEnvn1EYztmpNFQV89U9MIQa2Snttj39vZr+fUkNLJ
	fQWCDcpUYXktjSbQgIS/X59t5L3teAhnDU5I9Q6FmD2Ilh4wh3y2x5kb2DvOa6HtAYzVJJCOnEb
	cn3am9RuYU13J55xp0uHug9tB3LJ1idHEvMDJalGFBrEbZjIIUCnFdp+z4K6jobl8OGOqqqwfg5
	/IVQAvUaeiz2H92ovAPDkI
X-Received: by 2002:a05:6214:501b:b0:88a:35cf:8db3 with SMTP id 6a1803df08f44-89522185775mr76334956d6.18.1770259647646;
        Wed, 04 Feb 2026 18:47:27 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2b5e3sm308193085a.25.2026.02.04.18.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:47:27 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Thu, 05 Feb 2026 10:47:02 +0800
Subject: [PATCH net 1/2] net: cpsw_new: Fix unnecessary netdev
 unregistration in cpsw_probe() error path
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-cpsw-error-path-v1-1-6e58bae6b299@gmail.com>
References: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
In-Reply-To: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
To: netdev@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
 Murali Karicheri <m-karicheri2@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, 
 stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2

The current error handling in cpsw_probe() has two issues:
- cpsw_unregister_ports() may be called before cpsw_register_ports() has
  been executed.

- cpsw_unregister_ports() is already invoked within cpsw_register_ports()
  in case of a register_netdev() failure, but the error path would call
  it again.

Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/ti/cpsw_new.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 21af0a10626aaf0ce6ecb04837899801743f3894..b9fc31eb06134dae33427eaba06341c39eb4b41c 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -2003,7 +2003,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	/* setup netdevs */
 	ret = cpsw_create_ports(cpsw);
 	if (ret)
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 
 	/* Grab RX and TX IRQs. Note that we also have RX_THRESHOLD and
 	 * MISC IRQs which are always kept disabled with this driver so
@@ -2017,14 +2017,14 @@ static int cpsw_probe(struct platform_device *pdev)
 			       0, dev_name(dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	ret = devm_request_irq(dev, cpsw->irqs_table[1], cpsw_tx_interrupt,
 			       0, dev_name(dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	if (!cpsw->cpts)
@@ -2034,7 +2034,7 @@ static int cpsw_probe(struct platform_device *pdev)
 			       0, dev_name(&pdev->dev), cpsw);
 	if (ret < 0) {
 		dev_err(dev, "error attaching misc irq (%d)\n", ret);
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 	}
 
 	/* Enable misc CPTS evnt_pend IRQ */
@@ -2043,7 +2043,7 @@ static int cpsw_probe(struct platform_device *pdev)
 skip_cpts:
 	ret = cpsw_register_notifiers(cpsw);
 	if (ret)
-		goto clean_unregister_netdev;
+		goto clean_cpts;
 
 	ret = cpsw_register_devlink(cpsw);
 	if (ret)
@@ -2065,8 +2065,6 @@ static int cpsw_probe(struct platform_device *pdev)
 
 clean_unregister_notifiers:
 	cpsw_unregister_notifiers(cpsw);
-clean_unregister_netdev:
-	cpsw_unregister_ports(cpsw);
 clean_cpts:
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);

-- 
2.52.0

