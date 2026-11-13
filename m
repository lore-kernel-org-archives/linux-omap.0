Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605477;
	b=CQ3xF4m4nhW8Qx3CKNdT22D7oyCja2J/Z762pOpt1JsrLhdFKqyX5TJNKpz2Co+LDT7g
	 +uAUoJtY6jkWSf+cd2Tt0HSvRoIftCWSvmvn5wcBMMjSUDeogHTHDYuy0nRPpwDdY4XCQ
	 +FOVn1onZFq5P7I9Oo23XQnyau8q/hKewe88YIKZSl1qssJG/xxxHEJKvC1qa4MlJvNUc
	 F2llrMmCgBuz9o/TUlfppzRXKNzCdO6IxK+DaD4orpZkDuMw/NoKlH1elfYAOrI9yOaNv
	 CmF+pBw9jk6hCmxzbU4b+bTJ0jGxJe/+IbPYxbq72Bc7Ano3YuWfKMPUyb8o54xeSWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=kMoMcD1Lt/e75Xj6NwZBeN1pbuvertD/cK+qW6+KjfM=;
	b=DFOclXahezDi1PFYGeBPyEXUkdJXh4yzIg06JJqBrj8w88eQJFkp/2tMjVs0vtdxRCyN
	 EgevADL/ENafzvDY8itiNFfY4lAC4POcPbK8iEj4miPDPP5Wo/DZEpA13bgKUMmN0xu7R
	 ooy3+MksFBMMVyPwRkq1U67DIN7RmDU8WZHnqhA6VfJd7dy4t0xNup6FBjMAJa1fVgH26
	 NzLnoWYh5FsJ+OAWmsUuOaEW0L428RDmIEXJZJLzr7e3UeA2sBBGNd2WESOn5LPkH0Nfa
	 P1ljexgmr8xAgo3T23NdRtC9PUNb6WTdbxqj8l4R82rFa9D6IGgI24g038K0ZGa5FLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=W0icztte;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C17606A882
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 21:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6C17606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=W0icztte
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so14450395e9.0
        for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 13:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794605475; x=1795210275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kMoMcD1Lt/e75Xj6NwZBeN1pbuvertD/cK+qW6+KjfM=;
        b=W0icztteFaa6NYbT/QAMgfvslUHIGvz9Q9hJaV5MZastAiI+FLdz/e3yH+fhEBn/pc
         xuiBT9kq3STl/OlC3L1g+Bt/1ph1fZrxBZT/9WQ9eLfovE7WrH9tgQu8/d2ix61SlKEx
         ANrZGg28xLox5Feob815ZcshJq6JM5aFXbW1wHezRmb5Os9ZkviBm1TvtgjJIzW1quHQ
         FY7ZPzOF3L7xDjVGcHXCZFMKaK/iKVssyVWFNX/S3ZT6uMO+mb7vsjMYj+DUgk9wmC7d
         xaSnf0QiPf6L5Las0YvQ1K2JQlD5TJOMJe/XcopA9sKocYMqns2USzVGZ1B5wTkKD2y5
         xJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605475; x=1795210275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kMoMcD1Lt/e75Xj6NwZBeN1pbuvertD/cK+qW6+KjfM=;
        b=lXeSr+A/lqzPM07zG9xvKqK5UfhPB97W61Z5v0/13NSYBmSV41XHD+U+85ATDIxmYE
         50VCPTK/hAzWTJyUfEIRfF/2/+0/nsdgRlIo4VrRa3MBq3G2cqY07As76208xIm+Clrl
         TveOcwyt7R5fO71Idus97EFQoRdXDV6Hj3HL/qICaF+0nMTRHAzNV+qWQIA5fXphRfdG
         s7+e1Hp0XosQQLZJ1wIfPnZMaH7lcT0wnLz1CVyePupE/6XY5FDEL++rklEc7IQtJAMi
         1p0nJvL/B2kXG+cAivOLxA8al7CFlyp5yGxJa/KUARns0upWTc+zISeu0gMiunAYySjL
         q9MA==
X-Gm-Message-State: APuU4Z98erYQgwuA603c4KbtF/RYbySmMwQyh8guHmuQwBfQoBQc+B4F
	gVWOOru0zAQnAqagLLiRfSM96WkW8NpG/gZVlorZC8JeR5k3e3cwAkvGvGcvY3J8IdA=
