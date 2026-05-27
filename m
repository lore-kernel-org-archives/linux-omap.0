Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60595427A1A
	for <linux-omap@vger.kernel.org>; Wed, 27 May 2026 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893868; cv=none; b=crWBUfyOCCC53hhnA27jc7rmKDhrvHbAfIYNsqHXD0QZ3380VYeSpMm31+Y586Bk3IIOFBlyCVGShXNJoB7qtDF8IJWH5LYC3KULdroNbzTZrdqJh9RvkoNP0SEwGxJMiQqsUjI1a72Rs3U7IXX8kvIbzQgVVeIEWszlMpvvEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893868; c=relaxed/simple;
	bh=oDODHMUoLpDU7iZfBhWstcjShA2kx7eASZvf6nRJz28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oFsjf+Zy+HtccTJdC9vPUdoUW/Gr+JBrvK7SDGgLx82DPyO9Je6G37gyz4G0FXv9ph6l8nbgIyzVn2tuVkOp5rOze/kMCDr38KYoJKb+K3XbPrk0gZY5KTW6Ok4sADIphDbIiHdrfn38axJK1O80pxi6BqgkxRSkgvbGqkG0IEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LfB52L7n; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LfB52L7n"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so85940475e9.0
        for <linux-omap@vger.kernel.org>; Wed, 27 May 2026 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779893863; x=1780498663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vS1V6wFacA53GGyfnOVFyw9GSa+e1cL9vb2RCcSv0ng=;
        b=LfB52L7nzgAI+OeOURJRd5sLxGfCSAKt3aIjopJuT1QfOuEVGMo8MnAOctU5XlpzlU
         bqV8STYCLqpoXXrkyn0z9oOb9zu55vkva6xbek7DrJP9ImBq/2wdvbl6T2z4CSWX8E9M
         NONHoW5JltWzuzDGBAYcjQib2LDqSyGyXUuJppkmE5B+6U0uGORrDgNX8+h/lQynyRCa
         cpL6korOlFSvMPBxow3fWx9uoWWtwkZTBSdCBgmVwe8aBxJVyHO1E2Bn8qrQbUna21jF
         Sp9qKMkB0O6tA5wxP32Xnm6VDzc8zjQZcHlsjTUV8j8QXVeBb3hS5qIR9wl/TEeODKd9
         dRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779893863; x=1780498663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vS1V6wFacA53GGyfnOVFyw9GSa+e1cL9vb2RCcSv0ng=;
        b=OrjpTQOinP7Xz0+bBzuI8Te4AlZmhwxV4TVKQmP/tFU6oBGsMOyx/1cNTEB/RtsPyd
         5wXyN4326DpbwTGFTzDbViW0NdgXmWyNAYao0saF3EkClrBqjNDsdTLTx8Y6/XSn1o06
         vJNuRqkzE052I+Tw7ECcJ9kYvjJCIR8o7wzQg/qUQB7WeO+N2n++y+qAWtMHpOuK2CUs
         zjOCT7EfU3I+ZAkmb/8ZB3v4HyDxSZLetE5TJXpKUe6Pg3aRnYpsAOYAyAN2k1NdnPNT
         yx42EdeJvePT74v30x92fQJT6Nij/P0KMRPduUGPB1quEs51NTPQPGcDdkjv+hUnLuDA
         yGbg==
X-Forwarded-Encrypted: i=1; AFNElJ+Q9xI+IqoPeuWPUCNYzyyKi4hCKgqQRRkY6l+Q0p2JMMbjAZtbkDSgWQVibYn0uYFfvsMYgITu5VQM@vger.kernel.org
X-Gm-Message-State: AOJu0YzqOAIrjuNgvQ6Bm6jPTJyCKtEARpuqC3nrbaNSDOzhYf6INxxG
	ntFpwaf1gj1XV+kQiiyvYWeAQKirYybSRmyqx45KyflfdoB4OTXgdLP2/nFNUA9pe6Y=
