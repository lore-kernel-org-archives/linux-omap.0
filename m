Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432759;
	b=uCiVqKy6hKOvV+Wqufve6AKIoqQZOoRSXPFnoh2IFhwuLzMIg7R1UhfTgFhBK33Q/oOG
	 tDanqX5rAjzii40WqY5iaRJp9ILrkHqVAmUfizCgbF3ovyiANYaZ6D+npEshq8S6dNmS1
	 DIVrhtHupBppAL8sh6RRWz8g0RfWilDNAYNlKgQ4bA+LyZ8UN3BcEscvcYeqEA4cGt/tw
	 4cfTKm1slSInC17EFYwQmkGtPYIdtPeDndan1b8bGpHc6WA8wnFJmgTu6ObF8sTnjBVwV
	 f395yvw5dEp3t4wCVH4PdXKcljlc6Qpr3W+yzfZ4BuM3zggA1M3YuhICE4Rp6W3hnTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=ucAmEFsa7p0L3cxR4mHPR4770B2XlVZhSoV9n7aBPo0=;
	b=0Sy+mnBOgF2w1cCDKvIY1+Je5lbpy0VWaAucVm2lBtKQrzi8YqyWqc+IQQZmxerz70a6
	 i4s8guSeihfNgLGYPMiHH/xSj41b/vl7X4S0/va7riEY653eUJBj6gAlx7VgBCEr5iu/F
	 vn8Xhdf57JN9Cnu0GC++CCML2D97G2//z3hSRE12T5W9I59deryhtOgS2tqgxWjoe3SME
	 G0nFDCaR70lxPwbOUedHMYLOgyZLg101OlSrhkHgoFDdQ0xCRDrFa0MuduXmD3+bavRRC
	 gEPW50k+9v5eBJ/fYvzBh4BrSooK7q6skPCteNGUqDq665E8XEvmCB5ncLR3pwaLmkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=LjTJX8Zt;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFF360A2614
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 11:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBFF360A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=LjTJX8Zt
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso30551165e9.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 03:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795432757; x=1796037557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ucAmEFsa7p0L3cxR4mHPR4770B2XlVZhSoV9n7aBPo0=;
        b=LjTJX8ZtOkMI8l01O6LKNQWB9iTOsU22KECj9lhq1oQjbXQriLKnKZv/hBKErUjcqX
         gctoVKEIObx1a1FR+TXoHXz4j4ltzLHzAZxqF9xAtEWuUeiDEnpWgdMrOqXebO8uXDto
         gHVh8YQSdiAmtuR8CphvEbwudpMkDobJLVBcubpZ819AtwkMqwKoZiCNfvT+9qqIhj0p
         CkZu5uVv2eyM1/tJGAVIGwda4Q45Cq+o8xRCA9/2ya71/NM/mWEa8MvT/4AEbUPuhXY8
         wm6cVWeu1/o8UTb7oeqTXxYRAX5T1Iv3ezFWXaPElQo15zlpimuiRYuHQFcaotl2EdEG
         bYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432757; x=1796037557;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucAmEFsa7p0L3cxR4mHPR4770B2XlVZhSoV9n7aBPo0=;
        b=GR8rHYegbXIm4wwHSZmNKJ4NScGSyxz2F3y9L8ZYZdEeB8Rbo1oY9SbW6w//MBhf+h
         dnmdWyrDaA+b9JxdZMKpkZ46jfPJb8IwlUDPdMlBLBeK0k8hdRhrhe86tXxF+0uxi8Hm
         dLivg9lNEai89losdL90NbsabHN4C28i4hTi0omQ/E/Z/f70JY1zjNUmFo9nHljpPYY7
         excN0umcMXLOsgW4RMG+5Qz0adEtPE1q+ZlbiOlZrAehceGS0s2eP6uJUx3NSKDz5uK5
         66vu5m2jHBW66GOMiJRmFbsZtWfa6KT+AfcjdZ+QVqoAehc9wKe/NDuc0XOuyoYDweEP
         kJbQ==
