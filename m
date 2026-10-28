Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202860;
	b=KrkHh7dj4GoOvZJspkNKqVEiyE/5RpDNzj3IMe0+cn5KG40whCwtpE4a7LFolhoAhC11
	 N4kx2Nr2AgmVWUtnqxOJItdow7q60AjW4YX4h4ix2diwCLhAhg4ucfNyTXGtD4dI8XWwb
	 Ntx7vGXfXVb8gTXlC4kah/9MnXyjeKpE0qY7Ur8gXopOhEuUaT4DlGIp907UJEOCnIQnD
	 hsmH0zp/0q7dheoidf+7AY8+Jsfp/NI/QNdWE6QL5DZRZs1EubkjYA3hmbSJgWKueeUa4
	 k4DRPHXxCXg76CqlbmzSdLbvtlmUqYRPEptLkxzHJjvDfWOLOpgSKZ0B1W6SFx+3dlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ccajBfB1DRQJx0jrMEZz3XqV1UkUklVx5XXr8c2Z960=;
	b=1QvUqjZm1TKxvHBx+XqOPZJmQ4HyLiBF/i4OA3SpLYMCFcY9X+yIAqu6rBbPiSHOkYJx
	 56u2YnBz2MuQFk+m6s6CuRFjzTx/xykOuaPlW+c64kS3TXrNGPkGVs/VmHTxy7RfAI0+G
	 BS4/BVTZhvqsc1Tw1lu+MgPG0Jvk5UsXOJ9WGQWAt7Y1gT34BUsl6auzFjrfgjcSGTt+G
	 m8UnoWXcEiW03vtOTx+RnkwFD10JypYDy+QbSzBlnoGIq/SSkx/h1MIcRPDjA62z1qIEi
	 B/aIgl5qqzKgZdFIomg6NmLAG6Js+R0rn/yu1yHQ+cEL5Yjn+hKjhCq3/50+J08LjLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GkTDrLIs;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923C606A33A
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 15:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6923C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GkTDrLIs
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so11062125e9.0
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2026 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793202853; x=1793807653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccajBfB1DRQJx0jrMEZz3XqV1UkUklVx5XXr8c2Z960=;
        b=GkTDrLIsrm1vtvQLBsXeNrwfCa3oJVly33MOEkh+K9cKm/r1BqduL9IJs5nJCOwLBS
         7WcwizkEQ3VynNSnJnAEP8q4O7SWxFpkBVzMW7Akb5C6oM3Sm3tnH1/zwTmmQ/uaolR3
         1Ydtbvxoyig0vZiwZwfNuy4UZ8mY0+urDngIaLsVGXxWs2br7VubefsYe2sJmzjPBzR/
         m5tEaMRyCegh54VaMe4X8UeMlBNWOPvIzwuzlvhsgIUirqcD6Tl0EMBpnrjWHoU8tFyh
         OsRBpO5I8XmuVcea6sQKYtZR5M6RznNM9dXylb8ER4djsM6F1THF/ODKZEF53U1/wIYa
         3SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202853; x=1793807653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ccajBfB1DRQJx0jrMEZz3XqV1UkUklVx5XXr8c2Z960=;
        b=dlXKc7zNSZJhpHZ74Y7W3w2xY42WBgG/2SSLvO3CRTeD11uO8k7Evj4XpjqDwsTEzt
         DuHzWBZ1/xlWvYEXb9DvdOPTM6NQutum/bMo11+z5YDNavezOB7AxxMtzT0id9nAUyJ2
         ZCXJxchQkiYJ9D94b8IKjVlYwD6Sw0fcXrGe/76LKiIFrIex/57bj3N8fsm7s+bDQJI8
         K9ZwT2GzUyRFvhJtdB8C3NRGu7oJ58FOOV48cIxwsQLLrK/76czpQpfCbmF3ons0iigi
         9/XlqvoAjGRPAdFz5Yy773/obrqVmFgow4emXoBxm/9i+FkF/UYSIDaYvtTMGC5ScHYf
         Mvig==
