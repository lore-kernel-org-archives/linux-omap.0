Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C003EAC75
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883864; cv=none; b=CHyOxkqvBQ3z0WysMwewQICr9dRTDsTTMp3xWeJ4fyr8kh191wsY035OUHQNOhF8lzhIY5nddt4UksPLCioH8yx/jxp01Fckr78L+GA2x27Eph9BUHZPe+4wSXFYxw2bAtqYjD51Ix/bUeFyyHPgarX0bkfghECklVGQ8AepimU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883864; c=relaxed/simple;
	bh=i4qllS4+L+pREPH0T4wiXzxc5q4nTV6C2Q3lI6XF9y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fsqDKmcAfgv3BPe24AMw4y+wJzl+flVmdxn4M+SZ5y+KF2V0cIz2V9sdbBt1S+5nlq0GOEfo24dItvz/zmnreIS1rlNw1S7ucFWvKVVFpiNkn3FVWOJihMiEpJTAW7v05Wx3sF7n0nd8jcuc1CSC+ryeDAEhFlBSTPDjmFEqoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TJQJXebt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TJQJXebt"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f707e5d75so165110f8f.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784883857; x=1785488657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MLV7Kh0UK364ekQydmUokZhdiy99pnn6pB+Tv4eP+3c=;
        b=TJQJXebtndoDHifWZk4L+YPtIt7ZMTnQKpJLdeiIW59NfDFtu55xcbF5pWkXwELeTs
         mPViOzD9d88aGV4yVXRFKEFzMRoGMH+/0FacxJewwrahoJtxCj1GHR1KR6voOFb7pvCP
         Fwn+1ZupPY5pFN1YUtF5/wB/xzDMSaGzd4TjH4JJ9WTbA/305avXm84GQK9u+xz6BLNg
         KPAwe968H9ILkXB4JIn/+SX/XKJV2dOXV8M44c9kIoLUh6H9LzjHjXNn9mAwegfT7haq
         maptLeE3lHrZghQMZQ2r9vW9Q+dqYgUclewPMq/BRgze9wts5dznHFJaOuHatYUPFW+F
         +h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784883857; x=1785488657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLV7Kh0UK364ekQydmUokZhdiy99pnn6pB+Tv4eP+3c=;
        b=Vs8bkhcNc9z8UUPwbeRT69WZrblvcSIqskJ55DWhdXq0uIK37DaAI/Sn48+GklCd+N
         X1o3W+RUoQ9gglmJo3/TwEduwJDZ7jVrNmBcf1OKvlSyOw9zUFlXsMkU843LgLMRjQvg
         S5zJJmw5Ovdxmc9ssaLmzv//PPFKJbEYwZTf4iFNp+889No+SypxrVJUCKfAkxzXp4bw
         TwdB7vspYjZ9vYwAeiWAzS1PR2WbAQj3lGauCvW1FyGN1uSRemth32HRV+aY6ks35AN+
         5vL3KrDRzwZNe7vJxjwe62pPBQ/HHuNGsgfSwIFRniHF0YGe8eR0NZExuSupJJw8fAkG
         CZEw==
X-Forwarded-Encrypted: i=1; AHgh+Rpe+dmm8Ni1VlCRz43o53GbLGBLGWIXRMqTHAcZEQSn6hVHVD49Hqq2fgXNlFk2vH1kuFBnohg86jkt@vger.kernel.org
X-Gm-Message-State: AOJu0YykBvCr9RPnTKqD+BSoKJCcwSfogKHtHT6hKI0Dyd4sQJpIBdxJ
	UKquPO6M0oGq1H7DVuzcYtn66FfIHYgJT+0DyOejextUrH5j9ZzrRmM4S0JsI968+7dW84hriwz
	wpfCgroc=
