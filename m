Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CE238E8DA
	for <linux-omap@vger.kernel.org>; Sat, 19 Sep 2026 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789837873; cv=none; b=u+BPYBeg+858+/rw78BBVTS2i/axNrK2qL6BcqvU8A3tDiF8KyZUrIUfgUfDdKVkDR+fhPKXFObjkgN2MPTV7Wwa0LOJfxF2ada9ykTu7WwkPYqL+ily/IRaU9VJunbaI5qbLxek1Gpu+qwcPTxgAJFWnqvw4mLzClsCUUxvxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789837873; c=relaxed/simple;
	bh=mWJYfjoWJeRQg0RSy1KWzp8U/jgGnfAzAM3nmAcJAFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsZF76VB5ASx5Ai5TZdEWEfycju216Svq9xj7e7xgiSHF1vrLQ1p8J3+W8lLCG9M1Tk+gs6yiKQkL5QhOfmVXXilE8LcpK4c/R0BeiOMM1IriXwLPttm8Lrfl9CKzJ5LI1PkEhlbx3/q33kaUrkp4TbNemE4DR42HALZ29NSB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6RXmapZ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6RXmapZ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so8019075e9.0
        for <linux-omap@vger.kernel.org>; Sat, 19 Sep 2026 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789837870; x=1790442670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bdFmbxbENO0f+YbfOMbLsRbUwI3Z1sE3E+vQ+A1a+Ps=;
        b=O6RXmapZPq9Z29bZ7zP2TVftyb2g865qn3ziLdnteUrU2zCYzz93WwZP+6txu9lveu
         HFSl3arNgzqjZ4w7DJJrtoOHBBju9x2zLWOqz7pFsdK30ncsWx/bQiDrSZn/Ibfwi+/Q
         4JI2Es1FmlUtla8XqFATmq8Bg4BQQsBZrsDX3of0HSfMSxwshRsP8mRZo5Aj6k1SKH6A
         YKzZPm8zWt8Pezem7jNeLiK2NDexiOZDk9ajSa/OUJgSrRhs2iuCssg+kfcOrKCct24K
         sjn4Zg++ZgH2voszijium27ZF3ioOFmMKHnxuQVHY7f60ARnbLOyrwLQuS1gHqPkCxTG
         6tWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789837870; x=1790442670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bdFmbxbENO0f+YbfOMbLsRbUwI3Z1sE3E+vQ+A1a+Ps=;
        b=Y+PVltVWLoudpPMgsmQgCS7f/TaLcvdQnfJOFZnN9fZ8sHqW3xh/fyBZJ/+q5NmBoW
         h+tUg/+VD6yWW3TjQifGIoYgocZgQi1iPoASinPb6pACFUyDvoMlUCM8l3XJfMStHMij
         qukLHk+ez9XjCYWrOdo8szOyUVHrIK+zbi5aclilvisgWNqOKsUxghBJSdmLPEHxVQz/
         QDgwyuaMhDEoQYw3U3Tycjy+O54k67tZxvKKgNXI6PF1ybCEt0YecitYnKO0mcKQ/Alm
         leqIBcVTvPZYhK1zoFAw0TceCnuxJjibf/ciCzv0oSwFPqdccMNKO1NtwSGvDOaJXlRf
         xewg==
X-Forwarded-Encrypted: i=1; AKwUvBwIOsjKe6l4wfIXyJZCIdeK//YyOf0lTGiexc7+DArYX0N5DZ9YHETdnt11+ySM+Un+JAuJCRtlDUqv@vger.kernel.org
X-Gm-Message-State: AFuF++k6VCyV6/Ii1TQIr7+/lBsbWiQ/bABUboH4kQ5iQEPHdgDB532q
	CpDPIOlSX20dRzm105fUeTGGvPDn1QqvxFFFs4SNt7c3ekiUx/24MQ3v
