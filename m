Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432770;
	b=EJgSFaSnFvYqegZe0y0o1cSYCIZiwP6vpxrIRIWm4U+HBQa717GXcdJ4gMg5UmsYogke
	 0gq1qG5FMQ0pEHQMc9suLGZO+QNlmDnA9B2odkcBi5kpmFTRsBgwSrLqsj3KcihWvK5eO
	 DkKcJlEW0K/aBLpTiVjUkGa2SlKp9E0gE9vTTDdvMEDvGNLKMxUAcfQYQm59c6YuCgxSP
	 aHOwtIseLPtX+5O9VFOvKoQGsszgkK8zFB5aka3TACoES1iZoN6G+fea19W4ddFYc43iw
	 uEG8QSCk8uAQ5ZZLI5K7pKH2yDYYcszX+UBj3QoLlHnnOkB7nduLTby4Pi5cWni5s8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=uyaDZ7vgeML448C6gd8ME2h0GFd6KKMtwVzCZWTCnII=;
	b=k+NgxClNvHx1m6IS+BkNJIDcOpefbw/z83H6411oyAFZHUqDuhSIt35IcoYvm0uIkYJg
	 9jOryvxTWv2Ip01qxRLNMYIpRwhHjXhivwtRY62QB8XfN55okMdcNGKUwQHGfM/F90R/T
	 7r866yY81a3/XRhyZ+ysKxP/CwkUBDzJFMJYqNCpLfFlbILibHPfOQ3MUQSvy/trk0y7T
	 CIgRgiVu01yDZB1FPBAQqAOITPqlKe9DFuiODnWqF3P6l9GrraToRckGHb7bexT18Hi6o
	 /AmrIX9Dw7syorBjOcbZGbQWCZEsu+kRKCvRTa/cJOk5tY0nDrYNu8eyxB/VvJnSjIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=S5zbmwFf;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268E960A260E
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 11:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 268E960A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=S5zbmwFf
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a34ffd3e39so1685265f8f.0
        for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2026 03:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795432766; x=1796037566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uyaDZ7vgeML448C6gd8ME2h0GFd6KKMtwVzCZWTCnII=;
        b=S5zbmwFflLIojrvVlSKTdBmgGFo5UtYxkcr+yLhqwHra8eQoqYHdYMOLbw8vHOM5oJ
         pZ17kpkIpBAgEboZPO0bSFlNaWO2CwhR5j9KfaYfBamtUXUVI/zan1rdW3xU2W4phkD1
         vzGD5SIBMjqnqwcfeQ5PzXtGDjoVUpelsnsVHkHl8b8u8vamfEmnyKdBYwfErXozJVfP
         4hH0u7N18K8Wh+ZQQyv1tfH8IU8T+yqKx/DPbwVnEMdjPfWgk+mUYq4mOYOMEXWRwY5M
         w8IlgiaFfhnI4r0X3k/9bBsemfPH32hOt9bk62vJ/ro5NeA7aLbYClFQ8PukLURBjTRW
         W65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432766; x=1796037566;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uyaDZ7vgeML448C6gd8ME2h0GFd6KKMtwVzCZWTCnII=;
        b=z2fruZ5bGet6X9WLIKFb0YlkvipfEM8VN3eLarEoMmwB/2XDBdbJ/7JP8ha+9aNvSV
         WX7oGB9LQL1oBjoSY3mtXZe7ZA6fjaubl9wW2lMkCM1fFR6DHJBKgjfaXvjFXF8ingEa
         x176KmP07DlaKr7UCMN03Z7iojJtBQFYV/HK7KwDCIQvp/WbHWrwDfvG281Kd/FhZwJM
         W+X3vMsUOglnhy3wDHe3RibZBvW1B0AwZgnqDdNwk/89HQomT++1d1/Y1vOqDC8tIzof
         DnxSAttL81ATL+8BUW3kSC2FGCkqAjAD5/K54Ak9tGwElQI1hAc6RuSAFD9miHZQ6hYE
         JT1g==
X-Forwarded-Encrypted: i=1; AL+hErFz5sVNicn7/INprDi8WNdWT+ofNs44GIzd3uGmZW/o0LVgw3d4/DQ6chGiOlk6c7/OkIvvqfexH8Ah@vger.kernel.org
X-Gm-Message-State: APuU4Z+P5OYPpuz2LQG3QW+TjT4uutKo3dVYs1638qyt1kVzY4FUEq3b
	esBKBj05UXqaWrYvzBf86rYh8Y9V7Cx3Vpff86sGv9437dEBayTUh3aXgW83RDoYX64=
X-Gm-Gg: AZFdTZfpAU34fzMRCFKQH7hLV+jlgd21o6KjIwl5W/YOdQCGRFj4QFRLq/2hi386pd1
	HZth9yh+NGVJ2z9mTHs/dyRpEQuRz20HdtAteR9GscoPrn7+7ec8g8Knq1+DSeOLbeFAOwXCiLF
	oBmtm3C6HkB8QL4XLT1y1IkdCANjRaOoLXLg8dGXezR3SxaXgS1NDVn++BNmuNBf8X+B3z+luQ6
	NuFsOWOPh86g0iZu+PdmEBKj8IAe6cqMWNjpFvKh5pD05zTW/mTkryTBPza3X//ClM51BYBZHhd
	JF2DlqaKE3U2JuHp5L2Cl11+45FdXyGgWELtFjuKXKaUi1lUvrXIyjGoN0JJ/pXiXEciBxmqoGJ
	G8frf+PomFxCPoJLlmUeFGLZbpWl1zCBEFWZrxy7OsQ+1W0taNo+ihNEWEs6K/Nf3f3hF5KXL3L
	h46FQDVfcbtK9WH6Q5aewqXUltS1r9LaUlJgny5lziBlmeSIsg1FtoN+nNTLkdaaNZTMWD7MDyF
	l6kF+xaR4eRmWN+POR29nK/mPOniGykP5yUIw2j9PoEq4jFF+1Cm3cytj2S2LUBqobgoVTgNqgE
	ZYRCGWOO7S7yO9tqbBNs7DGZseH33r+Aqs6WdUpSoKRH9RMDQjd+mORJ244iGk5+RpoNO4Ba9PA
	aw+5yWmpBejcwooMvbRWIUOSCtJkyzkWE6d4mYQ==
X-Received: by 2002:a05:6000:220a:b0:4a2:edb3:5d45 with SMTP id ffacd0b85a97d-4abb4b84c8amr23262767f8f.41.1795432766086;
        Mon, 23 Nov 2026 03:19:26 -0800 (PST)
Received: from localhost (p200300f65f19a90438645cebc2ee104e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3864:5ceb:c2ee:104e])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6a680355sm18744438f8f.27.2026.11.23.03.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:25 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	Linus Walleij <linusw@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Chen-Yu Tsai <wens@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <fred.treven@cirrus.com>,
	Ben Bright <ben.bright@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	Saravanan Sekar <sravanhome@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	patches@opensource.cirrus.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	asahi@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	imx@lists.linux.dev,
	linux-omap@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v5 16/17] mfd: Unify style of of_device_id arrays
Date: Mon, 23 Nov 2026 12:18:14 +0100
Message-ID:  <b69bcdcc394e46e0eb60947f23923e6241d24ff4.1795431460.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=58381; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=a7Z3d9hAPBJ+O93Zvfp1bnUUV3VKXzaS98GQNC0QEK0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBCERZCeLQn0jaf1lKLfAlF4sOYORlfl1oXK9c zEtEacn7+2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawQhEQAKCRCPgPtYfRL+ TnlRCACm3fD5eyIQ4Z+Bp6Z0FBztQp5BMGDWMfu2EffIIQvjFdeODISx92EqrjQOGqX2dkkKXN6 iH0npRSG/ExO17AS4VYFlQcK8LNqw+kZkNVRI08sRyqIarDXhPer39PBL15cUm+du6M62BEWjzS aFDGS/GRFbmYtg5lP4kB/kPswHkuNTVCOoyhEkI343F+oeKu08DT5GD6k1lBtz64FQrfox3vpf0 LJpv2GqBYD+I8iL4Cf1ofrmw/gdcfZiOjLNxiJRknvT0GS1XauFK+xkgZchBfnq89NUdIxWFuNM JRf06ED9bsag10UzMpSrRtGD1yOy8TTgknbcE7ryrOR3NhAH
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

These arrays already mostly match the most used and generally
recommended coding style. That is:

 - no comma after the list terminator;
 - a comma after an initializer if (and only if) the closing } is not
   directly following;
 - no explicit zeros in the list terminator;
 - a space after an opening { and before a closing }, a single space in
   the list terminator;

Adapt the offenders accordingly.

