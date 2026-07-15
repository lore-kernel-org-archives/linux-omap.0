Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A33B3888
	for <linux-omap@vger.kernel.org>; Wed, 15 Jul 2026 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134569; cv=none; b=QlsOfbZ1JBtTlNA5qOKQWdpyUF625eho1FTQCIsXo0NMTLEVAhKYC6czv9wlhKAO1W1KrTjmxV691yy0c2whHyhuTla6tJAyBWIjGvQv7xYmr6rl/TXGtQOhiPObMOaSlipF2jV6oe7ZfkrCwJtFcVkeim+Jf68IhWXKZJZ+L5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134569; c=relaxed/simple;
	bh=IWUCunGUaTCNiIjJZFExRrEmVa81OfH9Xay6Y9Sp9+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=obr36YjLCpqF9S1iHM2VLshmF84ovpB0/kSXFYnrRSksLJiUhqNmvd8knyHOxffmHrRS4MbIFUKbm0SOJTBxuo7WB2yLaddkQNtI5hcDDYy5cHG9zYktaxZzdbIZYy6IQmZ+y1c1uQbPnntfiQriwVZoEAbd3Hl4gQupHPFBd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Sk8E7JgZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Sk8E7JgZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so40925205e9.1
        for <linux-omap@vger.kernel.org>; Wed, 15 Jul 2026 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784134563; x=1784739363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dc9Aopu2Z728JKtTIyYoYTkFBGcLajEY2h1IaXFOYK4=;
        b=Sk8E7JgZ9QqHvLIBBkfBmNVNpje85Pf9Cww9Mu2irimAnE2tVv/LJJYsOY3Hez12p8
         tTWmpcnZUKVyj7+Mq5IavtVMvpcbe/2VvwONESmnH5wtAePUCJ9kCGOWAswVSVD6TgnJ
         ps335RqHyORIHjXX6j3IBiY3c9wWfprB0n1IYjp7VCqb+KjzWEW21YRI12qA0dbYqmZh
         sSZ6Rp+iIyUYfrMxRpvm8ZWsAlpnOENDZqinnBOP/75tAs3+35Nco1NhPudZR30M5odE
         uciZmblCIzAMlj2Pe1Dl2hzH7V9ti/O1VDeP0EnDVPLeFWRbbj+gSvf3Z6vAlkPQHtz0
         wY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784134563; x=1784739363;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dc9Aopu2Z728JKtTIyYoYTkFBGcLajEY2h1IaXFOYK4=;
        b=EPWkA/iczUqBHeCmZz+bHi+TmWOj+xnZFcp52TeaHr5otlBvi+eFGbVXAlmxe716jV
         HDyVQSJz972/vIboB+G2Jor1+tjUXD307RSev3/pUJyl6GnctZfUUzaZua6FduLlqmuZ
         VbO5C7jJ+yLhZJa/D0t8fUsvOSJGsbjQOlS1otohxtmzoFAp6BmW6vd4I89Pgq/wwBKN
         wfMjj8p82Y53cDu6CM6XMVDaWbbyjaRST1oBLYqeDG79qQC6kj8Go89m6o4pmHXnl/+J
         rrK2LwarJHovMv93d0S6YtVVNoSWNn6RwG/sgtVJVsj/C33mQ1nTzLdBq2j8AdKgzPyV
         2YMA==
X-Forwarded-Encrypted: i=1; AHgh+RpDjOaqs1a2bFXATQWCLUTfDtSBq7vFR2MTkIEy8+IQXCnP0F6PXEYBuAPhUCPHPLauuaO07SuZHmWH@vger.kernel.org
X-Gm-Message-State: AOJu0YwFT5RXuZEpfg/Jmlg+IVvIgXVcdzyNZPGhWbIW3oG96HnWMjx8
	vpl87oaVXI5+6RWHx54R65J+rlFNaetSzojSPJUBh2azfheEVbFVqwPg9eckb3JF+5Q=
X-Gm-Gg: AfdE7cnsfwFSvGKZCkcBd+17rSFt65wk47AR9kYIWU0euDx/ZQNur2a1y2wYBl9Yz8L
	/gfcF9kevjR2mpc4zw+F5eDUP08Za6RvHMQckjbQR0rA5nTlSjnoOGKiul9IzIQL8C8hC/kpcSu
	PkJ+wbiQY14LdeSVG+KoUCybgotfefeaz9nnifoWD9pQOEMO8lu6Y27ry6RT+vIDN7u6IQL9XO+
	nOvfSL519fG+pyrTMF0AH/jJenAZjjzJ3h1gZhVqBhEdbHcwxQ8aI94dDDiqqgSivHeOqsDkYgs
	REdZEoBfwRDpR/UL7/7agkohLK2W7tRUGOFCEjdOrscr2vRLc+/XYujjRXIJP5bVBsrngZhSZ6h
	ge4PrQyc6gvyvTd5m8ceq1Z/kabpxBMc2Nvk/t0HtPuIJZn4ddh+eXSaFVWGDV0WFxQDcwaL+V7
	x9xLjqpiM1uf31fKP6TfFFwOczFowG8u7Mmt1PtXRk09OacYoA9BETwAqqAx/EYhVZ0M419fQ9h
	uI=
