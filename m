Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032166;
	b=nb7X4fqqjyXHMRf9t2iJuJCA+Qf773n6pRKrWX+e1XukGkfb9ZOEBCyqIlw8aRqhDSD/
	 kFE15Ejil+K4dg6CiiCQ29Y6tadhJDKxF/LC9LN+3wGCpj5zEU/+P2cX/Vj7gpv5uSKlH
	 uYX3ZWTADq9+D8FZehVVcjaP6ZKjYSNiVxxYGK6zh83qf8r0g84vllEk2LeJzOHs/S2GC
	 C9Dvqp2IqKAp7lMkScUUdqWtKVgVg0T0nw3nFRlCIZlHJC/c6V22sGWrWwPejtXKuNBVg
	 gCnutx+RFx0KvxKFbwiGdOWv0fTb6N2cJQdUEmFI5pcvU1i4FV5IgP0EWWSZOOOf0WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=ITqbDSTjwjfbrrpkyujx4v8CTbfspgT4IGjU+cO6egY=;
	b=C7aQ3ESvlInFfTP0BR+LAJ5ESxLSsCJk/1wQLU/tqGmapdLhsckgRQzG5JEG9sqCzHme
	 KnI7P0EtxUXz/rzNzCV4Nh8oXYLo3MBBs8fxifo3zNZJfgRwj+YXYc0nrGgQwfknDWzDv
	 xt8uwd6NX0N1uHoxoQO6thUYlOiVV5P0b5pCI5MN0GleM+P7bMoJ8kuGF0Jn7zsteMk/9
	 daUMHkvY0v5PIMpp85dqIsUYTj+xFjzlhbtxB1XbUdellEWONQo5koeR8FWh5/Ksh1BPl
	 KlY0rpIONE8EwFZWGZLe7RF4uCiINFx92UlHF6MS6lVG29pvy/6lCLuz9N740vQD9Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DifXhBTJ;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FE606A322
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 16:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 549FE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DifXhBTJ
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so13863025e9.0
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2026 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793032163; x=1793636963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITqbDSTjwjfbrrpkyujx4v8CTbfspgT4IGjU+cO6egY=;
        b=DifXhBTJvVk6Znsfpih+FjoF5Wrg8MrElM8vyIYQMuriEdZUtnmV1Ytb2fl6ArI9rS
         D+7w6w3VpIz+TsP1rgGV2DdnTf+azKO0nz7iMBN/ilkiUuoHSciiqM8LieFFsMm7HXTC
         OF24i9+3qwQtdvqBQQnWKSKIl6x9VkXIuL4LDFEbsEJNC0zgbXm2cgUwYJOLnJG/zhOI
         cE6NBCl16W61Eqz27cCC0I+HYoboIJMACuuniRG48Hfab5GyC/3a52VvGpFR5KSNjwmQ
         AcBqRQugntBg1pxLccN5iKH5pEMTNRivZ1B2IN3ifWFJctq1M1c2XptTKy6HcKE0++lG
         0DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032163; x=1793636963;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ITqbDSTjwjfbrrpkyujx4v8CTbfspgT4IGjU+cO6egY=;
        b=ttkOQ+nNsQlCjds0yN5/xGYC65g2V9AxmG/A1jdSodXJfOeYCxeovzkGPv9OOPELQL
         yXUb0mnAHH3CWNDoMatfAInr/JHFZ5msmX5df4dxmL2rO8/dl3Pmzwao8NWZPh6qMnRo
         zKnSCiYmT+S3dADYu3NzpK7PRALKOAEM4AV5uCF7lYl72eO6hmSBzpZsVEZmx3T1bIrd
         ZOKm41o2YcKJzrCeIHmuu1tCdYdg29xu+hhaF6jRJyTev5pCo9Y8vdzNhqr+9r9xesKI
         EacHxazreE9DnhER/piP3P0Ifvb/nHlNS/NGEF04DD+MPQXj3Mnv1soQ2hwVQmXUUFDL
         uCSA==
X-Forwarded-Encrypted: i=1; AKwUvBzdZBlkaQx0j3JwQlndk7M15Cws4nenydtpfTsGYTafM2ZYGykiI+RiuhGRGix1c1NxJ4gly1ArkuQP@vger.kernel.org
X-Gm-Message-State: AFq9FYJPi7n9qND9il3J8ZZdTvkQ8HO8OoEegwZ1tfcuHiVBnUQLtfU1
	24bbsmHHQvoR898GvbhYFSKG6yIFkbzpQ4y5F6NCb8Od2XRHX5v8StUzG1M8J0GfncY=
