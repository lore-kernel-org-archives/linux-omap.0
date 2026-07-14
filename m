Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A03EDABA
	for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013916; cv=none; b=cHQdaKdTCVH1/LTvcteSYt+D4+hlKUcvHewo/MgFKdRcsV/DoyjL8zXxeZnIXOuK+6muFpY2qB8W4uBGOfLmgYhBCfcJDwm44w0td07/wIElhtsO6xlCI++20iLQS1btOdXj5689pv9HcZ7lsGhPHLH9PNDVVCT77PTCEtzT9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013916; c=relaxed/simple;
	bh=R2k78ifV57I7bqElN2rqk35dKurD9aNrsEluPiAhhMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SO25GnwPko4PU8xdrWA/NtwE/nMVpYO8JTg21wpk2M9F5L71RAh0Q1uEd+fGdMyvPFR0th4jBcbCzRyl3ZvVaciav79SCTXg1rQv12w82qbc1LrwIZCIcijfC30mq6uXLui7QDe8cw2ztgI0XJF3TGlnlKZjz4OfzyWMwQVPEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UmiSDjxh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="UmiSDjxh"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so4295235e9.3
        for <linux-omap@vger.kernel.org>; Tue, 14 Jul 2026 00:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784013912; x=1784618712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=peGrgF9PpfvVPhNKWNItMli4F0UFAyd4BhokmZXNYpk=;
        b=UmiSDjxh058lkRayooZX4mDFyCSfO86DkBcYLFCmQrfao+ueU/g+0gXlDMVT5RopkY
         KPRRx0mlt4m5Evo822AOuYKuNhtSCuSJTEkzRy5lSzEVZA7VgLIQsDkH37WzMdpm1sS9
         7VG8C8wO8XjuMioBxC25Ix/At91I9N989mfg0Kj7YcIXia1MxtE3knmHPf6Y3HknLCKo
         D4p245xClTp4j0ZxzmFKkdFisUQWtBSSXj/Y7IkyN7j6HVxbzUOm6GnfnbyOk7Xg4m4n
         abRBFuAh/1Des/xQWaOAN90S7Mo6mubDqKPvw8AE4dFgVt5EyXN07Gkcwss/4sTCk7FG
         EvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013912; x=1784618712;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=peGrgF9PpfvVPhNKWNItMli4F0UFAyd4BhokmZXNYpk=;
        b=B85MXtgmJ0Qu73wW/ketPCuRMJi2DO9q57KFmhmDT/QwwH5xf6H3Nqv31kpWln75C+
         uULdZ2ve3ZWPJDx9v/dbj2xrRAUzXtUGBHJz9DcH8tRKdAVNx9V6E6IbyieeG4cvr0R9
         k726bKmLorWZGv6Ve1k0rBpj0qNA9nVgsWsFx+ob2WuaJ5raDZBCxcZTKaUswWJxS79h
         vO98QzCSKL9EOrHkuDocjAZcoTUyZ54Vo1mmgGu5eaQWZPOGcKDrcXnQCJrQZLCU75jg
         ZDyyr4jl4swPrZkWYdcheu3Vnvzbvbx12Xn/JlPOXXDcv6efff0WNvTd4sPw4yHF6api
         G0LA==
X-Forwarded-Encrypted: i=1; AHgh+Rpu/S2BMVhnJaSnMAt0RFoVBo/cMnb8rB2TKLUyZBQAUWi60MlgvnimnS7qwrRFtaE0x9h0RAOh+o49@vger.kernel.org
X-Gm-Message-State: AOJu0YxyS5BISb1eaBQZOXpF/QJgkd6l44vZC8ZzSqzKnr+nCGXk9MA7
	LFD1kGaqb2wcfFsrsazoq07pgWce2AcUl/OvT6JRrYPagms1hz0SSRx885CxXSlyDPI=
