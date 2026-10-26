Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032203;
	b=JxKURTh0JB4tQOrFgJTPyyoNO9PA5VabcwS9bCh7Kqrwja0WsCNtELIYaZ/WSocGs8d0
	 1+xVTNVEj4YFh2iRFK85UQy3XgVAhnsfitIKoN2mhJIHwFBEVl1n5CWU4Jlps95maOaOA
	 f8Tx2HTAKug6WU+oy5X1pxBG5xacs/Ip/I2bRTTEzQaGSgh0cHuUg1y/jplycajgHmJnV
	 E5FnlGHSvLBmDrH8pXUaHjigPV6VmmvbUb3UdCR47qqoehRw0BQkwh3bbFTLRveBVYghI
	 orZIj/23dZ5wUoFl2MQmQ2X4CBJlQBPC11JSPvDtuqtWdLAQbo5y/u4PTMu+MGAy+cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=jWILgexA7XWv2SxTlD3qvn6SKAgv5vWCgflv/xy06MU=;
	b=Lw4OrJuGlFnqyIhiD8hXvJ2XywVb6PCnXa+C1xs6PdSd/HsbZqGJmj/H3LiwoSTgvxqN
	 2URZqAKpn8F+cznRvj1XcYcATlXKKD1SalY9cwiurWYgL4fO7xoj+oW7oDlLo11rxa+Mx
	 4It/7ITFe0Vc3CstearJ3tElbrUt5QcdmK+i2cmqDTQ7tgLMJRmp2Y8FKy844nPoABrRo
	 2TV+e9M9i1BrMn3n0Uo/+tQGNhZUtDJfYzGGNv0SUKJI5CE8JOWxKoJ/WOEvwwh/hYFrv
	 R0LNzr6lrQS8MV0SQVuKYqi/NsnyQQlOUeu75SsHqy20OLInJmEat+DbbBbgV0vyXCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JZuISPSW;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA7B606A33D
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 16:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CA7B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JZuISPSW
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so13869105e9.0
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793032199; x=1793636999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jWILgexA7XWv2SxTlD3qvn6SKAgv5vWCgflv/xy06MU=;
        b=JZuISPSW+7lAzjYpZTcULExF5DXtETOxKDslZGUEY58hjMkqqBU/cEIskCBVPyyzhj
         dbz/TEgjlsJ6dWi2OBuXQbCaqSvkSPQpC2Qk0x9lgs8FLGDFDbTyslKKvAnnYHWUf5+i
         Fzl/VQkFBq8EhSuMP6rMbhh4UAuYWi96QOaUkEufOA+5e2xt/10osCdd1sDs1oZkhi16
         eTTyQPAvGqI751VTOD/tOciqb7iPqfMC2NZ469+PaiZUcDBzUF55MayarLEXNQoTawBi
         jUa7N9rhjZLUUSuld07aGtzO7d95/4GwcHlfRuQPpFrxM06fNK/2Be26ErJ/Wf/NjnNo
         O6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032199; x=1793636999;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jWILgexA7XWv2SxTlD3qvn6SKAgv5vWCgflv/xy06MU=;
        b=Ylq4jnpHL19A0ar9Z/E2NVzrm0p6MVNy79u4NtWpGfBkAnH9eSyxeFX81cVX73EZ9N
         HgweqPiNVfMdzawWo0ecs6HJBchpXpy0J8MnS/d3GY8ecHXflTmuvzISETIMILth0TYX
         UY6SjU1RO2vLznzlE91lLQqJM0wSke9gORS7Qr28qoXQhKBIq7Z0ShcaeYCHT+Za+epP
         qn9XCVAFDjj1AAWw+IM6yIXiBoH16OgM5xPq7wYBVJvC+cohyC/nJ33axFSAqE0namAY
         fTDQHE5kd2+OERph9AaTo2bI/RJs63CIzXLSCIfABwm2oJBm72QO4UkPOGNeV+XMa8Gi
         CQtQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKP9+ugJ/yKOMoftfKDklxWCDHkvh5gd6F/KDr8wWloeDP8N8GNb3w+WlD9Aw2tWpqcKVsKbkZPGRL@vger.kernel.org
X-Gm-Message-State: AFq9FYJvU+oJ5iLQAl41y4zOtKARR66EJPmvc71KuXTCO3HLkm2Zz2L6
	WKDEWwlnXmG6jP1gIozNLi5xPj1h/oNJm+7RxFIUKSC2Xryxl9K0RWPhmJXw+58qil0=
X-Gm-Gg: AYBFou3TjASAKVUkS+t5gdfz+fx75Tuk2UINYEGvtINmrqMG0sIivU6SV87J1+vh0nZ
	wmyyjI4ALMB9clPePpLCYHkbXPoXeIdJXrYmsFwPTc3kRsmKZg0zA7Q8FrlRt2uoCUB3rNcSDuP
	s6fIWlNW9sTh6MdsBdHDgcGa9w7HdcMLk1OpryNPE3WEY1octppdHe4SzjOW1gbO4h/g23L4ZYT
	ic+wm0cb+EowR1C/Gonui42OiID9L3XPa2MOkXasfCw31NJxyTdQa+O6QDZyPMRRsTIEYSStpce
	OFk2H3QutOjh923/Fjx0fRZfzivxH22230H/rJc7PznnreR349VFjkfqMFpAjkj1R2kBGtGwqSw
	u5fRq4YNSYM1fJCBJr20gjIHnvvHO2suI/WBW+fpH1BkZUCcXoxP7OMMUkBDZiSqETle1peCA/W
	mpP4GFPiiMwYuqRQiOvu9aR7CFMnO4L73aEENWLgQKb71oP9SeGltiNq9BBJvkib1PVKMnlUqjD
	M3wZjKx/1v2edGzgE7/3VAsBo40i8EN3KWjj16wrHVBCmZNhrPOxcVv9nmuku+yE3G/FCtJTpaW
	B2APETGeypMOsQVPvXW+V8B/7mr6
X-Received: by 2002:a05:600c:c107:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4a5e70ca839mr57289365e9.31.1793032198756;
        Mon, 26 Oct 2026 09:29:58 -0700 (PDT)
Received: from localhost (p200300f65f19a904cbccaa7a4d73ac15.dip0.t-ipconnect.de. [2003:f6:5f19:a904:cbcc:aa7a:4d73:ac15])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a359ff2189sm242039135e9.1.2026.10.26.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:29:57 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	asahi@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	imx@lists.linux.dev,
	openbmc@lists.ozlabs.org,
	linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-unisoc@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 18/22] gpio: Unify style of of_device_id arrays
Date: Mon, 26 Oct 2026 17:28:29 +0100
Message-ID:  <600e39b6a1b7d76b9247c2651bc2d060a55fe633.1793030820.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
References: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=47074; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=AmQSNCZc3pUgbYHN5dv/7/QPZrp67GO5zJHpDpXN1pY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq33/Mk4u6FCdotHVT8H7zeleNcebDgZy7fp6gL MSdzrdsXPKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCat9/zAAKCRCPgPtYfRL+ TpcrCACan9/MDe1K+GmOea4WxLhjubbFDg9T0DJ+i86k+1h6wTx/UScuhNuQn4lqZywwug/iqc1 fG/9Hf0Wee/ZKGL1TX9PwcxCFpx9vR8f86/aU/u1/pai0D0LOy2cn5cRbTwAxSGm672Co31CIvw gHvbKplTVr9tUzRz9dQ4Wm0JmM9SdYjFF+NzNCK9UQiIIMkBo6AP3Vg+3npzi/lKogYdXxU6XQK eIItkoC1ALaK+yXeqm7R5htKyzNwEJsj6cJfOLDEtcbx7cBb3X6ojPFz20ggiGpMY3owbKkem7J Hk8t5Y0EcofP8CNkEwB+IdSiD/z6leaSE4sKw4rVKhnIHrHp
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Update the various of_device_id arrays to conform to the most used and
generally recommended coding style. That is:

 - no comma after the list terminator;
 - a comma after an initializer if (and only if) the closing } is not
   directly following;
 - no explicit zeros in the list terminator;
 - a space after an opening { and before a closing }, a single space in
   the list terminator;

