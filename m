Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218743F1678
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883869; cv=none; b=jKpfsR42psPra5fZZJiQ3Xajnd2iQk7iaboR500eBSBCcXViTflOJ5f4o33wsvksQurZUcEW61ALv1ObYvDIxMF8wt+4hXGW65dFtsg5BgOqHEKo/ZyxunOZFqD4DG+qrlHf9u+dgQ4EuH6d6Blo+uKkuAyThBQKb+CIr5CLmWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883869; c=relaxed/simple;
	bh=8ScTk5smx7gkl/cV62c2yigppOTQ+FIzCJYYFT90JYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TruoLI+5w+yy/GJGLtiuD3MqLUiFrj1goGNIWqPaENo0Ngxj2i6SRu1N7fYXC+Ip2dEeS+I8Sevtk8Vy/uXarIDn7h/M1742O/qKXHpIB7v9rQo9WoqLfzoGAU5e968kK6QpMmxVBntFnQ7vExPaOZjZC0czQC5RIJ8g14hdtQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SQA2qBVe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SQA2qBVe"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4957eefd361so1763885e9.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 02:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784883866; x=1785488666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yHnSuBWNbpbTyZdc+kGUK7XSKGZJQ8XAkxJmAT7v10M=;
        b=SQA2qBVetKDxtccmmzbOxWE18/Xm8R8CHrI6Q11Ixpr7hVheLhv+ZB670e+jbELcJs
         WV/2E5fdrhZ0cnS8zQ/MhGW0kl3k0OgYGPB7Jkr673ai9dfCJVJBocr2MvXO4IxTQIWJ
         ms1unb+WBmMZ5Lq5GyLzUHJKxcPU8pvvrteErQtq0lSkwO8pMnMlr13X4neGfp1zQpSg
         Og+IMI7UCXyyotfMu/PJEoiy6/Qi2XUJDMb3+FNLaTiDTvZOuNtOWRMUd/Ru1RrdbYtR
         G39B66RzPAtu9Qd0APJDSu+PAxCJklQQo1ael8UTpBDK34YE0jYm1zHhLGWounIFKM5w
         XQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784883866; x=1785488666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHnSuBWNbpbTyZdc+kGUK7XSKGZJQ8XAkxJmAT7v10M=;
        b=evfTnmlyYx4PLRc69QGSB1B8BCQzvlYAINZROH0/DP8Dvv5SXYroa0tk9cqzUeQjAD
         qPQmPt9PjIyjRQP/85kkEiO/sTuPK6Z1SHvlaLG/iwRldwhjFN9MATvdkdZ1lupvLgrm
         HNqwGRW93qzyWjN8lezz2/9Ola9NV09VthJJ4SC/Q6enx4wNNnoksLfb3Gw1BFOL/x00
         RSF9wSrOuKvKsHW18DMlgMQ8EM+IHMJ4xBjeAz4xF8kpNK4hkwzRJvAzdJlbWzVLU2Qs
         qkXCT1X9TgZ3Zw6vTH7LE0r8xBG63Pagr16OLj8QXcyTXoAHFkyGuOhkKxPJUjefJbKN
         csWQ==
X-Forwarded-Encrypted: i=1; AHgh+RrId9Jn/xQFFccIM4jXiYLx3hFQ4JTMSdrDXw7zzhXHumZGAHhFp7tx0CGAcbR9ljVS2YCrMQ/FJ4Qa@vger.kernel.org
X-Gm-Message-State: AOJu0YzB62wQ/196ewLkifsMxFqIF3wlco2+vBemuNQgdhePqnnJi10b
	8RP0p0F1N5ydzFVAO8gKI222wNL141W5QOTuZLC27wAZfKdw93bRe4cNzkYUbxHAYASKKBxu9HU
	o0VsCpoU=
