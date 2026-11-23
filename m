Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432766;
	b=PRAOr4A/3Jf7JkQzZlvExWG1GCHKHncaDhvkkOcrp1VxB0d2bCr3Tv6wrAeL2PjMDqYe
	 LrOVVC1rE9y+wCXHWXdXOwd/bakSpnrC4Q8TCeoZaJH758tS5RacMaeOIVt02MW/r4c3D
	 mtU/gKGTXJ3xMT1hnevJX47WCpirFmSfEf4w2sHCFzgFsDmnNYOpFcfMBGB3RF/sWUR8h
	 D52e5IE9gJK+/yrqF7jf3Bfq767TSuWqotzID7RBHAiGdfiy0CwFOH8RBwhJvdbOen4Jg
	 EMJaqAEO9UxmXQBiI2rasy6ZSlnSN6C8EKWqlgS0t3hFCnvCdcosvOYdxZa77aPgMLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=UriCVVi4FzVmNtd9uxOgPEfOtJolmF8AfkCfRGKWNaA=;
	b=PTAnz6oXC9xFhLx3WR4lPzh4oQ6IGWZWazO3U3+t4sjaEblsVUPowgON4V9E8Ft/4J43
	 d4g3DWNUQdsOIPZqeZRQJmZxNgkHMFc2HkRH4iG3QaPCri17basW+X8WnProItHvXAvWH
	 nnl91ulARBgijmvQC9P8jEGPiM35C3qWl3kyfiF5UxJaVOw+1re4ttc+YccK3U1lwcsp+
	 +Jdbu18eHj9UOrXGN2D5DkTgS+UcBCWPI4G+aA00ckFVYXklLM33FojEpg6UqChmWri6b
	 Xv/Ik8dwZVPq8Ib2Hx518QkvW8gTRNJR1GtTiwaNsgYWrL1j1qVFUs1qaXuYEgAEKjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=USvG9OQZ;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9FE60A262F
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 11:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB9FE60A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=USvG9OQZ
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a210470b49so29913275e9.2
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 03:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795432764; x=1796037564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UriCVVi4FzVmNtd9uxOgPEfOtJolmF8AfkCfRGKWNaA=;
        b=USvG9OQZtCSyZnQrX8fl7VEnt57WZrcHgr3ItD9StEAp8J0VFqvOGi2v5YLaUiIjYj
         ouPb2u40lPGbSZZnMQsbofsJ6sjaaqKiPU6Vawimqd0JFucD7k2ymWZt3C1KC/0pGFbH
         gQTIDTRFiwfcPACNgnkPrVy5bAhQWEp5g71spy5SKykP2Z5LUXfmbeGnGTIMXsgkRCM+
         W4+DySM6yKz6UdPfQpqSihJLF0+r6e7EmmEZ1NfSjPc6VDL4pZNcqVpoO1PL+fKOEgKk
         SZkgBLQCGwJa0j2bM9aDwAUNYcYdmVJXJr065DnVbfzH5D3udyQ2BiF9bHILSMJuZSwu
         ZIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432764; x=1796037564;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UriCVVi4FzVmNtd9uxOgPEfOtJolmF8AfkCfRGKWNaA=;
        b=UuQFs6Ewsc0E3IK6pZiFxS66nQKd0Qn74BLVKwA+e2MRTfjT1/a2PUstDXlnn4HM8r
         ocDJTGohIw50+bXIbVGA8tkxB7HsvRmAV0NSJU2slP69XsIar8AvZWrFNm9+I9z6ZrCm
         JnzcfN79uzTr0wwERj85JCIxYVflm9fdkv51BAjgLqyVgNtC74ES+wNoh9lmiOmYsq4T
         EFVxgW1m7JY4279s2G5CHlNAShZxSp/KpnLIFuHHXanLGkqi3xjxUS3q1S5zzEOdk/YD
         TzxSeurKonNkY5yxuKvDlOaRo+fFxbXsN1zBYzl/jIWmdYsmCn3l+OSmilFNHmhktZ+j
         qrUw==
X-Forwarded-Encrypted: i=1; AL+hErENDmwMyZ4VH9eNP/ANo1RwitiEvHNDX/eKRxyfFQINfS+8442XZV8R/jOpTW5/zn2ebyugHvUQIhYt@vger.kernel.org
X-Gm-Message-State: APuU4Z95d29AZPUAcD72LnIVFDLZlmHJZIgzIXyHfd6NkBBgMqYfKSTb
	SM5wCQJR7je/lUciXG508ta0Ceg/yJEhJQS0UqlFE8opELqp+7JcNkote5kR6v4mBIc=
