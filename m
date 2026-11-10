Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347783;
	b=bibjzwPsQ403T0CZP/g8LWtC0y6gWUoIzb3abViPWWMP2blX5gLCTYhf2rX6Nh7unWnP
	 hIxq9SC5oKVNX0LpG640n+IGHUeox5Fy6IM9RFr05gMuvsAJr7gu5f9tkHKpy/piWK6ac
	 5pEhhZS9dIbZtSiSOtpd4u7AjH47of2NgvlZlMVIH9Ev/JGkkXQ2zOMR3Tzm7p8YGopmc
	 E1MkmhEJW7oalQdlx4H2CtovM69dYhYHCnE4xU8UEBSBneZj4Z6ky4hCe/oWJnGGmqeXi
	 uC276/jMu6C5lc7Jy4fuzErJ2SnFdBO9ab8ePI6/GCZKNaLrXNVMnd3HUBagg6/FOXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=2R7Vfn0GQ5DPzT80qB75r6tRx9r0Ti6+T0q5fMrBmX8=;
	b=jroDdzcsWAv0TOfTft+8J5QFGGYd7Asr4RIuV/TqKEYrEGp42J5Y54YCaX4UjwoK/d2L
	 nEguViTfkDEDNKwo1daWZEf6iXbuvwxI1Px5AWpkPYI3KW7RMZBuIFZCA0Vuxinar729o
	 j8Upp4VA1xdzs39DIII+DIwK6+dwiYpHSVITmkQ7m1Pfjrtq5Aele2JNnLGs4ZJijlPhq
	 OAxAnK8DY72zFue5jQrYP1v54ExVB3m7BlNMAlmAV985BpOL9VHYcHZA+4Uc3UVENXAmq
	 lmTV49uN9z/EPGI3DO2PX/A8iVqknUelZenmzVgedY4EHCyNYno3yMWy9cyLdD/l2IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UzGRi7Y2;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C9560A6F4F
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 21:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9C9560A6F4F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UzGRi7Y2
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a210470b49so20734965e9.2
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 13:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794347781; x=1794952581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2R7Vfn0GQ5DPzT80qB75r6tRx9r0Ti6+T0q5fMrBmX8=;
        b=UzGRi7Y2c+J5eAcI5svz2rhK7TSVEzPnPMoeNa0nQLlU/iH8YJ+vFkLgjHEoZv6abx
         RUpTQvZtFgk5zYFgeeaLI9uPoI3wmrc33xLhJZoAFi3ONlhODq+TmwP36tm/vBxHi6Qa
         arf+s7AzGaSwnxJITX9YLBq4eiYON5MLugAHCjmsClBwPKBkwgDIq9uR+sBJjdkfLOOZ
         SfaOLVyj98svm6JynaZ3PgSaAnYuE6iD2Dx0lcSX0yupGxVc5qXeKm3wYuGmL1z+p+I5
         xo/jOXMCx38NtXlg2gRcFDbxfEGDfDAIYX1FIDyC4iezHhhNVw/4pp1xpho0ASRb7j5Y
         JqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794347781; x=1794952581;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2R7Vfn0GQ5DPzT80qB75r6tRx9r0Ti6+T0q5fMrBmX8=;
        b=iegf7djPTAuoyiKqXNsGBOc9wY11RRAYOQUJZu1mAgT0DYZk2zcYwX1GjRufbu5Q8J
         vJns1JR2fDOqjqD2fmwyhHZzOYQYVBfNrjISJZF8oyVsAmxSUCnbHfQgSbTazYdfGOPX
         UNgfu2gdujrLqK5i+ffFW6/b6YQiCh4+X9lLM3IjaQITY3HqyV71zWumYskJMHpus0KA
         hRPE0WE0NGF6eXpepeM6SqAumi33gy9TQ6mgIlMJFW1ANxCM2c6nWbuOp/SsgQN4WSzj
         WHC+3Av6owZcx+iGX5TdTSLP0ePexvYi2/yjD6YpKicqY+XWCKuboa5MAoLVUYWh+k8/
         t7zg==
X-Forwarded-Encrypted: i=1; AL+hErGLJQ/pdNFnBfYCy4tSylg/sTu0ELAMD1TD8r9kJqs233kFnKOIoIpB+tWt3aA9EzEyJCFTkbeO9qkI@vger.kernel.org
X-Gm-Message-State: APuU4Z/pDnPBBf/E4Sbnf1Z9gCWIgJQoDLh5Sn0fhsv3wWbjHRabnzEO
	1RTg3QzXbQJfeBnFk5zOJ1VYjO/n1K3PDNWGdK/XGO/1O36z6h69iaH3+HX8b5LT9Zw=
