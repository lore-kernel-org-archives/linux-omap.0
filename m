Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347803;
	b=KqrlHFgNkALuTqdxFsPCFEk8Nas3rZH5HmMcLediM8v/YC1vJ16bfqP7I/Chpyq0U3po
	 8NmJ162ku+zsaA6qjNmHDENI9kgTeExhS+d86vci8uZhXx8GR8uK5uzaO/rzrk0m7bPVg
	 Sa0Ii8pYokBdhK728/Qgdcd5KuN56XyXGimVN1kNf2uKkMuyFmITTjsIbpmJKZ5wKjMJ6
	 k4shxZqoy+wEWgacevph137XDkEV7m0SHeLRkgvh92dKXSUqZt1nm6J2sY8RykSTq+wdx
	 vfV2aUyBfC3Dm1OeEGcTBQpwYcSLGiyyg26rDKZHIu93o6zQNRS6WClBe0rCsD7IxKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=E59CXqBJgHb8JuBP3VbC54ycnN+izEgm9vGp5wS4S/I=;
	b=CQ6i41OIlEiuACOIv4Qqjt4N+/GaTCK9TuqOMTkGNeyouxy2w6bnxs2cmXt2TRyu1G+f
	 KiNR7ejq2/UdROQJRjSDRXcwjy62wej1r0DNsU/WZYjr/9lDNQoKRBEswmP/4rBf7XLKk
	 QbztgwQ9uhc3Mm6CvcKGfeNje+n00nEEaYDThquSI6KXsufAQQVThfp4FCLtlUyfbIJOW
	 FiOBO0J1N2R9ESLXE1U+prNiwE78NLM6EdvQyC7nXYbdAGTG7mRGKmj9OsFUnRRjiglyL
	 Ax/GA/uwqLnsYAzQ1/WNfYlL+aNvsw6fkELh5JH60SU76DBts9FwxjoKKFMj7paIGfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VroI5BUA;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F760A2617
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 21:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE6F760A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VroI5BUA
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-490585eddfcso2014322f8f.0
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 13:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794347801; x=1794952601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E59CXqBJgHb8JuBP3VbC54ycnN+izEgm9vGp5wS4S/I=;
        b=VroI5BUAKdjlWlw5llC3ybTIXsKHe7A2Q+FM0SdY8gzOpgbbNVBDzYJT8YMw46bw87
         PzAplY09XRq65V1qa/GCIRy0J/N/P/DtBfTR3B2hoiVMh9tndOtxCoCpdSBXcBe2kUzP
         WObk/gXIBr6IRSfvKKegvHQBGRz6BEcv4CxLYSLu1jW/1wvbdo7W6JIF6HYLd0OI9Fu4
         /LIT2vAWBH/cUbvuJhFQ3cfhIsEkC3H871r45BWiJ3wx12b5IeVw5ksXFVxpywOBSsQ7
         ZBsNY4wgZiGyEf0BQdEnwkEY4gCidorPfZkEV4PMF8yuXnh38s4IG8wB8fkA248ehSxP
         fpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794347801; x=1794952601;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E59CXqBJgHb8JuBP3VbC54ycnN+izEgm9vGp5wS4S/I=;
        b=hj6w2qumWE4iPS5wMghPMuhRO75t+ZVPUYAe4vzQ8INSNpFVJktHXmBAMgopNjoFqg
         ra2rrpv7irI71KAKXJqtXA2dIz4rCoZdlzVKZHr/7RLuidGvNalnlw1bs3fmANrpxlU8
         uVcAJUgv+UdijqGhty/yoUYogZVNOo+W/aBZmzPq7NiLVC4F1Gd7nwaK8w4xiaUWgEYj
         2BpeAcGoxX56v/YDF5XXzntVFdETIMHYRhdozetNlLal0IPL1CtJkbzISfeNQZxXPGC6
         aQPua2TPuydthdubEA2VJIh6/nyneb4kXC5Q294u1WYWCMEUn8oDBMfClkc2HGk1mopf
         728A==