X-Gm-Gg: AR+sD13spQfVLFKx7vR8qCbkd4zIpH3pDqDbKv4lJ5B8GExKyOPYZ08LZXTudLybJl5
	yy3AcwgMr0Hewbmt1oPqArG9A92SNUulWrAxjuSp2BsGeuNNccyoS7jxBLU+hjoHuRHYAMe8l++
	ErUMU7x8MuS7WBffHuzvdtYreRtrwLQWwyUN08YrfEup47NkE9QMHw9eAi/uybKu7dAXt74RlY9
	XaSAia4pKeF0CrYuFS/xliVv5WMtF0MZqPve0qp6hlutldjHf92MNeZxhHV2fKUu2kGgu1lj4xx
	C3lOb5stsTOhA4scV3o+mBiU2QXKLwOQTAvXfcVnSmzPEDvhvGekPhzzh+zGadhL/oUQSGMmON0
	X4945f0WbEvjdWvecXRcCXi6/isswV5C2TBvrlAo9f2lHglO/K8N8jXAXjC34oEaJc3dEgyXP0z
	VZ
X-Received: by 2002:a05:600c:5942:b0:495:6397:14b1 with SMTP id 5b1f17b1804b1-49573cf0ec2mr50589315e9.34.1784883861704;
        Fri, 24 Jul 2026 02:04:21 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:e584:93af:f3aa:2c19])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4957afb4e48sm56146715e9.13.2026.07.24.02.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:04:20 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 24 Jul 2026 11:03:56 +0200
Subject: [PATCH v2 5/7] clk: st: clean-up simple provider misuse of the
 consumer API
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-clk-provider-simple-clean-v2-5-56f306156d25@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3497; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=8ScTk5smx7gkl/cV62c2yigppOTQ+FIzCJYYFT90JYU=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqYyqBKY9/Vk8kDgE398fs0o059XkEvxbFDk0sc
 0pKxCS2UE2JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCamMqgQAKCRDm/A8cN/La
 he3VD/4xcO2E6eu/4/OSXYGa7ndR/i5CWeM9fueSz9wfG+wRyrWEUUaO+rnqwnI1gajCZyEFGc3
 lrU2E+AlDn2a4Y8V6x7kWA2qkMV0jWm6v9aIN7PNqscHa1ps2NMnYCwIdJTDFbwp177j2mDf5x+
 nHdtLUMoFs0y42p3Tv+wg7SQ723imZaR/f/oUgQlLk3uO7l94PQDgI7w74VeIyYMxz5yhVnID74
 6kxXBzfkfuEI+QfGLXK538H/gYeDNRkr36r78UPmD+6ESFLDTiYFsd1s3oLXcYL+qIGMVaXHQqp
 2lSyciBUSIavwAvhDlkWoW6CNCrzRgiW5OjFedzsQS7zYynC+DgjCgskuhjTRjg0IyYS6tZ2+s+
 AJDXpBIEMOiXimegNz//Pq8hXRia9Y4WoEWBq7LD4qvTGiMKee5+xaQyeVstIObFsBIzxQBuJ+k
 me9loWvo79YxRs3X2Rgs9e91OiIE9TTtwMWgdTCYPQgx21ZuiYdxVeZETunwKFIE7XEOX6QNEu7
 2U5n/3SUr1+jp0T3YdDlW0rYPvpgkLSSf4FXWI0Rn5oiuaNejA9bmWtwqpixcWAJephSit/g6i6
 I1EfAGP3kaJ/LglQYCO0b0cJt9qrL2XRipEYQdiGKUZcmtYrko1tUcwe1o0EPmtphuD+4WMyP7r
 86NGuAW7RKxaWLw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Clock provider should not be using the consumer interface.
In other words, a provider should not be dealing with struct clk.

This change targets occurrences for which the provider uses the
consumer interface and corresponding clk_hw interface exist.

Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/st/clkgen-pll.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 9eb2cb83fa69..17551c6a879a 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -260,7 +260,7 @@ static int __clkgen_pll_enable(struct clk_hw *hw)
 		if (pll->data->switch2pll_en)
 			CLKGEN_WRITE(pll, switch2pll, 0);
 
