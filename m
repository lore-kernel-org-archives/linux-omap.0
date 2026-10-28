Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202861;
	b=M9TO8+8MXXXrYB3XeNHUAzrcwg4nzEWp4OHM+REx2mv0l6555DjE+U25fggl6sllbvvM
	 nqRQEeK8OdOZA5jCpQCmLKfKXGKSq+MBohTI952r5yVNWyc4Xibr42ziheuY9jmR+OcZw
	 zmTwJabjJNYZw1CafHzTq2gb+JDYM8Y5Fp4Jl0oiQ5LQE76weTngAfjqQNuy0bBbmvZ96
	 6CEg34Go/117kZirNOvtSdgFlSAVZ4UsR/yEZ0lb/VbxshrbNyX1iLu6tEG+o/tQoQkJC
	 /AYkAJGex0+mC9fTQhLZqa/QRs7e+xpB3YpBrL4ckdnggMMZHDjIdaekCeXx/Oy5zRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nOQQ4FV9ljkth31bB4LLMsIJDcvWTQeL1zQqaIAUkSI=;
	b=kI6v52cf93VlgR6OOj1wt5n6WS86MPHEHZkgALU2lISN5XoTSmuMF+JC89guJ0Lnxzk2
	 NzJCtyh/OKGd07SeXqg0vMmwVp4cXTg04KOpFnuDGE9tGCy1of9SHIjE4czm/XrXvkUp/
	 zwKhv2RsJAqKbVQikZr5cMtho4FIMtQ4ifP1U9E1e4KAPOk5y8QRf5KQ9zdI9tBWOuFYk
	 ilfVQJouHMVznxyOf3fVdrb6ALAz4Cz9KNW4MIr0je9A5OB4OUGYeXrNj6VQM01URkdHg
	 Tdw11Sk6XjjZMeKnvYvW78B8owugZN99kub+JSoshQl+pNhN9OXx+jxcFFwx6kW7YHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=q4ZcMaxW;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855BA606A32D
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 15:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 855BA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=q4ZcMaxW
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so8385395e9.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793202854; x=1793807654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nOQQ4FV9ljkth31bB4LLMsIJDcvWTQeL1zQqaIAUkSI=;
        b=q4ZcMaxWzdLtkA3zzlJS/tOaVgjyxV3N+LUDCU+2Yf0uTfBtM08gd5FHOmFJ6KPCbp
         EuxYd9avWQqzpQjWqNf31QPqzF3f8BKWkCZMlIDAPhvQwmU/1mggUdG/2uCvudRhghE1
         XR/2kNDcCVmFpPSK1sXqCgQ+kY6trEB3/6EoGB+rNCklMfhHjz+BALtjiBy8ZIV1tFhI
         O8u/yQ0auX/cNS97ZqHy1/hcnNUjydDycPgqNGbv+cgBzm026VxFNfN2UjfN2/iYIF3t
         ymLnDUgVF4OayaK/bxTwTSIVDMBdy5Nt3q/sFxeJtw2Izdgv8gXKi0/mIZNvS9ATphZC
         HJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202854; x=1793807654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nOQQ4FV9ljkth31bB4LLMsIJDcvWTQeL1zQqaIAUkSI=;
        b=fL70Dbz/Qk8pocGZXFmyWoy9tcZ6bWf1hcIMhoN7s2+6KCPkPFfOm6HQQsH70CMXR3
         HoM2pk5PWHFXrcRwAW6wPdyGODFH71QBZHjCXKZ96yNy5KwYBp5aTphgUb6Ei7Do/52B
         m8mfBZHN5pcqBXMlsyOVoYsDAeq348PZtO9VKwEEMr5OGGXYbmcMhah3NQ6PMgz0Hrho
         Q6l6+TzFvphqXIptBbJbYhzqfSwEZi9fBY0mVC/NI/SDdSrjyzObaKDQwCDF4wBVnw3H
         QWaz4mdJNMpIX6QaPGuKvm88kyw0rtLaoA5sEsYTu36psEMUd+cwh/jyStNMDP0JMzHt
         dM8g==