X-Received: by 2002:a05:600c:350a:b0:493:bb23:152a with SMTP id 5b1f17b1804b1-4953c28868emr41628395e9.34.1784134563454;
        Wed, 15 Jul 2026 09:56:03 -0700 (PDT)
Received: from localhost (p200300f65f47db04249e031dea91a10d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:249e:31d:ea91:a10d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4953c6ff429sm47318815e9.1.2026.07.15.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:56:02 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
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
	Hoan Tran <hoan@os.amperecomputing.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	virtualization@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
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
	linux-aspeed@lists.ozlabs.org,
	asahi@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-unisoc@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Michael Buesch <m@bues.ch>,
	William Breathitt Gray <wbg@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 00/21] gpio: Improvements around device-id arrays
Date: Wed, 15 Jul 2026 18:55:05 +0200
Message-ID: <cover.1784133987.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8054; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=IWUCunGUaTCNiIjJZFExRrEmVa81OfH9Xay6Y9Sp9+8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqV7tpcWa4IDqdHE07WRN6KbaBUpPQqFeHKz38l NPYom/XImOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCale7aQAKCRCPgPtYfRL+ TtTaB/wMHdo4jeTAu8TDocMrZIkg854g5QFjcfbVE54N17jnr4AIRFzaeHw5Ef3dkM+guUxSwmj F5MR8eG3l1tF9YtUNmlhbx/vfxy40WhQn9DtmnjtWzwMlcrq2Bx1Qy3dAIUKRmWu8OBHmQoLETO JQ4Z0G/Aungdh91TZCoSgDUdjGBT9AqikXKikNh82DMEMiG8tx14PL5vabsoJ+RX+kgTyt3svCn U25sKCqazurzcIFFDvuLBrl46NkLy88JS0XSCIhIpvTjh0oHlkKksNl1o0uzGB+W2A9BEDa799A SZq7t3HXFBTrZVb4r5+uP0V69VjegzndPUWsZzWqJxaovWlm
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

as with v1 the original motivation for this series are the patches that
convert the arrays to use named initializers, see
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for the idea behind it. Then by not closing the eyes for small issues
spotted while working on that, this series grew a bit.

