Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C041A56E;
	Wed, 15 Jul 2026 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138592; cv=none; b=fPBhdsif8PiDaCOAkaUnecaDANjrdtb3ADYCTutVU/0UHEbqKQpEXbB9nh97i9woaMl1P34w8Nc9DHhWb0VHOr6SnTww2Bq4Q/U+W/tZr1eE+eMUyYoMNhTX1mOuko6K9kNL/xK2wpM/YE7NtVkvhvFMyyzFNBwZI57ZO9MFFGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138592; c=relaxed/simple;
	bh=9OgfLL5KgScCxZBmXsZuyUZVZq0idXb05mKOPsKZp4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejSkiI/3WgXMUvid9TaSUDzg4BrcfFsX4P2xUm+z3qwlDvGkc3om9t8SQ/w6F/cPrVHI8qfTZQiobR1Sfuf7ehtI50AKSWYcd8q2C8LBuR5NW8A9kMkc+Bvb6PH0khqykffBhlG5YyS/F9aZ10N98OYtFqAeZXH5+mlW7pA09jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 093A2F40D21; Wed, 15 Jul 2026 19:52:42 +0200 (CEST)
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
Subject: [PATCH 4/8] misc: make all reg_write callbacks take const void *
Date: Wed, 15 Jul 2026 19:52:20 +0200
Message-ID: <20260715175229.24672-5-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715175229.24672-1-linkmauve@linkmauve.fr>
References: <20260715175229.24672-1-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The previous commit switched from a pointer to mutable data to a pointer
to immutable data, so let’s fix all users of the nvmem_config API.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
---
 drivers/misc/ds1682.c                             | 2 +-
 drivers/misc/eeprom/at24.c                        | 4 ++--
 drivers/misc/eeprom/at25.c                        | 2 +-
 drivers/misc/eeprom/eeprom_93xx46.c               | 4 ++--
 drivers/misc/eeprom/m24lr.c                       | 2 +-
 drivers/misc/keba/cp500.c                         | 2 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c | 8 ++++----
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
index cb09e056531a..4e42a45c17d4 100644
--- a/drivers/misc/ds1682.c
+++ b/drivers/misc/ds1682.c
@@ -209,7 +209,7 @@ static int ds1682_nvmem_read(void *priv, unsigned int offset, void *val,
 	return ret < 0 ? ret : 0;
 }
 
-static int ds1682_nvmem_write(void *priv, unsigned int offset, void *val,
+static int ds1682_nvmem_write(void *priv, unsigned int offset, const void *val,
 			      size_t bytes)
 {
 	struct i2c_client *client = priv;
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 772c4d9fa651..cd38cf8aad45 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -477,11 +477,11 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	return 0;
 }
 
-static int at24_write(void *priv, unsigned int off, void *val, size_t count)
+static int at24_write(void *priv, unsigned int off, const void *val, size_t count)
 {
 	struct at24_data *at24;
 	struct device *dev;
-	char *buf = val;
+	const char *buf = val;
 	int ret;
 
 	at24 = priv;
diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index bc2cfb75d9bb..28f1dc1b9be7 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -235,7 +235,7 @@ static int at25_wait_ready(struct at25_data *at25)
 	return bounce[0];
 }
 
-static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
+static int at25_ee_write(void *priv, unsigned int off, const void *val, size_t count)
 {
 	u8 *bounce __free(kfree) = kmalloc(min(count, io_limit), GFP_KERNEL);
 	struct at25_data *at25 = priv;
diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index f9c3ab52c2f9..813f295af096 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -268,10 +268,10 @@ eeprom_93xx46_write_word(struct eeprom_93xx46_dev *edev,
 }
 
 static int eeprom_93xx46_write(void *priv, unsigned int off,
-				   void *val, size_t count)
+			       const void *val, size_t count)
 {
 	struct eeprom_93xx46_dev *edev = priv;
-	char *buf = val;
+	const char *buf = val;
 	int ret, step = 1;
 	unsigned int i;
 
diff --git a/drivers/misc/eeprom/m24lr.c b/drivers/misc/eeprom/m24lr.c
index 7a9fd45a8e46..22f3221e232b 100644
--- a/drivers/misc/eeprom/m24lr.c
+++ b/drivers/misc/eeprom/m24lr.c
@@ -374,7 +374,7 @@ static int m24lr_nvmem_read(void *priv, unsigned int offset, void *val,
 	return 0;
 }
 
-static int m24lr_nvmem_write(void *priv, unsigned int offset, void *val,
+static int m24lr_nvmem_write(void *priv, unsigned int offset, const void *val,
 			     size_t bytes)
 {
 	ssize_t err;
diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
index 6c65fbf22e75..ee7889cb63a8 100644
--- a/drivers/misc/keba/cp500.c
+++ b/drivers/misc/keba/cp500.c
@@ -590,7 +590,7 @@ static int cp500_nvmem_read(void *priv, unsigned int offset, void *val,
 	return 0;
 }
 
-static int cp500_nvmem_write(void *priv, unsigned int offset, void *val,
+static int cp500_nvmem_write(void *priv, unsigned int offset, const void *val,
 			     size_t bytes)
 {
 	struct cp500_nvmem *nvmem = priv;
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
index a2ed477e0370..f2759e9b4138 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
@@ -159,11 +159,11 @@ static int pci1xxxx_eeprom_read(void *priv_t, unsigned int off,
 }
 
 static int pci1xxxx_eeprom_write(void *priv_t, unsigned int off,
-				 void *value_t, size_t count)
+				 const void *value_t, size_t count)
 {
 	struct pci1xxxx_otp_eeprom_device *priv = priv_t;
 	void __iomem *rb = priv->reg_base;
-	char *value = value_t;
+	const char *value = value_t;
 	u32 regval;
 	u32 byte;
 	int ret;
@@ -262,11 +262,11 @@ static int pci1xxxx_otp_read(void *priv_t, unsigned int off,
 }
 
 static int pci1xxxx_otp_write(void *priv_t, unsigned int off,
-			      void *value_t, size_t count)
+			      const void *value_t, size_t count)
 {
 	struct pci1xxxx_otp_eeprom_device *priv = priv_t;
 	void __iomem *rb = priv->reg_base;
-	char *value = value_t;
+	const char *value = value_t;
 	u32 regval;
 	u32 byte;
 	int ret;
-- 
2.55.0