Adapt the few offenders accordingly.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpio/gpio-74x164.c         |  2 +-
 drivers/gpio/gpio-adnp.c           |  4 ++--
 drivers/gpio/gpio-aggregator.c     |  2 +-
 drivers/gpio/gpio-altera-a10sr.c   |  2 +-
 drivers/gpio/gpio-altera.c         |  4 ++--
 drivers/gpio/gpio-aspeed-sgpio.c   | 10 +++++-----
 drivers/gpio/gpio-aspeed.c         | 10 +++++-----
 drivers/gpio/gpio-ath79.c          |  2 +-
 drivers/gpio/gpio-blzp1600.c       |  4 ++--
 drivers/gpio/gpio-brcmstb.c        |  2 +-
 drivers/gpio/gpio-cadence.c        |  6 +++---
 drivers/gpio/gpio-creg-snps.c      |  4 ++--
 drivers/gpio/gpio-davinci.c        |  8 ++++----
 drivers/gpio/gpio-dwapb.c          |  4 ++--
 drivers/gpio/gpio-em.c             |  4 ++--
 drivers/gpio/gpio-ftgpio010.c      |  2 +-
 drivers/gpio/gpio-grgpio.c         |  2 +-
 drivers/gpio/gpio-gw-pld.c         |  4 ++--
 drivers/gpio/gpio-hisi.c           |  2 +-
 drivers/gpio/gpio-hlwd.c           |  4 ++--
 drivers/gpio/gpio-ixp4xx.c         |  2 +-
 drivers/gpio/gpio-loongson-64bit.c |  2 +-
 drivers/gpio/gpio-lp3943.c         |  2 +-
 drivers/gpio/gpio-lpc32xx.c        |  4 ++--
 drivers/gpio/gpio-macsmc.c         |  4 ++--
 drivers/gpio/gpio-max7360.c        |  8 ++++----
 drivers/gpio/gpio-max77759.c       |  2 +-
 drivers/gpio/gpio-mm-lantiq.c      |  2 +-
 drivers/gpio/gpio-mockup.c         |  4 ++--
 drivers/gpio/gpio-moxtet.c         |  4 ++--
 drivers/gpio/gpio-mpc5200.c        |  8 ++++----
 drivers/gpio/gpio-mpc8xxx.c        | 22 +++++++++++-----------
 drivers/gpio/gpio-mt7621.c         |  2 +-
 drivers/gpio/gpio-mvebu.c          | 12 ++++++------
 drivers/gpio/gpio-mxc.c            |  2 +-
 drivers/gpio/gpio-mxs.c            |  4 ++--
 drivers/gpio/gpio-nomadik.c        |  6 +++---
 drivers/gpio/gpio-npcm-sgpio.c     |  6 +++---
 drivers/gpio/gpio-octeon.c         |  2 +-
 drivers/gpio/gpio-omap.c           |  2 +-
 drivers/gpio/gpio-palmas.c         | 10 +++++-----
 drivers/gpio/gpio-pca9570.c        |  2 +-
 drivers/gpio/gpio-pisosr.c         |  2 +-
 drivers/gpio/gpio-pmic-eic-sprd.c  |  2 +-
 drivers/gpio/gpio-pxa.c            | 18 +++++++++---------
 drivers/gpio/gpio-qixis-fpga.c     |  3 +--
 drivers/gpio/gpio-rcar.c           |  2 +-
 drivers/gpio/gpio-rda.c            |  2 +-
 drivers/gpio/gpio-realtek-otto.c   |  2 +-
 drivers/gpio/gpio-rockchip.c       |  4 ++--
 drivers/gpio/gpio-sama5d2-piobu.c  |  2 +-
 drivers/gpio/gpio-sifive.c         |  2 +-
 drivers/gpio/gpio-sl28cpld.c       |  2 +-
 drivers/gpio/gpio-spear-spics.c    |  2 +-
 drivers/gpio/gpio-sprd.c           |  2 +-
 drivers/gpio/gpio-stmpe.c          |  2 +-
 drivers/gpio/gpio-stp-xway.c       |  2 +-
 drivers/gpio/gpio-tegra.c          |  6 +++---
 drivers/gpio/gpio-tegra186.c       | 30 +++++++++++++++---------------
 drivers/gpio/gpio-tps65218.c       |  2 +-
 drivers/gpio/gpio-ts4800.c         |  4 ++--
 drivers/gpio/gpio-ts4900.c         |  2 +-
 drivers/gpio/gpio-twl4030.c        |  4 ++--
 drivers/gpio/gpio-vf610.c          |  4 ++--
 drivers/gpio/gpio-visconti.c       |  2 +-
 drivers/gpio/gpio-waveshare-dsi.c  |  2 +-
 drivers/gpio/gpio-xgene-sb.c       |  2 +-
 drivers/gpio/gpio-xgene.c          |  4 ++--
 drivers/gpio/gpio-xgs-iproc.c      |  2 +-
 drivers/gpio/gpio-xilinx.c         |  4 ++--
 drivers/gpio/gpio-xra1403.c        |  2 +-
 drivers/gpio/gpio-zevio.c          |  4 ++--
 drivers/gpio/gpio-zynqmp-modepin.c |  2 +-
 73 files changed, 159 insertions(+), 160 deletions(-)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index 5ca61cf5206a..eeed612e7c80 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -189,7 +189,7 @@ MODULE_DEVICE_TABLE(spi, gen_74x164_spi_ids);
 static const struct of_device_id gen_74x164_dt_ids[] = {
 	{ .compatible = "fairchild,74hc595" },
 	{ .compatible = "nxp,74lvc594" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, gen_74x164_dt_ids);
 
diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index 0410e3adbf54..4b5825a49a08 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -506,8 +506,8 @@ static const struct i2c_device_id adnp_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, adnp_i2c_id);
 
 static const struct of_device_id adnp_of_match[] = {
-	{ .compatible = "ad,gpio-adnp", },
-	{ },
+	{ .compatible = "ad,gpio-adnp" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adnp_of_match);
 
diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index b0b65416d74d..e79ba562a8ce 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -1651,7 +1651,7 @@ static const struct of_device_id gpio_aggregator_dt_ids[] = {
 	 * Add GPIO-operated devices controlled from userspace below,
 	 * or use "driver_override" in sysfs.
 	 */
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, gpio_aggregator_dt_ids);
 
diff --git a/drivers/gpio/gpio-altera-a10sr.c b/drivers/gpio/gpio-altera-a10sr.c
index a41e5575ee37..2b06315abe74 100644
--- a/drivers/gpio/gpio-altera-a10sr.c
+++ b/drivers/gpio/gpio-altera-a10sr.c
@@ -96,7 +96,7 @@ static int altr_a10sr_gpio_probe(struct platform_device *pdev)
 
 static const struct of_device_id altr_a10sr_gpio_of_match[] = {
 	{ .compatible = "altr,a10sr-gpio" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, altr_a10sr_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index a6ac9356229c..ec3dea89d1bb 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -260,8 +260,8 @@ static int altera_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id altera_gpio_of_match[] = {
-	{ .compatible = "altr,pio-1.0", },
-	{},
+	{ .compatible = "altr,pio-1.0" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, altera_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 4225261f61c8..fbde74be8a80 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -594,11 +594,11 @@ static const struct aspeed_sgpio_pdata ast2700_sgpiom_pdata = {
 };
 
 static const struct of_device_id aspeed_sgpio_of_table[] = {
-	{ .compatible = "aspeed,ast2400-sgpio", .data = &ast2400_sgpio_pdata, },
-	{ .compatible = "aspeed,ast2500-sgpio", .data = &ast2400_sgpio_pdata, },
-	{ .compatible = "aspeed,ast2600-sgpiom", .data = &ast2600_sgpiom_pdata, },
-	{ .compatible = "aspeed,ast2700-sgpiom", .data = &ast2700_sgpiom_pdata, },
-	{}
+	{ .compatible = "aspeed,ast2400-sgpio", .data = &ast2400_sgpio_pdata },
+	{ .compatible = "aspeed,ast2500-sgpio", .data = &ast2400_sgpio_pdata },
+	{ .compatible = "aspeed,ast2600-sgpiom", .data = &ast2600_sgpiom_pdata },
+	{ .compatible = "aspeed,ast2700-sgpiom", .data = &ast2700_sgpiom_pdata },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, aspeed_sgpio_of_table);
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index dc53b2decb66..1a7fc65d6279 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1292,11 +1292,11 @@ static const struct aspeed_gpio_config ast2700_config =
 	};
 
 static const struct of_device_id aspeed_gpio_of_table[] = {
-	{ .compatible = "aspeed,ast2400-gpio", .data = &ast2400_config, },
-	{ .compatible = "aspeed,ast2500-gpio", .data = &ast2500_config, },
-	{ .compatible = "aspeed,ast2600-gpio", .data = &ast2600_config, },
-	{ .compatible = "aspeed,ast2700-gpio", .data = &ast2700_config, },
-	{}
+	{ .compatible = "aspeed,ast2400-gpio", .data = &ast2400_config },
+	{ .compatible = "aspeed,ast2500-gpio", .data = &ast2500_config },
+	{ .compatible = "aspeed,ast2600-gpio", .data = &ast2600_config },
+	{ .compatible = "aspeed,ast2700-gpio", .data = &ast2700_config },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
 
diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index aa37579c9608..5270f9121749 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -210,7 +210,7 @@ static void ath79_gpio_irq_handler(struct irq_desc *desc)
 static const struct of_device_id ath79_gpio_of_match[] = {
 	{ .compatible = "qca,ar7100-gpio" },
 	{ .compatible = "qca,ar9340-gpio" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ath79_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-blzp1600.c b/drivers/gpio/gpio-blzp1600.c
index 0f8c826ba876..b8d07a9b4a68 100644
--- a/drivers/gpio/gpio-blzp1600.c
+++ b/drivers/gpio/gpio-blzp1600.c
@@ -270,8 +270,8 @@ static int blzp1600_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id blzp1600_gpio_of_match[] = {
-	{ .compatible = "blaize,blzp1600-gpio", },
-	{ /* Sentinel */ },
+	{ .compatible = "blaize,blzp1600-gpio" },
+	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, blzp1600_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 44ca798cf832..60dec669ca67 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -787,7 +787,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 
 static const struct of_device_id brcmstb_gpio_of_match[] = {
 	{ .compatible = "brcm,brcmstb-gpio" },
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, brcmstb_gpio_of_match);
diff --git a/drivers/gpio/gpio-cadence.c b/drivers/gpio/gpio-cadence.c
index d7790fc35c22..a71747cef51c 100644
--- a/drivers/gpio/gpio-cadence.c
+++ b/drivers/gpio/gpio-cadence.c
@@ -170,13 +170,13 @@ static const struct irq_chip cdns_gpio_irqchip = {
 static const struct of_device_id cdns_of_ids[] = {
 	{
 		.compatible = "axiado,ax3000-gpio",
-		.data = &ax3000_gpio_quirks
+		.data = &ax3000_gpio_quirks,
 	},
 	{
 		.compatible = "cdns,gpio-r1p02",
-		.data = &cdns_default_quirks
+		.data = &cdns_default_quirks,
 	},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, cdns_of_ids);
 
diff --git a/drivers/gpio/gpio-creg-snps.c b/drivers/gpio/gpio-creg-snps.c
index 2e159ea41791..6834191d9294 100644
--- a/drivers/gpio/gpio-creg-snps.c
+++ b/drivers/gpio/gpio-creg-snps.c
@@ -125,10 +125,10 @@ static const struct creg_layout axs10x_flsh_cs_ctl = {
 static const struct of_device_id creg_gpio_ids[] = {
 	{
 		.compatible = "snps,creg-gpio-axs10x",
-		.data = &axs10x_flsh_cs_ctl
+		.data = &axs10x_flsh_cs_ctl,
 	}, {
 		.compatible = "snps,creg-gpio-hsdk",
-		.data = &hsdk_cs_ctl
+		.data = &hsdk_cs_ctl,
 	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, creg_gpio_ids);
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index fc2b9bef7efc..f7c3b644e0e3 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -668,10 +668,10 @@ static DEFINE_SIMPLE_DEV_PM_OPS(davinci_gpio_dev_pm_ops, davinci_gpio_suspend,
 			 davinci_gpio_resume);
 
 static const struct of_device_id davinci_gpio_ids[] = {
-	{ .compatible = "ti,keystone-gpio", keystone_gpio_get_irq_chip},
-	{ .compatible = "ti,am654-gpio", keystone_gpio_get_irq_chip},
-	{ .compatible = "ti,dm6441-gpio", davinci_gpio_get_irq_chip},
-	{ /* sentinel */ },
+	{ .compatible = "ti,keystone-gpio", .data = keystone_gpio_get_irq_chip },
+	{ .compatible = "ti,am654-gpio", .data = keystone_gpio_get_irq_chip },
+	{ .compatible = "ti,dm6441-gpio", .data = davinci_gpio_get_irq_chip },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, davinci_gpio_ids);
 
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 3b24daabcf0f..8a5791a4a77e 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -713,8 +713,8 @@ static int dwapb_get_clks(struct dwapb_gpio *gpio)
 }
 
 static const struct of_device_id dwapb_of_match[] = {
-	{ .compatible = "snps,dw-apb-gpio", .data = (void *)GPIO_REG_OFFSET_V1},
-	{ .compatible = "apm,xgene-gpio-v2", .data = (void *)GPIO_REG_OFFSET_V2},
+	{ .compatible = "snps,dw-apb-gpio", .data = (void *)GPIO_REG_OFFSET_V1 },
+	{ .compatible = "apm,xgene-gpio-v2", .data = (void *)GPIO_REG_OFFSET_V2 },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dwapb_of_match);
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index a214b0672726..b660a0c7cfc8 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -357,8 +357,8 @@ static int em_gio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id em_gio_dt_ids[] = {
-	{ .compatible = "renesas,em-gio", },
-	{},
+	{ .compatible = "renesas,em-gio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, em_gio_dt_ids);
 
diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index e29df8d5e571..da30e3d927b9 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -321,7 +321,7 @@ static const struct of_device_id ftgpio_gpio_of_match[] = {
 	{
 		.compatible = "faraday,ftgpio010",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ftgpio_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index e4fa84e22726..fbbe201cce4c 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -444,7 +444,7 @@ static int grgpio_probe(struct platform_device *ofdev)
 static const struct of_device_id grgpio_match[] = {
 	{.name = "GAISLER_GPIO"},
 	{.name = "01_01a"},
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, grgpio_match);
diff --git a/drivers/gpio/gpio-gw-pld.c b/drivers/gpio/gpio-gw-pld.c
index bf1f91c3c4a8..96a7e11ff667 100644
--- a/drivers/gpio/gpio-gw-pld.c
+++ b/drivers/gpio/gpio-gw-pld.c
@@ -115,8 +115,8 @@ static const struct i2c_device_id gw_pld_id[] = {
 MODULE_DEVICE_TABLE(i2c, gw_pld_id);
 
 static const struct of_device_id gw_pld_dt_ids[] = {
-	{ .compatible = "gateworks,pld-gpio", },
-	{ },
+	{ .compatible = "gateworks,pld-gpio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, gw_pld_dt_ids);
 
diff --git a/drivers/gpio/gpio-hisi.c b/drivers/gpio/gpio-hisi.c
index f03df71e3296..b75b52607711 100644
--- a/drivers/gpio/gpio-hisi.c
+++ b/drivers/gpio/gpio-hisi.c
@@ -228,7 +228,7 @@ static const struct acpi_device_id hisi_gpio_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, hisi_gpio_acpi_match);
 
 static const struct of_device_id hisi_gpio_dts_match[] = {
-	{ .compatible = "hisilicon,ascend910-gpio", },
+	{ .compatible = "hisilicon,ascend910-gpio" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hisi_gpio_dts_match);
diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
index 043ce5ef3b07..663a8d05719a 100644
--- a/drivers/gpio/gpio-hlwd.c
+++ b/drivers/gpio/gpio-hlwd.c
@@ -303,8 +303,8 @@ static int hlwd_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id hlwd_gpio_match[] = {
-	{ .compatible = "nintendo,hollywood-gpio", },
-	{},
+	{ .compatible = "nintendo,hollywood-gpio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hlwd_gpio_match);
 
diff --git a/drivers/gpio/gpio-ixp4xx.c b/drivers/gpio/gpio-ixp4xx.c
index 88d48cfc9017..e791ba19928a 100644
--- a/drivers/gpio/gpio-ixp4xx.c
+++ b/drivers/gpio/gpio-ixp4xx.c
@@ -339,7 +339,7 @@ static const struct of_device_id ixp4xx_gpio_of_match[] = {
 	{
 		.compatible = "intel,ixp4xx-gpio",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ixp4xx_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-loongson-64bit.c b/drivers/gpio/gpio-loongson-64bit.c
index d76c3cf177d1..edcff2fa8adc 100644
--- a/drivers/gpio/gpio-loongson-64bit.c
+++ b/drivers/gpio/gpio-loongson-64bit.c
@@ -519,7 +519,7 @@ static const struct of_device_id loongson_gpio_of_match[] = {
 		.compatible = "loongson,ls3a6000-gpio",
 		.data = &loongson_gpio_ls3a6000_data,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, loongson_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-lp3943.c b/drivers/gpio/gpio-lp3943.c
index e8e00daff7df..ab84f83aec86 100644
--- a/drivers/gpio/gpio-lp3943.c
+++ b/drivers/gpio/gpio-lp3943.c
@@ -209,7 +209,7 @@ static int lp3943_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id lp3943_gpio_of_match[] = {
-	{ .compatible = "ti,lp3943-gpio", },
+	{ .compatible = "ti,lp3943-gpio" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, lp3943_gpio_of_match);
diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
index 7fb46262e18c..dfa18058abf4 100644
--- a/drivers/gpio/gpio-lpc32xx.c
+++ b/drivers/gpio/gpio-lpc32xx.c
@@ -535,8 +535,8 @@ static int lpc32xx_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id lpc32xx_gpio_of_match[] = {
-	{ .compatible = "nxp,lpc3220-gpio", },
-	{ },
+	{ .compatible = "nxp,lpc3220-gpio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lpc32xx_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-macsmc.c b/drivers/gpio/gpio-macsmc.c
index b0952d066a9d..4afc73da2bee 100644
--- a/drivers/gpio/gpio-macsmc.c
+++ b/drivers/gpio/gpio-macsmc.c
@@ -274,8 +274,8 @@ static int macsmc_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id macsmc_gpio_of_table[] = {
-	{ .compatible = "apple,smc-gpio", },
-	{}
+	{ .compatible = "apple,smc-gpio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, macsmc_gpio_of_table);
 
diff --git a/drivers/gpio/gpio-max7360.c b/drivers/gpio/gpio-max7360.c
index 6755d58c4534..d3bc5f29e099 100644
--- a/drivers/gpio/gpio-max7360.c
+++ b/drivers/gpio/gpio-max7360.c
@@ -234,12 +234,12 @@ static int max7360_gpio_probe(struct platform_device *pdev)
 static const struct of_device_id max7360_gpio_of_match[] = {
 	{
 		.compatible = "maxim,max7360-gpo",
-		.data = &max7360_gpio_col_plat
+		.data = &max7360_gpio_col_plat,
 	}, {
 		.compatible = "maxim,max7360-gpio",
-		.data = &max7360_gpio_port_plat
-	}, {
-	}
+		.data = &max7360_gpio_port_plat,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max7360_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-max77759.c b/drivers/gpio/gpio-max77759.c
index da3c77dd574e..b2259d875751 100644
--- a/drivers/gpio/gpio-max77759.c
+++ b/drivers/gpio/gpio-max77759.c
@@ -495,7 +495,7 @@ static int max77759_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id max77759_gpio_of_id[] = {
-	{ .compatible = "maxim,max77759-gpio", },
+	{ .compatible = "maxim,max77759-gpio" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max77759_gpio_of_id);
diff --git a/drivers/gpio/gpio-mm-lantiq.c b/drivers/gpio/gpio-mm-lantiq.c
index 1bd98c50a459..f48dc24151b1 100644
--- a/drivers/gpio/gpio-mm-lantiq.c
+++ b/drivers/gpio/gpio-mm-lantiq.c
@@ -134,7 +134,7 @@ static int ltq_mm_probe(struct platform_device *pdev)
 
 static const struct of_device_id ltq_mm_match[] = {
 	{ .compatible = "lantiq,gpio-mm" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ltq_mm_match);
 
diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 1c6a2f3414f1..c26a97f8deac 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -487,8 +487,8 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id gpio_mockup_of_match[] = {
-	{ .compatible = "gpio-mockup", },
-	{},
+	{ .compatible = "gpio-mockup" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, gpio_mockup_of_match);
 
diff --git a/drivers/gpio/gpio-moxtet.c b/drivers/gpio/gpio-moxtet.c
index 4eb9f1a2779b..d87e9f4bd037 100644
--- a/drivers/gpio/gpio-moxtet.c
+++ b/drivers/gpio/gpio-moxtet.c
@@ -152,8 +152,8 @@ static int moxtet_gpio_probe(struct device *dev)
 }
 
 static const struct of_device_id moxtet_gpio_dt_ids[] = {
-	{ .compatible = "cznic,moxtet-gpio", },
-	{},
+	{ .compatible = "cznic,moxtet-gpio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, moxtet_gpio_dt_ids);
 
diff --git a/drivers/gpio/gpio-mpc5200.c b/drivers/gpio/gpio-mpc5200.c
index 2c828bc922ae..aa5d210882b0 100644
--- a/drivers/gpio/gpio-mpc5200.c
+++ b/drivers/gpio/gpio-mpc5200.c
@@ -177,8 +177,8 @@ static int mpc52xx_wkup_gpiochip_probe(struct platform_device *ofdev)
 }
 
 static const struct of_device_id mpc52xx_wkup_gpiochip_match[] = {
-	{ .compatible = "fsl,mpc5200-gpio-wkup", },
-	{}
+	{ .compatible = "fsl,mpc5200-gpio-wkup" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mpc52xx_wkup_gpiochip_match);
 
@@ -340,8 +340,8 @@ static int mpc52xx_simple_gpiochip_probe(struct platform_device *ofdev)
 }
 
 static const struct of_device_id mpc52xx_simple_gpiochip_match[] = {
-	{ .compatible = "fsl,mpc5200-gpio", },
-	{}
+	{ .compatible = "fsl,mpc5200-gpio" },
+	{ }
 };
 
 static struct platform_driver mpc52xx_simple_gpiochip_driver = {
diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index e79312a7d5a4..fb280d87c578 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -306,17 +306,17 @@ static const struct mpc8xxx_gpio_devtype mpc8xxx_gpio_devtype_default = {
 };
 
 static const struct of_device_id mpc8xxx_gpio_ids[] = {
-	{ .compatible = "fsl,mpc8314-gpio", },
-	{ .compatible = "fsl,mpc8349-gpio", },
-	{ .compatible = "fsl,mpc8572-gpio", .data = &mpc8572_gpio_devtype, },
-	{ .compatible = "fsl,mpc8610-gpio", },
-	{ .compatible = "fsl,mpc5121-gpio", .data = &mpc512x_gpio_devtype, },
-	{ .compatible = "fsl,mpc5125-gpio", .data = &mpc5125_gpio_devtype, },
-	{ .compatible = "fsl,pq3-gpio",     },
-	{ .compatible = "fsl,ls1028a-gpio", },
-	{ .compatible = "fsl,ls1088a-gpio", },
-	{ .compatible = "fsl,qoriq-gpio",   },
-	{}
+	{ .compatible = "fsl,mpc8314-gpio" },
+	{ .compatible = "fsl,mpc8349-gpio" },
+	{ .compatible = "fsl,mpc8572-gpio", .data = &mpc8572_gpio_devtype },
+	{ .compatible = "fsl,mpc8610-gpio" },
+	{ .compatible = "fsl,mpc5121-gpio", .data = &mpc512x_gpio_devtype },
+	{ .compatible = "fsl,mpc5125-gpio", .data = &mpc5125_gpio_devtype },
+	{ .compatible = "fsl,pq3-gpio" },
+	{ .compatible = "fsl,ls1028a-gpio" },
+	{ .compatible = "fsl,ls1088a-gpio" },
+	{ .compatible = "fsl,qoriq-gpio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mpc8xxx_gpio_ids);
 
diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index a86f6b1060fc..f0c85a5a38b4 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -487,7 +487,7 @@ mt7621_gpio_probe(struct platform_device *pdev)
 
 static const struct of_device_id mt7621_gpio_match[] = {
 	{ .compatible = "mediatek,mt7621-gpio" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mt7621_gpio_match);
 
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index d433b8a9e230..2e015667ef43 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -971,27 +971,27 @@ static void mvebu_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 static const struct of_device_id mvebu_gpio_of_match[] = {
 	{
 		.compatible = "marvell,orion-gpio",
-		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_ORION,
+		.data	    = (void *)MVEBU_GPIO_SOC_VARIANT_ORION,
 	},
 	{
 		.compatible = "marvell,mv78200-gpio",
-		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_MV78200,
+		.data	    = (void *)MVEBU_GPIO_SOC_VARIANT_MV78200,
 	},
 	{
 		.compatible = "marvell,armadaxp-gpio",
-		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_ARMADAXP,
+		.data	    = (void *)MVEBU_GPIO_SOC_VARIANT_ARMADAXP,
 	},
 	{
 		.compatible = "marvell,armada-370-gpio",
-		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_ORION,
+		.data	    = (void *)MVEBU_GPIO_SOC_VARIANT_ORION,
 	},
 	{
 		.compatible = "marvell,armada-8k-gpio",
-		.data       = (void *) MVEBU_GPIO_SOC_VARIANT_A8K,
+		.data	    = (void *)MVEBU_GPIO_SOC_VARIANT_A8K,
 	},
 	{
 		/* sentinel */
-	},
+	}
 };
 MODULE_DEVICE_TABLE(of, mvebu_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 32ded7b548fb..2e61fd79edbe 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -139,7 +139,7 @@ static struct mxc_gpio_hwdata imx35_gpio_hwdata = {
 #define GPIO_INT_BOTH_EDGES	0x4
 
 static const struct of_device_id mxc_gpio_dt_ids[] = {
-	{ .compatible = "fsl,imx1-gpio", .data =  &imx1_imx21_gpio_hwdata },
+	{ .compatible = "fsl,imx1-gpio", .data = &imx1_imx21_gpio_hwdata },
 	{ .compatible = "fsl,imx21-gpio", .data = &imx1_imx21_gpio_hwdata },
 	{ .compatible = "fsl,imx31-gpio", .data = &imx31_gpio_hwdata },
 	{ .compatible = "fsl,imx35-gpio", .data = &imx35_gpio_hwdata },
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 900315aba85a..c6172010c5c6 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -250,8 +250,8 @@ static int mxs_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 }
 
 static const struct of_device_id mxs_gpio_dt_ids[] = {
-	{ .compatible = "fsl,imx23-gpio", .data = (void *) IMX23_GPIO, },
-	{ .compatible = "fsl,imx28-gpio", .data = (void *) IMX28_GPIO, },
+	{ .compatible = "fsl,imx23-gpio", .data = (void *)IMX23_GPIO },
+	{ .compatible = "fsl,imx28-gpio", .data = (void *)IMX28_GPIO },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxs_gpio_dt_ids);
diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 90293329b40b..32390bc00649 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -715,9 +715,9 @@ static int nmk_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id nmk_gpio_match[] = {
-	{ .compatible = "st,nomadik-gpio", },
-	{ .compatible = "mobileye,eyeq5-gpio", },
-	{}
+	{ .compatible = "st,nomadik-gpio" },
+	{ .compatible = "mobileye,eyeq5-gpio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, nmk_gpio_match);
 
diff --git a/drivers/gpio/gpio-npcm-sgpio.c b/drivers/gpio/gpio-npcm-sgpio.c
index 83c77a2c0623..99f57bcf2b9c 100644
--- a/drivers/gpio/gpio-npcm-sgpio.c
+++ b/drivers/gpio/gpio-npcm-sgpio.c
@@ -596,9 +596,9 @@ static const struct npcm_clk_cfg npcm845_sgpio_pdata = {
 };
 
 static const struct of_device_id npcm_sgpio_of_table[] = {
-	{ .compatible = "nuvoton,npcm750-sgpio", .data = &npcm750_sgpio_pdata, },
-	{ .compatible = "nuvoton,npcm845-sgpio", .data = &npcm845_sgpio_pdata, },
-	{}
+	{ .compatible = "nuvoton,npcm750-sgpio", .data = &npcm750_sgpio_pdata },
+	{ .compatible = "nuvoton,npcm845-sgpio", .data = &npcm845_sgpio_pdata },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, npcm_sgpio_of_table);
 
diff --git a/drivers/gpio/gpio-octeon.c b/drivers/gpio/gpio-octeon.c
index 777e20c608dc..2854443226b7 100644
--- a/drivers/gpio/gpio-octeon.c
+++ b/drivers/gpio/gpio-octeon.c
@@ -121,7 +121,7 @@ static const struct of_device_id octeon_gpio_match[] = {
 	{
 		.compatible = "cavium,octeon-3860-gpio",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, octeon_gpio_match);
 
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index a9b9a3d9631e..fa7a18d37e91 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1383,7 +1383,7 @@ static const struct of_device_id omap_gpio_match[] = {
 		.compatible = "ti,omap2-gpio",
 		.data = &omap2_pdata,
 	},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, omap_gpio_match);
 
diff --git a/drivers/gpio/gpio-palmas.c b/drivers/gpio/gpio-palmas.c
index e64ee0487718..ebf2a29d8210 100644
--- a/drivers/gpio/gpio-palmas.c
+++ b/drivers/gpio/gpio-palmas.c
@@ -151,11 +151,11 @@ static const struct palmas_device_data tps80036_dev_data = {
 };
 
 static const struct of_device_id of_palmas_gpio_match[] = {
-	{ .compatible = "ti,palmas-gpio", .data = &palmas_dev_data,},
-	{ .compatible = "ti,tps65913-gpio", .data = &palmas_dev_data,},
-	{ .compatible = "ti,tps65914-gpio", .data = &palmas_dev_data,},
-	{ .compatible = "ti,tps80036-gpio", .data = &tps80036_dev_data,},
-	{ },
+	{ .compatible = "ti,palmas-gpio", .data = &palmas_dev_data },
+	{ .compatible = "ti,tps65913-gpio", .data = &palmas_dev_data },
+	{ .compatible = "ti,tps65914-gpio", .data = &palmas_dev_data },
+	{ .compatible = "ti,tps80036-gpio", .data = &tps80036_dev_data },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_palmas_gpio_match);
 
diff --git a/drivers/gpio/gpio-pca9570.c b/drivers/gpio/gpio-pca9570.c
index db027c10494f..8f4f97d723fd 100644
--- a/drivers/gpio/gpio-pca9570.c
+++ b/drivers/gpio/gpio-pca9570.c
@@ -171,7 +171,7 @@ static const struct i2c_device_id pca9570_id_table[] = {
 MODULE_DEVICE_TABLE(i2c, pca9570_id_table);
 
 static const struct of_device_id pca9570_of_match_table[] = {
-	{ .compatible = "dlg,slg7xl45106", .data = &slg7xl45106_gpio},
+	{ .compatible = "dlg,slg7xl45106", .data = &slg7xl45106_gpio },
 	{ .compatible = "nxp,pca9570", .data = &pca9570_gpio },
 	{ .compatible = "nxp,pca9571", .data = &pca9571_gpio },
 	{ /* sentinel */ }
diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index 75a8f3efaf94..bb533070f46b 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -156,7 +156,7 @@ static const struct spi_device_id pisosr_gpio_id_table[] = {
 MODULE_DEVICE_TABLE(spi, pisosr_gpio_id_table);
 
 static const struct of_device_id pisosr_gpio_of_match_table[] = {
-	{ .compatible = "pisosr-gpio", },
+	{ .compatible = "pisosr-gpio" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, pisosr_gpio_of_match_table);
diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index cb015fb5c946..8012ca4299f6 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -362,7 +362,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sprd_pmic_eic_of_match[] = {
-	{ .compatible = "sprd,sc2731-eic", },
+	{ .compatible = "sprd,sc2731-eic" },
 	{ /* end of list */ }
 };
 MODULE_DEVICE_TABLE(of, sprd_pmic_eic_of_match);
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index d241fd4c3d31..ac117abf0b52 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -573,15 +573,15 @@ static const struct irq_domain_ops pxa_irq_domain_ops = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id pxa_gpio_dt_ids[] = {
-	{ .compatible = "intel,pxa25x-gpio",	.data = &pxa25x_id, },
-	{ .compatible = "intel,pxa26x-gpio",	.data = &pxa26x_id, },
-	{ .compatible = "intel,pxa27x-gpio",	.data = &pxa27x_id, },
-	{ .compatible = "intel,pxa3xx-gpio",	.data = &pxa3xx_id, },
-	{ .compatible = "marvell,pxa93x-gpio",	.data = &pxa93x_id, },
-	{ .compatible = "marvell,mmp-gpio",	.data = &mmp_id, },
-	{ .compatible = "marvell,mmp2-gpio",	.data = &mmp2_id, },
-	{ .compatible = "marvell,pxa1928-gpio",	.data = &pxa1928_id, },
-	{}
+	{ .compatible = "intel,pxa25x-gpio",	.data = &pxa25x_id },
+	{ .compatible = "intel,pxa26x-gpio",	.data = &pxa26x_id },
+	{ .compatible = "intel,pxa27x-gpio",	.data = &pxa27x_id },
+	{ .compatible = "intel,pxa3xx-gpio",	.data = &pxa3xx_id },
+	{ .compatible = "marvell,pxa93x-gpio",	.data = &pxa93x_id },
+	{ .compatible = "marvell,mmp-gpio",	.data = &mmp_id },
+	{ .compatible = "marvell,mmp2-gpio",	.data = &mmp2_id },
+	{ .compatible = "marvell,pxa1928-gpio",	.data = &pxa1928_id },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pxa_gpio_dt_ids);
 
diff --git a/drivers/gpio/gpio-qixis-fpga.c b/drivers/gpio/gpio-qixis-fpga.c
index b590572ac2bd..00bef538f94f 100644
--- a/drivers/gpio/gpio-qixis-fpga.c
+++ b/drivers/gpio/gpio-qixis-fpga.c
@@ -91,8 +91,7 @@ static const struct of_device_id qixis_cpld_gpio_of_match[] = {
 		.compatible = "fsl,ls1046aqds-fpga-gpio-stat-pres2",
 		.data = &ls1046aqds_stat_pres2_cfg,
 	},
-
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, qixis_cpld_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 54dc47d45de7..88ce42399b2b 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -493,7 +493,7 @@ static const struct of_device_id gpio_rcar_of_table[] = {
 		.data = &gpio_rcar_info_gen1,
 	}, {
 		/* Terminator */
-	},
+	}
 };
 
 MODULE_DEVICE_TABLE(of, gpio_rcar_of_table);
diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
index f6c05fdbe63f..b2ab9572434d 100644
--- a/drivers/gpio/gpio-rda.c
+++ b/drivers/gpio/gpio-rda.c
@@ -280,7 +280,7 @@ static int rda_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rda_gpio_of_match[] = {
-	{ .compatible = "rda,8810pl-gpio", },
+	{ .compatible = "rda,8810pl-gpio" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rda_gpio_of_match);
diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek-otto.c
index 5d98ad597d9e..46ded0e22882 100644
--- a/drivers/gpio/gpio-realtek-otto.c
+++ b/drivers/gpio/gpio-realtek-otto.c
@@ -356,7 +356,7 @@ static const struct of_device_id realtek_gpio_of_match[] = {
 		.compatible = "realtek,rtl9607-gpio",
 		.data = (void *)GPIO_PORTS_REVERSED,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, realtek_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 77b239a9a601..0f46ff095a24 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -806,9 +806,9 @@ static void rockchip_gpio_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id rockchip_gpio_match[] = {
-	{ .compatible = "rockchip,gpio-bank", },
+	{ .compatible = "rockchip,gpio-bank" },
 	{ .compatible = "rockchip,rk3188-gpio-bank0" },
-	{ },
+	{ }
 };
 
 static struct platform_driver rockchip_gpio_driver = {
diff --git a/drivers/gpio/gpio-sama5d2-piobu.c b/drivers/gpio/gpio-sama5d2-piobu.c
index 5005688f6e67..ab8655e9a518 100644
--- a/drivers/gpio/gpio-sama5d2-piobu.c
+++ b/drivers/gpio/gpio-sama5d2-piobu.c
@@ -228,7 +228,7 @@ static int sama5d2_piobu_probe(struct platform_device *pdev)
 
 static const struct of_device_id sama5d2_piobu_ids[] = {
 	{ .compatible = "atmel,sama5d2-secumod" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sama5d2_piobu_ids);
 
diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index e9a992cd4b9c..5b719b9f7650 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -258,7 +258,7 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 static const struct of_device_id sifive_gpio_match[] = {
 	{ .compatible = "sifive,gpio0" },
 	{ .compatible = "sifive,fu540-c000-gpio" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sifive_gpio_match);
 
diff --git a/drivers/gpio/gpio-sl28cpld.c b/drivers/gpio/gpio-sl28cpld.c
index ca7a9b9bcf48..ac9cf23a865f 100644
--- a/drivers/gpio/gpio-sl28cpld.c
+++ b/drivers/gpio/gpio-sl28cpld.c
@@ -141,7 +141,7 @@ static const struct of_device_id sl28cpld_gpio_of_match[] = {
 	{ .compatible = "kontron,sl28cpld-gpio", .data = (void *)SL28CPLD_GPIO },
 	{ .compatible = "kontron,sl28cpld-gpi", .data = (void *)SL28CPLD_GPI },
 	{ .compatible = "kontron,sl28cpld-gpo", .data = (void *)SL28CPLD_GPO },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sl28cpld_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-spear-spics.c b/drivers/gpio/gpio-spear-spics.c
index 3099deb2b290..6df67b6bdf34 100644
--- a/drivers/gpio/gpio-spear-spics.c
+++ b/drivers/gpio/gpio-spear-spics.c
@@ -155,7 +155,7 @@ static int spics_gpio_probe(struct platform_device *pdev)
 
 static const struct of_device_id spics_gpio_of_match[] = {
 	{ .compatible = "st,spear-spics-gpio" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, spics_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index 042a83f60eaa..7ddbe0eb500d 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -261,7 +261,7 @@ static int sprd_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sprd_gpio_of_match[] = {
-	{ .compatible = "sprd,sc9860-gpio", },
+	{ .compatible = "sprd,sc9860-gpio" },
 	{ /* end of list */ }
 };
 MODULE_DEVICE_TABLE(of, sprd_gpio_of_match);
diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index ccdf13a741b7..31317ddf1982 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -533,7 +533,7 @@ static int stmpe_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id stmpe_gpio_of_matches[] = {
-	{ .compatible = "st,stmpe-gpio", },
+	{ .compatible = "st,stmpe-gpio" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, stmpe_gpio_of_matches);
diff --git a/drivers/gpio/gpio-stp-xway.c b/drivers/gpio/gpio-stp-xway.c
index 78d6c78d4aab..37c480c1f031 100644
--- a/drivers/gpio/gpio-stp-xway.c
+++ b/drivers/gpio/gpio-stp-xway.c
@@ -315,7 +315,7 @@ static int xway_stp_probe(struct platform_device *pdev)
 
 static const struct of_device_id xway_stp_match[] = {
 	{ .compatible = "lantiq,gpio-stp-xway" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, xway_stp_match);
 
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index ccda3a56d599..98b393f6dfec 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -669,8 +669,8 @@ static const struct dev_pm_ops tegra_gpio_pm_ops = {
 };
 
 static const struct of_device_id tegra_pmc_of_match[] = {
-	{ .compatible = "nvidia,tegra210-pmc", },
-	{ /* sentinel */ },
+	{ .compatible = "nvidia,tegra210-pmc" },
+	{ /* sentinel */ }
 };
 
 static int tegra_gpio_probe(struct platform_device *pdev)
@@ -808,7 +808,7 @@ static const struct of_device_id tegra_gpio_of_match[] = {
 	{ .compatible = "nvidia,tegra210-gpio", .data = &tegra210_gpio_config },
 	{ .compatible = "nvidia,tegra30-gpio", .data = &tegra30_gpio_config },
 	{ .compatible = "nvidia,tegra20-gpio", .data = &tegra20_gpio_config },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 50de4bf20a5a..dc25db599fc3 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -1559,49 +1559,49 @@ static const struct tegra_gpio_soc tegra410_system_soc = {
 static const struct of_device_id tegra186_gpio_of_match[] = {
 	{
 		.compatible = "nvidia,tegra186-gpio",
-		.data = &tegra186_main_soc
+		.data = &tegra186_main_soc,
 	}, {
 		.compatible = "nvidia,tegra186-gpio-aon",
-		.data = &tegra186_aon_soc
+		.data = &tegra186_aon_soc,
 	}, {
 		.compatible = "nvidia,tegra194-gpio",
-		.data = &tegra194_main_soc
+		.data = &tegra194_main_soc,
 	}, {
 		.compatible = "nvidia,tegra194-gpio-aon",
-		.data = &tegra194_aon_soc
+		.data = &tegra194_aon_soc,
 	}, {
 		.compatible = "nvidia,tegra234-gpio",
-		.data = &tegra234_main_soc
+		.data = &tegra234_main_soc,
 	}, {
 		.compatible = "nvidia,tegra234-gpio-aon",
-		.data = &tegra234_aon_soc
+		.data = &tegra234_aon_soc,
 	}, {
 		.compatible = "nvidia,tegra238-gpio",
-		.data = &tegra238_main_soc
+		.data = &tegra238_main_soc,
 	}, {
 		.compatible = "nvidia,tegra238-gpio-aon",
-		.data = &tegra238_aon_soc
+		.data = &tegra238_aon_soc,
 	}, {
 		.compatible = "nvidia,tegra256-gpio",
-		.data = &tegra256_main_soc
+		.data = &tegra256_main_soc,
 	}, {
 		.compatible = "nvidia,tegra264-gpio",
-		.data = &tegra264_main_soc
+		.data = &tegra264_main_soc,
 	}, {
 		.compatible = "nvidia,tegra264-gpio-aon",
-		.data = &tegra264_aon_soc
+		.data = &tegra264_aon_soc,
 	}, {
 		.compatible = "nvidia,tegra264-gpio-uphy",
-		.data = &tegra264_uphy_soc
+		.data = &tegra264_uphy_soc,
 	}, {
 		.compatible = "nvidia,tegra268-gpio",
-		.data = &tegra268_main_soc
+		.data = &tegra268_main_soc,
 	}, {
 		.compatible = "nvidia,tegra268-gpio-aon",
-		.data = &tegra268_aon_soc
+		.data = &tegra268_aon_soc,
 	}, {
 		.compatible = "nvidia,tegra268-gpio-uphy",
-		.data = &tegra268_uphy_soc
+		.data = &tegra268_uphy_soc,
 	}, {
 		/* sentinel */
 	}
diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
index bf85663349fb..79e13adeb21e 100644
--- a/drivers/gpio/gpio-tps65218.c
+++ b/drivers/gpio/gpio-tps65218.c
@@ -196,7 +196,7 @@ static int tps65218_gpio_probe(struct platform_device *pdev)
 
 static const struct of_device_id tps65218_dt_match[] = {
 	{ .compatible = "ti,tps65218-gpio" },
-	{  }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tps65218_dt_match);
 
diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index 0207c2b813f4..a67f6808ea16 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -48,8 +48,8 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id ts4800_gpio_of_match[] = {
-	{ .compatible = "technologic,ts4800-gpio", },
-	{},
+	{ .compatible = "technologic,ts4800-gpio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ts4800_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
index b46b48e56c56..e7acc4937f26 100644
--- a/drivers/gpio/gpio-ts4900.c
+++ b/drivers/gpio/gpio-ts4900.c
@@ -132,7 +132,7 @@ static const struct of_device_id ts4900_gpio_of_match_table[] = {
 		.compatible = "technologic,ts7970-gpio",
 		.data = (void *)TS7970_GPIO_IN,
 	},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ts4900_gpio_of_match_table);
 
diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index a851702befde..d61bf331395d 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -604,8 +604,8 @@ static int gpio_twl4030_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id twl_gpio_match[] = {
-	{ .compatible = "ti,twl4030-gpio", },
-	{ },
+	{ .compatible = "ti,twl4030-gpio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, twl_gpio_match);
 
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index adfa2c2d5873..0b67194de573 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -79,8 +79,8 @@ static const struct fsl_gpio_soc_data imx8ulp_data = {
 
 static const struct of_device_id vf610_gpio_dt_ids[] = {
 	{ .compatible = "fsl,vf610-gpio",	.data = &vf610_data },
-	{ .compatible = "fsl,imx7ulp-gpio",	.data = &imx_data, },
-	{ .compatible = "fsl,imx8ulp-gpio",	.data = &imx8ulp_data, },
+	{ .compatible = "fsl,imx7ulp-gpio",	.data = &imx_data },
+	{ .compatible = "fsl,imx8ulp-gpio",	.data = &imx8ulp_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, vf610_gpio_dt_ids);
diff --git a/drivers/gpio/gpio-visconti.c b/drivers/gpio/gpio-visconti.c
index 6d5d829634ad..59e57b8e8604 100644
--- a/drivers/gpio/gpio-visconti.c
+++ b/drivers/gpio/gpio-visconti.c
@@ -219,7 +219,7 @@ static int visconti_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id visconti_gpio_of_match[] = {
-	{ .compatible = "toshiba,gpio-tmpv7708", },
+	{ .compatible = "toshiba,gpio-tmpv7708" },
 	{ /* end of table */ }
 };
 MODULE_DEVICE_TABLE(of, visconti_gpio_of_match);
diff --git a/drivers/gpio/gpio-waveshare-dsi.c b/drivers/gpio/gpio-waveshare-dsi.c
index 38f52351bb58..bb862f450140 100644
--- a/drivers/gpio/gpio-waveshare-dsi.c
+++ b/drivers/gpio/gpio-waveshare-dsi.c
@@ -190,7 +190,7 @@ static int waveshare_gpio_probe(struct i2c_client *i2c)
 
 static const struct of_device_id waveshare_gpio_dt_ids[] = {
 	{ .compatible = "waveshare,dsi-touch-gpio" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, waveshare_gpio_dt_ids);
 
diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index 30b6e9f3f8ba..b1e0008679d0 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -334,7 +334,7 @@ static void xgene_gpio_sb_remove(struct platform_device *pdev)
 
 static const struct of_device_id xgene_gpio_sb_of_match[] = {
 	{ .compatible = "apm,xgene-gpio-sb" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, xgene_gpio_sb_of_match);
 
diff --git a/drivers/gpio/gpio-xgene.c b/drivers/gpio/gpio-xgene.c
index f4adf2962557..2aa0432dab7f 100644
--- a/drivers/gpio/gpio-xgene.c
+++ b/drivers/gpio/gpio-xgene.c
@@ -188,8 +188,8 @@ static int xgene_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id xgene_gpio_of_match[] = {
-	{ .compatible = "apm,xgene-gpio", },
-	{},
+	{ .compatible = "apm,xgene-gpio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, xgene_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-xgs-iproc.c b/drivers/gpio/gpio-xgs-iproc.c
index 77eb29dcc217..211e64b793a6 100644
--- a/drivers/gpio/gpio-xgs-iproc.c
+++ b/drivers/gpio/gpio-xgs-iproc.c
@@ -310,7 +310,7 @@ static void iproc_gpio_remove(struct platform_device *pdev)
 
 static const struct of_device_id bcm_iproc_gpio_of_match[] = {
 	{ .compatible = "brcm,iproc-gpio-cca" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bcm_iproc_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index 9406ce85f933..8a03d33f7b2a 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -660,8 +660,8 @@ static int xgpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id xgpio_of_match[] = {
-	{ .compatible = "xlnx,xps-gpio-1.00.a", },
-	{ /* end of list */ },
+	{ .compatible = "xlnx,xps-gpio-1.00.a" },
+	{ /* end of list */ }
 };
 
 MODULE_DEVICE_TABLE(of, xgpio_of_match);
diff --git a/drivers/gpio/gpio-xra1403.c b/drivers/gpio/gpio-xra1403.c
index 3713475bdb75..03c216d6d03f 100644
--- a/drivers/gpio/gpio-xra1403.c
+++ b/drivers/gpio/gpio-xra1403.c
@@ -192,7 +192,7 @@ MODULE_DEVICE_TABLE(spi, xra1403_ids);
 
 static const struct of_device_id xra1403_spi_of_match[] = {
 	{ .compatible = "exar,xra1403" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, xra1403_spi_of_match);
 
diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
index f1c5c6a20673..78c6988b5027 100644
--- a/drivers/gpio/gpio-zevio.c
+++ b/drivers/gpio/gpio-zevio.c
@@ -210,8 +210,8 @@ static int zevio_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id zevio_gpio_of_match[] = {
-	{ .compatible = "lsi,zevio-gpio", },
-	{ },
+	{ .compatible = "lsi,zevio-gpio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, zevio_gpio_of_match);
 
diff --git a/drivers/gpio/gpio-zynqmp-modepin.c b/drivers/gpio/gpio-zynqmp-modepin.c
index 5e651482e985..dcf41101a1e6 100644
--- a/drivers/gpio/gpio-zynqmp-modepin.c
+++ b/drivers/gpio/gpio-zynqmp-modepin.c
@@ -145,7 +145,7 @@ static int modepin_gpio_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id modepin_platform_id[] = {
-	{ .compatible = "xlnx,zynqmp-gpio-modepin", },
+	{ .compatible = "xlnx,zynqmp-gpio-modepin" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, modepin_platform_id);
-- 
2.56.0.rc1