Changes since v1 (available at
https://lore.kernel.org/linux-kernel/cover.1784013063.git.u.kleine-koenig@baylibre.com):

 - Trivially rebase to today's next/master
 - The first two patches are new. My script didn't match on device-id
   arrays that are marked with __maybe_unused, so the drivers touched in
   these two patches are adapted further down, too.
 - Fixed capitalisation of PCI (Andy), did the same for ACPI
 - Sort the ACPI device-id arrays by .id in the "unify" patch (only one
   instance in gpio-dwapb.c was unsorted), suggested by Andy.
 - Found a few other inconsistent device_id arrays that my script didn't
   match (due to .driver_data not being a single expression or a comment
   in the terminator or more than one array in a single file)
 - Fixed cast expressions in drivers/gpio/gpio-mvebu.c to please
   checkpatch
 - Dropped the dmi MODULE_DEVICE_TABLE patch
 - Added review tags from v1

Checkpatch only reports two undocumented device-tree compatibles. I felt
free to ignore these as this is a pre-existing issue and out-of-context
for this series.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (21):
  gpio: Remove __maybe_unused annotations from acpi_device_id arrays
  gpio: fxl6408: Remove __maybe_unused annotations from of_device_id
    array
  gpio: Drop unused assignment of acpi_device_id driver data
  gpio: max7301: Drop unused assignment of spi_device_id driver data
  gpio: mmio: Drop unused assignment of platform_device_id driver data
  gpio: ljca: Drop unused assignment of auxiliary_device_id driver data
  gpio: Add missing ACPI module annotations
  gpio: sodaville: Add missing PCI module annotations
  gpio: Add missing OF module annotations
  gpio: pxa: Add missing platform module annotations
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
 drivers/gpio/gpio-blzp1600.c        |  4 ++--
 drivers/gpio/gpio-brcmstb.c         |  2 +-
 drivers/gpio/gpio-bt8xx.c           |  2 +-
 drivers/gpio/gpio-cadence.c         |  6 +++---
 drivers/gpio/gpio-creg-snps.c       |  5 +++--
 drivers/gpio/gpio-davinci.c         |  8 ++++----
 drivers/gpio/gpio-dwapb.c           | 14 +++++++-------
 drivers/gpio/gpio-em.c              |  4 ++--
 drivers/gpio/gpio-ep93xx.c          |  1 +
 drivers/gpio/gpio-ftgpio010.c       |  3 ++-
 drivers/gpio/gpio-fxl6408.c         |  2 +-
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
 drivers/gpio/gpio-mlxbf.c           |  6 +++---
 drivers/gpio/gpio-mlxbf2.c          |  6 +++---
 drivers/gpio/gpio-mlxbf3.c          |  4 ++--
 drivers/gpio/gpio-mm-lantiq.c       |  2 +-
 drivers/gpio/gpio-mmio.c            |  3 +--
 drivers/gpio/gpio-mockup.c          |  4 ++--
 drivers/gpio/gpio-moxtet.c          |  4 ++--
 drivers/gpio/gpio-mpc5200.c         |  9 +++++----
 drivers/gpio/gpio-mpc8xxx.c         | 25 +++++++++++++------------
 drivers/gpio/gpio-mpfs.c            |  1 +
 drivers/gpio/gpio-mpsse.c           |  3 +--
 drivers/gpio/gpio-msc313.c          |  1 +
 drivers/gpio/gpio-mt7621.c          |  2 +-
 drivers/gpio/gpio-mvebu.c           | 13 +++++++------
 drivers/gpio/gpio-mxc.c             |  2 +-
 drivers/gpio/gpio-mxs.c             |  4 ++--
 drivers/gpio/gpio-nomadik.c         |  7 ++++---
 drivers/gpio/gpio-novalake-events.c |  4 ++--
 drivers/gpio/gpio-npcm-sgpio.c      |  6 +++---
 drivers/gpio/gpio-octeon.c          |  2 +-
 drivers/gpio/gpio-omap.c            |  2 +-
 drivers/gpio/gpio-palmas.c          | 10 +++++-----
 drivers/gpio/gpio-pca953x.c         |  4 ++--
 drivers/gpio/gpio-pca9570.c         |  2 +-
 drivers/gpio/gpio-pcf857x.c         | 26 +++++++++++++-------------
 drivers/gpio/gpio-pci-idio-16.c     |  3 ++-
 drivers/gpio/gpio-pcie-idio-24.c    |  8 +++++---
 drivers/gpio/gpio-pisosr.c          |  4 ++--
 drivers/gpio/gpio-pl061.c           |  2 +-
 drivers/gpio/gpio-pmic-eic-sprd.c   |  2 +-
 drivers/gpio/gpio-pxa.c             | 20 +++++++++++---------
 drivers/gpio/gpio-qixis-fpga.c      |  3 +--
 drivers/gpio/gpio-rcar.c            |  2 +-
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
 drivers/gpio/gpio-tegra.c           |  6 +++---
 drivers/gpio/gpio-tegra186.c        | 26 +++++++++++++-------------
 drivers/gpio/gpio-thunderx.c        |  3 +--
 drivers/gpio/gpio-tps65218.c        |  2 +-
 drivers/gpio/gpio-ts4800.c          |  4 ++--
 drivers/gpio/gpio-ts4900.c          |  2 +-
 drivers/gpio/gpio-twl4030.c         |  4 ++--
 drivers/gpio/gpio-usbio.c           | 13 +++++++------
 drivers/gpio/gpio-vf610.c           |  4 ++--
 drivers/gpio/gpio-virtio.c          |  4 ++--
 drivers/gpio/gpio-visconti.c        |  2 +-
 drivers/gpio/gpio-waveshare-dsi.c   |  2 +-
 drivers/gpio/gpio-xgene-sb.c        |  6 +++---
 drivers/gpio/gpio-xgene.c           | 10 ++++++----
 drivers/gpio/gpio-xgs-iproc.c       |  2 +-
 drivers/gpio/gpio-xilinx.c          |  4 ++--
 drivers/gpio/gpio-xlp.c             |  6 +++---
 drivers/gpio/gpio-xra1403.c         |  6 +++---
 drivers/gpio/gpio-zevio.c           |  5 +++--
 drivers/gpio/gpio-zynqmp-modepin.c  |  2 +-
 drivers/gpio/gpiolib-acpi-quirks.c  |  2 +-
 106 files changed, 265 insertions(+), 247 deletions(-)


base-commit: b8809969e1d7a591e0f49dd464a5d04b3cf02ab1
-- 
2.55.0.11.g153666a7d9bb