X-Gm-Gg: AYBFou11qClzboyJWx+rp/VPGpAbOe1Ghua0/cVrc0Ye/DmV0IFKY+ZaaSqVU/dleNO
	YfOPwDS0C739s9i2Gl1l991sJcZWbym9f2RdFUAcr79T8/AaYq5czgRUqQOnoOL8KGvrETct5Jb
	XaP0ZHsV3BNemHJlqVzCHnYx9rZqodkPCyNk4FmpUN5BpeVZdjXOxG4mDCqfNpZjKpddoLBIyiL
	B/LSOKwFfOnIVTnCGOl0fL7BiCzuQ1IDgVs+h+wOzWTP0FKYiv5SzFmOIHG9xNyGdtGgNM+yHqk
	Lln00B4PxwSJLe9MNqIZ+3J+whH7Jz+JiWNDztGOOjTzFpJBrFtwxegVGErrzXucop+BhJRgZIi
	dRMrIz53GKLiNnjunXwc7FhhTqeTDErf7xS8dQKodj2FpGjYVJySbRIk1K+9zlJh5RhI98PTF4C
	sL3zjd8tUdakgubQXQIhzBw8Bi+C3qtBFKn5vkjzhZK8chfU3M9jzRPzCxPElmfWRTUGjnVatxI
	k0oXdupG1auTyga15z9P+D10yy6rQggCEf8holE+/AmQW6ArT/3ZOFgGbAcWEwYc7JYwINZ7V2l
	8A4PtD5S2NCG7KCXCDn4ymNgIC6NpLN4C7YU4FgA/M4=
X-Received: by 2002:a05:600c:474a:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4a35acb9afamr139448685e9.33.1793032162560;
        Mon, 26 Oct 2026 09:29:22 -0700 (PDT)
Received: from localhost (p200300f65f19a904cbccaa7a4d73ac15.dip0.t-ipconnect.de. [2003:f6:5f19:a904:cbcc:aa7a:4d73:ac15])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e3ecd8dcfsm17304483f8f.50.2026.10.26.09.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:29:21 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Shen <shenyang39@huawei.com>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ray Jui <rjui@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Imre Kaloz <kaloz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
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
	Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	virtualization@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
Subject: [PATCH v3 00/22] gpio: Improvements around device-id arrays
Date: Mon, 26 Oct 2026 17:28:11 +0100
Message-ID: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8375; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=/oBogVX4W/l/tSbRcbLeyK5GzZPZsHFXHxISWg2r7FU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq33+c3CfzXRBmptFu1GW2GtVslcFR47MrFB6ag QI8Xzy686OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCat9/nAAKCRCPgPtYfRL+ TixACACdtBFK6kNYWLMcAtstDryOYl7PdfPG1N2WQbOF3hzVRHuidZJEElOlxQOHOxjmH5QxfjG oK6tEHPvQpPYGNE6X2ddRlR3vKhFUQXZie3uQhpRkFU+T2B/9DaN4bQiSXUkhXTzFYvqdfGt+bx UbRl8w0O3UDWE1J1O3+WraRa9pLQ1EiCUZzbGW6h1FRI28X6Atl+O3zYxu2WImvV46mPVm5T7XZ b0jHMwW4knA+B/zWMTvL7A92KmAeoLFPWwfaif9ujRL8DnOG5TkQO7aEpnmwLg6WGA9ruZ09COA LKAAW+CtN1A3UjlRp4pFGny5ogYUqSyfQs1hycndKa4RLwtW
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

as with v1 and v2 the original motivation for this series are the
patches that convert the arrays to use named initializers, see
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for the idea behind it. Then by not closing the eyes for small issues
spotted while working on that, this series grew a bit.

