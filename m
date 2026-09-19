Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90F36A35A
	for <linux-omap@vger.kernel.org>; Sat, 19 Sep 2026 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789837870; cv=none; b=ny5GPNVeX6S6eSGKEM+zk6aIeM57eu6Tcj4254naDzI5QJxRvgvaVxZRUD9DNTYDolt8RbFfQrwC52P39l8uZRL06Ya5KmZ4MdXOTfVIKGXLrjcJ6j207V0M+4hWN7j6XEWrjLQdcfLDsUSsjY1y3jj939tZYaYEIx3Ewf5vR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789837870; c=relaxed/simple;
	bh=cnELjqd1Pl7f/0JTN+K6wmbhpcxee0KU5jbx2ycb1p8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L0hUGN+ejWXebx29etWcedPSZgBSrt6imZo4lqM5eDvnq41rdq7kpp8aHq7usm7rEMC6wvufbbpk0Zdyh+KaLS8B9dCaHUBXby3i3f/ci+jPUli39qB5Ux3Do0asExdrDPdkyb40DHCpvs2dTcoaaGlbTD1IgDj8I77ejFTWrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTVKXYZT; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTVKXYZT"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso12925835e9.2
        for <linux-omap@vger.kernel.org>; Sat, 19 Sep 2026 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789837867; x=1790442667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DfqMrkAh22cdKYOtoUtJ+Se8srdrCdZTjCyOvlrBsnY=;
        b=PTVKXYZTzpVBkuYsalNCIu17XXvZky34ZiJ/nx7qavLPtQUx8Wt38QB7nIUNHALYjo
         A3TugXHZXAbrQUWDE6OzRcC+Ni2U7GOpxAa/fIDFq987+Pjm+Sfaw+/ECh7K+esK6BVS
         MxvTq/Wy4E0dtH9QMDZEkUGzhJ1+PPB+nl/bV9F1AUMufowWdgvXwclfNc++bUbeB3fo
         gX4jCk+/DJmu9Trw5Z4kXJwPo1edIz6SxvaPa7RLxnXqZTsOzoD5KxfOsqz4talWEuUz
         89ZZWcrXzLftpcssJ4/BjZtoHMjbtCpRMP9rrzj4oj/PuASQ6hlb27C0G7oCkGYbsHEh
         eXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789837867; x=1790442667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DfqMrkAh22cdKYOtoUtJ+Se8srdrCdZTjCyOvlrBsnY=;
        b=DO5xqYB1iZqfisecYpm+Kga+IxL/McH36KNhKATbQJ9ZToEfJlk3JVA1X09L5cHOlx
         umnsru+X1NraM8X+RwU3Fxh+xfSqWDeSw8QqTBvSYGHI54z7lzOHeFDqkklyYgz23GW3
         yfgZOECAdtZCqQiuE5XkfUGWuLKF9DcjUipsPfGqWwDSZjUEGA5YlYsfvaAOVE46l6UB
         wXjnW5ALQGQEVfFp/JboPw+ff+q47X8MB8vglDMSALZ3OV7gOUAuHcFgzR1MmNPeiUc8
         4UJvSF3nPECEaw4DST7WRPiR+LAFEbsajeBOoyHFMNLUWzq3u91MUHcYr/NhkUcEaVKP
         TabQ==
X-Forwarded-Encrypted: i=1; AKwUvByHotAzrXBDQMLQ3J5hruu/NBZD+DgH4k13CJm/EkhMdRgfVbh+Y7a+BnxI9Y1PgmzAwQceSRt5VFgs@vger.kernel.org
X-Gm-Message-State: AFuF++lDW89tt7lMl/RN42KnpNtBuvI8smkQQKF87xHeG1MQ7ncEcHa4
	oZbe+4zIhBPJ6X44d1TPU/GWtaTGd0V8KrCZ1WCekbkvxl8Bi8kTQcBt