X-Gm-Gg: AYBFou0qqMbqMdoN5mhdaoWXcnn0QceOJDYneHup7XnaKNoBcCB/iD50LNK1Xg/8ApA
	23lz60mOgWgMeZ2raQ459CvbdVX4/Q06hBrX5XjRjAu8uhImTjNfeIZRCyovm3DGkfkOvEV7NIE
	Jr6gyqTURFCtNq8r4GFbb+DzbFaOjugG1oq7EkXJAY+sH4DDKbIqSvGKWa+IXVV12Q5tGAry4dl
	l8P5m6zKMGA4APumjB+Kg0l9K5s/+DV1XTQMcOqAUo9DKy03VKAbos/CxGje3KbtTm8vk0St/7p
	SvFnBezxHoA78+PF+cCPJr9CbFcH1NX2W+TZDGJpZpi3wc3rV+aBgDDlvOi6Aag4QEBXfip5caN
	QoXxK0PpZQgnGMdjoUVIayZKkurSXnagWTXeMMdZMi/vJu97Xf/bN73z8Dg9fpIpKuJrKYJyscG
	Wtd2PsDwYlwj+oaoM8eS7hyELA0LV83VFt8v7r90Zpk84CQnKvdrVZ0T2I//Pooh9AHUch2QWat
	0n2/TfdpKn23EoHi5Sl2TwSrQeCH5iaS8FJPhW44jGOrD4c77o5p9npnZ7HF9wpjFgkl965S90G
	Yq7BFVWKc9nL1v6+YvYoyPNN1S/asJLQHSqhno9t1sI4rhnBumRWS+8QoV3eF0AEcIEeGLGYDum
	pCwgzL6aYYBMWlERetIB/ZhRAyQ==
X-Received: by 2002:a05:600c:46c9:b0:4a3:d327:6ed with SMTP id 5b1f17b1804b1-4bb55a5fdf6mr84563715e9.17.1794605475200;
        Fri, 13 Nov 2026 13:31:15 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c8a77sm7447727f8f.49.2026.11.13.13.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:31:14 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Fri, 13 Nov 2026 22:30:47 +0100
Subject: [PATCH v3 1/4] clk: ti: fapll: remove ti_dt_clk_name helper
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
Message-Id: <20261113-patch-ektor5-dm8168-clk-v3-1-a42cd1edc5f3@linaro.org>
References: <20261113-patch-ektor5-dm8168-clk-v3-0-a42cd1edc5f3@linaro.org>
In-Reply-To: <20261113-patch-ektor5-dm8168-clk-v3-0-a42cd1edc5f3@linaro.org>
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605472; l=2570;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=FcaXkSbmbLoEIeujNjI02i1V62uXoYWuhvh7robgIBw=;
 b=yLzZpIemdaez6TzWeagpbhxQd2QIPUczwuLxkq3FTp3SnHfFkFs2ln3YalKRTVg4zPqtLR4Zq
 gaAXhu0n3+tB3801Yk1hXh8pMvLRuRWqQDG22Hw4QL2NW+kQgCF34IM
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Rouven Czerwinski <rouven.czerwinski@linaro.org>

The fapll driver uses multiple `clock-output-names`, so we cannot use the
DT helper in this driver because that would assign the first clock
output name as the parent name. Otherwise, the clock hierarchy would
look like this:

        main_pll_clk1       <--- main PLL should be parent of other PLLs.
           sysclk1_ck
           main_pll_clk7
                    ...
           main_pll_clk6
                    ...
           main_pll_clk5
                    ...
           main_pll_clk4
                    ...

Reverting to not using `ti_dt_clk_name()` solves this problem, assigning
the correct parent.  This change do not affect other SoCs as the only
consumer is DM816x.

Fixes: 9e56a7d4263c ("clk: ti: Update pll and clockdomain clocks to use ti_dt_clk_name()")
Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 drivers/clk/ti/fapll.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index e54b1df3436e..ae2f6fed10f6 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -10,8 +10,6 @@
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
 
-#include "clock.h"
-
 /* FAPLL Control Register PLL_CTRL */
 #define FAPLL_MAIN_MULT_N_SHIFT	16
 #define FAPLL_MAIN_DIV_P_SHIFT	8
@@ -541,7 +539,6 @@ static void __init ti_fapll_setup(struct device_node *node)
 	struct clk_init_data *init = NULL;
 	const char *parent_name[2];
 	struct clk *pll_clk;
-	const char *name;
 	int i;
 
 	fd = kzalloc_obj(*fd);
@@ -559,8 +556,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 		goto free;
 
 	init->ops = &ti_fapll_ops;
-	name = ti_dt_clk_name(node);
-	init->name = name;
+	init->name = node->name;
 
 	init->num_parents = of_clk_get_parent_count(node);
 	if (init->num_parents != 2) {
@@ -592,7 +588,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 	if (fapll_is_ddr_pll(fd->base))
 		fd->bypass_bit_inverted = true;
 
-	fd->name = name;
+	fd->name = node->name;
 	fd->hw.init = init;
 
 	/* Register the parent PLL */
@@ -639,7 +635,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 				freq = NULL;
 		}
 		synth_clk = ti_fapll_synth_setup(fd, freq, div, output_instance,
-						 output_name, name, pll_clk);
+						 output_name, node->name, pll_clk);
 		if (IS_ERR(synth_clk))
 			continue;
 

-- 
2.56.1

