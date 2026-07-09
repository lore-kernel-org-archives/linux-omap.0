Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC2435EFF
	for <linux-omap@vger.kernel.org>; Thu,  9 Jul 2026 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616440; cv=none; b=hYmTEAfgIRykVEDST5l3qFrWpesuwnDXF1VokCs5NHrJ9oq1nCjsvHfUdCxrwRdpD0Z0phVpAJpy+jGheQyb3jm186fk7vlfjhE6cwenjJSAmZIERr4GgPhzXy1UYcaGnXsRPED+MvuMT2zLjXYsR4jtV26si6d3vi1mC3yQDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616440; c=relaxed/simple;
	bh=0fWR3hB0c6+gia3PEndtbwhhT0RB0WdAxWuNvfIiO2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=op54OM32oXyh5XAdXXqcwt8JVqgzyoflmepYC6Qb+EWSQbBnX6oiGlta3Sg65TltimNdTxK75c1dIW6ima8V0SNd2t4uykz90tLiuZH6cDbmFvnVV6ZjiYo+xTAu/q0tAjraPYukYtPaUZtRxLT8sSVYbGGTxx8HeupEj9B8JyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MUBvl/nB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MUBvl/nB"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so409385e9.1
        for <linux-omap@vger.kernel.org>; Thu, 09 Jul 2026 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783616435; x=1784221235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1obID3ONEZq36YlunR8wnWWc7ONenVNzJZZ5TRSAad4=;
        b=MUBvl/nBHISO35hojIGs1GJ4L9iFHe4WKuIOemawwaAUozaYUUwSHqutyxpuRKlKk6
         MDP5CqHnsfqcD2tmuKRXuSz3XCxg1K3mQ7wVaiB1Nlaac67WWMsOQxm4mJt1qOPyhNQT
         frTnCyqH9CLStGcEDqHyPt6KyJ4udP5H0zl8+DHGqPKKgZxfKoG6908r4+YnbP+Aikup
         LN4W1r11gC+YhuCFKVMxBfmarPyUIfX8PkbBf2VBKmN1yX9+DuXE6ZeR6d5MXeKAVfr4
         Dl0k/wGKf3XyR/aO/47qof8ILNuTTO6OtBtIKOiJoq2grFIfuuKKRMDR+I6OV1Ct8vfq
         ikAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783616435; x=1784221235;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1obID3ONEZq36YlunR8wnWWc7ONenVNzJZZ5TRSAad4=;
        b=ZCnihSHmeBD2bt+fiWnUD7hblpB4baqUs6FUH8/ut4rZxInwf7+fAarqYEEmCmda7D
         e7f8fm4Lg9tHkir/HtXQfYLgKgBiSgRFakHwHpYANmHxToTcbwpCfd1dXqFcvWWQad8G
         Ayj+qmoLeO/Rv4VHmiZKe59KRSDcNb4BDEb7ZKuOkYhUNUs3umwPC1amPXX0YvNN+vGD
         E4bPPBqjBUfpX2GVVqlXbwluDTUQBU8baFxZpEKiGNNHXpmRJVA/8+OSopNY8+1h8URG
         pWh6d4lSjyX1Vdt2mKDZVabTj8yCHyPISNFfzBWvzyeBcPhzKTRRKAbVZ2SmZdmRyNqV
         xD+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrodNrzQvLDsTI6oC0WXfzXiL76kWp6MPH0SF1d4T9grLKSre4T8i8S/9In3sLILe7Izj1VAYzPzqa0@vger.kernel.org
X-Gm-Message-State: AOJu0YypUg4XtSRGHr9igJZFrhQNHj9pIknqgmUwyU+/L6gsCWi356fT
	S5s4lxDr3xnwM/p1BmV7UvrK+zEXSInCFceGdpE2ssKyJb16CFQCz+EXN0GUk0ow9Xo=
X-Gm-Gg: AfdE7ckVDl9zwIlMrsTbWk4xWAcZ98FiBH5GolN65mDh5CwU/B3Y/jzEBtSfbgkqDT2
	P89MqaIM1IG3uaVWWslUZs/QZOXhgTJAAa715PwckgJeiU4wMCJC5GjqVJ/LPhbOyyGmSxWpr2n
	zeIOe+caVyuavRS4Z+QcZ1ugek0ihjWFEj0OFP5914nDSHrSiaO23lTQCBHT50qn8/9ctINr7Ln
	ACi8B9hoFPsLbf9hd1vS1dQg4iJe3HTxuxnzpXxlx2fJ8UYh/roUZVAamNhV9NLNSNTLFABvKqQ
	tX+iuphvCx6lNbXjp5NHQ6rb/RrSD68ql3xeM4B9oqyXLT95fnsBNxSfrjDIzuwp9xiaUdXj1uW
	yUzgYUhybUbcS4UlmYnF3c1e4BycEw84t3aDiPXXe0t6E34HFU2wmH/2WBXqjfRmY+MAMfBEbUm
	hucMNtBfdBlmwn+0PHYe1RyxAJVfBqehQECTkIxEkyqBHSV8TjsJG28bh8rC+0zRuHXSjZUS9Z
X-Received: by 2002:a05:600c:c1d7:10b0:493:e41a:9b23 with SMTP id 5b1f17b1804b1-493f2b24cf0mr123065e9.1.1783616435191;
        Thu, 09 Jul 2026 10:00:35 -0700 (PDT)