X-Gm-Gg: AYBFou3oGaSEBihai/YTZ0CGEXT+JTOqovpSEGyzo9stpUp1/7KQaJOM0O5GSzlhTy8
	E0nQPLlJIZImgGWITgA1P8aZv/fNMeOEqbIOAGYSIa/eQ1+SZSZxY6wu3znxKmDAis8MrWfa8gC
	bC6YCyD4QzbOYEALAhAMr7Oalp9yeCe4n0FR6kLNXrFugNiIJa5yh+cciRMQiKmGnVptXF5M5xf
	x9GH1UsZpTf0i8FpYccMIrUUNSmi3yb7D8tWSP+nxmA7B8DXbK9MwLXpub8KCOq9qmaWI2hMLK5
	7gWtB2FZVOc4/1zU3Z8JHuAL5VdQzKpdpMJzwHJTfKb/mrcXLqliB2Q1KqibKv0Qp/lJGknv16A
	G+MVVUjiGHicygTTwhPEzS2CkYHq++pbfi1pAbJXvV9NE53+FXrqWs96vAcxEtBVoLj5dOWfqeP
	pF13xZXz5gnqU8BlhbUCKLgZX4Zqe9Qi+GkbMgJIRwuYYgIdV/PeZvp77GR19wvZsz37QkhUB1a
	jjICpSzNDsJBOec5BT3mX5ktDkYgCYr13PXH0FFYcsAIYfu8jyOG9oeL3SNLBXN2Ga5q4CsrHVw
	FySdLUP0d9XlE0202zODzQM0zRquFkuZH5lh/ER9fdQ38SytO68GrnmSeNZV/zmGNRe8Y75Ygb6
	To3MyaNXD51XdD6U=
X-Received: by 2002:a05:600c:a00f:b0:49e:645e:2616 with SMTP id 5b1f17b1804b1-49fc56692e0mr84074825e9.5.1789837869581;
        Sat, 19 Sep 2026 10:11:09 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f8563sm98714425e9.6.2026.09.19.10.11.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 10:11:09 -0700 (PDT)
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
Subject: [PATCH 3/3] gpio: tps65219: Fix TPS65214 GPIO direction programming
Date: Sat, 19 Sep 2026 19:11:00 +0200
Message-Id: <20260919171100.90430-4-kmehltretter@gmail.com>
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

GPIO_LINE_DIRECTION_OUT and GPIO_LINE_DIRECTION_IN have the values 0
and 1, respectively, while the TPS65214 GPIO_CONFIG field is BIT(1).
regmap_update_bits() masks the supplied value, so passing either
direction value clears the field and selects input mode.

Translate the GPIO direction to the register encoding used by
tps65214_gpio_get_direction(), setting GPIO_CONFIG for output and
clearing it for input.

Fixes: 1b6ab07c0c80 ("gpio: tps65219: Add support for TI TPS65214 PMIC")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Testing:

  - This register programming was exercised together with patch 2 by a
    temporary KUnit test using a RAM-backed regmap under x86_64 QEMU
    10.2.1.  The TPS65214 direction-output test failed on the base
    commit and passes with this series.
  - This has not been tested on real hardware; testing on affected
    hardware is welcome.

 drivers/gpio/gpio-tps65219.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tps65219.c b/drivers/gpio/gpio-tps65219.c
index 479a80ef76543..6958466455d04 100644
--- a/drivers/gpio/gpio-tps65219.c
+++ b/drivers/gpio/gpio-tps65219.c
@@ -158,8 +158,10 @@ static int tps65214_gpio_change_direction(struct gpio_chip *gc, unsigned int off
 	if (ret)
 		dev_err(dev, "GPIO%d configured as VSEL, not GPIO\n", offset);
 
+	val = direction == GPIO_LINE_DIRECTION_OUT ?
+		TPS65214_GPIO0_DIR_MASK : 0;
 	ret = regmap_update_bits(gpio->tps->regmap, TPS65219_REG_GENERAL_CONFIG,
-				 TPS65214_GPIO0_DIR_MASK, direction);
+				 TPS65214_GPIO0_DIR_MASK, val);
 	if (ret)
 		dev_err(dev, "Fail to change direction to %u for GPIO%d.\n", direction, offset);
 
-- 
2.53.0