X-Gm-Message-State: AFq9FYKh0atxEUlcfJwQ115GAyaigIHlLbViq5sd2Su1BMhQT3j2TbHp
	70ds8sdNg1G1egXRXMv7b97H39vgm4NBkK+JUg14AArmanC/TXAUUOdS/8aAQAI47wQ=
X-Gm-Gg: AYBFou0FWr5j93qAl3X0o8nNQ0sSefR55iCz4/41lVbvS/WxvR52HLn16XVk5Ibam6F
	M1v6jUFB0iddIFn7iiHVMmcf44nAjlBRk0ZWD6fGypYGV4RIsNg0wHgDRtweDLBR4N84qUPaPrz
	rMqbcCjcSAFiRw05g0XQAlJRxvvTmxUPdMxYKDf9Aqc8WuF8IoChltu0VULW1YsaU2q380gFBDa
	5rPcrICMAnajX6YXnhnUUH9+T0HQSDhCctNRt3jx8Dvp0632F+FzUj2bY1IIFmAjHS0+WNf/FXq
	PcXk05iLxqHu6AicC7TlDQXmgfJo/FxSkGGCAjNnaHnUJl83mxHv9qPtHHOo30YY0B5JIuSfo2r
	1CeNUKhvHe0cv7ZfbPhK063Hk5A+mIYtSwmSJFuSENwvWmPSCuCyF7ru7BxIGzI6mg3nNRoHSlp
	/lMOVzVNJh4NHSAqkmkXoOnDEZ5EEGd/w/SPHyet68hiryMJgC2qFX5l8jylfWpkF6RHYzNIg0n
	uNHFmXBEwIUXSs2hjCSAcl9GGZOqeSo0EOAXQgNmKStuy3VxFY2Z8QW8jSVht9Wjpf8KmrRs1M4
	pYCrYN4rdl5DHB9Oy72P4+c4UA9peXtZPHkYlBkZl4vM5sckGxpLr7Ic40pBuMoBHiEUvdy9NVm
	nh4P4c4sFZ/71KaXSmKhGuDJPGQ==
X-Received: by 2002:a05:600c:1d0a:b0:4a2:883:4adb with SMTP id 5b1f17b1804b1-4a9678c28ffmr61407455e9.22.1793202852789;
        Wed, 28 Oct 2026 08:54:12 -0700 (PDT)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm1468515e9.1.2026.10.28.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:54:12 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Wed, 28 Oct 2026 16:53:51 +0100
Subject: [PATCH v2 3/4] clk: ti: fapll: print clock name that fails to
 register
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
Message-Id: <20261028-patch-ektor5-dm8168-clk-v2-3-dc6bf0fabae4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793202849; l=826;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=Slbv+1YP2F1a+aBq2BJ9DLP7Wji77v+hSEpGjiXeytg=;
 b=O5OWEnIaLu4SaaALVpToqLuve4ADF6Pi4kM+qtBiKp67uCZLvnY7K6PnWC1gqUsH3oIg/uxU3
 Ariczt9c58VAr4RVCBk7U4KvTD2dOQs6lR0U7IniniqERExBUAerwfS
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Rouven Czerwinski <rouven.czerwinski@linaro.org>

Improve the error message when a clock fails to register by including
the clock's name and its parent's name for better debugging.

Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 drivers/clk/ti/fapll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 8ab9acd57b60..d360e9d986c3 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -520,7 +520,7 @@ static struct clk * __init ti_fapll_synth_setup(struct fapll_data *fd,
 
 	clk = clk_register(NULL, &synth->hw);
 	if (IS_ERR(clk)) {
-		pr_err("failed to register clock\n");
+		pr_err("failed to register clock '%s' for parent '%s'\n", name, parent);
 		goto free;
 	}
 

-- 
2.56.0