X-Gm-Gg: AYBFou3sZSLYRHFWiOHewB3ZOPSOmgvQdNGGFBpRryMDMdyH9siYGq8sQBlPDXdwkGy
	Y/BiLyT0t7csi1hTa+lSNrMas7fTW1fKIg+p0h5fYeei3M2h3qF6XrC1+VaQUU76RPWoMQ21pTO
	jXV0/cFoA88ABq7S+wAfS4GPkCOJueSauljxiF3JBORIFJ5GruOEwH0Ch+CJOC+XOjLM5RlFAB0
	aV/IylKOitjWy7TLAAITu1MkfUocv8msdsUyNp7xNJCWZ6SSMUwDArSLWqmye7b58OKLC/7g5WW
	LoqOVSB3r0RbTETukKN7k0sxeBsgRdrSsAp4bOdHZ7BqXCLleW06a3IqGIpwgn7A0XGmjnOiWU2
	2zoQB+coM2jagRpx7OfHgKrjWFrm28SgnqwWlR3bxvkS8CG8XEjchapIy5SfznR9IjBmfh7VpXj
	j/ttcoVRLKrTVkQiHIwfcJ+1v5sDzl75GgAgzarq8ZNAnCUVGO8+6kBuYGEwQ/HQuY2FHgYreIe
	zXu1ovx1d/DRi9gmdBjeq5WaqIFYw5ckb2RFiOz3/Ia2Y3A9odjapA9E7CdIJcfVZeP2d1zwjeT
	EMXVG2wDSk38dMDor/PROyXbDRr5Dc6br4CJmbJ+iGWdxmzIzYp85GZ4
X-Received: by 2002:a05:600c:1e06:b0:4b0:9803:dc8a with SMTP id 5b1f17b1804b1-4ba093ab912mr5881245e9.26.1794347781134;
        Tue, 10 Nov 2026 13:56:21 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4ba01fe2c5asm141480835e9.5.2026.11.10.13.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:56:20 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH v4 13/20] mfd: twl6030: Use named initializers for of_device_id
Date: Tue, 10 Nov 2026 22:54:38 +0100
Message-ID:  <0fe20dd5f0218e5f283f50412bc549b2a37f73bb.1794347059.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <cover.1794347059.git.u.kleine-koenig@baylibre.com>
References: <cover.1794347059.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=+wVm/Ab+8kSEk1PxbUHacl3hTVz3Pk7CsUo1EBPglgk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq85LB0W9L3jSbEh/EoEhWg+qwRUWmJ7ZJxZykB i4qaZhdQl2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCavOSwQAKCRCPgPtYfRL+ TivmB/wM4c7D5xazvoGMYEDaQWxqfOpGo0jdoe8i11cYqLE0IQtsBTV224HDv7gKyHsW/pNhh97 P1LjIN6brwjG4XP+A3AyK8HFw21YNx2WjEOl2fu9+vcvtquoTdG2nzsKlziLHsPxfVToQ94Uwj8 aYE16Vuf8qN6AmzmnY8O71sQNamrQg+71XqKlLQ6ncnDyKjFFVTupW5dDyAG5ISHtfWGZtvhVpD 3lnRKIT10hYWb3PuNHuBm2MAyPmORPbeboGeFxN6iwt4VDEMBusVpjM7d4tYa41eVAjy0oaaXtM DReS8gBCRlaS5V1TrKj75j92n7Cka71tL9mCTTbZQVRcVMP6
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

For .compatible a named initializer was already used, unify by also
doing that for the .data member.

This is easier readable for a human and more robust against changes to
the struct definition. This robustness is relevant for a planned change
to struct of_device_id that replaces .driver_data by an anonymous union.

This patch doesn't modify the compiled array, only its representation
in source form benefits.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/mfd/twl6030-irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 0ca00f618d4d..4303fb288dd5 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -283,8 +283,8 @@ static const struct irq_domain_ops twl6030_irq_domain_ops = {
 };
 
 static const struct of_device_id twl6030_of_match[] __maybe_unused = {
-	{.compatible = "ti,twl6030", &twl6030_interrupt_mapping},
-	{.compatible = "ti,twl6032", &twl6032_interrupt_mapping},
+	{ .compatible = "ti,twl6030", .data = &twl6030_interrupt_mapping },
+	{ .compatible = "ti,twl6032", .data = &twl6032_interrupt_mapping },
 	{ },
 };
 
-- 
2.56.0.rc1

