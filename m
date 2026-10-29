Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270193;
	b=Os3VhzzsMh7Q9w0I4hRqT5abvsUneC6D/+XNEcFQruVoPwezEgUCb7at5LortXr75YoG
	 KBurnQDz052UeK6dbYpaBQsCy8p5V98B6RNyXe+gV1za+rXGGYlvNZpYhFTgbIpqsFUOy
	 0udy4vPnMzPRzDeTqV0KNEpJPc3bBSRwgBBFD64gnPK3ucaqFFhMZT/KO1rskguNuQHY9
	 xBAKHdpE0EYcfSU1xrZ+SMh+SHjlo4a2RF4RG1FkG5lv7LHJBbaFxnQ3qV4IK4v0juyCW
	 jJkQgOLl17WQjkhHKXNN+ojGUrTrTzHBegpodGDbL0XLtUKuCmIU8aw7e0wlfoKar3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jehMkVEgMGBUzExRW4jLTeS4kpPNr3py8r2FnDt6bfI=;
	b=1UEG0G93t4Uu8ZwkLh1s1U6uVP8/mIXDU7suPSSDWJ+npqx5udQAR9IbmHqqE9d1csOI
	 lcTiHT41bo4FEhyLfA94njma0NQr9GOXlMVhBhDn8o+n0JH2soACKw4j5lmW3vNDQyUjc
	 EnrpO11SaOZCoEQkyjVU8lPoY3jJC0b2fHLKWfiIf8O0wSg1vteLOMUgxQJUeZCgSKfDf
	 Ai0cAB4aUM4X9Z9eNhkSel39M9/qS2ey/BBOJesWUI2SRRS09h+XznsXdUW/Ts2FdglDG
	 jJwcJmEwmwOivwvYfwHmZPFVOEkF0/4vOOhnWBLdyysyuMcHf3IaJY212n+yY/zQ7Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gd4GPgsj;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6710606A31A
	for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2026 10:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6710606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gd4GPgsj
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1604020f8f.1
        for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2026 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270191; x=1793874991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jehMkVEgMGBUzExRW4jLTeS4kpPNr3py8r2FnDt6bfI=;
        b=gd4GPgsjVo6GcYklyr1/n1T+RIm/k3Kyr0LN0pHHmi0WpE+3LYFksPgqRfLZhxpWO8
         rTEQYvkf30gK2Jc+/VGp6ld4qZD8LMdn6EvRJMwNI6DswMMb5bRJ2fs1Zk1rEQM5CK+m
         3EshKbyw2XIgoDPG0+ldJGles3WBcJP2sZpWBkTsJZWnvwseD9CKkN1sE7waoSOPhZK4
         5BSUusbSKU3UIxWNCEkHPn76dxUwcvsa4/yCRj0YRxxrYSns18l+eQxWh6xDts8bLhK1
         HNK7rckLaQfqeHOgye/wqpFNdh23bS5dOk/EbYM7qonlCOq02rMf6bNh16lMaca32bKY
         Cgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270191; x=1793874991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jehMkVEgMGBUzExRW4jLTeS4kpPNr3py8r2FnDt6bfI=;
        b=ZLTYarbKx6va0hiumQE/W9Z6Q+2g97cYcEyGEONjAK1EAQfmQBJlJ1zRsYFQNAbgI3
         sDBAkT9y2OGMZoYFdL8Gnc7M/pmo8lbd3Z1chZs9iA6CbW2jpKS++8AQdH3B+AcZIOg/
         Z8vZW0ylo6WqmcZkYCqVwKp81cMmgRYmCShpaJo6aniJad4U1U3nr5vsp5c3oyqVu4x6
         TH3VXCypgeOsl0Irkn8Cak7iBtgxiAO+au9tE+Ym8oHCWvZTObw9LUE5HKyao/VAvzl3
         hgr/GDi3WnOeUKwjGm5KVssKDZrcLAdh02SVUKJkgziKSFg18SGM8xtXNEJAff/3xa1D
         z4+g==
X-Forwarded-Encrypted: i=1; AKwUvBzOdtG8ZunhIYO5iPtpXGD25gn24Hu+cGEjMnMIwprmYR6iNWLuDJoOAo5InZ1OQx8JXU62Ko9DsQEp@vger.kernel.org
X-Gm-Message-State: AFq9FYItddmfAlsjHJ0UDKjJFIymKNAbI41ZwI8rx6Au8/bVxD2QfuNX
	2uUIrlKdIW15UHryc2nVSdkSPoCKygFNspKg1WLpYOnSX7kfcSX2iGTZ
