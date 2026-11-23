Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432758;
	b=xU2pbBULUKhGQ8aWz4FDx3paFNmBk0D5qeIw7M9gXgQRhKDr9661C+iupmpmHPirjXMK
	 7j+nJLe/UsmrlIr4m8BwTiyMo5ETPnkeDfo6TCCtEYulL6FFS4GRfVbKRkY8K8RHUwoX+
	 gkFme1TAoTUskaDHEYfkZ775fE1gDe3MD3+lFfelmpFg6ksR6RJBGetVq384QePAZDXBb
	 29kwxTKLrpBz9c1SeDc2cWEbV1w4szszys4tW0ijto1ftljb05SfWeQCecpyQOGqLguZd
	 A7Fwf8B3eV6CQQN3vibjwiInm8ZRS/3CQTpbb9vTRVBtbfUzxjU91mmExRfehZw3X5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=F6aYEvyvr6XKd0QbMWMdVWiuZFcXBiHFz9z5mNCZHzg=;
	b=ihlroxrTcIlx0xy8Tv6bp2vzh8quA+GEr/aEbOWGzhEYoB3J6V3H43CpRnAzSUn9Viba
	 hQCTu39InYnEEOolI9wIT07rUa0xdFm/XSF3D6b0HgpqPnvMxd7zOlYQ0fg0qklDMC2lB
	 Q73fiI1Lop8fJEXpQifG7iJO1GsnDvLIUObBQVuW6loMjcXGQaGkDbti5+eAyW7AidMZ1
	 03h1iGEzHrfACqZqddItAgz3hsfqlbNJQHTUER7nsIzIp/ghv+5vZ6Feoaouj5AhnlyzH
	 UwUh16WwX1rv7+xRs+jp0XRMnEbsqXeQh3PJf9cSauq41UhTsfxUz84B35vEIw5OZNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hzHzOzjb;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945A60A3822
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 11:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3945A60A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hzHzOzjb
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so28754795e9.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 03:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795432755; x=1796037555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F6aYEvyvr6XKd0QbMWMdVWiuZFcXBiHFz9z5mNCZHzg=;
        b=hzHzOzjbYTIbgMikTamnbl8SL80+oJqLr4sCydaIbc3uMVbFe74nescCAAbx5p4mCQ
         n1vgijLy4jAuhfH2BS87l7wmomDHDlJrmMsVR7HBO7TLqWowRaciy4eNC9+5OGUGSzHq
         XboGyawZCQXsKXCiCpkG1iziJvm/oNpqrI5cvGdm3EbUQaxks5Nq3bNGdUnqVKsh5795
         sxpgIak41DhJJVhxbyci/SPVjfiqpYoQ5Yb6kOUYpPOgfFZbtzta0ndtthAO+tsyWyor
         3Xas8xnHGatIaAF3/r13ZETTYLdV1L/FbzYDZ+7bjm6iCca0Jifn395fuF0eO2t8o1qg
         Y+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432755; x=1796037555;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6aYEvyvr6XKd0QbMWMdVWiuZFcXBiHFz9z5mNCZHzg=;
        b=fyFpz4VF0+EtXAoNncbP99LbkOrTFBw3Ov44HnGdMeepCfc2B3YFlrAUv61z3qwG5e
         Y6xrBB6/XBcPXiSqWLmjD50kCN2t3vYUNFmc0K6HC1TmRGICUi5Yj2BCEs4v/5nwjDs0
         jgOBIlc4aHggalOjH11Q3TKdSkYYAwG2wCQkRN6ROkg3xOsMNIN6dJBPWrhXbaLsDmYw
         F58S/bRq/rzkKj/SvxqWNZNHKTPlBE2hd720pwLV6N3BT7x1IpVNsQrYwdWQV1F4m5JV
         lB53YqkjDcdRQcnYJrltj9DmNJdchpzL2sJe1BCNXB2n1sj2IxYHz6wiYaWWAz43FFbX
         kS4A==
X-Forwarded-Encrypted: i=1; AL+hErEKk7xXPScrf961I9ZhtxbkaK9hf2GUHpA+NCiXW9h8SP9WiVg/5T692/b50e2vMC1oIEApyxpDYbF7@vger.kernel.org
X-Gm-Message-State: APuU4Z+AiYZ617jUjuMtWeT0ua+GpN4IHSkPzVOYla8x3z3sPmOqLXk/
	wSao5lN7vmJnhO5S7kzy2z9S+MjYa70HoKB2CkRuOJAB3EgOw0FELqj/G2quQUD4eDw=
X-Gm-Gg: AZFdTZcQpFW7O3dTYk6BrXgSbbC4B2S1IyA6cNMaS/jS+76acBo94nWQ/BgfIwo/20Z
	h9yWarHzyVJtx99ug2r+uz4gsU58nE9Uj+/QucPATqRRJy9Og5c/IuyfoEKkVahhXj+SfPIvZ82
	mYNtmxDMKu0+GptfWof/GBg5GTCYPkE4TWEpkA2rixolJXt1hHWu6bltQuhYfkocF5IN/6ND3zG
	UnCjzOk3Nw3849QexX30Mdkx+LpPEw312xvrrNUrLAnzG3pw9ZkC80sJJqPQ7CP/VAza1RudLT6
	uvQFnui/sZIAgMfPfpwyqrM+62llIUwc7mLHSDHQQUGJIOb10G27hNA99++1k/1aFa7LDf8y25K
	kLN5jozN4C1qIvcpxHrkcoWkT3IJqFvDLCe2NH57gdDBMl7UsGc13J/QZnUsy8IrAIjjn3QfpXu
	543sLA9uZCesakz3Wq0J0AHZJaobqGK7ftn/DObeqvvBZvg3ZNpwwW+j8B3u9euOzcEyT12fJ61
	zfJ3nVJEz72Dj9yefPubRpIxV5LXqUcIJdksfjJ80lrq87eFS/VNpCJl+v6tsYN7/vLSscnYI4f
	9sCb0x9XXu5IxCPTX2wHaMfAJ8ZptKIp5K9f8Q+Lui8W+oVm/+kPImXPzhJACJaRd69khuvdHv5
	zpKqId+DXdbgPUwZGjX0lcnPwCLknWesOtwxb5w==