X-Gm-Gg: AR+sD10gisVFuvstxe6jXLRkguAimFXB1afTK5Lm/TborTREvoHTEi6yPdBExOWwyWM
	G7aZHbHc6L/w4esKV+XOUYxmoDFsPeuh1rdHZ/84uIbxCrnpV8IubWytDFan09WIWS7wjPdaJVw
	KtkKi1JoZtMHmaapbvhkEGIhPZ531vmIDz2Dc9OchGCNlgJz0vf22xtnUHIWoEfeeHzCpf2P7cR
	CQ71E7BR0q2c97tKgD3S+OWpHpWps+DSx7hOsf00rnT5aWVIDPadyOsxT5GZARuT6ryfe6354TV
	o7l6S07Phj3pcQTMvmItizaYCArEcANOMVSHR/mbh31azJQbDo0xTqA2d/8A25Nf91FYVYyJr7a
	8mh9jyAos2tbsYlDa15HsltzWkA+gB8W3Vc1gQFWZ6h1Dqq/I+uZD/QZM0ZzE9zsGcsRS+GWiID
	qC
X-Received: by 2002:a05:600c:3508:b0:495:5f00:9497 with SMTP id 5b1f17b1804b1-49573cd9427mr73102445e9.18.1784883856862;
        Fri, 24 Jul 2026 02:04:16 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:e584:93af:f3aa:2c19])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4957af6b10esm57168825e9.5.2026.07.24.02.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:04:16 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 24 Jul 2026 11:03:54 +0200
Subject: [PATCH v2 3/7] clk: renesas: clean-up simple provider misuse of
 the consumer API
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-clk-provider-simple-clean-v2-3-56f306156d25@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=i4qllS4+L+pREPH0T4wiXzxc5q4nTV6C2Q3lI6XF9y4=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqYyqAHjrBMlLbsRDUuljqrEYPOyeyYAPzg/SXk
 jNGwdlpTaaJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCamMqgAAKCRDm/A8cN/La
 hSkyD/4pUoLziZUxxkpmbPY/qvTAcrEdq7SBbVU6GpskFU5ov07moRfgR+6L+QnROKwYTiacIiV
 j1Id4mbcJS4lTGYyfhQHnpCpE6g4Ty5AOA5LGOh4j4/JBxdHL+gSrPGt14RoF6Yj4XQkhA1UHUu
 PUEYCZKL0dJtmaJtG+j9xQ1n8J5fLTJ4yYwDhVGPC0gFBub2VC55exg1nLw9H/BA9QuYfH/R6jB
 1gRBMy3ki4RKKZlrSF/HE+vSq17ymWXfrS3FSS34wfEJBVX61mFRwB0GHvC4MH3rUyoibQ+VXyT
 fxhDd8LpNOnsg4bjNSbln23x9I7vCg5gIqqxj3bytRpFG6vWz/hwCe241843XOXyP8UZXor57aU
 yCUv+ewWTn7vvtq/y0V8EFxe3K77GZ5obxj3nS1lws92lwHu5LoB7SmbeRYj3c8n2Cw4DJ4BP04
 aDLst1r0KfbFdesTIeiNVRM7Pj3uVdpGPq95OarAzPWMQ84Rw9b01YxXpPr4Qt0BO8crTXNH5bT
 9maeRb1sc1HL6+ksttwt1yZ9bpD0WzEbL1UOkKEbpdhQGM+2M9RzZzmlK0wbO4TnJ12TqHh5iWx
 gOM1ryGczqr/oYKu/yudM5d+TlB4vMwCZUy579E3zBPTZJJ6qG11DkD5DCSjYDdD8Ew2ujwzSo0
 pwxjz05NaJ3Z5Uw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Clock provider should not be using the consumer interface.
In other words, a provider should not be dealing with struct clk.

This change targets occurrences for which the provider uses the
consumer interface and corresponding clk_hw interface exist.

Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 076f587dfd39..1da25e4fb4d7 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -1014,7 +1014,7 @@ r9a06g032_div_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 	if (clk->index == R9A06G032_DIV_UART ||
 	    clk->index == R9A06G032_DIV_P2_PG) {
 		pr_devel("%s div uart hack!\n", __func__);
-		req->rate = clk_get_rate(hw->clk);
+		req->rate = clk_hw_get_rate(hw);
 		return 0;
 	}
 	req->rate = DIV_ROUND_UP(req->best_parent_rate, div);

-- 
2.47.3

