Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224723F3284
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883871; cv=none; b=MFJxjcaeLogiYFBARRTd/056H/1sAVRA38cVHifieNI/OGZUyhTJlIUt8nn76WXqBsoWKhicQ0uE9ofw3xrUHA9uJDsPHYUH3iZJgC6WUHhhb8XMkhxkVMzwjCW77TtuBywFoI7+LsD+M3pctpD7kCSg6P/CcyiWG8V4jPR3BP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883871; c=relaxed/simple;
	bh=avXrZ+5B5tjwtUKvf/CVoHvEaPEqaWPpS7ZwUFxswLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RsvljA7xGHjj81aOPw4qFkMCupKnQNqCZltwhTLS+CTn/gLYG8K+nixNylbdR7W5J3a3mUG0K5PeukzDx0RaHsJamtScwdOpibC1HRUTBKhaCs5TXWRWXq91UYHjcf71KxLwJw9TAXnQ6sEf9Twt1orJzqXSWpQINm/F4t+bVEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UY/yWeVf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="UY/yWeVf"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so1542865e9.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784883868; x=1785488668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HQnvaHgupyGQPniAuZ9m3sJLh0U25N0HAPnxpHfI//A=;
        b=UY/yWeVfGIuMyB/jcFXmqmQ316caMdQ/kC7zDXTJo/4oGbx1BO6AJvRivkoOxTLm2B
         PX3kdv5Nvjx8p6jQQqqcpMHgxmd5N9GpYKtKQlrdHoRUUtiUFU/4MXg7iAUqauYJa3GF
         7N/0osoQyiO/TVGwqRjKzfxDgfeyDB4EH1BKYfuTlV7T4pdQJy+Gq8R6adE8ZTNWAChU
         KAPyhzrqmO5YrdRQdhT2PljUEsnbn5kmL7d4ypjVEkyulJSN6XnCddBn9DfIoyejlyas
         iiTN0zs7+K2CYaUb9FGOlG91LGpeNgLSWB8QMqQWVETlTLKQiLvGU+SSywgnSWZMxZRR
         BIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784883868; x=1785488668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HQnvaHgupyGQPniAuZ9m3sJLh0U25N0HAPnxpHfI//A=;
        b=DLUcRmkchazcKYP1fxwKalFD3wZc5t74D95vwqCH6fIxcYTaUGWRDepvSeXwH9c0wJ
         HfBYYFtD2KmVGXl2B0bq8++mE/iQg9mC4DuZBtz2EvpAkOBwl+YL01ORWXuIR9yjQO0l
         xzE7ya6FzOC+yb02L4CxQE364+U50Nsg4uF+aQ2ZC+9grFyqyKZ1qbwGOjBAH79J+S8e
         AiQHHRHLl9OO0Ny4NAdYKW8CpmQVDQjMKEXvJSFaMddUZz2PYaxf/TYllFfZAxmIMfF6
         iTzI+ivLA4SZel2Wra5iABHS2rbr1tXbHe3kpcLN9mZeElPzUV1OwC6eOGqohGblsIDB
         41kA==
X-Forwarded-Encrypted: i=1; AHgh+Rrq8BUTCuTSVgJU40BGlbfHwxYA9W9YeUy5cgVJcEnwZbHBTqttymxIxrLdTCcgrC4Jentp9mBOyLLM@vger.kernel.org
X-Gm-Message-State: AOJu0YxKcE39oL3W+VEuqBwq0RbP9xIhfr1UQ89XYni6WVh+WwjdhtQ7
	jyxPWbQEw66GoRQDs7Zm4sQPtIpf5bMtDeXHv+LREu5Ksb3JCKg6/nFy5AXUE12yJRighmzDItZ
	2r5kaiWg=