X-Received: by 2002:a05:600c:4f15:b0:4bb:6861:657d with SMTP id 5b1f17b1804b1-4bb88923954mr261338275e9.21.1795432755339;
        Mon, 23 Nov 2026 03:19:15 -0800 (PST)
Received: from localhost (p200300f65f19a90438645cebc2ee104e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3864:5ceb:c2ee:104e])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8538b2c5sm347462085e9.5.2026.11.23.03.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:14 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <fred.treven@cirrus.com>,
	Ben Bright <ben.bright@cirrus.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Andy Shevchenko <andy@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Samuel Kayode <samkay014@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH v5 10/17] mfd: Use named initializers for arrays of i2c_device_id
Date: Mon, 23 Nov 2026 12:18:08 +0100
Message-ID:  <a93880e320db09a9c9640c197ce4d1a8b17d5746.1795431460.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=39679; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=n1fbG9EjNu/uLOjYJLXY5E+4XExtNFFbeahBBZoZcUA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBCEALCM/Exnw9hrwN5ghPVoSEvIfUbVvnuJJZ zW/BzJ0iXCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawQhAAAKCRCPgPtYfRL+ Tt9XB/9ry/beJE2Qia6GN6dMA87zRuPxufLbw3WZMMEE/6Nr0DpWdMF0YZXNlnw80ihTs2lg3bH YwIaR9vRYCCJKEkpjQ9NfDYyIK/kB+qn8+ChxLA3+n/s+4G9wRwe6j8LatgA/Xf6Om+LOgfCqF1 KxCf1wWbqJKxAxb7O5tOTjaFL4WYCPzWGZJUfVmanukI3sf7cTyqASOkxNA5cPI1w2npWsSdyq8 8XZCi6J11kT5Ztc3oejF38VgSW8nFkqUa/XUqWFXdUNCCQX5h/Ltt1rmarfTbMgFUeidmiGp6k7 U316Ub0OuAmKbliFgbwQez/r6SBphLCzBlCWeQttJo2WLan3
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits.