X-Gm-Gg: Acq92OFWMgY9p3dru0MVGvEXtgL6wqLeDsuTg9caq9mXaHGv7dToB2+9jYbsc/WEWhP
	JNGvg4SXmuBr4EvzKknFW9sVR5CEUQdtki5OiEDJSFrDZX4vlQX+3NlCw2PbZzX9U8bG7evSUSF
	R6TKfwOJD3E7na8n+dP2rR6cyBFExBYSg22W7Juq7q4Rpau9qlHErVJ0U7NVag6jYwI/8hxbnvO
	Orh8AT6fGcahoURcY1bq7ReNpY1uaCTbpaq1GmHbt5lLaJkmbsGrKnbq4VeIyZ6LmXrpur+WPtx
	8vXMUPit6bfh8NGoMWwjjPwFL0EtF2AvVm2se7Qwbj8H2maSdg3aOyBw+dtymeUcS9P6CS0TZup
	TQX3DnlHVNflawF1CunHYyAhryNuRBu2eDy+uUXjUMYWel2MWLrFN9md4a6wi5aVMXSwVDyd6Pa
	fCoTKG7Ad5b/CQ2XbUxsBGqIUA5wSl6A+xg5w3dwZWbGPTnou8WZPlG2qOQItzvvDSFr4uim8wi
	aYg80R8lTVLEXI=
X-Received: by 2002:a05:600c:8b84:b0:490:5466:8576 with SMTP id 5b1f17b1804b1-490546689a7mr366033115e9.1.1779893862724;
        Wed, 27 May 2026 07:57:42 -0700 (PDT)