X-Gm-Message-State: AFq9FYJz6CtozxeTN9bvuJSNwDbeQKgHaVTsBP282Xa1K2WN3L3fYIgo
	msZY/+lYwEfJQ6yQ8bWzu2qB82nma7fgduaMh6MxwtmaHer7uZ2lgwboU+nKUj83EQg=
X-Gm-Gg: AYBFou3DomSXRej8K78jWHVtZvUUmtEvzTqEdAvwb4hoh1uYcB8P9Mo1WHPSrM22nKN
	16yonXPt8karg+Mg3t1XgdqH3FFys15gHrX3rjhOOWfHJWkTr02d8bCAScZeZy5ANCY2SR0UN9p
	P6CmuujNcNxT6FeHSfybAQet1U+gBMBEt6wbkq3F6Ztupgs6IqaZLgrkXEhtgpubouUYOcoJTlI
	SltEeBaBnSviFXnS3r3n/yzSX6FiDxDuyDScV8D/AUa9UaqwzXTuq9lRvCLK0RUMBl3cNxBzYoT
	43fRNkKT1POnzG/IpEn3A2wFzbk2x/GHdW2uElthnv4ni6MAAIQ0eFyIN6CrbDy6/+dZ7eYbP+4
	wRVL4idC3PNPF3ZlA3lqcZzvhlhCDLQzpuwEgBmE5QmWCE+0S7M3fLw1CPi0HUaeb/iTYumps22
	xC8XmbyfjHkMuJQ6USdmc4BpfKwIetUYtaPAJrjiPscpQsLOuxki31UTptl3H81pqHh6tt3PRow
	0DstvwcPMU96qoToNeuK1js2oKL42f94OrZwuXJXbRy2yoXv5GafBsiuzHRE3DOwKOTmATico4G
	CsceDc2mv3765TAU9qOGnerxDG6H9dt5/M2iESA0pd+SKM+4+ACF+GTP92TyL9tz3A8Wj29sROW
	oX/yl7nLvUZk5fanrNpJNfK2TSw==
X-Received: by 2002:a05:600c:b99:b0:4a1:a45a:88f with SMTP id 5b1f17b1804b1-4a966c4113amr58228835e9.20.1793202853801;
        Wed, 28 Oct 2026 08:54:13 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm1468515e9.1.2026.10.28.08.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:54:13 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 28 Oct 2026 16:53:52 +0100
Subject: [PATCH v2 4/4] clk-816x: add sys_ck clock as sys_clkin_ck alias
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-patch-ektor5-dm8168-clk-v2-4-dc6bf0fabae4@linaro.org>
References: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
In-Reply-To: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Michael Turquette <mturquette@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793202849; l=1025;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=2inYdETjS1/0iXkUB93PtZKo6J17s5dPHUL/VIsncwk=;
 b=KfKesliDrKOJaJsoOLl5wvIYXtdqzsuOVACvkkiMCyuQmRlW4wxObOxLKTb+dw4dQDl5pQ8+0
 Z4Gm9Vpl6RRCP4hfAcfJ0BGifdHJT5goKzi/vMLGlxR0ldewux+zQFt
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

This patch adds a new clock alias for the DM816x system, mapping
'sys_ck' to 'sys_clkin_ck'. This change is necessary because the voltage
management driver searches for 'sys_ck' in these systems and fails
without this alias. By including 'sys_ck' as an alias for
'sys_clkin_ck', we ensure compatibility with existing drivers that may
reference 'sys_ck'.

Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 drivers/clk/ti/clk-816x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
index 3b8e483aec92..fe6f66fc5a05 100644
--- a/drivers/clk/ti/clk-816x.c
+++ b/drivers/clk/ti/clk-816x.c
@@ -57,6 +57,7 @@ static struct ti_dt_clk dm816x_clks[] = {
 	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
 	DT_CLK(NULL, "timer_32k_ck", "sysclk18_ck"),
 	DT_CLK(NULL, "timer_ext_ck", "tclkin_ck"),
+	DT_CLK(NULL, "sys_ck", "sys_clkin_ck"),
 	{ .node_name = NULL },
 };
 

-- 
2.56.0