X-Gm-Gg: AZFdTZd2sKpJE6ozJEq/UvefttdZ7sFaDnTP1Jxua/nfccSkL3pSyNkrd5+UtCzxSwd
	IGbMQGNd23I40/ISnzBszRWEK6nudwtJyg+ZCQcxt2KP6whYVVi8zzOXo0aYsy3a9qPzi0DeKBj
	FMzc1J+PX+0ReMLFElh+fev+164SiO8Ks4Ypf7zF/ZwlPLxWzACh1sj+axuL8rrYseswPHjOqtQ
	XNmGonl3KKj/eOan6+xzS2K3JiydbmYCcH+dyGUdLEIEs5jHjbayct8hhcrb936vNtMymxcuX+4
	56ys6W0rNpEAp5Y2LewGRdWZ5lUYImIpi6J48yzbudj1fC61K1lQ9+dk/OXXmgHD342eHF/8H6m
	jBXzYrPXF4L3MKi3QO8OpNiq3HezidPlOJeTiCcoReYyM2Mz9C5eReD/tmb0b0AwHlQjPUkB6bd
	dKGx7mE0GApYbSpaCgnJPCVkgfas3BEpcAU+1r+XlRpfUHTKIgasGYs5gc7jjh94yoZesM1zhu1
	Kw11Pu08xei2Vd3EN91uvdLXSzoa/uopR/9Mq00HzEzurdyh3Wt6NwL/jTWGUymyXygvelqzR8H
	Gzkfgj0nkyYcLo14mudeGr/KfUITbDGqYpHsE80nQXGJWTAriEffo9mPTjEfc2tZrDzYRglHw5U
	c2V58BbUpnr9rphT+
X-Received: by 2002:a05:600c:468c:b0:4bb:6d61:af7c with SMTP id 5b1f17b1804b1-4bb88944bf5mr221173065e9.35.1795432764263;
        Mon, 23 Nov 2026 03:19:24 -0800 (PST)
Received: from localhost (p200300f65f19a90438645cebc2ee104e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3864:5ceb:c2ee:104e])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb906817ccsm160694775e9.5.2026.11.23.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:23 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <fred.treven@cirrus.com>,
	Ben Bright <ben.bright@cirrus.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-omap@vger.kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH v5 15/17] mfd: Unify style of i2c_device_id arrays
Date: Mon, 23 Nov 2026 12:18:13 +0100
Message-ID:  <73d8e90d1a392767976100e83402ad31784a1fb2.1795431460.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9684; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Fdl26dtonR7KNI6QS7TwlVPlGBMUYj+GEYuuZH9GZEQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBCEN92s/Oe/+Qgz1dbF6dfn+BQeokBrqy4q+W 8oJMl1lSRCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawQhDQAKCRCPgPtYfRL+ ToVYCAC60VXGJyc9KXGFedrGxmQ18JZn7pkcWp2Ak04fM93K66CnovfvTBM5ZKgkHr2sLzcIaVJ Kyvwt+tQCc17ZbnyX1lRm37InUxvQ5gZbPjVUjhJ4KjYqL23FkqbNT8V1B2jem0pUgBeoVuhXaH 5lOaUdVERrmAx18H7E7qIfBs1a91gA7AT5EAvdZZwK+AyMDLWLs7jMOig10LjXgQS4tNtvXsYPo Kq1HARQJuY7g8OxIxdjNtDYl7qk04nIrG2T/K0XOq9WfR15HvopCaGaKdKci3kMSsC4IcdCFgaA 2n2tc54Dt9SWLIYrVZ1pJICGYTaxTMpPu6GtxRKOl4C4yICd
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Most of these arrays already mostly match the most used and
generally recommended coding style. That is:

 - no comma after the list terminator;
 - a comma after an initializer if (and only if) the closing } is not
   directly following;
 - no explicit zeros in the list terminator;
 - a space after an opening { and before a closing }, a single space in
   the list terminator;