X-Gm-Gg: AfdE7cmImlR0iY2aagiq8c8xoUt9UJOyHuf0QG6eS3aFB9AB0Z+MAbvQSK6XG768dPP
	iG5+Tn4jwjV2tqWrF7wjrsLfCVBeUcaakaiBc9pF4UXKppF2KCzP391r29j8yTrRebeKepfZS9f
	PZVmW9BRsb06C5XbLKfMql4VWULT1Km6ZNMGF6MC+n66relvz1qNLwII3PKbclrqGDAg+EJ+QmU
	rRnAqawhAPFOP9lZufMMkvTo8w6Us/e4rtqz4z6Qwu3W3SJoQZyQBuQNSy4wSqzzvzJ6Cbi/IQ3
	ObiTYJ8ujA3E1OUoKcoDEqa50DHmYxSchXeNzidWniLnm0LayEqWA/Yo9kMza+nhean7Je8mRKg
	30vfQBBelNPEYOWtV9XuHO0tD/lTyu7YtjarY4HHinJAyeqNEO84aBUF92jhbJE26HDYlJaMlJA
	+LTyvoUnnEMwvrSBb3qADYBME39AwK3rjZyCmpz65f8I+/VbPGbSHHNOgSUQYN+R34TrhgORz6r
	6gR
X-Received: by 2002:a05:600c:8108:b0:495:39a9:f8bb with SMTP id 5b1f17b1804b1-49539a9f8cbmr778035e9.27.1784013912057;
        Tue, 14 Jul 2026 00:25:12 -0700 (PDT)
Received: from localhost (p200300f65f47db04b44a80421173aa03.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b44a:8042:1173:aa03])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493f3a60404sm297426135e9.1.2026.07.14.00.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:25:11 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Yang Shen <shenyang39@huawei.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Imre Kaloz <kaloz@openwrt.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	virtualization@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Adrian Ng <adrianhoyin.ng@altera.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Alban Bedel <albeu@free.fr>,
	James Cowgill <james.cowgill@blaize.com>,
	Matt Redfearn <matt.redfearn@blaize.com>,
	Neil Jones <neil.jones@blaize.com>,
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>,
	Doug Berger <opendmb@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	Bamvor Jian Zhang <bamv2005@gmail.com>,
	=?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Michael Walle <mwalle@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-aspeed@lists.ozlabs.org,
	asahi@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	linux-omap@vger.kernel.org,
	linux-unisoc@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org,
	Michael Buesch <m@bues.ch>,
	William Breathitt Gray <wbg@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: [PATCH v1 00/20] gpio: Improvements around device-id arrays
Date: Tue, 14 Jul 2026 09:24:01 +0200
Message-ID: <cover.1784013063.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7258; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=R2k78ifV57I7bqElN2rqk35dKurD9aNrsEluPiAhhMs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqVeQbXm7nXijEy1eKUYHbl4wNScCj2qk8mUj+/ y7zzDJKfG2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCalXkGwAKCRCPgPtYfRL+ TjNvB/9C7+ymz4UqICZy8QPsc/Ow/qn0VBiFWbW1tSEKOBwwkQZo1Hy7AQ+gRBuqZ6lBXIdivbl J6Moa1BauQELgVWaBtRg0uf+8VuSizBtFiZs9QSAnyGq1As8Ig3H0TlZMAEH7loRfQoggE2XZy9 Z6FBACymjA3pjCM6m6bFnTEdA7tf/NkWWZgyekUvsu73ijI6WRdlCw8zOm3IsrB5CrRvIp5ys9E 168mnbodlTxBlZAxkLyLZkx1mBnl7QBeAFNihaznSJgydZjTVWUJ8Mg0DbCJcUjhwIRfsM0cj+S HdpAl3yxTBLjbpBAO/O99zNroQbc5aZ9lfnoj9rKKt4u/QJg
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the original motivation for this series are the patches that convert the
arrays to use named initializers, see
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for the idea behind it. Then the quest grew, due to thinking to convert
all device id arrays in a single series to not bother each subsystem
repeatedly[1], then I spotted a few missing MODULE_DEVICE_TABLE annotations
and decided to fix these. Then I noticed that some driver_data entries
to be unused and then dropped them instead of converting to named
initializers. And as my scripts that do most of these changes also cared
about trailing commas and how the list terminators look, this is also
addressed in this series. And so this grew to 20 patches ...

This is based on yesterday's next and obviously merge window material.

Best regards
Uwe

[1] Of course this only works if no new entries are added that
    initialize .driver_data by a positional initializer until I come
    around to add the union to the respecive device id struct.