X-Gm-Gg: AYBFou2WTkAV9fqN4ueMNCjN+1I/5eitXC6drhz9oIPhXcmFnBytBQjj+jI0Yx7dI6W
	LB1YaNfqxJlBhlCs3bJIK96LWOAEehAw5cIZGXeOyMAqMc3Q8isG2LDCIZq35E9Ylw8xlTqbWcu
	PeHqldYjH8ck+zWh9A2S0ruCyoOpay4m7re0ekD+4xLkWg0NsV/SNnM1zRKaMYG3LguFju+shI1
	E628isfFioWMuSyDenz22LiLSe//sbaoVzq0fpmguBJu8LCsOVnPTrP85UjLL6Y45Gr4vjVVfq4
	s81WOje+Nc7o56GZPyVKarpja5TBvERm2hhM+ocKXKCev2WXoHnB5hMT1gtYvJndAwwqSVO4ze6
	N75kcq9zzlqqFL41Z21BiVvAgS60PuNmfvwSe3MC0Q0lgfWj8PduLS4sJLXSeRPx/4Xi8Blrr69
	zkNAKFYBs4BlAJYRWNXXrUScHkSTcfPZD2e0MYLCP//HTJUOc7qpCniMhm3gk/cz5euf2VqWAdR
	QkK4fiWOL1hmV8jFlQPVvFBF1tNOoanUnat4TyapcG0ZgaBzfbPBjwKzmU7TseD904jWT0fJy9Y
	eKriijYIAogrTufqMFLvab+ltAe3uUOsZRnmHxujqFs8z6xdTTc3vTSkw0jXq9tJxmUJmZZbUFr
	EBT6X8CiYjBJd3OE=
X-Received: by 2002:a05:600c:358a:b0:49c:fa20:cc08 with SMTP id 5b1f17b1804b1-49fc5741844mr94051495e9.31.1789837866288;
        Sat, 19 Sep 2026 10:11:06 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f8563sm98714425e9.6.2026.09.19.10.11.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 10:11:05 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jerome Neanne <jneanne@baylibre.com>,
	Jonathan Cormier <jcormier@criticallink.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Shree Ramamoorthy <s-ramamoorthy@ti.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] gpio: tps65219: Fix GPIO input value reads
Date: Sat, 19 Sep 2026 19:10:58 +0200
Message-Id: <20260919171100.90430-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260919171100.90430-1-kmehltretter@gmail.com>
References: <20260919171100.90430-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TPS65219_MFP_GPIO_STATUS_MASK is already BIT(4). Passing it to BIT()
again tests bit 16, which cannot be set in the 8-bit MFP_CTRL register,
so GPIO0 is always reported low when configured as an input.

Test the register value with the mask directly.

Fixes: 57e30e00bd5b ("gpio: tps65219: add GPIO support for TPS65219 PMIC")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Testing:

  - A temporary KUnit test instantiated the driver with a RAM-backed
    regmap under x86_64 QEMU 10.2.1.  The TPS65219 input-high test
    failed on the base commit and passes with this series.
  - This has not been tested on real hardware; testing on affected
    hardware is welcome.

 drivers/gpio/gpio-tps65219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tps65219.c b/drivers/gpio/gpio-tps65219.c
index 457fd8a589e89..b25c6f7277680 100644
--- a/drivers/gpio/gpio-tps65219.c
+++ b/drivers/gpio/gpio-tps65219.c
@@ -79,7 +79,7 @@ static int tps65219_gpio_get(struct gpio_chip *gc, unsigned int offset)
 	if (ret)
 		return ret;
 
-	ret = !!(val & BIT(TPS65219_MFP_GPIO_STATUS_MASK));
+	ret = !!(val & TPS65219_MFP_GPIO_STATUS_MASK);
 	dev_warn(dev, "GPIO%d = %d, MULTI_DEVICE_ENABLE, not a standard GPIO\n", offset, ret);
 
 	/*
-- 
2.53.0