X-Forwarded-Encrypted: i=1; AL+hErEl02N8zVGQ1l5EnOXp3D7IalBGCw4I9uBpEJ+opxn2v0BWQiRwAqVM+QNL3V6cRnP/mbcVdz24WIzp@vger.kernel.org
X-Gm-Message-State: APuU4Z/RHcljPQQjtswt1XE1o08ln8aoqppltZJ/SenH/e2bAyxohPx0
	iq+14q6hJXyys8dDFMQVR2XbOQZAMqLi8uU2BOBwmZc8OpXVhrQI+5qWRze2DShdvJo=
X-Gm-Gg: AYBFou1Q4icNsfHnjepjFilhhcQ9P0rXLG32BAl+f2/1HfTJ7KqTbYDlpjsdmA+lVEL
	2Kx0tF/KazH0iedE5RFiUKA53b50a1bWNu30bRXF6dvx+SJnxOJ7y5dukRYCNmUMi/rwn8vTNmg
	J87tT8N7Rjq1x0RYtPmnIIUPMIDMnyU2iA0IxtxKnllYTk5fA2HdioIHzCSe8iazYIUEa4UTUiS
	r1kERQ0xN6s7uctAsETmUJoX+IuDq9N2mTwzKqdZ+ueSJLYQkr27dc9oT/k8JU/eCMiK9tD2pgr
	/DDTA6C9HACdpW6++GO1R+xkTgPBfZj8JMBqomEq5NkPkjylkmdcPBqqtVQi1H86dygkVv4oCEZ
	Bc/KnQHn0aCD5q9/VJSElLEIWsbqhUpfcedebovkI4ZSnE20O57DrCkGadJmYEDlfkKESb5Iy1v
	0k7bcnFjU3eexmM7nJnJPl2eMG6fF6Ll16nDt5wGk9w2dygkPhiggApWn7dTEiMHDtDpUxTya2k
	4Eziy7OoETCxH+i4sBxNVXN2KuqPjET6ogYxdI97uvYrnr/526q3yuljVrrQZJ2FjOj02TZ+5Cd
	okOYeDawLwh0BfvRtinP6Hz5F1ckue4IG3c=
X-Received: by 2002:a05:6000:4917:b0:490:6e0f:a024 with SMTP id ffacd0b85a97d-499c69ca529mr383503f8f.13.1794347801137;
        Tue, 10 Nov 2026 13:56:41 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4983284c9b1sm6621758f8f.6.2026.11.10.13.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:56:37 -0800 (PST)
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
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH v4 18/20] mfd: Unify style of i2c_device_id arrays
Date: Tue, 10 Nov 2026 22:54:43 +0100
Message-ID:  <9d0e23458e847372a4ba9a4f582d36f0ff5b0edb.1794347059.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9688; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=myyBJOjZPFrpOZu3O1FTOXkBTyz0HAOD1yt8lASvMME=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq85LQLmEJ/EfwuhlpMI5PAWgaYg46BcM2a7xBy Uc5qGX1phaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCavOS0AAKCRCPgPtYfRL+ Thh5B/96AgcnoILKjfGHz+Ttbq3WuuqTyIoUl0O2oKQ4URsccTHtPLRWDArTmC31psMPoxB+mqj ZcqOSIfuZbV2JuYvf4OFI+GxMSN0bI3KcEeB9AqVmmNOdMTz+c1/BM7duwUtf/ZQKDw+JJqAvu1 sgpHvePMiHwuES4dnG1RniGoMbxqDkxXTqnAmnS8gJCdF+9I/ymeLWOWwuXazvjMffzNu8D7eOs 7TE4XNpQjCtk+McVeaHXmPDaZkiQMkwyr2DYJr/iPslEwmp1J/D0f/PwCaxqg7f3E1Bm72Zadai wIXzc8+bn1lZEmO2bfBQ6m2qJENGLl5m0NxRLoew5xaMd58Z
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
index 0e5c6b20943f..0f209084e8d3 100644
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
index 5310337fe9d4..48c5b132de2f 100644
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
index 64c7ea0b5d2b..4491aba8f835 100644
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
index d3224cf5e3f6..238584e703b8 100644
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
index 549f64255eef..aa2619e41484 100644
--- a/drivers/mfd/si476x-i2c.c
+++ b/drivers/mfd/si476x-i2c.c
@@ -841,7 +841,7 @@ static const struct i2c_device_id si476x_id[] = {
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
2.56.0.rc1