X-Forwarded-Encrypted: i=1; AL+hErHE2zCZGr67HvxgRr58I09EMPivmyov6L7kGgt6lF2WzqoxEHbPKhW8U/7AZjnPu3lTLPngd56d6blq@vger.kernel.org
X-Gm-Message-State: APuU4Z+yV8KtsZZHGqIeLjkp4zgQo2yYFncF/CYX2lxAuHmiFsZ9Q85U
	X4RjmHJ92ebQzSIm3exKB9Ezo5ywfy6aqV/JUSMmmJvsle5wZ6wKeD9GhWhISrK8Sdk=
X-Gm-Gg: AZFdTZey/TlbZZmP3pESUryCXYeRv5775xRtCNx6ZYpnoDXrZZgUY/NfRnqBbEDVDUW
	Xh3YurdQT4ZCIQ18AfGOQ2e6tBteMUm00pm3D3jTFhJAc+HEvjR8ikbhr7EFMD/Ihva3VB1SunZ
	uVDUu6xfbik9Dz8JNI6RYEjobHqNz7w1n652uVzvCMmOqmZq3yh7QgjfwXQnoQCAteha7cyAJTT
	xAOBRmiMSYkQDHIE7uroqFbSv7e/lsnHDq7CBZ3k3UEEcFd2qIUtwlDAVOebSorgMrFpLI+Nhf8
	gPGSWhcl1CQcBdl+4XWmbI6omEujsqOgS1T40s9xrY4DHYJhaJl1Ch58Atdg94JQH3xZU+AqNjm
	aYEu7bCQeOig8mVAVRG3Ln61+/RSOetjIwaM1/aDyfTElpdxmGWQPxZ+m9BTIce9joIiAHbshnA
	Fok9jgewYMYVxyYb9lwo6aCm2tKb2vaIIf92KVe2zyfdl2yAgDqGLfGdyVKv30aF3ruWCKNnXdb
	nqQKLRer0VJNLZYu2JAhW6mCHhf9fLKzs2tkFOetKAdOKZ8JbkrcYbiP8qK2wWtB++6Lp6U4jDx
	3hbuY7ZdyZcLJk+6x+yXBYmmu2unPK2631y5g8QMVhVI4V7D8mj2/fS9SgVGo6OsDWfMz7wO//7
	vOx1NGMmxNQX+k26p
X-Received: by 2002:a05:600c:310f:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb8881f9b7mr246892845e9.34.1795432757202;
        Mon, 23 Nov 2026 03:19:17 -0800 (PST)
Received: from localhost (p200300f65f19a90438645cebc2ee104e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3864:5ceb:c2ee:104e])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884c3063sm351330435e9.15.2026.11.23.03.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:16 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH v5 11/17] mfd: twl6030: Use named initializers for of_device_id
Date: Mon, 23 Nov 2026 12:18:09 +0100
Message-ID:  <67c8b42a7ade79452f9540899b8da762a800e367.1795431460.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795431460.git.u.kleine-koenig@baylibre.com>
References: <cover.1795431460.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=8Rq3Ynt64dgZs5N07nH6EhswZsw6cyYyIHyFU+QK58Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBCEDW59riR4bnjjOXgbHT5J/IbMCHUOG8L7Nd pUlUuniZ1qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawQhAwAKCRCPgPtYfRL+ Thi3B/9akDOZt1NDJUslN18OIZRU85umTflGQUMuziVJVnfi0U1eOfWubs112TDxqavas4twt5B E0TgY3QqfV3QjMkVr/X4Mwha7b9/XlTQ2r41qVnLL06aYVcyKEHoq3sKqLb7v+uvARtQpKcG0jL 6CNXRPMqPUJPtUfRb5MwV77797F6V2oteqp4++uDN8mBdIilWH3Qhb84fudPNtDXxSyousRRcVy NLIT0Cuhcs+UAeQ0GrBMRAfwIgDRZVVjYCWPo6nEhj3NFgdDx8JGcjY2/u3BdNCRLxGH6Zt6oCn LFFz88zz/f999p4xynkktV3yk1Jqp7Znc26Xz37lQ2JPMY1N
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

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
index 502b1542186b..c1d3ef007601 100644
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
2.47.3