Received: from localhost (p200300f65f47db043de98c19b374aa68.dip0.t-ipconnect.de. [2003:f6:5f47:db04:3de9:8c19:b374:aa68])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493eb6f2e56sm91112755e9.13.2026.07.09.10.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 10:00:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: James Ogletree <jogletre@opensource.cirrus.com>,
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
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v3 20/23] mfd: Unify style of i2c_device_id arrays
Date: Thu,  9 Jul 2026 18:58:39 +0200
Message-ID:  <a2a2ece7d82cfe644c5c588f84379917790dc923.1783615311.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1783615311.git.u.kleine-koenig@baylibre.com>
References: <cover.1783615311.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9668; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=0fWR3hB0c6+gia3PEndtbwhhT0RB0WdAxWuNvfIiO2U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqT9NmVgVMidfhQuEvrSl4pRBhKjmTtDMVoUbj9 HPjY5ZPdWKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCak/TZgAKCRCPgPtYfRL+ TtZJCACeIlUjHGk1UvYQ3PfkgScRsjZbt8z/paHX/oXAdOjM6i00DYUgehKObYj+pyc7B1IbW0C JagXbIo7QsibeH4BGWMP/L9yEAlmg7FP7XsqiNIEVpxu0WCQ2WLaNokV3YZyzcN5OLDTtxix3IU CqHzJfBY2FuMGhk/g7LDBYpVDRN/5dPAgnqLH/uKUA2q2y947usesVwvrVdgesJ2oy3kdevUYbx u4m1yZMROtEfvqDZgo45qea6d8NBTp79+Tco4Gru9zEoklJtO2uFfQfuh72Rc8KAE94YV08H8IQ tATPHVv2uCcKEOeStK8tk3/xQkPutH6uMNUlG9IL/TCl2I0/
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

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
index 74dc419402f9..fe1017c6234b 100644
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
index 1b201ad129c2..d3c24a7a3936 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1233,7 +1233,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(pm860x_pm_ops, pm860x_suspend, pm860x_resume);
 
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
index eb03b813d58f..6d2fa63e7f4b 100644
--- a/drivers/mfd/as3711.c
+++ b/drivers/mfd/as3711.c
@@ -193,7 +193,7 @@ static int as3711_i2c_probe(struct i2c_client *client)
 
 static const struct i2c_device_id as3711_i2c_id[] = {
 	{ .name = "as3711" },
-	{}
+	{ }
 };
 
 static struct i2c_driver as3711_i2c_driver = {
diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index 2f58709ffd9a..ec7be5fb326e 100644
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
index 8ad9f0ad6512..182d67f23f60 100644
--- a/drivers/mfd/bq257xx.c
+++ b/drivers/mfd/bq257xx.c
@@ -121,7 +121,7 @@ static int bq257xx_probe(struct i2c_client *client)
 static const struct i2c_device_id bq257xx_i2c_ids[] = {
 	{ .name = "bq25703a", .driver_data = BQ25703A },
 	{ .name = "bq25792", .driver_data = BQ25792 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bq257xx_i2c_ids);
 
diff --git a/drivers/mfd/cs40l50-i2c.c b/drivers/mfd/cs40l50-i2c.c
index 6043eb6639b5..b61b0484644d 100644
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
index c949ebc57b18..46d9d823414a 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -441,7 +441,7 @@ static const struct da903x_chip_ops da903x_ops[] = {
 static const struct i2c_device_id da903x_id_table[] = {
 	{ .name = "da9030", .driver_data = 0 },
 	{ .name = "da9034", .driver_data = 1 },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da903x_id_table);
 
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index b75cfe805d5e..6af9552ccba1 100644
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
index b57a6ee90aa9..068f080d1f9b 100644
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
index a66ca73997f5..e4d7cb4afef0 100644
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
index 9e535ff1e3f7..c1cbf1f88b15 100644
--- a/drivers/mfd/max77843.c
+++ b/drivers/mfd/max77843.c
@@ -170,7 +170,7 @@ static const struct of_device_id max77843_dt_match[] = {
 
 static const struct i2c_device_id max77843_id[] = {
 	{ .name = "max77843", .driver_data = TYPE_MAX77843 },
-	{ },
+	{ }
 };
 
 static int __maybe_unused max77843_suspend(struct device *dev)
diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 70ffc08a96d1..6e2fed7021a8 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -301,7 +301,7 @@ MODULE_DEVICE_TABLE(of, max8907_of_match);
 
 static const struct i2c_device_id max8907_i2c_id[] = {
 	{ .name = "max8907" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max8907_i2c_id);
 
diff --git a/drivers/mfd/rc5t583.c b/drivers/mfd/rc5t583.c
index 4ad761fbfab2..acb42868be37 100644
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
index d05aaf576a86..c03db3ce5f12 100644
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
index f25a4b60071b..30e545cd0889 100644
--- a/drivers/mfd/si476x-i2c.c
+++ b/drivers/mfd/si476x-i2c.c
@@ -844,7 +844,7 @@ static const struct i2c_device_id si476x_id[] = {
 	{ .name = "si4761", .driver_data = SI476X_CHIP_SI4761 },
 	{ .name = "si4764", .driver_data = SI476X_CHIP_SI4764 },
 	{ .name = "si4768", .driver_data = SI476X_CHIP_SI4768 },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, si476x_id);
 
diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index b0dbee3e6ea2..d19bd3643591 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -532,9 +532,9 @@ static int tps65910_i2c_probe(struct i2c_client *i2c)
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
index 1c0ba450ef9b..d3180aa44e1a 100644
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
2.55.0.11.g153666a7d9bb