-		pr_debug("%s:%s enabled\n", __clk_get_name(hw->clk), __func__);
+		pr_debug("%s:%s enabled\n", clk_hw_get_name(hw), __func__);
 	}
 
 	return ret;
@@ -295,7 +295,7 @@ static void __clkgen_pll_disable(struct clk_hw *hw)
 
 	CLKGEN_WRITE(pll, pdn_ctrl, 1);
 
-	pr_debug("%s:%s disabled\n", __clk_get_name(hw->clk), __func__);
+	pr_debug("%s:%s disabled\n", clk_hw_get_name(hw), __func__);
 }
 
 static void clkgen_pll_disable(struct clk_hw *hw)
@@ -405,14 +405,14 @@ static int stm_pll3200c32_determine_rate(struct clk_hw *hw,
 					&req->rate);
 	else {
 		pr_debug("%s: %s rate %ld Invalid\n", __func__,
-			 __clk_get_name(hw->clk), req->rate);
+			 clk_hw_get_name(hw), req->rate);
 		req->rate = 0;
 
 		return 0;
 	}
 
 	pr_debug("%s: %s new rate %ld [ndiv=%u] [idf=%u]\n",
-		 __func__, __clk_get_name(hw->clk),
+		 __func__, clk_hw_get_name(hw),
 		 req->rate, (unsigned int)params.ndiv,
 		 (unsigned int)params.idf);
 
@@ -434,7 +434,7 @@ static int set_rate_stm_pll3200c32(struct clk_hw *hw, unsigned long rate,
 		clk_pll3200c32_get_rate(parent_rate, &params, &hwrate);
 
 	pr_debug("%s: %s new rate %ld [ndiv=0x%x] [idf=0x%x]\n",
-		 __func__, __clk_get_name(hw->clk),
+		 __func__, clk_hw_get_name(hw),
 		 hwrate, (unsigned int)params.ndiv,
 		 (unsigned int)params.idf);
 
@@ -547,7 +547,7 @@ static unsigned long recalc_stm_pll4600c28(struct clk_hw *hw,
 
 	clk_pll4600c28_get_rate(parent_rate, &params, &rate);
 
-	pr_debug("%s:%s rate %lu\n", __clk_get_name(hw->clk), __func__, rate);
+	pr_debug("%s:%s rate %lu\n", clk_hw_get_name(hw), __func__, rate);
 
 	return rate;
 }
@@ -562,14 +562,14 @@ static int stm_pll4600c28_determine_rate(struct clk_hw *hw,
 					&req->rate);
 	} else {
 		pr_debug("%s: %s rate %ld Invalid\n", __func__,
-			 __clk_get_name(hw->clk), req->rate);
+			 clk_hw_get_name(hw), req->rate);
 		req->rate = 0;
 
 		return 0;
 	}
 
 	pr_debug("%s: %s new rate %ld [ndiv=%u] [idf=%u]\n",
-		 __func__, __clk_get_name(hw->clk),
+		 __func__, clk_hw_get_name(hw),
 		 req->rate, (unsigned int)params.ndiv,
 		 (unsigned int)params.idf);
 
@@ -591,12 +591,12 @@ static int set_rate_stm_pll4600c28(struct clk_hw *hw, unsigned long rate,
 		clk_pll4600c28_get_rate(parent_rate, &params, &hwrate);
 	} else {
 		pr_debug("%s: %s rate %ld Invalid\n", __func__,
-			 __clk_get_name(hw->clk), rate);
+			 clk_hw_get_name(hw), rate);
 		return -EINVAL;
 	}
 
 	pr_debug("%s: %s new rate %ld [ndiv=0x%x] [idf=0x%x]\n",
-		 __func__, __clk_get_name(hw->clk),
+		 __func__, clk_hw_get_name(hw),
 		 hwrate, (unsigned int)params.ndiv,
 		 (unsigned int)params.idf);
 

-- 
2.47.3