Uwe Kleine-König (The Capable Hub) (20):
  gpio: Drop unused assignment of acpi_device_id driver data
  gpio: max7301: Drop unused assignment of spi_device_id driver data
  gpio: mmio: Drop unused assignment of platform_device_id driver data
  gpio: ljca: Drop unused assignment of auxiliary_device_id driver data
  gpio: Add missing ACPI module annotations
  gpio: sodaville: Add missing pci module annotations
  gpio: Add missing OF module annotations
  gpio: pxa: Add missing platform module annotations
  gpio: Add missing dmi module annotations
  gpio: pl061: Use empty initializer for amba_id terminator
  gpio: Use named initializers for acpi_device_id array
  gpio: Use named initializers for spi_device_id array
  gpio: virtio: Use a named initializer for virtio_device_id array
  gpio: pcf857x: Use named initializers for of_device_id array
  gpio: Unify style of acpi_device_id arrays
  gpio: Unify style of of_device_id arrays
  gpio: max77620: Unify style of platform_device_id arrays
  gpio: Unify style of spi_device_id arrays
  gpio: Unify style of pci_device_id arrays
  gpio: Unify style of various *_device_id arrays

 drivers/gpio/gpio-74x164.c          |  4 ++--
 drivers/gpio/gpio-adnp.c            |  4 ++--
 drivers/gpio/gpio-aggregator.c      |  2 +-
 drivers/gpio/gpio-altera-a10sr.c    |  2 +-
 drivers/gpio/gpio-altera.c          |  4 ++--
 drivers/gpio/gpio-amd8111.c         |  2 +-
 drivers/gpio/gpio-amdpt.c           |  8 ++++----
 drivers/gpio/gpio-aspeed-sgpio.c    | 10 +++++-----
 drivers/gpio/gpio-aspeed.c          | 10 +++++-----
 drivers/gpio/gpio-ath79.c           |  2 +-
 drivers/gpio/gpio-bcm-kona.c        |  1 +
 drivers/gpio/gpio-blzp1600.c        |  2 +-
 drivers/gpio/gpio-brcmstb.c         |  2 +-
 drivers/gpio/gpio-bt8xx.c           |  2 +-
 drivers/gpio/gpio-cadence.c         |  4 ++--
 drivers/gpio/gpio-creg-snps.c       |  5 +++--
 drivers/gpio/gpio-davinci.c         |  6 +++---
 drivers/gpio/gpio-dwapb.c           | 14 +++++++-------
 drivers/gpio/gpio-em.c              |  4 ++--
 drivers/gpio/gpio-ep93xx.c          |  1 +
 drivers/gpio/gpio-ftgpio010.c       |  3 ++-
 drivers/gpio/gpio-graniterapids.c   |  4 ++--
 drivers/gpio/gpio-grgpio.c          |  2 +-
 drivers/gpio/gpio-gw-pld.c          |  4 ++--
 drivers/gpio/gpio-hisi.c            |  6 +++---
 drivers/gpio/gpio-hlwd.c            |  4 ++--
 drivers/gpio/gpio-imx-scu.c         |  1 +
 drivers/gpio/gpio-ixp4xx.c          |  4 ++--
 drivers/gpio/gpio-ljca.c            |  4 ++--
 drivers/gpio/gpio-loongson-64bit.c  |  4 ++--
 drivers/gpio/gpio-lp3943.c          |  2 +-
 drivers/gpio/gpio-lpc32xx.c         |  4 ++--
 drivers/gpio/gpio-macsmc.c          |  4 ++--
 drivers/gpio/gpio-max3191x.c        | 12 ++++++------
 drivers/gpio/gpio-max7301.c         |  2 +-
 drivers/gpio/gpio-max7360.c         |  8 ++++----
 drivers/gpio/gpio-max77620.c        |  4 ++--
 drivers/gpio/gpio-max77759.c        |  2 +-
 drivers/gpio/gpio-mb86s7x.c         |  2 +-
 drivers/gpio/gpio-ml-ioh.c          |  2 +-
 drivers/gpio/gpio-mlxbf3.c          |  4 ++--
 drivers/gpio/gpio-mm-lantiq.c       |  2 +-
 drivers/gpio/gpio-mmio.c            |  3 +--
 drivers/gpio/gpio-mockup.c          |  4 ++--
 drivers/gpio/gpio-moxtet.c          |  4 ++--
 drivers/gpio/gpio-mpc5200.c         |  5 +++--
 drivers/gpio/gpio-mpc8xxx.c         | 25 +++++++++++++------------
 drivers/gpio/gpio-mpfs.c            |  1 +
 drivers/gpio/gpio-mpsse.c           |  3 +--
 drivers/gpio/gpio-msc313.c          |  1 +
 drivers/gpio/gpio-mt7621.c          |  2 +-
 drivers/gpio/gpio-mvebu.c           |  1 +
 drivers/gpio/gpio-mxc.c             |  2 +-
 drivers/gpio/gpio-mxs.c             |  4 ++--
 drivers/gpio/gpio-nomadik.c         |  7 ++++---
 drivers/gpio/gpio-novalake-events.c |  4 ++--
 drivers/gpio/gpio-npcm-sgpio.c      |  6 +++---
 drivers/gpio/gpio-octeon.c          |  2 +-
 drivers/gpio/gpio-omap.c            |  2 +-
 drivers/gpio/gpio-palmas.c          | 10 +++++-----
 drivers/gpio/gpio-pca953x.c         |  3 ++-
 drivers/gpio/gpio-pca9570.c         |  2 +-
 drivers/gpio/gpio-pcf857x.c         | 26 +++++++++++++-------------
 drivers/gpio/gpio-pci-idio-16.c     |  3 ++-
 drivers/gpio/gpio-pcie-idio-24.c    |  8 +++++---
 drivers/gpio/gpio-pisosr.c          |  4 ++--
 drivers/gpio/gpio-pl061.c           |  2 +-
 drivers/gpio/gpio-pmic-eic-sprd.c   |  2 +-
 drivers/gpio/gpio-pxa.c             | 20 +++++++++++---------
 drivers/gpio/gpio-qixis-fpga.c      |  3 +--
 drivers/gpio/gpio-rda.c             |  2 +-
 drivers/gpio/gpio-realtek-otto.c    |  2 +-
 drivers/gpio/gpio-rockchip.c        |  4 ++--
 drivers/gpio/gpio-sama5d2-piobu.c   |  2 +-
 drivers/gpio/gpio-sifive.c          |  2 +-
 drivers/gpio/gpio-sl28cpld.c        |  2 +-
 drivers/gpio/gpio-sodaville.c       |  3 ++-
 drivers/gpio/gpio-spear-spics.c     |  3 ++-
 drivers/gpio/gpio-sprd.c            |  2 +-
 drivers/gpio/gpio-stmpe.c           |  2 +-
 drivers/gpio/gpio-stp-xway.c        |  2 +-
 drivers/gpio/gpio-tegra.c           |  2 +-
 drivers/gpio/gpio-tegra186.c        |  2 +-
 drivers/gpio/gpio-thunderx.c        |  3 +--
 drivers/gpio/gpio-tps65218.c        |  2 +-
 drivers/gpio/gpio-ts4800.c          |  4 ++--
 drivers/gpio/gpio-twl4030.c         |  4 ++--
 drivers/gpio/gpio-usbio.c           | 13 +++++++------
 drivers/gpio/gpio-vf610.c           |  4 ++--
 drivers/gpio/gpio-virtio.c          |  4 ++--
 drivers/gpio/gpio-visconti.c        |  2 +-
 drivers/gpio/gpio-waveshare-dsi.c   |  2 +-
 drivers/gpio/gpio-xgene-sb.c        |  6 +++---
 drivers/gpio/gpio-xgene.c           | 10 ++++++----
 drivers/gpio/gpio-xgs-iproc.c       |  2 +-
 drivers/gpio/gpio-xilinx.c          |  2 +-
 drivers/gpio/gpio-xlp.c             |  6 +++---
 drivers/gpio/gpio-xra1403.c         |  6 +++---
 drivers/gpio/gpio-zevio.c           |  5 +++--
 drivers/gpio/gpio-zynqmp-modepin.c  |  2 +-
 drivers/gpio/gpiolib-acpi-quirks.c  |  3 ++-
 101 files changed, 231 insertions(+), 211 deletions(-)


base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
-- 
2.55.0.11.g153666a7d9bb