X-Gm-Gg: AR+sD11P/MZ+7DX8IHcrkzH5/vhFpwBHgw199DrI3FTOuNTAMqWIhQhT3c1dBG/Su6R
	Awm4dP9n5Z5dlF6riWsPUrbDDyTg+uzLDX1buF6TD3k5Iqr62peg8i7vrKNEddaEVAuxNp3/Unf
	Np6/m+sJl+yyBOO1gbwrHW+0RqqXSZqQnKdXvFvRtlp9fRilw2m6u9DaqwufSKV5ElVIgnRSEAX
	L+rHFJ9s81wHz8W95HSHq8r3OXnHavMylhT9llGLzoQR+irrZZ85LD7rWSrW51S9R3MU6GZtvMG
	isnsAFuEErnFEAa19rt4mRs20J3RFg7fv+42wHh0bqbThvU4YwAzRyiqBr0Y5QCHAEbkbNCdWNr
	zbSzTbWNUYyhbcAL9byNQPp+V62iNLch2VG02q7f9sBRP+BPJT2WFHjPELrXXShXcvWok5C4wIu
	bQmkcr8A4MmpU=
X-Received: by 2002:a05:600c:1f92:b0:495:4c62:9d43 with SMTP id 5b1f17b1804b1-49573d1ff7bmr72020495e9.34.1784883863694;
        Fri, 24 Jul 2026 02:04:23 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:e584:93af:f3aa:2c19])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4957af6b049sm62081735e9.6.2026.07.24.02.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:04:23 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 24 Jul 2026 11:03:57 +0200
Subject: [PATCH v2 6/7] clk: tegra: clean-up simple provider misuse of the
 consumer API
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-clk-provider-simple-clean-v2-6-56f306156d25@baylibre.com>
References: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
In-Reply-To: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Heiko Stuebner <heiko@sntech.de>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=avXrZ+5B5tjwtUKvf/CVoHvEaPEqaWPpS7ZwUFxswLY=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqYyqC3CQlE9ZZIVg5FO31DSHE8VYccHPXetZHC
 CBbG7T1HaCJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCamMqggAKCRDm/A8cN/La
 hdLjEACXqz7q4lL8DurbW6pS/HNGz1tLg+/2ZSOd2a7o3s1z2YOBOJHX5vpJFLW/nIYJQw5So1e
 bjWoWmm6BY5JCwtK8uqJ2bemWRXcpKLvIlUZY0FVmgQESFPtFI6OdwKwVPkWbdp0eS6LCSh/q6G
 JuMStoA3PBKgBu53Ve6ciKUHdiiBoMmgvHq0BSCaqIGndaJkgfdg4XuoiI/jJm6AzgtMB/1nUqs
 jbtnez8Ei4l7beEGIPt0nkoY3Nkfb+0yB+/jwtJ6N0qPr6whsRWIHOAdwMqA8Iq1+REmschxKZG
 rXPy0b12PE93ipjZMtunqFaT6XGz/iBiZRfZ1C5sGRIKSwh58YEZyIJDtz4lXRKejKn9ziciY/R
 JzXZTezQ7P2U3Wzw8rE957D+tus8PvY0lrAY8jzO6MQ6Xm9T7WbR6OP7GtkdQMOKn0NLEShvhbe
 oVzeAVhbWJXuikQDeKeq6wN+DATSFxT/BCw9z1g0PPQ4DuJoYiOXw0DbuoIL/1ar9IvnWpzAWzv
 +YYi227ullORrzbQ225A5CHiau0GS0MokdcCulaJSeznIQwGVMkbJy6v0tlxRii8q2Qtb9CCoQI
 rqGyS2+E25eCLne9dNnKOrjnKPB1NUFEawcRFsnJ1o1K+N0G+eiJ5YPh5DcnSVvF1h1Kl0VzA/E
 k1+4dgdZ/1iNGHQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Clock provider should not be using the consumer interface.
In other words, a provider should not be dealing with struct clk.

This change targets occurrences for which the provider uses the
consumer interface and corresponding clk_hw interface exist.

Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/tegra/clk-tegra210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index 0c86cff719e3..df1d7b471745 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -1460,7 +1460,7 @@ static int tegra210_pllx_dyn_ramp(struct tegra_clk_pll *pllx,
 	udelay(1);
 
 	pr_debug("%s: dynamic ramp to m = %u n = %u p = %u, Fout = %lu kHz\n",
-		 __clk_get_name(pllx->hw.clk), cfg->m, cfg->n, cfg->p,
+		 clk_hw_get_name(&pllx->hw), cfg->m, cfg->n, cfg->p,
 		 cfg->input_rate / cfg->m * cfg->n /
 		 pllx->params->pdiv_tohw[cfg->p].pdiv / 1000);
 

-- 
2.47.3