Reviewed-by: André Draszik <andre.draszik@linaro.org> # for Maxim MAX77759
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com> # max7360
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/mfd/88pm860x-core.c    |  4 ++--
 drivers/mfd/ab8500-sysctrl.c   |  4 ++--
 drivers/mfd/ac100.c            |  2 +-
 drivers/mfd/act8945a.c         |  4 ++--
 drivers/mfd/altera-a10sr.c     |  2 +-
 drivers/mfd/altera-sysmgr.c    |  2 +-
 drivers/mfd/arizona-i2c.c      |  2 +-
 drivers/mfd/arizona-spi.c      |  2 +-
 drivers/mfd/as3711.c           |  4 ++--
 drivers/mfd/as3722.c           |  4 ++--
 drivers/mfd/atmel-hlcdc.c      |  2 +-
 drivers/mfd/atmel-smc.c        |  2 +-
 drivers/mfd/axp20x-i2c.c       |  2 +-
 drivers/mfd/axp20x-rsb.c       |  2 +-
 drivers/mfd/bcm2835-pm.c       |  4 ++--
 drivers/mfd/bd9571mwv.c        |  4 ++--
 drivers/mfd/bq257xx.c          |  2 +-
 drivers/mfd/cs40l50-i2c.c      |  2 +-
 drivers/mfd/cs40l50-spi.c      |  2 +-
 drivers/mfd/cs42l43-i2c.c      |  2 +-
 drivers/mfd/da9055-i2c.c       |  2 +-
 drivers/mfd/da9063-i2c.c       |  5 +++--
 drivers/mfd/da9150-core.c      |  2 +-
 drivers/mfd/db8500-prcmu.c     |  4 ++--
 drivers/mfd/exynos-lpass.c     |  2 +-
 drivers/mfd/gateworks-gsc.c    |  2 +-
 drivers/mfd/hi6421-pmic-core.c |  6 +++---
 drivers/mfd/hi655x-pmic.c      |  4 ++--
 drivers/mfd/khadas-mcu.c       |  2 +-
 drivers/mfd/lochnagar-i2c.c    |  2 +-
 drivers/mfd/lp3943.c           |  2 +-
 drivers/mfd/lp873x.c           |  6 +++---
 drivers/mfd/lp87565.c          |  2 +-
 drivers/mfd/macsmc.c           |  2 +-
 drivers/mfd/madera-core.c      |  2 +-
 drivers/mfd/max14577.c         |  2 +-
 drivers/mfd/max7360.c          |  2 +-
 drivers/mfd/max77686.c         |  2 +-
 drivers/mfd/max77693.c         |  2 +-
 drivers/mfd/max77714.c         |  2 +-
 drivers/mfd/max77759.c         |  2 +-
 drivers/mfd/max77843.c         |  4 ++--
 drivers/mfd/max8907.c          |  2 +-
 drivers/mfd/max8925-i2c.c      |  4 ++--
 drivers/mfd/max8997.c          |  2 +-
 drivers/mfd/max8998.c          |  2 +-
 drivers/mfd/mc13xxx-spi.c      |  6 +++---
 drivers/mfd/mp2629.c           |  2 +-
 drivers/mfd/mt6360-core.c      |  4 ++--
 drivers/mfd/mt6370.c           |  2 +-
 drivers/mfd/mxs-lradc.c        |  4 ++--
 drivers/mfd/ntxec.c            |  4 ++--
 drivers/mfd/omap-usb-host.c    |  4 ++--
 drivers/mfd/qcom-pm8008.c      |  4 ++--
 drivers/mfd/qcom-pm8xxx.c      |  6 +++---
 drivers/mfd/rave-sp.c          |  4 ++--
 drivers/mfd/rk8xx-i2c.c        |  2 +-
 drivers/mfd/rk8xx-spi.c        |  2 +-
 drivers/mfd/rohm-bd71828.c     |  4 ++--
 drivers/mfd/rohm-bd9576.c      |  6 +++---
 drivers/mfd/rsmu_i2c.c         |  2 +-
 drivers/mfd/rsmu_spi.c         |  2 +-
 drivers/mfd/rt4831.c           |  4 ++--
 drivers/mfd/rt5033.c           |  2 +-
 drivers/mfd/rt5120.c           |  2 +-
 drivers/mfd/rz-mtu3.c          |  2 +-
 drivers/mfd/sec-acpm.c         |  6 +++---
 drivers/mfd/sec-i2c.c          | 22 +++++++++++-----------
 drivers/mfd/simple-mfd-i2c.c   |  2 +-
 drivers/mfd/sky81452.c         |  2 +-
 drivers/mfd/sm501.c            |  2 +-
 drivers/mfd/smpro-core.c       |  2 +-
 drivers/mfd/sprd-sc27xx-spi.c  |  2 +-
 drivers/mfd/ssbi.c             |  2 +-
 drivers/mfd/stm32-lptimer.c    |  4 ++--
 drivers/mfd/stm32-timers.c     |  4 ++--
 drivers/mfd/stmfx.c            |  4 ++--
 drivers/mfd/stmpe-i2c.c        | 18 +++++++++---------
 drivers/mfd/stmpe-spi.c        | 14 +++++++-------
 drivers/mfd/stpmic1.c          |  4 ++--
 drivers/mfd/stw481x.c          |  6 +++---
 drivers/mfd/sun6i-prcm.c       |  2 +-
 drivers/mfd/tps6105x.c         |  2 +-
 drivers/mfd/tps6507x.c         |  4 ++--
 drivers/mfd/tps65086.c         |  2 +-
 drivers/mfd/tps65090.c         |  4 ++--
 drivers/mfd/tps65217.c         |  4 ++--
 drivers/mfd/tps65218.c         |  4 ++--
 drivers/mfd/tps65219.c         |  8 ++++----
 drivers/mfd/tps6586x.c         |  4 ++--
 drivers/mfd/tps65910.c         |  6 +++---
 drivers/mfd/tps65912-i2c.c     |  2 +-
 drivers/mfd/tps65912-spi.c     |  2 +-
 drivers/mfd/tps6594-i2c.c      | 12 ++++++------
 drivers/mfd/tps6594-spi.c      | 12 ++++++------
 drivers/mfd/twl4030-audio.c    |  4 ++--
 drivers/mfd/twl4030-power.c    |  2 +-
 drivers/mfd/twl6030-irq.c      |  2 +-
 drivers/mfd/vexpress-sysreg.c  |  4 ++--
 drivers/mfd/wm831x-core.c      |  2 +-
 100 files changed, 185 insertions(+), 184 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index ce521b042c5c..de2f124b21ae 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1236,8 +1236,8 @@ static const struct i2c_device_id pm860x_id_table[] = {
 MODULE_DEVICE_TABLE(i2c, pm860x_id_table);
 
 static const struct of_device_id pm860x_dt_ids[] = {
-	{ .compatible = "marvell,88pm860x", },
-	{},
+	{ .compatible = "marvell,88pm860x" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pm860x_dt_ids);
 
diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index b6b44e2e3198..e4a7d864e254 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -149,8 +149,8 @@ static void ab8500_sysctrl_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ab8500_sysctrl_match[] = {
-	{ .compatible = "stericsson,ab8500-sysctrl", },
-	{}
+	{ .compatible = "stericsson,ab8500-sysctrl" },
+	{ }
 };
 
 static struct platform_driver ab8500_sysctrl_driver = {
diff --git a/drivers/mfd/ac100.c b/drivers/mfd/ac100.c
index cd57de780910..26d8797e28ab 100644
--- a/drivers/mfd/ac100.c
+++ b/drivers/mfd/ac100.c
@@ -116,7 +116,7 @@ static int ac100_rsb_probe(struct sunxi_rsb_device *rdev)
 
 static const struct of_device_id ac100_of_match[] = {
 	{ .compatible = "x-powers,ac100" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ac100_of_match);
 
diff --git a/drivers/mfd/act8945a.c b/drivers/mfd/act8945a.c
index e5fba40f89d4..31b46d032363 100644
--- a/drivers/mfd/act8945a.c
+++ b/drivers/mfd/act8945a.c
@@ -60,8 +60,8 @@ static const struct i2c_device_id act8945a_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, act8945a_i2c_id);
 
 static const struct of_device_id act8945a_of_match[] = {
-	{ .compatible = "active-semi,act8945a", },
-	{},
+	{ .compatible = "active-semi,act8945a" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, act8945a_of_match);
 
diff --git a/drivers/mfd/altera-a10sr.c b/drivers/mfd/altera-a10sr.c
index b4abb37dcd19..5e5cff522607 100644
--- a/drivers/mfd/altera-a10sr.c
+++ b/drivers/mfd/altera-a10sr.c
@@ -148,7 +148,7 @@ static int altr_a10sr_spi_probe(struct spi_device *spi)
 
 static const struct of_device_id altr_a10sr_spi_of_match[] = {
 	{ .compatible = "altr,a10sr" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, altr_a10sr_spi_of_match);
 
diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 1ad46dbcbab7..6cd69ab4c802 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -175,7 +175,7 @@ static int sysmgr_probe(struct platform_device *pdev)
 static const struct of_device_id altr_sysmgr_of_match[] = {
 	{ .compatible = "altr,sys-mgr" },
 	{ .compatible = "altr,sys-mgr-s10" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, altr_sysmgr_of_match);
 
diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 0f49ec7ff39b..f3f1d901c362 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -103,7 +103,7 @@ static const struct of_device_id arizona_i2c_of_match[] = {
 	{ .compatible = "wlf,wm8997", .data = (void *)WM8997 },
 	{ .compatible = "wlf,wm8998", .data = (void *)WM8998 },
 	{ .compatible = "wlf,wm1814", .data = (void *)WM1814 },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, arizona_i2c_of_match);
 #endif
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 57e97f1b9f1d..58e7db01feb4 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -270,7 +270,7 @@ static const struct of_device_id arizona_spi_of_match[] = {
 	{ .compatible = "wlf,wm8280", .data = (void *)WM8280 },
 	{ .compatible = "wlf,wm1831", .data = (void *)WM1831 },
 	{ .compatible = "cirrus,cs47l24", .data = (void *)CS47L24 },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, arizona_spi_of_match);
 #endif
diff --git a/drivers/mfd/as3711.c b/drivers/mfd/as3711.c
index 23dabf4483e5..4600a5f952c7 100644
--- a/drivers/mfd/as3711.c
+++ b/drivers/mfd/as3711.c
@@ -111,8 +111,8 @@ static const struct regmap_config as3711_regmap_config = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id as3711_of_match[] = {
-	{.compatible = "ams,as3711",},
-	{}
+	{ .compatible = "ams,as3711" },
+	{ }
 };
 #endif
 
diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index e545cdd09d81..21cabcdbad44 100644
--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -426,8 +426,8 @@ static int __maybe_unused as3722_i2c_resume(struct device *dev)
 }
 
 static const struct of_device_id as3722_of_match[] = {
-	{ .compatible = "ams,as3722", },
-	{},
+	{ .compatible = "ams,as3722" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, as3722_of_match);
 
diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index 4a10dac519ee..8fbba64a1c77 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -149,7 +149,7 @@ static const struct of_device_id atmel_hlcdc_match[] = {
 	{ .compatible = "microchip,sam9x60-hlcdc" },
 	{ .compatible = "microchip,sam9x75-xlcdc" },
 	{ .compatible = "microchip,sama7d65-xlcdc" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_match);
 
diff --git a/drivers/mfd/atmel-smc.c b/drivers/mfd/atmel-smc.c
index e69be61511a4..94d03a5e2207 100644
--- a/drivers/mfd/atmel-smc.c
+++ b/drivers/mfd/atmel-smc.c
@@ -333,7 +333,7 @@ static const struct of_device_id atmel_smc_ids[] __maybe_unused = {
 	{ .compatible = "atmel,at91sam9260-smc", .data = NULL },
 	{ .compatible = "atmel,sama5d3-smc", .data = &sama5d3_reg_layout },
 	{ .compatible = "atmel,sama5d2-smc", .data = &sama5d2_reg_layout },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 /**
diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index 12cc5d9dd84b..f98c504d732e 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -70,7 +70,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ .compatible = "x-powers,axp803", .data = (void *)AXP803_ID },
 	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
 	{ .compatible = "x-powers,axp15060", .data = (void *)AXP15060_ID },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
 #endif
diff --git a/drivers/mfd/axp20x-rsb.c b/drivers/mfd/axp20x-rsb.c
index dfc665f696bd..cfc2aba63e32 100644
--- a/drivers/mfd/axp20x-rsb.c
+++ b/drivers/mfd/axp20x-rsb.c
@@ -63,7 +63,7 @@ static const struct of_device_id axp20x_rsb_of_match[] = {
 	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
 	{ .compatible = "x-powers,axp809", .data = (void *)AXP809_ID },
 	{ .compatible = "x-powers,axp813", .data = (void *)AXP813_ID },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_rsb_of_match);
 
diff --git a/drivers/mfd/bcm2835-pm.c b/drivers/mfd/bcm2835-pm.c
index f21d5689561a..c15b00da9035 100644
--- a/drivers/mfd/bcm2835-pm.c
+++ b/drivers/mfd/bcm2835-pm.c
@@ -113,11 +113,11 @@ static int bcm2835_pm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id bcm2835_pm_of_match[] = {
-	{ .compatible = "brcm,bcm2835-pm-wdt", },
+	{ .compatible = "brcm,bcm2835-pm-wdt" },
 	{ .compatible = "brcm,bcm2835-pm", .data = (void *)BCM2835_PM_SOC_BCM2835 },
 	{ .compatible = "brcm,bcm2711-pm", .data = (void *)BCM2835_PM_SOC_BCM2711 },
 	{ .compatible = "brcm,bcm2712-pm", .data = (void *)BCM2835_PM_SOC_BCM2712 },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bcm2835_pm_of_match);
 
diff --git a/drivers/mfd/bd9571mwv.c b/drivers/mfd/bd9571mwv.c
index 2b6fe6fd9806..76ccca5ffbf8 100644
--- a/drivers/mfd/bd9571mwv.c
+++ b/drivers/mfd/bd9571mwv.c
@@ -261,8 +261,8 @@ static int bd9571mwv_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id bd9571mwv_of_match_table[] = {
-	{ .compatible = "rohm,bd9571mwv", },
-	{ .compatible = "rohm,bd9574mwf", },
+	{ .compatible = "rohm,bd9571mwv" },
+	{ .compatible = "rohm,bd9574mwf" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, bd9571mwv_of_match_table);
diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
index ea47496a81e3..80811890ad83 100644
--- a/drivers/mfd/bq257xx.c
+++ b/drivers/mfd/bq257xx.c
@@ -138,7 +138,7 @@ MODULE_DEVICE_TABLE(i2c, bq257xx_i2c_ids);
 static const struct of_device_id bq257xx_of_match[] = {
 	{ .compatible = "ti,bq25703a", .data = (void *)BQ25703A },
 	{ .compatible = "ti,bq25792", .data = (void *)BQ25792 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bq257xx_of_match);
 
diff --git a/drivers/mfd/cs40l50-i2c.c b/drivers/mfd/cs40l50-i2c.c
index 0e6fa90bb603..f783c674423e 100644
--- a/drivers/mfd/cs40l50-i2c.c
+++ b/drivers/mfd/cs40l50-i2c.c
@@ -47,7 +47,7 @@ MODULE_DEVICE_TABLE(i2c, cs40l50_id_i2c);
 
 static const struct of_device_id cs40l50_of_match[] = {
 	{ .compatible = "cirrus,cs40l50" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, cs40l50_of_match);
 
diff --git a/drivers/mfd/cs40l50-spi.c b/drivers/mfd/cs40l50-spi.c
index a213ef9a30d4..e62ed5fb6393 100644
--- a/drivers/mfd/cs40l50-spi.c
+++ b/drivers/mfd/cs40l50-spi.c
@@ -47,7 +47,7 @@ MODULE_DEVICE_TABLE(spi, cs40l50_id_spi);
 
 static const struct of_device_id cs40l50_of_match[] = {
 	{ .compatible = "cirrus,cs40l50" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, cs40l50_of_match);
 
diff --git a/drivers/mfd/cs42l43-i2c.c b/drivers/mfd/cs42l43-i2c.c
index cc4838ed3b0a..408a2dce9529 100644
--- a/drivers/mfd/cs42l43-i2c.c
+++ b/drivers/mfd/cs42l43-i2c.c
@@ -66,7 +66,7 @@ static const struct of_device_id cs42l43_of_match[] = {
 	{ .compatible = "cirrus,cs42l43", .data = (void *)CS42L43_DEVID_VAL },
 	{ .compatible = "cirrus,cs42l43b", .data = (void *)CS42L43B_DEVID_VAL },
 	{ .compatible = "cirrus,cs42l44", .data = (void *)CS42L43B_DEVID_VAL },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, cs42l43_of_match);
 #endif
diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index fcb61284b751..453fd650c8ec 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -60,7 +60,7 @@ static const struct i2c_device_id da9055_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
 
 static const struct of_device_id da9055_of_match[] = {
-	{ .compatible = "dlg,da9055-pmic", },
+	{ .compatible = "dlg,da9055-pmic" },
 	{ }
 };
 
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index fc053485656b..bcb9f2ab29ef 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -361,11 +361,12 @@ static struct regmap_config da9063_regmap_config = {
 };
 
 static const struct of_device_id da9063_dt_ids[] = {
-	{ .compatible = "dlg,da9063", },
-	{ .compatible = "dlg,da9063l", },
+	{ .compatible = "dlg,da9063" },
+	{ .compatible = "dlg,da9063l" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da9063_dt_ids);
+
 static int da9063_i2c_probe(struct i2c_client *i2c)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
index 13bf7393e471..6106cbce4ba6 100644
--- a/drivers/mfd/da9150-core.c
+++ b/drivers/mfd/da9150-core.c
@@ -504,7 +504,7 @@ static const struct i2c_device_id da9150_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, da9150_i2c_id);
 
 static const struct of_device_id da9150_of_match[] = {
-	{ .compatible = "dlg,da9150", },
+	{ .compatible = "dlg,da9150" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da9150_of_match);
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index cdfcbeb2a88c..b954ac4a1f6b 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3073,8 +3073,8 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 	return err;
 }
 static const struct of_device_id db8500_prcmu_match[] = {
-	{ .compatible = "stericsson,db8500-prcmu"},
-	{ },
+	{ .compatible = "stericsson,db8500-prcmu" },
+	{ }
 };
 
 static struct platform_driver db8500_prcmu_driver = {
diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 646bdb888915..d02e7301a175 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -177,7 +177,7 @@ static const struct dev_pm_ops lpass_pm_ops = {
 
 static const struct of_device_id exynos_lpass_of_match[] = {
 	{ .compatible = "samsung,exynos5433-lpass" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, exynos_lpass_of_match);
 
diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
index c034d54354f4..750358a270bb 100644
--- a/drivers/mfd/gateworks-gsc.c
+++ b/drivers/mfd/gateworks-gsc.c
@@ -155,7 +155,7 @@ static struct attribute_group attr_group = {
 };
 
 static const struct of_device_id gsc_of_match[] = {
-	{ .compatible = "gw,gsc", },
+	{ .compatible = "gw,gsc" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gsc_of_match);
diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic-core.c
index 44099fffa465..85a9b39fc370 100644
--- a/drivers/mfd/hi6421-pmic-core.c
+++ b/drivers/mfd/hi6421-pmic-core.c
@@ -38,13 +38,13 @@ static const struct regmap_config hi6421_regmap_config = {
 static const struct of_device_id of_hi6421_pmic_match[] = {
 	{
 		.compatible = "hisilicon,hi6421-pmic",
-		.data = (void *)HI6421
+		.data = (void *)HI6421,
 	},
 	{
 		.compatible = "hisilicon,hi6421v530-pmic",
-		.data = (void *)HI6421_V530
+		.data = (void *)HI6421_V530,
 	},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_hi6421_pmic_match);
 
diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index 32c9c2bcd922..c26f727f9c9a 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -152,8 +152,8 @@ static void hi655x_pmic_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id hi655x_pmic_match[] = {
-	{ .compatible = "hisilicon,hi655x-pmic", },
-	{},
+	{ .compatible = "hisilicon,hi655x-pmic" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hi655x_pmic_match);
 
diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index 1279a123f138..3b732ea351cc 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -194,7 +194,7 @@ static int khadas_mcu_probe(struct i2c_client *client)
 static const struct of_device_id khadas_mcu_of_match[] = {
 	{ .compatible = "khadas,mcu", .data = (void *)KHADAS_MCU_GENERIC },
 	{ .compatible = "khadas,vim4-mcu", .data = (void *)KHADAS_MCU_VIM4 },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, khadas_mcu_of_match);
 #endif
diff --git a/drivers/mfd/lochnagar-i2c.c b/drivers/mfd/lochnagar-i2c.c
index 33551c82414d..ead7f1098c62 100644
--- a/drivers/mfd/lochnagar-i2c.c
+++ b/drivers/mfd/lochnagar-i2c.c
@@ -200,7 +200,7 @@ static struct lochnagar_config lochnagar_configs[] = {
 static const struct of_device_id lochnagar_of_match[] = {
 	{ .compatible = "cirrus,lochnagar1", .data = &lochnagar_configs[0] },
 	{ .compatible = "cirrus,lochnagar2", .data = &lochnagar_configs[1] },
-	{},
+	{ }
 };
 
 static int lochnagar_wait_for_boot(struct regmap *regmap, unsigned int *id)
diff --git a/drivers/mfd/lp3943.c b/drivers/mfd/lp3943.c
index 2edaa6bcb0b8..ea230949c1c3 100644
--- a/drivers/mfd/lp3943.c
+++ b/drivers/mfd/lp3943.c
@@ -133,7 +133,7 @@ MODULE_DEVICE_TABLE(i2c, lp3943_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id lp3943_of_match[] = {
-	{ .compatible = "ti,lp3943", },
+	{ .compatible = "ti,lp3943" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, lp3943_of_match);
diff --git a/drivers/mfd/lp873x.c b/drivers/mfd/lp873x.c
index f00e8473bb38..5dd6c5ef12c4 100644
--- a/drivers/mfd/lp873x.c
+++ b/drivers/mfd/lp873x.c
@@ -60,9 +60,9 @@ static int lp873x_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id of_lp873x_match_table[] = {
-	{ .compatible = "ti,lp8733", },
-	{ .compatible = "ti,lp8732", },
-	{}
+	{ .compatible = "ti,lp8733" },
+	{ .compatible = "ti,lp8732" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_lp873x_match_table);
 
diff --git a/drivers/mfd/lp87565.c b/drivers/mfd/lp87565.c
index 009812be9614..bf3481f2c2f2 100644
--- a/drivers/mfd/lp87565.c
+++ b/drivers/mfd/lp87565.c
@@ -42,7 +42,7 @@ static const struct of_device_id of_lp87565_match_table[] = {
 		.compatible = "ti,lp87561-q1",
 		.data = (void *)LP87565_DEVICE_TYPE_LP87561_Q1,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_lp87565_match_table);
 
diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
index 8c058cf68222..bca15e5c66d6 100644
--- a/drivers/mfd/macsmc.c
+++ b/drivers/mfd/macsmc.c
@@ -489,7 +489,7 @@ static int apple_smc_probe(struct platform_device *pdev)
 static const struct of_device_id apple_smc_of_match[] = {
 	{ .compatible = "apple,t8103-smc" },
 	{ .compatible = "apple,smc" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, apple_smc_of_match);
 
diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 2f74a8c644a3..2d74b4511a8f 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -381,7 +381,7 @@ const struct of_device_id madera_of_match[] = {
 	{ .compatible = "cirrus,cs47l92", .data = (void *)CS47L92 },
 	{ .compatible = "cirrus,cs47l93", .data = (void *)CS47L93 },
 	{ .compatible = "cirrus,wm1840", .data = (void *)WM1840 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, madera_of_match);
 EXPORT_SYMBOL_GPL(madera_of_match);
diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index 18c478f61bb9..52c684252e30 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -140,7 +140,7 @@ static const struct of_device_id max14577_dt_match[] = {
 		.compatible = "maxim,max77836",
 		.data = (void *)MAXIM_DEVICE_TYPE_MAX77836,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max14577_dt_match);
 
diff --git a/drivers/mfd/max7360.c b/drivers/mfd/max7360.c
index 52fffed0c0dd..dc744b40bb38 100644
--- a/drivers/mfd/max7360.c
+++ b/drivers/mfd/max7360.c
@@ -152,7 +152,7 @@ static int max7360_probe(struct i2c_client *client)
 
 static const struct of_device_id max7360_dt_match[] = {
 	{ .compatible = "maxim,max7360" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max7360_dt_match);
 
diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 3e3404ebf689..6fb9cc433183 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -153,7 +153,7 @@ static const struct of_device_id max77686_pmic_dt_match[] = {
 		.compatible = "maxim,max77802",
 		.data = (void *)TYPE_MAX77802,
 	},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max77686_pmic_dt_match);
 
diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
index 3c1d843582c3..270a0f1a4ece 100644
--- a/drivers/mfd/max77693.c
+++ b/drivers/mfd/max77693.c
@@ -344,7 +344,7 @@ static const struct dev_pm_ops max77693_pm = {
 #ifdef CONFIG_OF
 static const struct of_device_id max77693_dt_match[] = {
 	{ .compatible = "maxim,max77693" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max77693_dt_match);
 #endif
diff --git a/drivers/mfd/max77714.c b/drivers/mfd/max77714.c
index c618605a3fb2..353f657da879 100644
--- a/drivers/mfd/max77714.c
+++ b/drivers/mfd/max77714.c
@@ -134,7 +134,7 @@ static int max77714_probe(struct i2c_client *client)
 
 static const struct of_device_id max77714_dt_match[] = {
 	{ .compatible = "maxim,max77714" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max77714_dt_match);
 
diff --git a/drivers/mfd/max77759.c b/drivers/mfd/max77759.c
index a06891781567..4b4b05d23d7c 100644
--- a/drivers/mfd/max77759.c
+++ b/drivers/mfd/max77759.c
@@ -718,7 +718,7 @@ static const struct i2c_device_id max77759_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, max77759_i2c_id);
 
 static const struct of_device_id max77759_of_id[] = {
-	{ .compatible = "maxim,max77759", },
+	{ .compatible = "maxim,max77759" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max77759_of_id);
diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
index 81c95b7fdfb1..4660e598cd8c 100644
--- a/drivers/mfd/max77843.c
+++ b/drivers/mfd/max77843.c
@@ -164,8 +164,8 @@ static int max77843_probe(struct i2c_client *i2c)
 }
 
 static const struct of_device_id max77843_dt_match[] = {
-	{ .compatible = "maxim,max77843", },
-	{ },
+	{ .compatible = "maxim,max77843" },
+	{ }
 };
 
 static const struct i2c_device_id max77843_id[] = {
diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index e15370320a50..fadcd6deaa3e 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -308,7 +308,7 @@ static void max8907_i2c_remove(struct i2c_client *i2c)
 #ifdef CONFIG_OF
 static const struct of_device_id max8907_of_match[] = {
 	{ .compatible = "maxim,max8907" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max8907_of_match);
 #endif
diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index 4544937b57d7..52356fddfa81 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -228,8 +228,8 @@ static DEFINE_SIMPLE_DEV_PM_OPS(max8925_pm_ops,
 				max8925_suspend, max8925_resume);
 
 static const struct of_device_id max8925_dt_ids[] = {
-	{ .compatible = "maxim,max8925", },
-	{},
+	{ .compatible = "maxim,max8925" },
+	{ }
 };
 
 static struct i2c_driver max8925_driver = {
diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 039c97002b5f..55be682fce00 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -39,7 +39,7 @@ static const struct mfd_cell max8997_devs[] = {
 #ifdef CONFIG_OF
 static const struct of_device_id max8997_pmic_dt_match[] = {
 	{ .compatible = "maxim,max8997-pmic", .data = (void *)TYPE_MAX8997 },
-	{},
+	{ }
 };
 #endif
 
diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index 90cc063efd31..23d5280b5455 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -120,7 +120,7 @@ static const struct of_device_id max8998_dt_match[] = {
 	{ .compatible = "maxim,max8998", .data = (void *)TYPE_MAX8998 },
 	{ .compatible = "national,lp3974", .data = (void *)TYPE_LP3974 },
 	{ .compatible = "ti,lp3974", .data = (void *)TYPE_LP3974 },
-	{},
+	{ }
 };
 #endif
 
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index 807b7e8503b2..ed637343c1fd 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -35,9 +35,9 @@ static const struct spi_device_id mc13xxx_device_id[] = {
 MODULE_DEVICE_TABLE(spi, mc13xxx_device_id);
 
 static const struct of_device_id mc13xxx_dt_ids[] = {
-	{ .compatible = "fsl,mc13783", .data = &mc13xxx_variant_mc13783, },
-	{ .compatible = "fsl,mc13892", .data = &mc13xxx_variant_mc13892, },
-	{ .compatible = "fsl,mc34708", .data = &mc13xxx_variant_mc34708, },
+	{ .compatible = "fsl,mc13783", .data = &mc13xxx_variant_mc13783 },
+	{ .compatible = "fsl,mc13892", .data = &mc13xxx_variant_mc13892 },
+	{ .compatible = "fsl,mc34708", .data = &mc13xxx_variant_mc34708 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mc13xxx_dt_ids);
diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
index e4959322985e..e0aed3cfa29b 100644
--- a/drivers/mfd/mp2629.c
+++ b/drivers/mfd/mp2629.c
@@ -60,7 +60,7 @@ static int mp2629_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id mp2629_of_match[] = {
-	{ .compatible = "mps,mp2629"},
+	{ .compatible = "mps,mp2629" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mp2629_of_match);
diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 40a035a89c8a..afeb16a6e132 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -607,8 +607,8 @@ static int mt6360_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(mt6360_pm_ops, mt6360_suspend, mt6360_resume);
 
 static const struct of_device_id mt6360_of_id[] = {
-	{ .compatible = "mediatek,mt6360", },
-	{},
+	{ .compatible = "mediatek,mt6360" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mt6360_of_id);
 
diff --git a/drivers/mfd/mt6370.c b/drivers/mfd/mt6370.c
index e97858dce95f..cca477965f55 100644
--- a/drivers/mfd/mt6370.c
+++ b/drivers/mfd/mt6370.c
@@ -294,7 +294,7 @@ static int mt6370_probe(struct i2c_client *i2c)
 
 static const struct of_device_id mt6370_match_table[] = {
 	{ .compatible = "mediatek,mt6370" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mt6370_match_table);
 
diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
index 6be18c188fe6..33c8cc3bb7c5 100644
--- a/drivers/mfd/mxs-lradc.c
+++ b/drivers/mfd/mxs-lradc.c
@@ -117,8 +117,8 @@ static const struct mfd_cell mx28_cells[] = {
 };
 
 static const struct of_device_id mxs_lradc_dt_ids[] = {
-	{ .compatible = "fsl,imx23-lradc", .data = (void *)IMX23_LRADC, },
-	{ .compatible = "fsl,imx28-lradc", .data = (void *)IMX28_LRADC, },
+	{ .compatible = "fsl,imx23-lradc", .data = (void *)IMX23_LRADC },
+	{ .compatible = "fsl,imx28-lradc", .data = (void *)IMX28_LRADC },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
index 4521f38ec256..be94cce85410 100644
--- a/drivers/mfd/ntxec.c
+++ b/drivers/mfd/ntxec.c
@@ -250,8 +250,8 @@ static void ntxec_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id of_ntxec_match_table[] = {
-	{ .compatible = "netronix,ntxec", },
-	{}
+	{ .compatible = "netronix,ntxec" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_ntxec_match_table);
 
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index a5426257776f..91440b204f51 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -516,8 +516,8 @@ static int usbhs_omap_get_dt_pdata(struct device *dev,
 }
 
 static const struct of_device_id usbhs_child_match_table[] = {
-	{ .compatible = "ti,ehci-omap", },
-	{ .compatible = "ti,ohci-omap3", },
+	{ .compatible = "ti,ehci-omap" },
+	{ .compatible = "ti,ohci-omap3" },
 	{ }
 };
 
diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 60204cc9a2dc..c1d522ecc938 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -261,8 +261,8 @@ static int pm8008_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id pm8008_match[] = {
-	{ .compatible = "qcom,pm8008", },
-	{ },
+	{ .compatible = "qcom,pm8008" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8008_match);
 
diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index 26b1043876f7..2379e6fbe180 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -499,9 +499,9 @@ static const struct pm_irq_data pm8821_data = {
 };
 
 static const struct of_device_id pm8xxx_id_table[] = {
-	{ .compatible = "qcom,pm8058", .data = &pm8xxx_data},
-	{ .compatible = "qcom,pm8821", .data = &pm8821_data},
-	{ .compatible = "qcom,pm8921", .data = &pm8xxx_data},
+	{ .compatible = "qcom,pm8058", .data = &pm8xxx_data },
+	{ .compatible = "qcom,pm8821", .data = &pm8821_data },
+	{ .compatible = "qcom,pm8921", .data = &pm8xxx_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_id_table);
diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index e06614769458..62da750fe75c 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -779,8 +779,8 @@ static const struct of_device_id rave_sp_dt_ids[] = {
 	{ .compatible = "zii,rave-sp-niu",  .data = &rave_sp_legacy },
 	{ .compatible = "zii,rave-sp-mezz", .data = &rave_sp_legacy },
 	{ .compatible = "zii,rave-sp-esb",  .data = &rave_sp_legacy },
-	{ .compatible = "zii,rave-sp-rdu1", .data = &rave_sp_rdu1   },
-	{ .compatible = "zii,rave-sp-rdu2", .data = &rave_sp_rdu2   },
+	{ .compatible = "zii,rave-sp-rdu1", .data = &rave_sp_rdu1 },
+	{ .compatible = "zii,rave-sp-rdu2", .data = &rave_sp_rdu2 },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
index 161b25fbe146..b87ad6d620fb 100644
--- a/drivers/mfd/rk8xx-i2c.c
+++ b/drivers/mfd/rk8xx-i2c.c
@@ -262,7 +262,7 @@ static const struct of_device_id rk8xx_i2c_of_match[] = {
 	{ .compatible = "rockchip,rk816", .data = &rk816_data },
 	{ .compatible = "rockchip,rk817", .data = &rk817_data },
 	{ .compatible = "rockchip,rk818", .data = &rk818_data },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rk8xx_i2c_of_match);
 
diff --git a/drivers/mfd/rk8xx-spi.c b/drivers/mfd/rk8xx-spi.c
index bb85fe60518f..b5bbf8c09148 100644
--- a/drivers/mfd/rk8xx-spi.c
+++ b/drivers/mfd/rk8xx-spi.c
@@ -98,7 +98,7 @@ static int rk8xx_spi_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id rk8xx_spi_of_match[] = {
-	{ .compatible = "rockchip,rk806", },
+	{ .compatible = "rockchip,rk806" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rk8xx_spi_of_match);
diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 537f9753c5bf..a01814378284 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -1194,8 +1194,8 @@ static const struct of_device_id bd71828_of_match[] = {
 	}, {
 		.compatible = "rohm,bd73800",
 		.data = (void *)ROHM_CHIP_TYPE_BD73800,
-	 },
-	{ },
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bd71828_of_match);
 
diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
index 17323ae39803..eaf30aa3dcca 100644
--- a/drivers/mfd/rohm-bd9576.c
+++ b/drivers/mfd/rohm-bd9576.c
@@ -167,9 +167,9 @@ static int bd957x_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct of_device_id bd957x_of_match[] = {
-	{ .compatible = "rohm,bd9576", .data = (void *)ROHM_CHIP_TYPE_BD9576, },
-	{ .compatible = "rohm,bd9573", .data = (void *)ROHM_CHIP_TYPE_BD9573, },
-	{ },
+	{ .compatible = "rohm,bd9576", .data = (void *)ROHM_CHIP_TYPE_BD9576 },
+	{ .compatible = "rohm,bd9573", .data = (void *)ROHM_CHIP_TYPE_BD9573 },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bd957x_of_match);
 
diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
index e1c4eec6098d..68d2149d30e5 100644
--- a/drivers/mfd/rsmu_i2c.c
+++ b/drivers/mfd/rsmu_i2c.c
@@ -347,7 +347,7 @@ static const struct of_device_id rsmu_i2c_of_match[] = {
 	{ .compatible = "idt,82p33811", .data = (void *)RSMU_SABRE },
 	{ .compatible = "idt,8v19n850", .data = (void *)RSMU_SL },
 	{ .compatible = "idt,8v19n851", .data = (void *)RSMU_SL },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rsmu_i2c_of_match);
 
diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
index 66ed3175008d..de419ebbe2a9 100644
--- a/drivers/mfd/rsmu_spi.c
+++ b/drivers/mfd/rsmu_spi.c
@@ -254,7 +254,7 @@ static const struct of_device_id rsmu_spi_of_match[] = {
 	{ .compatible = "idt,8a34002",  .data = (void *)RSMU_CM },
 	{ .compatible = "idt,82p33810", .data = (void *)RSMU_SABRE },
 	{ .compatible = "idt,82p33811", .data = (void *)RSMU_SABRE },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rsmu_spi_of_match);
 
diff --git a/drivers/mfd/rt4831.c b/drivers/mfd/rt4831.c
index 2b3f84b81c65..06794ced4124 100644
--- a/drivers/mfd/rt4831.c
+++ b/drivers/mfd/rt4831.c
@@ -99,8 +99,8 @@ static void rt4831_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id rt4831_of_match[] = {
-	{ .compatible = "richtek,rt4831", },
-	{}
+	{ .compatible = "richtek,rt4831" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rt4831_of_match);
 
diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index 698a441679fd..f13e135e7105 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -113,7 +113,7 @@ static const struct i2c_device_id rt5033_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, rt5033_i2c_id);
 
 static const struct of_device_id rt5033_dt_match[] = {
-	{ .compatible = "richtek,rt5033", },
+	{ .compatible = "richtek,rt5033" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rt5033_dt_match);
diff --git a/drivers/mfd/rt5120.c b/drivers/mfd/rt5120.c
index a229eb292484..b42c0e2e7d15 100644
--- a/drivers/mfd/rt5120.c
+++ b/drivers/mfd/rt5120.c
@@ -104,7 +104,7 @@ static int rt5120_probe(struct i2c_client *i2c)
 
 static const struct of_device_id rt5120_device_match_table[] = {
 	{ .compatible = "richtek,rt5120" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rt5120_device_match_table);
 
diff --git a/drivers/mfd/rz-mtu3.c b/drivers/mfd/rz-mtu3.c
index 479ecf7a1123..731bbb1426c0 100644
--- a/drivers/mfd/rz-mtu3.c
+++ b/drivers/mfd/rz-mtu3.c
@@ -332,7 +332,7 @@ static int rz_mtu3_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rz_mtu3_of_match[] = {
-	{ .compatible = "renesas,rz-mtu3", },
+	{ .compatible = "renesas,rz-mtu3" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rz_mtu3_of_match);
diff --git a/drivers/mfd/sec-acpm.c b/drivers/mfd/sec-acpm.c
index f5e5990f5e81..dfba9e08e09e 100644
--- a/drivers/mfd/sec-acpm.c
+++ b/drivers/mfd/sec-acpm.c
@@ -560,9 +560,9 @@ static const struct sec_pmic_acpm_platform_data s2mpg11_data = {
 };
 
 static const struct of_device_id sec_pmic_acpm_of_match[] = {
-	{ .compatible = "samsung,s2mpg10-pmic", .data = &s2mpg10_data, },
-	{ .compatible = "samsung,s2mpg11-pmic", .data = &s2mpg11_data, },
-	{ },
+	{ .compatible = "samsung,s2mpg10-pmic", .data = &s2mpg10_data },
+	{ .compatible = "samsung,s2mpg11-pmic", .data = &s2mpg11_data },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sec_pmic_acpm_of_match);
 
diff --git a/drivers/mfd/sec-i2c.c b/drivers/mfd/sec-i2c.c
index 4eec8f7ceee3..5c614098470f 100644
--- a/drivers/mfd/sec-i2c.c
+++ b/drivers/mfd/sec-i2c.c
@@ -236,17 +236,17 @@ static const struct sec_pmic_i2c_platform_data s5m8767_data = {
 };
 
 static const struct of_device_id sec_pmic_i2c_of_match[] = {
-	{ .compatible = "samsung,s2dos05", .data = &s2dos05_data, },
-	{ .compatible = "samsung,s2mpa01-pmic", .data = &s2mpa01_data, },
-	{ .compatible = "samsung,s2mps11-pmic", .data = &s2mps11_data, },
-	{ .compatible = "samsung,s2mps13-pmic", .data = &s2mps13_data, },
-	{ .compatible = "samsung,s2mps14-pmic", .data = &s2mps14_data, },
-	{ .compatible = "samsung,s2mps15-pmic", .data = &s2mps15_data, },
-	{ .compatible = "samsung,s2mpu02-pmic", .data = &s2mpu02_data, },
-	{ .compatible = "samsung,s2mpu05-pmic", .data = &s2mpu05_data, },
-	{ .compatible = "samsung,s2mu005-pmic", .data = &s2mu005_data, },
-	{ .compatible = "samsung,s5m8767-pmic", .data = &s5m8767_data, },
-	{ },
+	{ .compatible = "samsung,s2dos05", .data = &s2dos05_data },
+	{ .compatible = "samsung,s2mpa01-pmic", .data = &s2mpa01_data },
+	{ .compatible = "samsung,s2mps11-pmic", .data = &s2mps11_data },
+	{ .compatible = "samsung,s2mps13-pmic", .data = &s2mps13_data },
+	{ .compatible = "samsung,s2mps14-pmic", .data = &s2mps14_data },
+	{ .compatible = "samsung,s2mps15-pmic", .data = &s2mps15_data },
+	{ .compatible = "samsung,s2mpu02-pmic", .data = &s2mpu02_data },
+	{ .compatible = "samsung,s2mpu05-pmic", .data = &s2mpu05_data },
+	{ .compatible = "samsung,s2mu005-pmic", .data = &s2mu005_data },
+	{ .compatible = "samsung,s5m8767-pmic", .data = &s5m8767_data },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sec_pmic_i2c_of_match);
 
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index ef3ce4bdf98b..4813faf9fd3e 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -126,7 +126,7 @@ static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "maxim,max77705-battery", .data = &maxim_mon_max77705 },
 	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a },
 	{ .compatible = "spacemit,p1", .data = &spacemit_p1 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
 
diff --git a/drivers/mfd/sky81452.c b/drivers/mfd/sky81452.c
index 4872d33a5322..b5954fd3c789 100644
--- a/drivers/mfd/sky81452.c
+++ b/drivers/mfd/sky81452.c
@@ -66,7 +66,7 @@ MODULE_DEVICE_TABLE(i2c, sky81452_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id sky81452_of_match[] = {
-	{ .compatible = "skyworks,sky81452", },
+	{ .compatible = "skyworks,sky81452" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sky81452_of_match);
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 2e2ee6d3b889..d1a27fef79a5 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1657,7 +1657,7 @@ static struct pci_driver sm501_pci_driver = {
 MODULE_ALIAS("platform:sm501");
 
 static const struct of_device_id of_sm501_match_tbl[] = {
-	{ .compatible = "smi,sm501", },
+	{ .compatible = "smi,sm501" },
 	{ /* end */ }
 };
 MODULE_DEVICE_TABLE(of, of_sm501_match_tbl);
diff --git a/drivers/mfd/smpro-core.c b/drivers/mfd/smpro-core.c
index 59d31590c69b..b236e4235cb5 100644
--- a/drivers/mfd/smpro-core.c
+++ b/drivers/mfd/smpro-core.c
@@ -120,7 +120,7 @@ static int smpro_core_probe(struct i2c_client *i2c)
 
 static const struct of_device_id smpro_core_of_match[] = {
 	{ .compatible = "ampere,smpro", .data = &smpro_regmap_config },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, smpro_core_of_match);
 
diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 4f5b31fc505f..d69227249291 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -287,7 +287,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops,
 static const struct of_device_id sprd_pmic_match[] = {
 	{ .compatible = "sprd,sc2730", .data = (void *)PMIC_TYPE_SC2730 },
 	{ .compatible = "sprd,sc2731", .data = (void *)PMIC_TYPE_SC2731 },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sprd_pmic_match);
 
diff --git a/drivers/mfd/ssbi.c b/drivers/mfd/ssbi.c
index 551a18fcaa85..f792076a9ab9 100644
--- a/drivers/mfd/ssbi.c
+++ b/drivers/mfd/ssbi.c
@@ -306,7 +306,7 @@ static int ssbi_probe(struct platform_device *pdev)
 
 static const struct of_device_id ssbi_match_table[] = {
 	{ .compatible = "qcom,ssbi" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ssbi_match_table);
 
diff --git a/drivers/mfd/stm32-lptimer.c b/drivers/mfd/stm32-lptimer.c
index a3d266fc199e..76092d07e95c 100644
--- a/drivers/mfd/stm32-lptimer.c
+++ b/drivers/mfd/stm32-lptimer.c
@@ -113,8 +113,8 @@ static int stm32_lptimer_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id stm32_lptimer_of_match[] = {
-	{ .compatible = "st,stm32-lptimer", },
-	{},
+	{ .compatible = "st,stm32-lptimer" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_lptimer_of_match);
 
diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
index d23ad342ecb1..df10ac91da76 100644
--- a/drivers/mfd/stm32-timers.c
+++ b/drivers/mfd/stm32-timers.c
@@ -347,9 +347,9 @@ static void stm32_timers_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id stm32_timers_of_match[] = {
-	{ .compatible = "st,stm32-timers", },
+	{ .compatible = "st,stm32-timers" },
 	{ .compatible = "st,stm32mp25-timers", .data = (void *)STM32MP25_TIM_IPIDR },
-	{ /* end node */ },
+	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE(of, stm32_timers_of_match);
 
diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 10b700d32436..21a7946b95f8 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -542,8 +542,8 @@ static int stmfx_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(stmfx_dev_pm_ops, stmfx_suspend, stmfx_resume);
 
 static const struct of_device_id stmfx_of_match[] = {
-	{ .compatible = "st,stmfx-0300", },
-	{},
+	{ .compatible = "st,stmfx-0300" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stmfx_of_match);
 
diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index 8eee780afa16..8628c6844ba6 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -54,15 +54,15 @@ static struct stmpe_client_info i2c_ci = {
 };
 
 static const struct of_device_id stmpe_of_match[] = {
-	{ .compatible = "st,stmpe610", .data = (void *)STMPE610, },
-	{ .compatible = "st,stmpe801", .data = (void *)STMPE801, },
-	{ .compatible = "st,stmpe811", .data = (void *)STMPE811, },
-	{ .compatible = "st,stmpe1600", .data = (void *)STMPE1600, },
-	{ .compatible = "st,stmpe1601", .data = (void *)STMPE1601, },
-	{ .compatible = "st,stmpe1801", .data = (void *)STMPE1801, },
-	{ .compatible = "st,stmpe2401", .data = (void *)STMPE2401, },
-	{ .compatible = "st,stmpe2403", .data = (void *)STMPE2403, },
-	{},
+	{ .compatible = "st,stmpe610", .data = (void *)STMPE610 },
+	{ .compatible = "st,stmpe801", .data = (void *)STMPE801 },
+	{ .compatible = "st,stmpe811", .data = (void *)STMPE811 },
+	{ .compatible = "st,stmpe1600", .data = (void *)STMPE1600 },
+	{ .compatible = "st,stmpe1601", .data = (void *)STMPE1601 },
+	{ .compatible = "st,stmpe1801", .data = (void *)STMPE1801 },
+	{ .compatible = "st,stmpe2401", .data = (void *)STMPE2401 },
+	{ .compatible = "st,stmpe2403", .data = (void *)STMPE2403 },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stmpe_of_match);
 
diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index 22a3da062dee..7d6dcc9dc5d3 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -110,13 +110,13 @@ static void stmpe_spi_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id stmpe_spi_of_match[] = {
-	{ .compatible = "st,stmpe610", },
-	{ .compatible = "st,stmpe801", },
-	{ .compatible = "st,stmpe811", },
-	{ .compatible = "st,stmpe1601", },
-	{ .compatible = "st,stmpe2401", },
-	{ .compatible = "st,stmpe2403", },
-	{ /* sentinel */ },
+	{ .compatible = "st,stmpe610" },
+	{ .compatible = "st,stmpe801" },
+	{ .compatible = "st,stmpe811" },
+	{ .compatible = "st,stmpe1601" },
+	{ .compatible = "st,stmpe2401" },
+	{ .compatible = "st,stmpe2403" },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, stmpe_spi_of_match);
 
diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index 7904f4d5b2b4..debbae5cddae 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -223,8 +223,8 @@ static int stpmic1_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(stpmic1_pm, stpmic1_suspend, stpmic1_resume);
 
 static const struct of_device_id stpmic1_of_match[] = {
-	{ .compatible = "st,stpmic1", },
-	{},
+	{ .compatible = "st,stpmic1" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stpmic1_of_match);
 
diff --git a/drivers/mfd/stw481x.c b/drivers/mfd/stw481x.c
index 454f5f495b74..42df2c28fe4f 100644
--- a/drivers/mfd/stw481x.c
+++ b/drivers/mfd/stw481x.c
@@ -228,9 +228,9 @@ static const struct i2c_device_id stw481x_id[] = {
 MODULE_DEVICE_TABLE(i2c, stw481x_id);
 
 static const struct of_device_id stw481x_match[] = {
-	{ .compatible = "st,stw4810", },
-	{ .compatible = "st,stw4811", },
-	{ },
+	{ .compatible = "st,stw4810" },
+	{ .compatible = "st,stw4811" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stw481x_match);
 
diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
index ee03db0b8485..a8a168f66fc1 100644
--- a/drivers/mfd/sun6i-prcm.c
+++ b/drivers/mfd/sun6i-prcm.c
@@ -122,7 +122,7 @@ static const struct of_device_id sun6i_prcm_dt_ids[] = {
 		.compatible = "allwinner,sun8i-a23-prcm",
 		.data = &sun8i_a23_prcm_data,
 	},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int sun6i_prcm_probe(struct platform_device *pdev)
diff --git a/drivers/mfd/tps6105x.c b/drivers/mfd/tps6105x.c
index c89c1c5547e2..18e708435c8e 100644
--- a/drivers/mfd/tps6105x.c
+++ b/drivers/mfd/tps6105x.c
@@ -200,7 +200,7 @@ MODULE_DEVICE_TABLE(i2c, tps6105x_id);
 static const struct of_device_id tps6105x_of_match[] = {
 	{ .compatible = "ti,tps61050" },
 	{ .compatible = "ti,tps61052" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tps6105x_of_match);
 
diff --git a/drivers/mfd/tps6507x.c b/drivers/mfd/tps6507x.c
index 9e33c191bf7c..931c7c36a52b 100644
--- a/drivers/mfd/tps6507x.c
+++ b/drivers/mfd/tps6507x.c
@@ -109,8 +109,8 @@ MODULE_DEVICE_TABLE(i2c, tps6507x_i2c_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id tps6507x_of_match[] = {
-	{.compatible = "ti,tps6507x", },
-	{},
+	{ .compatible = "ti,tps6507x" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tps6507x_of_match);
 #endif
diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index 7a0b9ca5ace4..340fd00ada22 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -57,7 +57,7 @@ static const struct regmap_irq_chip tps65086_irq_chip = {
 };
 
 static const struct of_device_id tps65086_of_match_table[] = {
-	{ .compatible = "ti,tps65086", },
+	{ .compatible = "ti,tps65086" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, tps65086_of_match_table);
diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index 730f5112adda..acbdc0838f66 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -157,8 +157,8 @@ static const struct regmap_config tps65090_regmap_config = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id tps65090_of_match[] = {
-	{ .compatible = "ti,tps65090",},
-	{},
+	{ .compatible = "ti,tps65090" },
+	{ }
 };
 #endif
 
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index b3e481356e92..35c88200e524 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -344,8 +344,8 @@ static const struct regmap_config tps65217_regmap_config = {
 };
 
 static const struct of_device_id tps65217_of_match[] = {
-	{ .compatible = "ti,tps65217"},
-	{ /* sentinel */ },
+	{ .compatible = "ti,tps65217" },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, tps65217_of_match);
 
diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 04f3a38fa961..bebc0e837b66 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -197,8 +197,8 @@ static const struct regmap_irq_chip tps65218_irq_chip = {
 };
 
 static const struct of_device_id of_tps65218_match_table[] = {
-	{ .compatible = "ti,tps65218", },
-	{}
+	{ .compatible = "ti,tps65218" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_tps65218_match_table);
 
diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index fc33cf09a473..3af0020324b3 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -554,10 +554,10 @@ static int tps65219_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id of_tps65219_match_table[] = {
-	{ .compatible = "ti,tps65214", .data = (void *)TPS65214, },
-	{ .compatible = "ti,tps65215", .data = (void *)TPS65215, },
-	{ .compatible = "ti,tps65219", .data = (void *)TPS65219, },
-	{}
+	{ .compatible = "ti,tps65214", .data = (void *)TPS65214 },
+	{ .compatible = "ti,tps65215", .data = (void *)TPS65215 },
+	{ .compatible = "ti,tps65219", .data = (void *)TPS65219 },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_tps65219_match_table);
 
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index c2e2dd1bfb10..3d64d24d19ff 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -432,8 +432,8 @@ static struct tps6586x_platform_data *tps6586x_parse_dt(struct i2c_client *clien
 }
 
 static const struct of_device_id tps6586x_of_match[] = {
-	{ .compatible = "ti,tps6586x", },
-	{ },
+	{ .compatible = "ti,tps6586x" },
+	{ }
 };
 #else
 static struct tps6586x_platform_data *tps6586x_parse_dt(struct i2c_client *client)
diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index ef465da7cf44..a61282460023 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -367,9 +367,9 @@ static int tps65910_sleepinit(struct tps65910 *tps65910,
 
 #ifdef CONFIG_OF
 static const struct of_device_id tps65910_of_match[] = {
-	{ .compatible = "ti,tps65910", .data = (void *)TPS65910},
-	{ .compatible = "ti,tps65911", .data = (void *)TPS65911},
-	{ },
+	{ .compatible = "ti,tps65910", .data = (void *)TPS65910 },
+	{ .compatible = "ti,tps65911", .data = (void *)TPS65911 },
+	{ }
 };
 
 static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
diff --git a/drivers/mfd/tps65912-i2c.c b/drivers/mfd/tps65912-i2c.c
index b4d9d7c36764..2fcb62a11e1f 100644
--- a/drivers/mfd/tps65912-i2c.c
+++ b/drivers/mfd/tps65912-i2c.c
@@ -16,7 +16,7 @@
 #include <linux/mfd/tps65912.h>
 
 static const struct of_device_id tps65912_i2c_of_match_table[] = {
-	{ .compatible = "ti,tps65912", },
+	{ .compatible = "ti,tps65912" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, tps65912_i2c_of_match_table);
diff --git a/drivers/mfd/tps65912-spi.c b/drivers/mfd/tps65912-spi.c
index 96d07631f210..0f4c2b3fe0d9 100644
--- a/drivers/mfd/tps65912-spi.c
+++ b/drivers/mfd/tps65912-spi.c
@@ -16,7 +16,7 @@
 #include <linux/mfd/tps65912.h>
 
 static const struct of_device_id tps65912_spi_of_match_table[] = {
-	{ .compatible = "ti,tps65912", },
+	{ .compatible = "ti,tps65912" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, tps65912_spi_of_match_table);
diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
index f9ae0b494d44..2738d8315e22 100644
--- a/drivers/mfd/tps6594-i2c.c
+++ b/drivers/mfd/tps6594-i2c.c
@@ -197,12 +197,12 @@ static struct regmap_config tps6594_i2c_regmap_config = {
 };
 
 static const struct of_device_id tps6594_i2c_of_match_table[] = {
-	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
-	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
-	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
-	{ .compatible = "ti,tps65224-q1", .data = (void *)TPS65224, },
-	{ .compatible = "ti,tps652g1", .data = (void *)TPS652G1, },
-	{}
+	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594 },
+	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593 },
+	{ .compatible = "ti,lp8764-q1", .data = (void *)LP8764 },
+	{ .compatible = "ti,tps65224-q1", .data = (void *)TPS65224 },
+	{ .compatible = "ti,tps652g1", .data = (void *)TPS652G1 },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tps6594_i2c_of_match_table);
 
diff --git a/drivers/mfd/tps6594-spi.c b/drivers/mfd/tps6594-spi.c
index d8b3da5f14e8..dee045922aa2 100644
--- a/drivers/mfd/tps6594-spi.c
+++ b/drivers/mfd/tps6594-spi.c
@@ -82,12 +82,12 @@ static struct regmap_config tps6594_spi_regmap_config = {
 };
 
 static const struct of_device_id tps6594_spi_of_match_table[] = {
-	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594, },
-	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593, },
-	{ .compatible = "ti,lp8764-q1",  .data = (void *)LP8764,  },
-	{ .compatible = "ti,tps65224-q1", .data = (void *)TPS65224, },
-	{ .compatible = "ti,tps652g1", .data = (void *)TPS652G1, },
-	{}
+	{ .compatible = "ti,tps6594-q1", .data = (void *)TPS6594 },
+	{ .compatible = "ti,tps6593-q1", .data = (void *)TPS6593 },
+	{ .compatible = "ti,lp8764-q1", .data = (void *)LP8764 },
+	{ .compatible = "ti,tps65224-q1", .data = (void *)TPS65224 },
+	{ .compatible = "ti,tps652g1", .data = (void *)TPS652G1 },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tps6594_spi_of_match_table);
 
diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index 17ac1c598f16..182e58142d8d 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -264,8 +264,8 @@ static void twl4030_audio_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id twl4030_audio_of_match[] = {
-	{.compatible = "ti,twl4030-audio", },
-	{ },
+	{ .compatible = "ti,twl4030-audio" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, twl4030_audio_of_match);
 
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index fc1cf316c236..f7fe6fcce891 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -875,7 +875,7 @@ static const struct of_device_id twl4030_power_of_match[] = {
 		.compatible = "ti,twl4030-power-omap3-evm",
 		.data = &omap3_idle_ac_quirk,
 	},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, twl4030_power_of_match);
 #endif	/* CONFIG_OF */
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index c1d3ef007601..8f178480093f 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -285,7 +285,7 @@ static const struct irq_domain_ops twl6030_irq_domain_ops = {
 static const struct of_device_id twl6030_of_match[] __maybe_unused = {
 	{ .compatible = "ti,twl6030", .data = &twl6030_interrupt_mapping },
 	{ .compatible = "ti,twl6032", .data = &twl6032_interrupt_mapping },
-	{ },
+	{ }
 };
 
 int twl6030_init_irq(struct device *dev, int irq_num)
diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 78e43e1d282a..4c5e2ad556cf 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -141,8 +141,8 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id vexpress_sysreg_match[] = {
-	{ .compatible = "arm,vexpress-sysreg", },
-	{},
+	{ .compatible = "arm,vexpress-sysreg" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, vexpress_sysreg_match);
 
diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index df8e76e000cc..00edac4216e2 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -1445,7 +1445,7 @@ const struct of_device_id wm831x_of_match[] = {
 	{ .compatible = "wlf,wm8321", .data = (void *)WM8321 },
 	{ .compatible = "wlf,wm8325", .data = (void *)WM8325 },
 	{ .compatible = "wlf,wm8326", .data = (void *)WM8326 },
-	{ },
+	{ }
 };
 EXPORT_SYMBOL_GPL(wm831x_of_match);
 
-- 
2.47.3