Adapt the few offenders accordingly and also use tabs for indention for
two drivers.

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/mfd/88pm800.c       | 2 +-
 drivers/mfd/88pm805.c       | 2 +-
 drivers/mfd/88pm860x-core.c | 2 +-
 drivers/mfd/act8945a.c      | 2 +-
 drivers/mfd/as3711.c        | 2 +-
 drivers/mfd/as3722.c        | 2 +-
 drivers/mfd/bq257xx.c       | 2 +-
 drivers/mfd/cs40l50-i2c.c   | 2 +-
 drivers/mfd/da903x.c        | 2 +-
 drivers/mfd/da9052-i2c.c    | 2 +-
 drivers/mfd/da9063-i2c.c    | 2 +-
 drivers/mfd/max77620.c      | 2 +-
 drivers/mfd/max77843.c      | 2 +-
 drivers/mfd/max8907.c       | 2 +-
 drivers/mfd/rc5t583.c       | 2 +-
 drivers/mfd/rsmu_i2c.c      | 2 +-
 drivers/mfd/si476x-i2c.c    | 2 +-
 drivers/mfd/tps65910.c      | 6 +++---
 drivers/mfd/wm8400-core.c   | 4 ++--
 19 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 570700d503a7..961d37814aba 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -117,7 +117,7 @@ enum {
 
 static const struct i2c_device_id pm80x_id_table[] = {
 	{ .name = "88PM800" },
-	{} /* NULL terminated */
+	{ } /* NULL terminated */
 };
 MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
 
diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
index 2eb3380a5207..8df11233bc4c 100644
--- a/drivers/mfd/88pm805.c
+++ b/drivers/mfd/88pm805.c
@@ -31,7 +31,7 @@
 
 static const struct i2c_device_id pm80x_id_table[] = {
 	{ .name = "88PM805" },
-	{} /* NULL terminated */
+	{ } /* NULL terminated */
 };
 MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
 
diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 733f2a50247a..ce521b042c5c 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1231,7 +1231,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(pm860x_pm_ops, pm860x_suspend, pm860x_resume);
 
 static const struct i2c_device_id pm860x_id_table[] = {
 	{ .name = "88PM860x" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pm860x_id_table);
 
diff --git a/drivers/mfd/act8945a.c b/drivers/mfd/act8945a.c
index bb1b4e4fb288..e5fba40f89d4 100644
--- a/drivers/mfd/act8945a.c
+++ b/drivers/mfd/act8945a.c
@@ -55,7 +55,7 @@ static int act8945a_i2c_probe(struct i2c_client *i2c)
 
 static const struct i2c_device_id act8945a_i2c_id[] = {
 	{ .name = "act8945a" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, act8945a_i2c_id);
 
diff --git a/drivers/mfd/as3711.c b/drivers/mfd/as3711.c
index 9513dc4ee0cd..23dabf4483e5 100644
--- a/drivers/mfd/as3711.c
+++ b/drivers/mfd/as3711.c
@@ -192,7 +192,7 @@ static int as3711_i2c_probe(struct i2c_client *client)
 
 static const struct i2c_device_id as3711_i2c_id[] = {
 	{ .name = "as3711" },
-	{}
+	{ }
 };
 
 static struct i2c_driver as3711_i2c_driver = {
diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index dfabb9b8956e..e545cdd09d81 100644
--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -433,7 +433,7 @@ MODULE_DEVICE_TABLE(of, as3722_of_match);
 
 static const struct i2c_device_id as3722_i2c_id[] = {
 	{ .name = "as3722" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
 
diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
index 1858f03df29a..ea47496a81e3 100644
--- a/drivers/mfd/bq257xx.c
+++ b/drivers/mfd/bq257xx.c
@@ -131,7 +131,7 @@ static int bq257xx_probe(struct i2c_client *client)
 static const struct i2c_device_id bq257xx_i2c_ids[] = {
 	{ .name = "bq25703a", .driver_data = BQ25703A },
 	{ .name = "bq25792", .driver_data = BQ25792 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bq257xx_i2c_ids);
 
diff --git a/drivers/mfd/cs40l50-i2c.c b/drivers/mfd/cs40l50-i2c.c
index 31da37fcc567..0e6fa90bb603 100644
--- a/drivers/mfd/cs40l50-i2c.c
+++ b/drivers/mfd/cs40l50-i2c.c
@@ -41,7 +41,7 @@ static void cs40l50_i2c_remove(struct i2c_client *i2c)
 
 static const struct i2c_device_id cs40l50_id_i2c[] = {
 	{ .name = "cs40l50" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, cs40l50_id_i2c);
 
diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index 36e1df514294..88a20e73a1ef 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -449,7 +449,7 @@ static const struct da903x_chip_ops da903x_ops[] = {
 static const struct i2c_device_id da903x_id_table[] = {
 	{ .name = "da9030", .driver_data = 0 },
 	{ .name = "da9034", .driver_data = 1 },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da903x_id_table);
 
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index d1da6e9e9b6b..110d0886f829 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -108,7 +108,7 @@ static const struct i2c_device_id da9052_i2c_id[] = {
 	{ .name = "da9053-ba", .driver_data = DA9053_BA },
 	{ .name = "da9053-bb", .driver_data = DA9053_BB },
 	{ .name = "da9053-bc", .driver_data = DA9053_BC },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da9052_i2c_id);
 
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index c91f4c4feda4..fc053485656b 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -478,7 +478,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c)
 static const struct i2c_device_id da9063_i2c_id[] = {
 	{ .name = "da9063", .driver_data = PMIC_TYPE_DA9063 },
 	{ .name = "da9063l", .driver_data = PMIC_TYPE_DA9063L },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
 
diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index 1b5d4f0c71fc..10a2ed2acfdd 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -697,7 +697,7 @@ static const struct i2c_device_id max77620_id[] = {
 	{ .name = "max77620", .driver_data = MAX77620 },
 	{ .name = "max20024", .driver_data = MAX20024 },
 	{ .name = "max77663", .driver_data = MAX77663 },
-	{},
+	{ }
 };
 
 static DEFINE_SIMPLE_DEV_PM_OPS(max77620_pm_ops,
diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
index 9d588e10f35d..81c95b7fdfb1 100644
--- a/drivers/mfd/max77843.c
+++ b/drivers/mfd/max77843.c
@@ -170,7 +170,7 @@ static const struct of_device_id max77843_dt_match[] = {
 
 static const struct i2c_device_id max77843_id[] = {
 	{ .name = "max77843", .driver_data = TYPE_MAX77843 },
-	{ },
+	{ }
 };
 
 static int max77843_suspend(struct device *dev)
diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index ae66027b5c35..e15370320a50 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -315,7 +315,7 @@ MODULE_DEVICE_TABLE(of, max8907_of_match);
 
 static const struct i2c_device_id max8907_i2c_id[] = {
 	{ .name = "max8907" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max8907_i2c_id);
 
diff --git a/drivers/mfd/rc5t583.c b/drivers/mfd/rc5t583.c
index 96553e5a8279..becb6637d346 100644
--- a/drivers/mfd/rc5t583.c
+++ b/drivers/mfd/rc5t583.c
@@ -281,7 +281,7 @@ static int rc5t583_i2c_probe(struct i2c_client *i2c)
 
 static const struct i2c_device_id rc5t583_i2c_id[] = {
 	{ .name = "rc5t583" },
-	{}
+	{ }
 };
 
 static struct i2c_driver rc5t583_i2c_driver = {
diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
index 435ffe3b0c89..e1c4eec6098d 100644
--- a/drivers/mfd/rsmu_i2c.c
+++ b/drivers/mfd/rsmu_i2c.c
@@ -335,7 +335,7 @@ static const struct i2c_device_id rsmu_i2c_id[] = {
 	{ .name = "82p33811", .driver_data = RSMU_SABRE },
 	{ .name = "8v19n850", .driver_data = RSMU_SL },
 	{ .name = "8v19n851", .driver_data = RSMU_SL },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rsmu_i2c_id);
 
diff --git a/drivers/mfd/si476x-i2c.c b/drivers/mfd/si476x-i2c.c
index 4be7ea17e2d8..b1f70a6cb027 100644
--- a/drivers/mfd/si476x-i2c.c
+++ b/drivers/mfd/si476x-i2c.c
@@ -843,7 +843,7 @@ static const struct i2c_device_id si476x_id[] = {
 	{ .name = "si4761", .driver_data = SI476X_CHIP_SI4761 },
 	{ .name = "si4764", .driver_data = SI476X_CHIP_SI4764 },
 	{ .name = "si4768", .driver_data = SI476X_CHIP_SI4768 },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, si476x_id);
 
diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index d7814f7bf6bf..ef465da7cf44 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -551,9 +551,9 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id tps65910_i2c_id[] = {
-       { .name = "tps65910", .driver_data = TPS65910 },
-       { .name = "tps65911", .driver_data = TPS65911 },
-       { }
+	{ .name = "tps65910", .driver_data = TPS65910 },
+	{ .name = "tps65911", .driver_data = TPS65911 },
+	{ }
 };
 
 static struct i2c_driver tps65910_i2c_driver = {
diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
index 562fef196c34..bcbd2408acad 100644
--- a/drivers/mfd/wm8400-core.c
+++ b/drivers/mfd/wm8400-core.c
@@ -135,8 +135,8 @@ static int wm8400_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id wm8400_i2c_id[] = {
-       { .name = "wm8400" },
-       { }
+	{ .name = "wm8400" },
+	{ }
 };
 
 static struct i2c_driver wm8400_i2c_driver = {
-- 
2.47.3