Changes since v2 (available at
https://lore.kernel.org/all/cover.1784133987.git.u.kleine-koenig@baylibre.com/)

 - Rebase to current next/master (new changes to
   drivers/gpio/gpio-mlxbf.c, drivers/gpio/gpio-mlxbf2.c,
   drivers/gpio/gpio-74x164.c)
 - Fix a few commit logs to reference the right *_device_id names
 - Drop all tags for Andy
 - Drop a questionable MODULE_DEVICE_TABLE(acpi, ...) for drivers/gpio/gpio-usbio.c

Checkpatch only reports two undocumented device-tree compatibles:

	WARNING: DT compatible string "apm,xgene-gpio-v2" appears un-documented -- check ./Documentation/devicetree/bindings/
	WARNING: DT compatible string "marvell,pxa1928-gpio" appears un-documented -- check ./Documentation/devicetree/bindings/

I felt free to ignore these as this is a pre-existing issue and
out-of-context for this series.

Andy didn't like how this series is split into patches before, I do. I
think it's not possible to please everyone's opinion regarding minimal
changes per patch vs grouping similar changes in patches and about what
is considered churn. I'm happy about every patch in this series that
goes in, so feel free to apply patches that you like and that don't get
resistance even if other's do. If patches don't apply, just drop them,
I'll catch up on them eventually.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (22):
  gpio: Remove __maybe_unused annotations from acpi_device_id arrays
  gpio: fxl6408: Remove __maybe_unused annotations from of_device_id
    array
  gpio: Drop unused assignment of acpi_device_id driver data
  gpio: max7301: Drop unused assignment of spi_device_id driver data
  gpio: mmio: Drop unused assignment of platform_device_id driver data
  gpio: ljca: Drop unused assignment of auxiliary_device_id driver data
  gpio: xgene: Add missing ACPI module annotation
  gpio: sodaville: Add missing PCI module annotations
  gpio: Add missing OF module annotations
  gpio: pxa: Add missing platform module annotations
  gpio: pl061: Use empty initializer for amba_id terminator
  gpio: Use named initializers for acpi_device_id array
  gpio: pcf857x: Use named initializers for of_device_id array
  gpio: bd73800: Use named initializers for platform_device_id array
  gpio: Use named initializers for spi_device_id array
  gpio: virtio: Use a named initializer for virtio_device_id array
  gpio: Unify style of acpi_device_id arrays
  gpio: Unify style of of_device_id arrays
  gpio: max77620: Unify style of platform_device_id array
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
 drivers/gpio/gpio-aspeed-sgpio.c    | 10 ++++-----
 drivers/gpio/gpio-aspeed.c          | 10 ++++-----
 drivers/gpio/gpio-ath79.c           |  2 +-
 drivers/gpio/gpio-bcm-kona.c        |  1 +
 drivers/gpio/gpio-bd73800.c         |  4 ++--
 drivers/gpio/gpio-blzp1600.c        |  4 ++--
 drivers/gpio/gpio-brcmstb.c         |  2 +-
 drivers/gpio/gpio-bt8xx.c           |  2 +-
 drivers/gpio/gpio-cadence.c         |  6 +++---
 drivers/gpio/gpio-creg-snps.c       |  5 +++--
 drivers/gpio/gpio-davinci.c         |  8 ++++----
 drivers/gpio/gpio-dwapb.c           | 14 ++++++-------
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
 drivers/gpio/gpio-max3191x.c        | 12 +++++------
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
 drivers/gpio/gpio-mpc5200.c         |  9 ++++----
 drivers/gpio/gpio-mpc8xxx.c         | 25 +++++++++++-----------
 drivers/gpio/gpio-mpfs.c            |  1 +
 drivers/gpio/gpio-mpsse.c           |  3 +--
 drivers/gpio/gpio-msc313.c          |  1 +
 drivers/gpio/gpio-mt7621.c          |  2 +-
 drivers/gpio/gpio-mvebu.c           | 13 ++++++------
 drivers/gpio/gpio-mxc.c             |  2 +-
 drivers/gpio/gpio-mxs.c             |  4 ++--
 drivers/gpio/gpio-nomadik.c         |  7 ++++---
 drivers/gpio/gpio-novalake-events.c |  4 ++--
 drivers/gpio/gpio-npcm-sgpio.c      |  6 +++---
 drivers/gpio/gpio-octeon.c          |  2 +-
 drivers/gpio/gpio-omap.c            |  2 +-
 drivers/gpio/gpio-palmas.c          | 10 ++++-----
 drivers/gpio/gpio-pca953x.c         |  4 ++--
 drivers/gpio/gpio-pca9570.c         |  2 +-
 drivers/gpio/gpio-pcf857x.c         | 26 +++++++++++------------
 drivers/gpio/gpio-pci-idio-16.c     |  3 ++-
 drivers/gpio/gpio-pcie-idio-24.c    |  8 +++++---
 drivers/gpio/gpio-pisosr.c          |  4 ++--
 drivers/gpio/gpio-pl061.c           |  2 +-
 drivers/gpio/gpio-pmic-eic-sprd.c   |  2 +-
 drivers/gpio/gpio-pxa.c             | 20 ++++++++++--------
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
 drivers/gpio/gpio-tegra186.c        | 32 ++++++++++++++---------------
 drivers/gpio/gpio-thunderx.c        |  3 +--
 drivers/gpio/gpio-tps65218.c        |  2 +-
 drivers/gpio/gpio-ts4800.c          |  4 ++--
 drivers/gpio/gpio-ts4900.c          |  2 +-
 drivers/gpio/gpio-twl4030.c         |  4 ++--
 drivers/gpio/gpio-usbio.c           | 12 +++++------
 drivers/gpio/gpio-vf610.c           |  4 ++--
 drivers/gpio/gpio-virtio.c          |  4 ++--
 drivers/gpio/gpio-visconti.c        |  2 +-
 drivers/gpio/gpio-waveshare-dsi.c   |  2 +-
 drivers/gpio/gpio-xgene-sb.c        |  6 +++---
 drivers/gpio/gpio-xgene.c           | 10 +++++----
 drivers/gpio/gpio-xgs-iproc.c       |  2 +-
 drivers/gpio/gpio-xilinx.c          |  4 ++--
 drivers/gpio/gpio-xlp.c             |  6 +++---
 drivers/gpio/gpio-xra1403.c         |  6 +++---
 drivers/gpio/gpio-zevio.c           |  5 +++--
 drivers/gpio/gpio-zynqmp-modepin.c  |  2 +-
 drivers/gpio/gpiolib-acpi-quirks.c  |  2 +-
 107 files changed, 269 insertions(+), 252 deletions(-)


base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
-- 
2.56.0.rc1

