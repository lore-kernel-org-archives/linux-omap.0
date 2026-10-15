Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6DD54B1DD
	for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083305; cv=none; b=Yzd0Xgzogk/FdZWNPmGoh/VaNBLZxdHkj9jSfR5LB1h3TzJHG3reoEmbHk4zrScNnbb3S0HhPk0qaHPPoWRKKYtLa1ETA/dEHHdT4z9WgzjhCmn7hR2P+gB5EurDaKIoBZlq0ELbFsQHhjzyBmM7IseiYg/d3FeoO3uEwqkgSgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083305; c=relaxed/simple;
	bh=dz4JFwB4ePeaGz3RlHhyJ9b6Yy23+uXcydlEUFJ6fY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4FbSnmpDU7k0yFwvgJGQp0kGHG0EmvIbAuJBk4EAfIrM5bRXS3CtOYhvqS+Y2Z3rWpZXd8pWkHcIXSwr/BqkHZTrtx4It8Sc7JHZx9ArsXzxupIgJdDA/JtWqWYdtch1H2Ei3NEB72TyUKIBax9GiY6ayzzSXrgZd8SLzO0rUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RY4L/Z10; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RY4L/Z10"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so44711135e9.0
        for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2026 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792083286; x=1792688086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QqLVm7SLi9zEE0K3BLZXJn3MFA1ghZKJ0G7TZDkfEHQ=;
        b=RY4L/Z10gtzvXkj5iCNOteXx+oNFO7bBsDk4+5lBQoMdHPQoh1XCRhik7j4YIoQ9B7
         9oc5D7K3vOvPJGlltGGLCOv1rTjIEzLqGZlulsAde/PoEf0LJNlOAbbiIzerik93H05s
         IYK8imrF1kmNhrCCRK8H8ZEYmMk7jfJwL58Hizb7tSXW4kN8NAc+mcFXAan65GAw63Gz
         1VWiiHrZ/r4WLC8+MWzbjfU9olX4uHJyUNZThTrfWFQmyguXVL/YOTCF60Ahxss75y91
         8IrUpi6enTsbs0Q8fODda4lRBRItx0jDEb2SEtw2pilp7sQAUov/1gI7c8Sc/0gEOLK5
         D08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083286; x=1792688086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QqLVm7SLi9zEE0K3BLZXJn3MFA1ghZKJ0G7TZDkfEHQ=;
        b=15RUG+T+9NUDZhaVm1JSWcljBbVQJk+pa7FmvFLvm2dG31JvGqScDFNTfK2Kx3eLA6
         t5vMvJaqqtRX7blywhyCSB9rFz8674r1msArKHRUL+8RPL94qJ6hzl5rjtO2I4nsf16P
         6nldkSLa+BsZ2HwAx+9+hzCBbQjHqzR24inNm6058KpBtrwjBlAkKyzBfEshxVMhVD6a
         JpitYEE8WpIxFo79N58MCywnxRRHghyB+U2t5mEGvNUUo8/opzwg7CbYzlcWH3zj048H
         s4qYN4DsOkOogtJSKJErQX3k6QjExzz+pJ7ncHqCkEAZ27NaD8LsjYSEVKQnRg27UGrI
         j3YQ==
X-Gm-Message-State: AFq9FYKfXxRXqSFLzE0maqh7BLlFskCiMvVTTcUkIcCMaoUMn1oh06eR
	Id3ktiym5pkqrnreZfqHqUuZon0AjhdY4GNs4L4wrWHHRrpf8S4PkDNfqdq7P7q1BGM=
X-Gm-Gg: AYBFou1m3mhBQeTv9LLTI8/lDBj4qH1wNRnrJpy4YUPG3LQrezwsEPfnqyzw1iL/eB2
	NbPKBA9UxrVeXgsB9kW0bFNW1k3j5+T4NhNmSvOFMk5WrfoyzCcXuZ70DodkoCpI5MoVMnFVrvw
	HjiieMSGifxl+CO9VGWBjxUUjxeoZJ2FaBRbFxYL0kNW6+gTetVW2uhFidg9Cn9GfvbtUEnSwJ7
	s5semcUg8Jb97Ap02jM2Up2D7BwP/Xw3At2RI4doudMsq/H+bkhoFQWphUpQcflG7SWcEfHRbW0
	ZvDzjh27cAHc4tZL/7eIf7MQsbq98BsD2U7V9KqjDpH03z0tlo8RUaSj+fjGNgFTYnCexBps8pv
	acTE9zqs6masx1ITbaXU7YFOsx4pCaxvFYevP8+7orEMc7n+m1OdE5wCau7uiwsHToZWqmxJr0a
	SyIeaALxO9R2XjCl81TxY5CPBT12PcD5aOWf0izrLpjVbszM1NTGzb5d9K2UniuxP0BEpDxTpOi
	O7H8Akq5rrfaTk3+LwquYtdbGpsmlsZymrDBN8el/jZotoV/CDEVDx0GaNkKYtPQFO2Xg==
X-Received: by 2002:a05:600c:a013:b0:4a1:c6fe:5c0e with SMTP id 5b1f17b1804b1-4a1c6fe6071mr6634665e9.33.1792083286162;
        Thu, 15 Oct 2026 09:54:46 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa5dbsm20775664f8f.12.2026.10.15.09.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:54:45 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Thu, 15 Oct 2026 18:54:31 +0200
Subject: [PATCH 2/4] clk: ti: fapll: Fix clock speed calculation
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-patch-ektor5-dm8168-clk-v1-2-8b99c5cd5541@linaro.org>
References: <20261015-patch-ektor5-dm8168-clk-v1-0-8b99c5cd5541@linaro.org>
In-Reply-To: <20261015-patch-ektor5-dm8168-clk-v1-0-8b99c5cd5541@linaro.org>
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792083282; l=1034;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=fBTD64HW6udC2yGl6I8fIRV564MzcGzaqjs261VGICI=;
 b=l/dbkURMpePhSEWvypYoRZlI9vzGFMFaCM9Q6CaCjA3UFI0DhdX13It/6H6eJCJkN+nzCGSf8
 FeOm2+7dNnCBmuBuRH4svkON+awYpeVhjA/7zgOJR2knKKfpPEU776N
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

The fractional part of the divider was being treated as 1/10000000 wheras
it is in fact 1/16777215. This led to incorrect clock speeds being
reported when a fractional divider was in use. Correct it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 drivers/clk/ti/fapll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index ae2f6fed10f6..008a61f45ac1 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -336,8 +336,8 @@ static unsigned long ti_fapll_synth_recalc_rate(struct clk_hw *hw,
 		v = readl_relaxed(synth->freq);
 		synth_int_div = (v >> 24) & 0xf;
 		synth_frac_div = v & 0xffffff;
-		synth_div_freq = (synth_int_div * 10000000) + synth_frac_div;
-		rate *= 10000000;
+		synth_div_freq = (synth_int_div * 16777215) + synth_frac_div;
+		rate *= 16777215;
 		do_div(rate, synth_div_freq);
 		rate *= SYNTH_PHASE_K;
 	}

-- 
2.56.0