Received: from localhost (p200300f65f47db042b54ed4dbf2ca0b5.dip0.t-ipconnect.de. [2003:f6:5f47:db04:2b54:ed4d:bf2c:a0b5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490838f7f35sm30535645e9.1.2026.05.27.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:57:42 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	linux-gpio@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v1 0/3] gpio: Use named initializers for platform_device_id arrays
Date: Wed, 27 May 2026 16:57:26 +0200
Message-ID: <cover.1779893336.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4144; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=oDODHMUoLpDU7iZfBhWstcjShA2kx7eASZvf6nRJz28=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFwZXDKwsOjAsKUzLboec5og9VLoE+o2c00gUz UH6kdhEIFSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahcGVwAKCRCPgPtYfRL+ TurWCACGVYbAn82eGpMPsanfyUS8JzwWXl0rIeWEgrdLqqdUkJHpswWdfqJjO8lhMS4iGBnyezq khvw4AJ/eD9YytnLbc+K71CagOVNrJcLWnQZFwmW4MRU1g8nyD7jskSqLUvinwNI7rm42JYZCXL XvQks/gI/EsLB4GXIIiJRW71/FmFZOq+3Q3Apa2Q0amRj9TXVDKMPmX6gpZaKIQA4i0Q4eMupu+ ao8oowaqpXDmq5aUoDZH3WBd5LclJ7rNtHPV+QNDeuU1aqnr1p3tRkqbimiN7ZCVnf6J3MQBiaJ +d0T79KmDEPQiN0SEJ1b9k+z17HNHxh71Ah1pva+IxvJq1LN
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series targets to use named initializers for platform_device_id
arrays. In general these are better readable for humans and more robust
to changes in the respective struct definition.

This robustness is needed as I want to do

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -610,4 +610,7 @@ struct dmi_system_id {
	 struct platform_device_id {
		char name[PLATFORM_NAME_SIZE];
	-	kernel_ulong_t driver_data;
	+	union {
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };

which allows dropping several casts and eases porting CHERI to mainline
linux. A possible follow-up change is the following example:

	diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
	index 5d61053e0596..03bc8e859d73 100644
	--- a/drivers/gpio/gpio-pxa.c
	+++ b/drivers/gpio/gpio-pxa.c
	@@ -534,7 +534,7 @@ static struct irq_chip pxa_muxed_gpio_chip = {
	 static int pxa_gpio_nums(struct platform_device *pdev)
	 {
		const struct platform_device_id *id = platform_get_device_id(pdev);
	-	struct pxa_gpio_id *pxa_id = (struct pxa_gpio_id *)id->driver_data;
	+	struct pxa_gpio_id *pxa_id = id->driver_data_ptr;
		int count = 0;
	 
		switch (pxa_id->type) {
	@@ -708,14 +708,14 @@ static int pxa_gpio_probe(struct platform_device *pdev)
	 }
	 
	 static const struct platform_device_id gpio_id_table[] = {
	-	{ .name = "pxa25x-gpio",	.driver_data = (unsigned long)&pxa25x_id },
	-	{ .name = "pxa26x-gpio",	.driver_data = (unsigned long)&pxa26x_id },
	-	{ .name = "pxa27x-gpio",	.driver_data = (unsigned long)&pxa27x_id },
	-	{ .name = "pxa3xx-gpio",	.driver_data = (unsigned long)&pxa3xx_id },
	-	{ .name = "pxa93x-gpio",	.driver_data = (unsigned long)&pxa93x_id },
	-	{ .name = "mmp-gpio",		.driver_data = (unsigned long)&mmp_id },
	-	{ .name = "mmp2-gpio",		.driver_data = (unsigned long)&mmp2_id },
	-	{ .name = "pxa1928-gpio",	.driver_data = (unsigned long)&pxa1928_id },
	+	{ .name = "pxa25x-gpio",	.driver_data_ptr = &pxa25x_id },
	+	{ .name = "pxa26x-gpio",	.driver_data_ptr = &pxa26x_id },
	+	{ .name = "pxa27x-gpio",	.driver_data_ptr = &pxa27x_id },
	+	{ .name = "pxa3xx-gpio",	.driver_data_ptr = &pxa3xx_id },
	+	{ .name = "pxa93x-gpio",	.driver_data_ptr = &pxa93x_id },
	+	{ .name = "mmp-gpio",		.driver_data_ptr = &mmp_id },
	+	{ .name = "mmp2-gpio",		.driver_data_ptr = &mmp2_id },
	+	{ .name = "pxa1928-gpio",	.driver_data_ptr = &pxa1928_id },
		{ }
	 };
 
increasing readability due to less casting. Also this results in the
compiler warning:

	drivers/gpio/gpio-pxa.c: In function ‘pxa_gpio_nums’:
	drivers/gpio/gpio-pxa.c:537:38: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
	  537 |         struct pxa_gpio_id *pxa_id = id->driver_data_ptr;
	      |                                      ^~

which is a good thing as adding the needed const to fix this warning
improves type safety.

If you consider the last patch mostly churn, just drop it.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (3):
  gpio: cros-ec: Drop unused assignment of platform_device_id driver
    data
  gpio: Use named initializers for platform_device_id arrays
  gpio: max77620: Unify usage of space and comma in platform_device_id
    array

 drivers/gpio/gpio-adp5585.c   |  4 ++--
 drivers/gpio/gpio-bd72720.c   |  4 ++--
 drivers/gpio/gpio-bd9571mwv.c |  4 ++--
 drivers/gpio/gpio-cros-ec.c   |  4 ++--
 drivers/gpio/gpio-lp873x.c    |  2 +-
 drivers/gpio/gpio-lp87565.c   |  2 +-
 drivers/gpio/gpio-max77620.c  |  2 +-
 drivers/gpio/gpio-max77759.c  |  2 +-
 drivers/gpio/gpio-pxa.c       | 18 +++++++++---------
 drivers/gpio/gpio-tps65086.c  |  2 +-
 drivers/gpio/gpio-tps65218.c  |  2 +-
 drivers/gpio/gpio-tps65219.c  |  4 ++--
 drivers/gpio/gpio-tps65912.c  |  2 +-
 drivers/gpio/gpio-ts5500.c    |  8 ++++----
 14 files changed, 30 insertions(+), 30 deletions(-)

base-commit: e7e28506af98ce4e1059e5ec59334b335c00a246
-- 
2.47.3