Reviewed-by: André Draszik <andre.draszik@linaro.org> # for Maxim MAX77759
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/mfd/88pm800.c            |  2 +-
 drivers/mfd/88pm805.c            |  2 +-
 drivers/mfd/88pm860x-core.c      |  2 +-
 drivers/mfd/aat2870-core.c       |  2 +-
 drivers/mfd/act8945a.c           |  2 +-
 drivers/mfd/adp5520.c            |  4 ++--
 drivers/mfd/arizona-i2c.c        | 12 ++++++------
 drivers/mfd/as3722.c             |  2 +-
 drivers/mfd/axp20x-i2c.c         | 22 +++++++++++-----------
 drivers/mfd/bcm590xx.c           |  4 ++--
 drivers/mfd/bd9571mwv.c          |  2 +-
 drivers/mfd/bq257xx.c            |  4 ++--
 drivers/mfd/cs40l50-i2c.c        |  2 +-
 drivers/mfd/da903x.c             |  4 ++--
 drivers/mfd/da9052-i2c.c         | 10 +++++-----
 drivers/mfd/da9055-i2c.c         |  2 +-
 drivers/mfd/da9062-core.c        |  4 ++--
 drivers/mfd/da9063-i2c.c         |  4 ++--
 drivers/mfd/da9150-core.c        |  2 +-
 drivers/mfd/intel_soc_pmic_crc.c |  2 +-
 drivers/mfd/lm3533-core.c        |  2 +-
 drivers/mfd/lp3943.c             |  2 +-
 drivers/mfd/lp873x.c             |  2 +-
 drivers/mfd/lp87565.c            |  2 +-
 drivers/mfd/lp8788.c             |  2 +-
 drivers/mfd/madera-i2c.c         | 18 +++++++++---------
 drivers/mfd/max14577.c           |  4 ++--
 drivers/mfd/max77541.c           |  4 ++--
 drivers/mfd/max77620.c           |  6 +++---
 drivers/mfd/max77693.c           |  2 +-
 drivers/mfd/max77759.c           |  2 +-
 drivers/mfd/max77843.c           |  2 +-
 drivers/mfd/max8907.c            |  2 +-
 drivers/mfd/max8925-i2c.c        |  2 +-
 drivers/mfd/max8997.c            |  4 ++--
 drivers/mfd/max8998.c            |  4 ++--
 drivers/mfd/menelaus.c           |  2 +-
 drivers/mfd/menf21bmc.c          |  2 +-
 drivers/mfd/palmas.c             |  8 ++++----
 drivers/mfd/pf1550.c             |  2 +-
 drivers/mfd/retu-mfd.c           |  4 ++--
 drivers/mfd/rsmu_i2c.c           | 14 +++++++-------
 drivers/mfd/rt5033.c             |  2 +-
 drivers/mfd/si476x-i2c.c         |  6 +++---
 drivers/mfd/sky81452.c           |  2 +-
 drivers/mfd/stmpe-i2c.c          | 16 ++++++++--------
 drivers/mfd/stw481x.c            |  2 +-
 drivers/mfd/tc3589x.c            | 14 +++++++-------
 drivers/mfd/ti-lmu.c             | 10 +++++-----
 drivers/mfd/tps6105x.c           |  4 ++--
 drivers/mfd/tps65010.c           | 10 +++++-----
 drivers/mfd/tps6507x.c           |  2 +-
 drivers/mfd/tps65086.c           |  2 +-
 drivers/mfd/tps65090.c           |  2 +-
 drivers/mfd/tps65217.c           |  2 +-
 drivers/mfd/tps65218.c           |  4 ++--
 drivers/mfd/tps6586x.c           |  2 +-
 drivers/mfd/tps65910.c           |  4 ++--
 drivers/mfd/tps65912-i2c.c       |  2 +-
 drivers/mfd/twl-core.c           | 22 +++++++++++-----------
 drivers/mfd/twl6040.c            |  4 ++--
 drivers/mfd/wm831x-i2c.c         | 14 +++++++-------
 drivers/mfd/wm8350-i2c.c         |  6 +++---
 drivers/mfd/wm8400-core.c        |  2 +-
 drivers/mfd/wm8994-core.c        |  8 ++++----
 65 files changed, 162 insertions(+), 162 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 98f1ebe38f71..570700d503a7 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -116,7 +116,7 @@ enum {
 #define PM800_CHIP_GEN_ID_NUM	0x3
 
 static const struct i2c_device_id pm80x_id_table[] = {
-	{ "88PM800" },
+	{ .name = "88PM800" },
 	{} /* NULL terminated */
 };
 MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
index f5d6663172ee..2eb3380a5207 100644
--- a/drivers/mfd/88pm805.c
+++ b/drivers/mfd/88pm805.c
@@ -30,7 +30,7 @@
 #include <linux/delay.h>
 
 static const struct i2c_device_id pm80x_id_table[] = {
-	{ "88PM805" },
+	{ .name = "88PM805" },
 	{} /* NULL terminated */
 };
 MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index c64a13e677a7..733f2a50247a 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1230,7 +1230,7 @@ static int pm860x_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(pm860x_pm_ops, pm860x_suspend, pm860x_resume);
 
 static const struct i2c_device_id pm860x_id_table[] = {
-	{ "88PM860x" },
+	{ .name = "88PM860x" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, pm860x_id_table);
diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index 5d43fd1da96e..0daf6b62c785 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -436,7 +436,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(aat2870_pm_ops, aat2870_i2c_suspend,
 				aat2870_i2c_resume);
 
 static const struct i2c_device_id aat2870_i2c_id_table[] = {
-	{ "aat2870" },
+	{ .name = "aat2870" },
 	{ }
 };
 
diff --git a/drivers/mfd/act8945a.c b/drivers/mfd/act8945a.c
index cafefb4451cb..bb1b4e4fb288 100644
--- a/drivers/mfd/act8945a.c
+++ b/drivers/mfd/act8945a.c
@@ -54,7 +54,7 @@ static int act8945a_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id act8945a_i2c_id[] = {
-	{ "act8945a" },
+	{ .name = "act8945a" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, act8945a_i2c_id);
diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
index 38fbdeef51cc..0a33e2e1660b 100644
--- a/drivers/mfd/adp5520.c
+++ b/drivers/mfd/adp5520.c
@@ -329,8 +329,8 @@ static int adp5520_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(adp5520_pm, adp5520_suspend, adp5520_resume);
 
 static const struct i2c_device_id adp5520_id[] = {
-	{ "pmic-adp5520", ID_ADP5520 },
-	{ "pmic-adp5501", ID_ADP5501 },
+	{ .name = "pmic-adp5520", .driver_data = ID_ADP5520 },
+	{ .name = "pmic-adp5501", .driver_data = ID_ADP5501 },
 	{ }
 };
 
diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 767c5dfd4db6..0f49ec7ff39b 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -85,12 +85,12 @@ static void arizona_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id arizona_i2c_id[] = {
-	{ "wm5102", WM5102 },
-	{ "wm5110", WM5110 },
-	{ "wm8280", WM8280 },
-	{ "wm8997", WM8997 },
-	{ "wm8998", WM8998 },
-	{ "wm1814", WM1814 },
+	{ .name = "wm5102", .driver_data = WM5102 },
+	{ .name = "wm5110", .driver_data = WM5110 },
+	{ .name = "wm8280", .driver_data = WM8280 },
+	{ .name = "wm8997", .driver_data = WM8997 },
+	{ .name = "wm8998", .driver_data = WM8998 },
+	{ .name = "wm1814", .driver_data = WM1814 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, arizona_i2c_id);
diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index 0a7f8e7d7619..dfabb9b8956e 100644
--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -432,7 +432,7 @@ static const struct of_device_id as3722_of_match[] = {
 MODULE_DEVICE_TABLE(of, as3722_of_match);
 
 static const struct i2c_device_id as3722_i2c_id[] = {
-	{ "as3722" },
+	{ .name = "as3722" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index ab4bf9d5229e..12cc5d9dd84b 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -76,17 +76,17 @@ MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
 #endif
 
 static const struct i2c_device_id axp20x_i2c_id[] = {
-	{ "axp152" },
-	{ "axp192" },
-	{ "axp202" },
-	{ "axp209" },
-	{ "axp221" },
-	{ "axp223" },
-	{ "axp313a" },
-	{ "axp717" },
-	{ "axp803" },
-	{ "axp806" },
-	{ "axp15060" },
+	{ .name = "axp152" },
+	{ .name = "axp192" },
+	{ .name = "axp202" },
+	{ .name = "axp209" },
+	{ .name = "axp221" },
+	{ .name = "axp223" },
+	{ .name = "axp313a" },
+	{ .name = "axp717" },
+	{ .name = "axp803" },
+	{ .name = "axp806" },
+	{ .name = "axp15060" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index f553937c4075..99725242f1f0 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -160,8 +160,8 @@ static const struct of_device_id bcm590xx_of_match[] = {
 MODULE_DEVICE_TABLE(of, bcm590xx_of_match);
 
 static const struct i2c_device_id bcm590xx_i2c_id[] = {
-	{ "bcm59054" },
-	{ "bcm59056" },
+	{ .name = "bcm59054" },
+	{ .name = "bcm59056" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bcm590xx_i2c_id);
diff --git a/drivers/mfd/bd9571mwv.c b/drivers/mfd/bd9571mwv.c
index db8c2963fb48..2b6fe6fd9806 100644
--- a/drivers/mfd/bd9571mwv.c
+++ b/drivers/mfd/bd9571mwv.c
@@ -268,7 +268,7 @@ static const struct of_device_id bd9571mwv_of_match_table[] = {
 MODULE_DEVICE_TABLE(of, bd9571mwv_of_match_table);
 
 static const struct i2c_device_id bd9571mwv_id_table[] = {
-	{ "bd9571mwv" },
+	{ .name = "bd9571mwv" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, bd9571mwv_id_table);
diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
index 7c00d7e21dc7..1858f03df29a 100644
--- a/drivers/mfd/bq257xx.c
+++ b/drivers/mfd/bq257xx.c
@@ -129,8 +129,8 @@ static int bq257xx_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bq257xx_i2c_ids[] = {
-	{ "bq25703a", BQ25703A },
-	{ "bq25792", BQ25792 },
+	{ .name = "bq25703a", .driver_data = BQ25703A },
+	{ .name = "bq25792", .driver_data = BQ25792 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, bq257xx_i2c_ids);
diff --git a/drivers/mfd/cs40l50-i2c.c b/drivers/mfd/cs40l50-i2c.c
index 13afbb73b223..31da37fcc567 100644
--- a/drivers/mfd/cs40l50-i2c.c
+++ b/drivers/mfd/cs40l50-i2c.c
@@ -40,7 +40,7 @@ static void cs40l50_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id cs40l50_id_i2c[] = {
-	{ "cs40l50" },
+	{ .name = "cs40l50" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, cs40l50_id_i2c);
diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index 43c85d8ebee3..36e1df514294 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -447,8 +447,8 @@ static const struct da903x_chip_ops da903x_ops[] = {
 };
 
 static const struct i2c_device_id da903x_id_table[] = {
-	{ "da9030", 0 },
-	{ "da9034", 1 },
+	{ .name = "da9030", .driver_data = 0 },
+	{ .name = "da9034", .driver_data = 1 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, da903x_id_table);
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index 612f202ce02a..d1da6e9e9b6b 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -103,11 +103,11 @@ static int da9052_i2c_disable_multiwrite(struct da9052 *da9052)
 }
 
 static const struct i2c_device_id da9052_i2c_id[] = {
-	{"da9052", DA9052},
-	{"da9053-aa", DA9053_AA},
-	{"da9053-ba", DA9053_BA},
-	{"da9053-bb", DA9053_BB},
-	{"da9053-bc", DA9053_BC},
+	{ .name = "da9052", .driver_data = DA9052 },
+	{ .name = "da9053-aa", .driver_data = DA9053_AA },
+	{ .name = "da9053-ba", .driver_data = DA9053_BA },
+	{ .name = "da9053-bb", .driver_data = DA9053_BB },
+	{ .name = "da9053-bc", .driver_data = DA9053_BC },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, da9052_i2c_id);
diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index b9fde5e5a102..fcb61284b751 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -54,7 +54,7 @@ static void da9055_i2c_remove(struct i2c_client *i2c)
  * and CODEC, which must be different to operate together.
  */
 static const struct i2c_device_id da9055_i2c_id[] = {
-	{ "da9055-pmic" },
+	{ .name = "da9055-pmic" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 70f8b9ddbe62..0838164b3120 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -711,8 +711,8 @@ static const struct of_device_id da9062_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, da9062_dt_ids);
 
 static const struct i2c_device_id da9062_i2c_id[] = {
-	{ "da9061", COMPAT_TYPE_DA9061 },
-	{ "da9062", COMPAT_TYPE_DA9062 },
+	{ .name = "da9061", .driver_data = COMPAT_TYPE_DA9061 },
+	{ .name = "da9062", .driver_data = COMPAT_TYPE_DA9062 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da9062_i2c_id);
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index fb13427b1b59..c91f4c4feda4 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -476,8 +476,8 @@ static int da9063_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id da9063_i2c_id[] = {
-	{ "da9063", PMIC_TYPE_DA9063 },
-	{ "da9063l", PMIC_TYPE_DA9063L },
+	{ .name = "da9063", .driver_data = PMIC_TYPE_DA9063 },
+	{ .name = "da9063l", .driver_data = PMIC_TYPE_DA9063L },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
index 9af0af93cdee..13bf7393e471 100644
--- a/drivers/mfd/da9150-core.c
+++ b/drivers/mfd/da9150-core.c
@@ -498,7 +498,7 @@ static void da9150_shutdown(struct i2c_client *client)
 }
 
 static const struct i2c_device_id da9150_i2c_id[] = {
-	{ "da9150", },
+	{ .name = "da9150" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da9150_i2c_id);
diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 008067f3f670..cc13b88bb9f2 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -258,7 +258,7 @@ static const struct acpi_device_id crystal_cove_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, crystal_cove_acpi_match);
 
 static const struct i2c_device_id crystal_cove_i2c_match[] = {
-	{ "intel_soc_pmic_crc" },
+	{ .name = "intel_soc_pmic_crc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, crystal_cove_i2c_match);
diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 4ab83be8beba..7c87cc14fba8 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -501,7 +501,7 @@ static const struct of_device_id lm3533_match_table[] = {
 MODULE_DEVICE_TABLE(of, lm3533_match_table);
 
 static const struct i2c_device_id lm3533_i2c_ids[] = {
-	{ "lm3533" },
+	{ .name = "lm3533" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm3533_i2c_ids);
diff --git a/drivers/mfd/lp3943.c b/drivers/mfd/lp3943.c
index 1726f3dd9153..2edaa6bcb0b8 100644
--- a/drivers/mfd/lp3943.c
+++ b/drivers/mfd/lp3943.c
@@ -126,7 +126,7 @@ static int lp3943_probe(struct i2c_client *cl)
 }
 
 static const struct i2c_device_id lp3943_ids[] = {
-	{ "lp3943" },
+	{ .name = "lp3943" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp3943_ids);
diff --git a/drivers/mfd/lp873x.c b/drivers/mfd/lp873x.c
index ab7bd46d9ff7..f00e8473bb38 100644
--- a/drivers/mfd/lp873x.c
+++ b/drivers/mfd/lp873x.c
@@ -67,7 +67,7 @@ static const struct of_device_id of_lp873x_match_table[] = {
 MODULE_DEVICE_TABLE(of, of_lp873x_match_table);
 
 static const struct i2c_device_id lp873x_id_table[] = {
-	{ "lp873x" },
+	{ .name = "lp873x" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp873x_id_table);
diff --git a/drivers/mfd/lp87565.c b/drivers/mfd/lp87565.c
index 08e7ab41a638..009812be9614 100644
--- a/drivers/mfd/lp87565.c
+++ b/drivers/mfd/lp87565.c
@@ -108,7 +108,7 @@ static void lp87565_shutdown(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lp87565_id_table[] = {
-	{ "lp87565-q1" },
+	{ .name = "lp87565-q1" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp87565_id_table);
diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
index 79028e06a665..c3c7b344f0a0 100644
--- a/drivers/mfd/lp8788.c
+++ b/drivers/mfd/lp8788.c
@@ -216,7 +216,7 @@ static void lp8788_remove(struct i2c_client *cl)
 }
 
 static const struct i2c_device_id lp8788_ids[] = {
-	{ "lp8788" },
+	{ .name = "lp8788" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp8788_ids);
diff --git a/drivers/mfd/madera-i2c.c b/drivers/mfd/madera-i2c.c
index a8feb7192ec2..1e5307a83062 100644
--- a/drivers/mfd/madera-i2c.c
+++ b/drivers/mfd/madera-i2c.c
@@ -112,15 +112,15 @@ static void madera_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id madera_i2c_id[] = {
-	{ "cs47l15", CS47L15 },
-	{ "cs47l35", CS47L35 },
-	{ "cs47l85", CS47L85 },
-	{ "cs47l90", CS47L90 },
-	{ "cs47l91", CS47L91 },
-	{ "cs42l92", CS42L92 },
-	{ "cs47l92", CS47L92 },
-	{ "cs47l93", CS47L93 },
-	{ "wm1840", WM1840 },
+	{ .name = "cs47l15", .driver_data = CS47L15 },
+	{ .name = "cs47l35", .driver_data = CS47L35 },
+	{ .name = "cs47l85", .driver_data = CS47L85 },
+	{ .name = "cs47l90", .driver_data = CS47L90 },
+	{ .name = "cs47l91", .driver_data = CS47L91 },
+	{ .name = "cs42l92", .driver_data = CS42L92 },
+	{ .name = "cs47l92", .driver_data = CS47L92 },
+	{ .name = "cs47l93", .driver_data = CS47L93 },
+	{ .name = "wm1840", .driver_data = WM1840 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, madera_i2c_id);
diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index 1bef531a8df1..18c478f61bb9 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -463,8 +463,8 @@ static void max14577_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id max14577_i2c_id[] = {
-	{ "max14577", MAXIM_DEVICE_TYPE_MAX14577, },
-	{ "max77836", MAXIM_DEVICE_TYPE_MAX77836, },
+	{ .name = "max14577", .driver_data = MAXIM_DEVICE_TYPE_MAX14577 },
+	{ .name = "max77836", .driver_data = MAXIM_DEVICE_TYPE_MAX77836 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max14577_i2c_id);
diff --git a/drivers/mfd/max77541.c b/drivers/mfd/max77541.c
index 510fa42e48eb..39b324c76b99 100644
--- a/drivers/mfd/max77541.c
+++ b/drivers/mfd/max77541.c
@@ -199,8 +199,8 @@ static const struct of_device_id max77541_of_id[] = {
 MODULE_DEVICE_TABLE(of, max77541_of_id);
 
 static const struct i2c_device_id max77541_id[] = {
-	{ "max77540", MAX77540 },
-	{ "max77541", MAX77541 },
+	{ .name = "max77540", .driver_data = MAX77540 },
+	{ .name = "max77541", .driver_data = MAX77541 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max77541_id);
diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index 56b5718d01f2..1b5d4f0c71fc 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -694,9 +694,9 @@ static int max77620_i2c_resume(struct device *dev)
 }
 
 static const struct i2c_device_id max77620_id[] = {
-	{"max77620", MAX77620},
-	{"max20024", MAX20024},
-	{"max77663", MAX77663},
+	{ .name = "max77620", .driver_data = MAX77620 },
+	{ .name = "max20024", .driver_data = MAX20024 },
+	{ .name = "max77663", .driver_data = MAX77663 },
 	{},
 };
 
diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
index 5b553924d3cc..3c1d843582c3 100644
--- a/drivers/mfd/max77693.c
+++ b/drivers/mfd/max77693.c
@@ -305,7 +305,7 @@ static void max77693_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id max77693_i2c_id[] = {
-	{ "max77693", TYPE_MAX77693 },
+	{ .name = "max77693", .driver_data = TYPE_MAX77693 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max77693_i2c_id);
diff --git a/drivers/mfd/max77759.c b/drivers/mfd/max77759.c
index 5818ee2811d1..a06891781567 100644
--- a/drivers/mfd/max77759.c
+++ b/drivers/mfd/max77759.c
@@ -712,7 +712,7 @@ static int max77759_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max77759_i2c_id[] = {
-	{ "max77759" },
+	{ .name = "max77759" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max77759_i2c_id);
diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
index d38f1da5e080..9d588e10f35d 100644
--- a/drivers/mfd/max77843.c
+++ b/drivers/mfd/max77843.c
@@ -169,7 +169,7 @@ static const struct of_device_id max77843_dt_match[] = {
 };
 
 static const struct i2c_device_id max77843_id[] = {
-	{ "max77843", TYPE_MAX77843, },
+	{ .name = "max77843", .driver_data = TYPE_MAX77843 },
 	{ },
 };
 
diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 2f9179141053..ae66027b5c35 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -314,7 +314,7 @@ MODULE_DEVICE_TABLE(of, max8907_of_match);
 #endif
 
 static const struct i2c_device_id max8907_i2c_id[] = {
-	{ "max8907" },
+	{ .name = "max8907" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, max8907_i2c_id);
diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index 00aff8949cad..4544937b57d7 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -127,7 +127,7 @@ EXPORT_SYMBOL(max8925_set_bits);
 
 
 static const struct i2c_device_id max8925_id_table[] = {
-	{ "max8925" },
+	{ .name = "max8925" },
 	{ }
 };
 
diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 3a1216ea20a7..039c97002b5f 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -228,8 +228,8 @@ static int max8997_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id max8997_i2c_id[] = {
-	{ "max8997", TYPE_MAX8997 },
-	{ "max8966", TYPE_MAX8966 },
+	{ .name = "max8997", .driver_data = TYPE_MAX8997 },
+	{ .name = "max8966", .driver_data = TYPE_MAX8966 },
 	{ }
 };
 
diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index ec9fa4487f01..90cc063efd31 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -222,8 +222,8 @@ static int max8998_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id max8998_i2c_id[] = {
-	{ "max8998", TYPE_MAX8998 },
-	{ "lp3974", TYPE_LP3974},
+	{ .name = "max8998", .driver_data = TYPE_MAX8998 },
+	{ .name = "lp3974", .driver_data = TYPE_LP3974 },
 	{ }
 };
 
diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 58434ec20966..c496d5ee4341 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1230,7 +1230,7 @@ static void menelaus_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id menelaus_id[] = {
-	{ "menelaus" },
+	{ .name = "menelaus" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, menelaus_id);
diff --git a/drivers/mfd/menf21bmc.c b/drivers/mfd/menf21bmc.c
index 252d5c81db6b..ed3e0ab6e262 100644
--- a/drivers/mfd/menf21bmc.c
+++ b/drivers/mfd/menf21bmc.c
@@ -101,7 +101,7 @@ menf21bmc_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id menf21bmc_id_table[] = {
-	{ "menf21bmc" },
+	{ .name = "menf21bmc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, menf21bmc_id_table);
diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 00332bd4f1c6..33719f16e95c 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -699,10 +699,10 @@ static const struct of_device_id of_palmas_match_tbl[] = {
 MODULE_DEVICE_TABLE(of, of_palmas_match_tbl);
 
 static const struct i2c_device_id palmas_i2c_id[] = {
-	{ "palmas", (kernel_ulong_t)&palmas_data },
-	{ "twl6035", (kernel_ulong_t)&palmas_data },
-	{ "twl6037", (kernel_ulong_t)&palmas_data },
-	{ "tps65913", (kernel_ulong_t)&palmas_data },
+	{ .name = "palmas", .driver_data = (kernel_ulong_t)&palmas_data },
+	{ .name = "twl6035", .driver_data = (kernel_ulong_t)&palmas_data },
+	{ .name = "twl6037", .driver_data = (kernel_ulong_t)&palmas_data },
+	{ .name = "tps65913", .driver_data = (kernel_ulong_t)&palmas_data },
 	{ /* end */ }
 };
 MODULE_DEVICE_TABLE(i2c, palmas_i2c_id);
diff --git a/drivers/mfd/pf1550.c b/drivers/mfd/pf1550.c
index f4daaa20cb84..672c60ecc12a 100644
--- a/drivers/mfd/pf1550.c
+++ b/drivers/mfd/pf1550.c
@@ -340,7 +340,7 @@ static int pf1550_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(pf1550_pm, pf1550_suspend, pf1550_resume);
 
 static const struct i2c_device_id pf1550_i2c_id[] = {
-	{ "pf1550" },
+	{ .name = "pf1550" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, pf1550_i2c_id);
diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
index c64690074169..736a79f72388 100644
--- a/drivers/mfd/retu-mfd.c
+++ b/drivers/mfd/retu-mfd.c
@@ -300,8 +300,8 @@ static void retu_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id retu_id[] = {
-	{ "retu" },
-	{ "tahvo" },
+	{ .name = "retu" },
+	{ .name = "tahvo" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, retu_id);
diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
index 771631fdb350..435ffe3b0c89 100644
--- a/drivers/mfd/rsmu_i2c.c
+++ b/drivers/mfd/rsmu_i2c.c
@@ -328,13 +328,13 @@ static void rsmu_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id rsmu_i2c_id[] = {
-	{ "8a34000",  RSMU_CM },
-	{ "8a34001",  RSMU_CM },
-	{ "8a34002",  RSMU_CM },
-	{ "82p33810", RSMU_SABRE },
-	{ "82p33811", RSMU_SABRE },
-	{ "8v19n850", RSMU_SL },
-	{ "8v19n851", RSMU_SL },
+	{ .name = "8a34000",  .driver_data = RSMU_CM },
+	{ .name = "8a34001",  .driver_data = RSMU_CM },
+	{ .name = "8a34002",  .driver_data = RSMU_CM },
+	{ .name = "82p33810", .driver_data = RSMU_SABRE },
+	{ .name = "82p33811", .driver_data = RSMU_SABRE },
+	{ .name = "8v19n850", .driver_data = RSMU_SL },
+	{ .name = "8v19n851", .driver_data = RSMU_SL },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, rsmu_i2c_id);
diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index a1c4d02e2e72..698a441679fd 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -107,7 +107,7 @@ static int rt5033_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id rt5033_i2c_id[] = {
-	{ "rt5033", },
+	{ .name = "rt5033" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5033_i2c_id);
diff --git a/drivers/mfd/si476x-i2c.c b/drivers/mfd/si476x-i2c.c
index b0445e279980..4be7ea17e2d8 100644
--- a/drivers/mfd/si476x-i2c.c
+++ b/drivers/mfd/si476x-i2c.c
@@ -840,9 +840,9 @@ static void si476x_core_remove(struct i2c_client *client)
 
 
 static const struct i2c_device_id si476x_id[] = {
-	{ "si4761", SI476X_CHIP_SI4761 },
-	{ "si4764", SI476X_CHIP_SI4764 },
-	{ "si4768", SI476X_CHIP_SI4768 },
+	{ .name = "si4761", .driver_data = SI476X_CHIP_SI4761 },
+	{ .name = "si4764", .driver_data = SI476X_CHIP_SI4764 },
+	{ .name = "si4768", .driver_data = SI476X_CHIP_SI4768 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, si476x_id);
diff --git a/drivers/mfd/sky81452.c b/drivers/mfd/sky81452.c
index f533409736d9..4872d33a5322 100644
--- a/drivers/mfd/sky81452.c
+++ b/drivers/mfd/sky81452.c
@@ -59,7 +59,7 @@ static int sky81452_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id sky81452_ids[] = {
-	{ "sky81452" },
+	{ .name = "sky81452" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sky81452_ids);
diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index 943fa363efc3..8eee780afa16 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -100,14 +100,14 @@ static void stmpe_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id stmpe_i2c_id[] = {
-	{ "stmpe610", STMPE610 },
-	{ "stmpe801", STMPE801 },
-	{ "stmpe811", STMPE811 },
-	{ "stmpe1600", STMPE1600 },
-	{ "stmpe1601", STMPE1601 },
-	{ "stmpe1801", STMPE1801 },
-	{ "stmpe2401", STMPE2401 },
-	{ "stmpe2403", STMPE2403 },
+	{ .name = "stmpe610", .driver_data = STMPE610 },
+	{ .name = "stmpe801", .driver_data = STMPE801 },
+	{ .name = "stmpe811", .driver_data = STMPE811 },
+	{ .name = "stmpe1600", .driver_data = STMPE1600 },
+	{ .name = "stmpe1601", .driver_data = STMPE1601 },
+	{ .name = "stmpe1801", .driver_data = STMPE1801 },
+	{ .name = "stmpe2401", .driver_data = STMPE2401 },
+	{ .name = "stmpe2403", .driver_data = STMPE2403 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stmpe_i2c_id);
diff --git a/drivers/mfd/stw481x.c b/drivers/mfd/stw481x.c
index 082fb1f5cf3f..454f5f495b74 100644
--- a/drivers/mfd/stw481x.c
+++ b/drivers/mfd/stw481x.c
@@ -222,7 +222,7 @@ static int stw481x_probe(struct i2c_client *client)
  * the structure of the I2C core.
  */
 static const struct i2c_device_id stw481x_id[] = {
-	{ "stw481x" },
+	{ .name = "stw481x" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stw481x_id);
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index ca506c157bde..35d87a46eef6 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -465,13 +465,13 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tc3589x_dev_pm_ops,
 				tc3589x_suspend, tc3589x_resume);
 
 static const struct i2c_device_id tc3589x_id[] = {
-	{ "tc35890", TC3589X_TC35890 },
-	{ "tc35892", TC3589X_TC35892 },
-	{ "tc35893", TC3589X_TC35893 },
-	{ "tc35894", TC3589X_TC35894 },
-	{ "tc35895", TC3589X_TC35895 },
-	{ "tc35896", TC3589X_TC35896 },
-	{ "tc3589x", TC3589X_UNKNOWN },
+	{ .name = "tc35890", .driver_data = TC3589X_TC35890 },
+	{ .name = "tc35892", .driver_data = TC3589X_TC35892 },
+	{ .name = "tc35893", .driver_data = TC3589X_TC35893 },
+	{ .name = "tc35894", .driver_data = TC3589X_TC35894 },
+	{ .name = "tc35895", .driver_data = TC3589X_TC35895 },
+	{ .name = "tc35896", .driver_data = TC3589X_TC35896 },
+	{ .name = "tc3589x", .driver_data = TC3589X_UNKNOWN },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tc3589x_id);
diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index 198a9b94fb79..4bd7e66e951f 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -206,11 +206,11 @@ static const struct of_device_id ti_lmu_of_match[] = {
 MODULE_DEVICE_TABLE(of, ti_lmu_of_match);
 
 static const struct i2c_device_id ti_lmu_ids[] = {
-	{ "lm3631", LM3631 },
-	{ "lm3632", LM3632 },
-	{ "lm3633", LM3633 },
-	{ "lm3695", LM3695 },
-	{ "lm36274", LM36274 },
+	{ .name = "lm3631", .driver_data = LM3631 },
+	{ .name = "lm3632", .driver_data = LM3632 },
+	{ .name = "lm3633", .driver_data = LM3633 },
+	{ .name = "lm3695", .driver_data = LM3695 },
+	{ .name = "lm36274", .driver_data = LM36274 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ti_lmu_ids);
diff --git a/drivers/mfd/tps6105x.c b/drivers/mfd/tps6105x.c
index d87d5216d2c6..c89c1c5547e2 100644
--- a/drivers/mfd/tps6105x.c
+++ b/drivers/mfd/tps6105x.c
@@ -191,8 +191,8 @@ static void tps6105x_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tps6105x_id[] = {
-	{ "tps61050" },
-	{ "tps61052" },
+	{ .name = "tps61050" },
+	{ .name = "tps61052" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tps6105x_id);
diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 17137697158a..3eb5e6cc9650 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -649,11 +649,11 @@ static int tps65010_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tps65010_id[] = {
-	{ "tps65010", TPS65010 },
-	{ "tps65011", TPS65011 },
-	{ "tps65012", TPS65012 },
-	{ "tps65013", TPS65013 },
-	{ "tps65014", TPS65011 },	/* tps65011 charging at 6.5V max */
+	{ .name = "tps65010", .driver_data = TPS65010 },
+	{ .name = "tps65011", .driver_data = TPS65011 },
+	{ .name = "tps65012", .driver_data = TPS65012 },
+	{ .name = "tps65013", .driver_data = TPS65013 },
+	{ .name = "tps65014", .driver_data = TPS65011 },	/* tps65011 charging at 6.5V max */
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tps65010_id);
diff --git a/drivers/mfd/tps6507x.c b/drivers/mfd/tps6507x.c
index f75d088257fd..9e33c191bf7c 100644
--- a/drivers/mfd/tps6507x.c
+++ b/drivers/mfd/tps6507x.c
@@ -102,7 +102,7 @@ static int tps6507x_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id tps6507x_i2c_id[] = {
-	{ "tps6507x" },
+	{ .name = "tps6507x" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tps6507x_i2c_id);
diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index 897ccd7ec852..7a0b9ca5ace4 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -127,7 +127,7 @@ static void tps65086_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tps65086_id_table[] = {
-	{ "tps65086" },
+	{ .name = "tps65086" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, tps65086_id_table);
diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index 8bc5f4acc7a3..730f5112adda 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -225,7 +225,7 @@ static int tps65090_i2c_probe(struct i2c_client *client)
 
 
 static const struct i2c_device_id tps65090_id_table[] = {
-	{ "tps65090" },
+	{ .name = "tps65090" },
 	{ }
 };
 
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index f087883dd5c8..b3e481356e92 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -418,7 +418,7 @@ static int tps65217_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tps65217_id_table[] = {
-	{"tps65217", TPS65217},
+	{ .name = "tps65217", .driver_data = TPS65217 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, tps65217_id_table);
diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 491c379a1a0f..04f3a38fa961 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -336,8 +336,8 @@ static int tps65218_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tps65218_id_table[] = {
-	{ "tps65218", TPS65218 },
-	{ },
+	{ .name = "tps65218", .driver_data = TPS65218 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tps65218_id_table);
 
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index f524bbdc8f3b..c2e2dd1bfb10 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -642,7 +642,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tps6586x_pm_ops, tps6586x_i2c_suspend,
 			 tps6586x_i2c_resume);
 
 static const struct i2c_device_id tps6586x_id_table[] = {
-	{ "tps6586x" },
+	{ .name = "tps6586x" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tps6586x_id_table);
diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 07348ff28ab2..d7814f7bf6bf 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -551,8 +551,8 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id tps65910_i2c_id[] = {
-       { "tps65910", TPS65910 },
-       { "tps65911", TPS65911 },
+       { .name = "tps65910", .driver_data = TPS65910 },
+       { .name = "tps65911", .driver_data = TPS65911 },
        { }
 };
 
diff --git a/drivers/mfd/tps65912-i2c.c b/drivers/mfd/tps65912-i2c.c
index e3b18490b9e0..b4d9d7c36764 100644
--- a/drivers/mfd/tps65912-i2c.c
+++ b/drivers/mfd/tps65912-i2c.c
@@ -43,7 +43,7 @@ static int tps65912_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tps65912_i2c_id_table[] = {
-	{ "tps65912" },
+	{ .name = "tps65912" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, tps65912_i2c_id_table);
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 9bc23b55c064..23bb89ecaebe 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -929,17 +929,17 @@ static int twl_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(twl_dev_pm_ops, twl_suspend, twl_resume);
 
 static const struct i2c_device_id twl_ids[] = {
-	{ "twl4030", TWL4030_VAUX2 },	/* "Triton 2" */
-	{ "twl5030", 0 },		/* T2 updated */
-	{ "twl5031", TWL5031 },		/* TWL5030 updated */
-	{ "tps65950", 0 },		/* catalog version of twl5030 */
-	{ "tps65930", TPS_SUBSET },	/* fewer LDOs and DACs; no charger */
-	{ "tps65920", TPS_SUBSET },	/* fewer LDOs; no codec or charger */
-	{ "tps65921", TPS_SUBSET },	/* fewer LDOs; no codec, no LED
-					   and vibrator. Charger in USB module*/
-	{ "twl6030", TWL6030_CLASS },	/* "Phoenix power chip" */
-	{ "twl6032", TWL6030_CLASS | TWL6032_SUBCLASS }, /* "Phoenix lite" */
-	{ /* end of list */ },
+	{ .name = "twl4030", .driver_data = TWL4030_VAUX2 },	/* "Triton 2" */
+	{ .name = "twl5030", .driver_data = 0 },		/* T2 updated */
+	{ .name = "twl5031", .driver_data = TWL5031 },		/* TWL5030 updated */
+	{ .name = "tps65950", .driver_data = 0 },		/* catalog version of twl5030 */
+	{ .name = "tps65930", .driver_data = TPS_SUBSET },	/* fewer LDOs and DACs; no charger */
+	{ .name = "tps65920", .driver_data = TPS_SUBSET },	/* fewer LDOs; no codec or charger */
+	{ .name = "tps65921", .driver_data = TPS_SUBSET },	/* fewer LDOs; no codec, no LED
+						   and vibrator. Charger in USB module*/
+	{ .name = "twl6030", .driver_data = TWL6030_CLASS },	/* "Phoenix power chip" */
+	{ .name = "twl6032", .driver_data = TWL6030_CLASS | TWL6032_SUBCLASS }, /* "Phoenix lite" */
+	{ /* end of list */ }
 };
 
 /* One Client Driver , 4 Clients */
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 2b0ed6819c95..8056f54a598b 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -816,8 +816,8 @@ static void twl6040_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id twl6040_i2c_id[] = {
-	{ "twl6040" },
-	{ "twl6041" },
+	{ .name = "twl6040" },
+	{ .name = "twl6041" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, twl6040_i2c_id);
diff --git a/drivers/mfd/wm831x-i2c.c b/drivers/mfd/wm831x-i2c.c
index 7fbeae088b24..485985757f2e 100644
--- a/drivers/mfd/wm831x-i2c.c
+++ b/drivers/mfd/wm831x-i2c.c
@@ -72,13 +72,13 @@ static int wm831x_i2c_poweroff(struct device *dev)
 }
 
 static const struct i2c_device_id wm831x_i2c_id[] = {
-	{ "wm8310", WM8310 },
-	{ "wm8311", WM8311 },
-	{ "wm8312", WM8312 },
-	{ "wm8320", WM8320 },
-	{ "wm8321", WM8321 },
-	{ "wm8325", WM8325 },
-	{ "wm8326", WM8326 },
+	{ .name = "wm8310", .driver_data = WM8310 },
+	{ .name = "wm8311", .driver_data = WM8311 },
+	{ .name = "wm8312", .driver_data = WM8312 },
+	{ .name = "wm8320", .driver_data = WM8320 },
+	{ .name = "wm8321", .driver_data = WM8321 },
+	{ .name = "wm8325", .driver_data = WM8325 },
+	{ .name = "wm8326", .driver_data = WM8326 },
 	{ }
 };
 
diff --git a/drivers/mfd/wm8350-i2c.c b/drivers/mfd/wm8350-i2c.c
index 35d2a8c7817e..08b3731a5e91 100644
--- a/drivers/mfd/wm8350-i2c.c
+++ b/drivers/mfd/wm8350-i2c.c
@@ -41,9 +41,9 @@ static int wm8350_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id wm8350_i2c_id[] = {
-	{ "wm8350" },
-	{ "wm8351" },
-	{ "wm8352" },
+	{ .name = "wm8350" },
+	{ .name = "wm8351" },
+	{ .name = "wm8352" },
 	{ }
 };
 
diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
index 4ef57b70172a..562fef196c34 100644
--- a/drivers/mfd/wm8400-core.c
+++ b/drivers/mfd/wm8400-core.c
@@ -135,7 +135,7 @@ static int wm8400_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id wm8400_i2c_id[] = {
-       { "wm8400" },
+       { .name = "wm8400" },
        { }
 };
 
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 365aef6e5f20..f72e624f6cdf 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -655,10 +655,10 @@ static void wm8994_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id wm8994_i2c_id[] = {
-	{ "wm1811", WM1811 },
-	{ "wm1811a", WM1811 },
-	{ "wm8994", WM8994 },
-	{ "wm8958", WM8958 },
+	{ .name = "wm1811", .driver_data = WM1811 },
+	{ .name = "wm1811a", .driver_data = WM1811 },
+	{ .name = "wm8994", .driver_data = WM8994 },
+	{ .name = "wm8958", .driver_data = WM8958 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wm8994_i2c_id);
-- 
2.47.3