X-Gm-Gg: AYBFou2UThpJgvnnIdHavA8GKMl4USOBsp4yHfk2SPxCazAM9O48SuZEJhyiCOXK+WL
	foxIFbsOPglzzNrhr59uNBbvyKY3HMTVvnqTfhlO1EoB+hE/ZzWZCzEAr9D22y+aopumbT3A7Sg
	83zoJSFVpsET9CBKaVszftGe0lJkMBaHEKWKhCQxMVshIJK0c9FdpUs+zVWjUzcSei/eKbTH/vz
	lPOS/t0/ffkO7atL+Lxis/FJ66uRfGUDj3EM/u3qphREVsZa93BKh81W/9u5WbzOO+HPGX42l8I
	EeG9+o4DYleams3/qsFvuQMOw/lVBt+lMup4nCVAbvkf0siWkgJatoSrLcY9AJASAwa7HPr1qki
	Cu+e+o/NZf0XVz3FiegKENx6msSJVkD1a2vtmT7tF059AN6ukpknIeMJZxr00QzmYcwZrDpG/tC
	2aLdJb7Wjj+9H+QDhWDtv/8hsrwatb4fba8Z95Hyz0GdIi89OFNZ0bcNEys9YpQSlmUXGO9sDUe
	0nzc8b9sksB9w+O7zUnpyXT8HOBtpuAb2ZRu8Tzx1EO9uHxIVTR6Jf2NL3CDB1ucLul3e7AdScE
	fhlxtmc5sI69qs5Ft5Q5cgfr9AtvOKUeS3moqqLU2SdK8eEowOEkZuRSnQ==
X-Received: by 2002:adf:e283:0:b0:48e:1299:c00f with SMTP id ffacd0b85a97d-48e5d288c04mr9053525f8f.3.1793270190865;
        Thu, 29 Oct 2026 03:36:30 -0700 (PDT)
Received: from LAPTOP-AVI.lan ([2a06:c701:4778:c500:4cef:6e83:1a47:83fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecde7easm33914037f8f.52.2026.10.29.03.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:36:30 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] gpio: omap: Propagate runtime PM failures in probe and request
Date: Thu, 29 Oct 2026 12:36:26 +0200
Message-ID: <20261029103626.1527919-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_get_sync() can fail when the OMAP PM domain cannot
resume a GPIO controller, but omap_gpio_probe() and
omap_gpio_request() ignore its return value.

Consequently, probe can register a GPIO controller despite a failed
resume, while a GPIO request can report success and modify GPIO
state even though runtime-PM acquisition failed.

Use pm_runtime_resume_and_get() in both paths and propagate
resume errors. On probe failure, disable runtime PM and unprepare
the debounce clock when applicable.

Reproduced both failures on QEMU N800 by injecting -EIO from the
OMAP PM-domain resume callback. The original driver continues
probe and accepts the GPIO request - while the patched driver
rejects both operations with -EIO. Normal GPIO controller
registration continues to work without fault injection.

Fixes: 77640aabd755 ("OMAP: GPIO: Implement GPIO as a platform device")
Fixes: 55b93c32520d ("gpio/omap: use pm-runtime framework")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---

Related/similar upstream GPIO runtime-PM commits:

  e9438ab5328a (gpio: zynq: fix runtime PM leak on request error path)
  ff82fc3a4a1d (gpio: xilinx: fix runtime PM leak on request error path)

Both use pm_runtime_resume_and_get() to avoid retaining a PM usage
reference when acquisition fails.

 drivers/gpio/gpio-omap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index a9b9a3d9631e..31525a8eedf5 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -813,8 +813,11 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank = gpiochip_get_data(chip);
 	unsigned long flags;
+	int ret;
 
-	pm_runtime_get_sync(chip->parent);
+	ret = pm_runtime_resume_and_get(chip->parent);
+	if (ret < 0)
+		return ret;
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	omap_enable_gpio_module(bank, offset);
@@ -1459,7 +1462,13 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, bank);
 
 	pm_runtime_enable(dev);
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		pm_runtime_disable(dev);
+		if (bank->dbck_flag)
+			clk_unprepare(bank->dbck);
+		return ret;
+	}
 
 	if (bank->is_mpuio)
 		omap_mpuio_init(bank);
-- 
2.43.0

