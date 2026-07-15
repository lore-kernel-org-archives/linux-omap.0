Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48AE41A565;
	Wed, 15 Jul 2026 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138588; cv=none; b=kF2EkRK6nIbAPacjxo2fcJorg1hOQfDO6gdJdpJoLu49fjMezorS5A0PKAwuGRiN0ooP1QEDUv7oxHrt4ZXh+H9dGF1nHl7gI96l+yYxISohG/LM6hbbsLZZ4kvr9DcI5qNFzE55lTB8c8iHti5eXQXZWMuX5Zwj4hZdD5YmFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138588; c=relaxed/simple;
	bh=ke3E5EttLeWiiEpEeXKV5/D2Jy1tJKCKfZGCrohPCjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RHm1hShlkK/xIIEjVHtHkJmfxMveNY6488VEUJkgPW0QkclbI6zFfDUdg90QLU0txGhWd+BBdfGyb53X7wJCufddzjT7NwUgMU7QktB3ppBCgtipmrTGmSLyUGKPGtjBLOKWAyCsp2zAK67rHaDbbIaIceUG47nEoBcfEnxjYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id E9559F40D1B; Wed, 15 Jul 2026 19:52:33 +0200 (CEST)
From: Link Mauve <linkmauve@linkmauve.fr>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	"Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	Kalyani Akula <kalyani.akula@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Joshua Kinard <linux@kumba.dev>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	Salah Triki <salah.triki@gmail.com>,
	Yury Norov <ynorov@nvidia.com>,
	David Carlier <devnexen@gmail.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Patrick Wicki <patrick.wicki@siemens.com>,
	Markus Heidelberg <m.heidelberg@cab.de>,
	Markus Perkins <markus@notsyncing.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-omap@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 0/8] nvmem: make reg_write() take a const void *
Date: Wed, 15 Jul 2026 19:52:16 +0200
Message-ID: <20260715175229.24672-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This callback used to take a mutable void * for no reason, which causes
the compiler to be unaware that the val buffer should never be modified
by the callback.

This was found while drafting the nvmem-provider Rust abstraction.

I’ve split this series based on the subsystem each patch affects, but I
think it should go through the nvmem tree in one go after gathering the
acks from the other subsystem maintainers.

I’ve been told previously to not include too many maintainers in Cc, but
I don’t know which ones to remove from the get_maintainers.pl output, so
I’ve still included everyone, sorry about that.

Thanks,

Link Mauve (8):
  nvmem: core: make reg_write() take a const void *
  nvmem: make all reg_write callbacks take const void *
  rtc: make all reg_write callbacks take const void *
  misc: make all reg_write callbacks take const void *
  iio: pressure: bmp280: make reg_write callback take const void *
  firmware: meson_sm: make reg_write callback take const void *
  mfd: twl-core: make reg_write callback take const void *
  media: ov2740: remove NULL reg_write callback

 drivers/firmware/meson/meson_sm.c                 | 2 +-
 drivers/iio/pressure/bmp280-core.c                | 6 +++---
 drivers/media/i2c/ov2740.c                        | 1 -
 drivers/mfd/twl-core.c                            | 2 +-
 drivers/misc/ds1682.c                             | 2 +-
 drivers/misc/eeprom/at24.c                        | 4 ++--
 drivers/misc/eeprom/at25.c                        | 2 +-
 drivers/misc/eeprom/eeprom_93xx46.c               | 4 ++--
 drivers/misc/eeprom/m24lr.c                       | 2 +-
 drivers/misc/keba/cp500.c                         | 2 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c | 8 ++++----
 drivers/nvmem/bcm-ocotp.c                         | 4 ++--
 drivers/nvmem/core.c                              | 2 +-
 drivers/nvmem/imx-ocotp-scu.c                     | 4 ++--
 drivers/nvmem/imx-ocotp.c                         | 4 ++--
 drivers/nvmem/lan9662-otpc.c                      | 4 ++--
 drivers/nvmem/lpc18xx_eeprom.c                    | 4 ++--
 drivers/nvmem/max77759-nvmem.c                    | 2 +-
 drivers/nvmem/meson-efuse.c                       | 4 ++--
 drivers/nvmem/qcom-spmi-sdam.c                    | 2 +-
 drivers/nvmem/qfprom.c                            | 4 ++--
 drivers/nvmem/rave-sp-eeprom.c                    | 4 ++--
 drivers/nvmem/snvs_lpgpr.c                        | 2 +-
 drivers/nvmem/sprd-efuse.c                        | 4 ++--
 drivers/nvmem/stm32-bsec-optee-ta.c               | 2 +-
 drivers/nvmem/stm32-bsec-optee-ta.h               | 4 ++--
 drivers/nvmem/stm32-romem.c                       | 6 +++---
 drivers/nvmem/zynqmp_nvmem.c                      | 4 ++--
 drivers/rtc/rtc-abx80x.c                          | 4 ++--
 drivers/rtc/rtc-cmos.c                            | 2 +-
 drivers/rtc/rtc-ds1305.c                          | 4 ++--
 drivers/rtc/rtc-ds1307.c                          | 2 +-
 drivers/rtc/rtc-ds1343.c                          | 2 +-
 drivers/rtc/rtc-ds1511.c                          | 2 +-
 drivers/rtc/rtc-ds1553.c                          | 4 ++--
 drivers/rtc/rtc-ds1685.c                          | 4 ++--
 drivers/rtc/rtc-ds1742.c                          | 4 ++--
 drivers/rtc/rtc-ds3232.c                          | 2 +-
 drivers/rtc/rtc-isl12026.c                        | 4 ++--
 drivers/rtc/rtc-isl1208.c                         | 2 +-
 drivers/rtc/rtc-m48t59.c                          | 4 ++--
 drivers/rtc/rtc-m48t86.c                          | 2 +-
 drivers/rtc/rtc-max31335.c                        | 2 +-
 drivers/rtc/rtc-meson.c                           | 2 +-
 drivers/rtc/rtc-omap.c                            | 4 ++--
 drivers/rtc/rtc-pcf2127.c                         | 2 +-
 drivers/rtc/rtc-pcf85063.c                        | 2 +-
 drivers/rtc/rtc-pcf85363.c                        | 4 ++--
 drivers/rtc/rtc-rp5c01.c                          | 4 ++--
 drivers/rtc/rtc-rv3028.c                          | 6 +++---
 drivers/rtc/rtc-rv3029c2.c                        | 2 +-
 drivers/rtc/rtc-rv3032.c                          | 4 ++--
 drivers/rtc/rtc-rv8803.c                          | 4 ++--
 drivers/rtc/rtc-rx8581.c                          | 4 ++--
 drivers/rtc/rtc-s35390a.c                         | 4 ++--
 drivers/rtc/rtc-stk17ta8.c                        | 4 ++--
 drivers/rtc/rtc-sun6i.c                           | 4 ++--
 drivers/rtc/rtc-ti-k3.c                           | 2 +-
 drivers/rtc/rtc-twl.c                             | 2 +-
 include/linux/firmware/meson/meson_sm.h           | 2 +-
 include/linux/mfd/twl.h                           | 4 ++--
 include/linux/nvmem-provider.h                    | 2 +-
 62 files changed, 100 insertions(+), 101 deletions(-)

-- 
2.55.0

