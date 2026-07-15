Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96F41A56F;
	Wed, 15 Jul 2026 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138592; cv=none; b=hNnMqxYu4YtsF8Z9oP5EzWwAYZTEJYiXCjo0TMl2mr5JDYkefMSH8mNINCqy2Dpg1mCC04IsECSyCFj/dmycqhYtULDk+NhWVpuEkbR6YTw8x4tMOXU4B6xp6r9fMAPBgN4xxk2iw9hbLgpEtUGThEIOAOEV0uWqocvF9oJVbr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138592; c=relaxed/simple;
	bh=8W/s9BjNijh1QTjI+jxMUwKEecT0oM+Qp3RDmen/Ljo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdrOVXEMOEwVQPPtAM1DcBGCZNvaujHcVJ7xnPiI64/+ZAnAT3TzSFdKkChgpQXN1PIJ4Qnz41khL96Fj1VZivDGHK5pL2j35B6xsevG6P13voS2MPtzQFVB6d47QzVApD4BvKETwlnpQ/vx5ZqS1A7jpw3doddEuvWSaC5CmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id C170CF40D20; Wed, 15 Jul 2026 19:52:40 +0200 (CEST)
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
Subject: [PATCH 3/8] rtc: make all reg_write callbacks take const void *
Date: Wed, 15 Jul 2026 19:52:19 +0200
Message-ID: <20260715175229.24672-4-linkmauve@linkmauve.fr>
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
 drivers/rtc/rtc-abx80x.c   | 4 ++--
 drivers/rtc/rtc-cmos.c     | 2 +-
 drivers/rtc/rtc-ds1305.c   | 4 ++--
 drivers/rtc/rtc-ds1307.c   | 2 +-
 drivers/rtc/rtc-ds1343.c   | 2 +-
 drivers/rtc/rtc-ds1511.c   | 2 +-
 drivers/rtc/rtc-ds1553.c   | 4 ++--
 drivers/rtc/rtc-ds1685.c   | 4 ++--
 drivers/rtc/rtc-ds1742.c   | 4 ++--
 drivers/rtc/rtc-ds3232.c   | 2 +-
 drivers/rtc/rtc-isl12026.c | 4 ++--
 drivers/rtc/rtc-isl1208.c  | 2 +-
 drivers/rtc/rtc-m48t59.c   | 4 ++--
 drivers/rtc/rtc-m48t86.c   | 2 +-
 drivers/rtc/rtc-max31335.c | 2 +-
 drivers/rtc/rtc-meson.c    | 2 +-
 drivers/rtc/rtc-omap.c     | 4 ++--
 drivers/rtc/rtc-pcf2127.c  | 2 +-
 drivers/rtc/rtc-pcf85063.c | 2 +-
 drivers/rtc/rtc-pcf85363.c | 4 ++--
 drivers/rtc/rtc-rp5c01.c   | 4 ++--
 drivers/rtc/rtc-rv3028.c   | 6 +++---
 drivers/rtc/rtc-rv3029c2.c | 2 +-
 drivers/rtc/rtc-rv3032.c   | 4 ++--
 drivers/rtc/rtc-rv8803.c   | 4 ++--
 drivers/rtc/rtc-rx8581.c   | 4 ++--
 drivers/rtc/rtc-s35390a.c  | 4 ++--
 drivers/rtc/rtc-stk17ta8.c | 4 ++--
 drivers/rtc/rtc-sun6i.c    | 4 ++--
 drivers/rtc/rtc-ti-k3.c    | 2 +-
 drivers/rtc/rtc-twl.c      | 2 +-
 31 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 5486d9d0b1e5..c401c70cbace 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -733,10 +733,10 @@ static int abx80x_nvmem_read(void *priv, unsigned int offset, void *val,
 	return abx80x_nvmem_xfer(priv, offset, val, bytes, false);
 }
 
-static int abx80x_nvmem_write(void *priv, unsigned int offset, void *val,
+static int abx80x_nvmem_write(void *priv, unsigned int offset, const void *val,
 			      size_t bytes)
 {
-	return abx80x_nvmem_xfer(priv, offset, val, bytes, true);
+	return abx80x_nvmem_xfer(priv, offset, (void *)val, bytes, true);
 }
 
 static int abx80x_setup_nvmem(struct abx80x_priv *priv)
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fa04ece151b8..09da71a0009e 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -659,7 +659,7 @@ static int cmos_nvram_read(void *priv, unsigned int off, void *val,
 	return 0;
 }
 
-static int cmos_nvram_write(void *priv, unsigned int off, void *val,
+static int cmos_nvram_write(void *priv, unsigned int off, const void *val,
 			    size_t count)
 {
 	struct cmos_rtc	*cmos = priv;
diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index d4de401548b4..eab61ec97ece 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -487,7 +487,7 @@ static irqreturn_t ds1305_irq(int irq, void *p)
  */
 
 static void msg_init(struct spi_message *m, struct spi_transfer *x,
-		u8 *addr, size_t count, char *tx, char *rx)
+		u8 *addr, size_t count, const char *tx, char *rx)
 {
 	spi_message_init(m);
 	memset(x, 0, 2 * sizeof(*x));
@@ -519,7 +519,7 @@ static int ds1305_nvram_read(void *priv, unsigned int off, void *buf,
 	return spi_sync(spi, &m);
 }
 
-static int ds1305_nvram_write(void *priv, unsigned int off, void *buf,
+static int ds1305_nvram_write(void *priv, unsigned int off, const void *buf,
 			      size_t count)
 {
 	struct ds1305		*ds1305 = priv;
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index fd3858b6569e..7cb6c96d2ec7 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1285,7 +1285,7 @@ static int ds1307_nvram_read(void *priv, unsigned int offset, void *val,
 				val, bytes);
 }
 
-static int ds1307_nvram_write(void *priv, unsigned int offset, void *val,
+static int ds1307_nvram_write(void *priv, unsigned int offset, const void *val,
 			      size_t bytes)
 {
 	struct ds1307 *ds1307 = priv;
diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index aa9500791b7e..b4daa5136078 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -123,7 +123,7 @@ static ssize_t ds1343_store_glitchfilter(struct device *dev,
 static DEVICE_ATTR(glitch_filter, S_IRUGO | S_IWUSR, ds1343_show_glitchfilter,
 			ds1343_store_glitchfilter);
 
-static int ds1343_nvram_write(void *priv, unsigned int off, void *val,
+static int ds1343_nvram_write(void *priv, unsigned int off, const void *val,
 			      size_t bytes)
 {
 	struct ds1343_priv *ds1343 = priv;
diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 8b087d9556be..23ee75f8035b 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -257,7 +257,7 @@ static int ds1511_nvram_read(void *priv, unsigned int pos, void *buf,
 	return 0;
 }
 
-static int ds1511_nvram_write(void *priv, unsigned int pos, void *buf,
+static int ds1511_nvram_write(void *priv, unsigned int pos, const void *buf,
 			      size_t size)
 {
 	int i;
diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
index dbff5b621ef5..d561bd5997bc 100644
--- a/drivers/rtc/rtc-ds1553.c
+++ b/drivers/rtc/rtc-ds1553.c
@@ -234,13 +234,13 @@ static int ds1553_nvram_read(void *priv, unsigned int pos, void *val,
 	return 0;
 }
 
-static int ds1553_nvram_write(void *priv, unsigned int pos, void *val,
+static int ds1553_nvram_write(void *priv, unsigned int pos, const void *val,
 			      size_t bytes)
 {
 	struct platform_device *pdev = priv;
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
 	void __iomem *ioaddr = pdata->ioaddr;
-	u8 *buf = val;
+	const u8 *buf = val;
 
 	for (; bytes; bytes--)
 		writeb(*buf++, ioaddr + pos++);
diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 5fc8e36b1abf..996d13cd3ce3 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -904,13 +904,13 @@ static int ds1685_nvram_read(void *priv, unsigned int pos, void *val,
 	return 0;
 }
 
-static int ds1685_nvram_write(void *priv, unsigned int pos, void *val,
+static int ds1685_nvram_write(void *priv, unsigned int pos, const void *val,
 			      size_t size)
 {
 	struct ds1685_priv *rtc = priv;
 	struct mutex *rtc_mutex = &rtc->dev->ops_lock;
 	ssize_t count;
-	u8 *buf = val;
+	const u8 *buf = val;
 	int err;
 
 	err = mutex_lock_interruptible(rtc_mutex);
diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
index 6ae8b9a294fe..257d91400290 100644
--- a/drivers/rtc/rtc-ds1742.c
+++ b/drivers/rtc/rtc-ds1742.c
@@ -126,12 +126,12 @@ static int ds1742_nvram_read(void *priv, unsigned int pos, void *val,
 	return 0;
 }
 
-static int ds1742_nvram_write(void *priv, unsigned int pos, void *val,
+static int ds1742_nvram_write(void *priv, unsigned int pos, const void *val,
 			      size_t bytes)
 {
 	struct rtc_plat_data *pdata = priv;
 	void __iomem *ioaddr = pdata->ioaddr_nvram;
-	u8 *buf = val;
+	const u8 *buf = val;
 
 	for (; bytes; bytes--)
 		writeb(*buf++, ioaddr + pos++);
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index d1ef9e0dad34..2a978c9f21b1 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -449,7 +449,7 @@ static int ds3232_nvmem_read(void *priv, unsigned int offset, void *val,
 				val, bytes);
 }
 
-static int ds3232_nvmem_write(void *priv, unsigned int offset, void *val,
+static int ds3232_nvmem_write(void *priv, unsigned int offset, const void *val,
 			      size_t bytes)
 {
 	struct regmap *ds3232_regmap = (struct regmap *)priv;
diff --git a/drivers/rtc/rtc-isl12026.c b/drivers/rtc/rtc-isl12026.c
index b86a325d8a23..0b8b1b50c7b6 100644
--- a/drivers/rtc/rtc-isl12026.c
+++ b/drivers/rtc/rtc-isl12026.c
@@ -319,11 +319,11 @@ static int isl12026_nvm_read(void *p, unsigned int offset,
 }
 
 static int isl12026_nvm_write(void *p, unsigned int offset,
-			      void *val, size_t bytes)
+			      const void *val, size_t bytes)
 {
 	struct isl12026 *priv = p;
 	int ret;
-	u8 *v = val;
+	const u8 *v = val;
 	size_t chunk_size, num_written;
 	u8 payload[ISL12026_PAGESIZE + 2]; /* page + 2 address bytes */
 	struct i2c_msg msgs[] = {
diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 9bdd5d121571..07ce522e69c5 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -799,7 +799,7 @@ static int isl1208_nvmem_read(void *priv, unsigned int off, void *buf,
 				    count);
 }
 
-static int isl1208_nvmem_write(void *priv, unsigned int off, void *buf,
+static int isl1208_nvmem_write(void *priv, unsigned int off, const void *buf,
 			       size_t count)
 {
 	struct isl1208_state *isl1208 = priv;
diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
index 4e608bc8bbd3..ad407faecf1f 100644
--- a/drivers/rtc/rtc-m48t59.c
+++ b/drivers/rtc/rtc-m48t59.c
@@ -316,7 +316,7 @@ static int m48t59_nvram_read(void *priv, unsigned int offset, void *val,
 	return 0;
 }
 
-static int m48t59_nvram_write(void *priv, unsigned int offset, void *val,
+static int m48t59_nvram_write(void *priv, unsigned int offset, const void *val,
 			      size_t size)
 {
 	struct platform_device *pdev = priv;
@@ -325,7 +325,7 @@ static int m48t59_nvram_write(void *priv, unsigned int offset, void *val,
 	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
 	ssize_t cnt = 0;
 	unsigned long flags;
-	u8 *buf = val;
+	const u8 *buf = val;
 
 	spin_lock_irqsave(&m48t59->lock, flags);
 
diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index db3bdb171ff0..da3835d85fbc 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -171,7 +171,7 @@ static int m48t86_nvram_read(void *priv, unsigned int off, void *buf,
 	return 0;
 }
 
-static int m48t86_nvram_write(void *priv, unsigned int off, void *buf,
+static int m48t86_nvram_write(void *priv, unsigned int off, const void *buf,
 			      size_t count)
 {
 	struct device *dev = priv;
diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
index 595816973851..3b3d4b0d3af3 100644
--- a/drivers/rtc/rtc-max31335.c
+++ b/drivers/rtc/rtc-max31335.c
@@ -576,7 +576,7 @@ static int max31335_nvmem_reg_read(void *priv, unsigned int offset,
 }
 
 static int max31335_nvmem_reg_write(void *priv, unsigned int offset,
-				    void *val, size_t bytes)
+				    const void *val, size_t bytes)
 {
 	struct max31335_data *max31335 = priv;
 	unsigned int reg = max31335->chip->ram_reg + offset;
diff --git a/drivers/rtc/rtc-meson.c b/drivers/rtc/rtc-meson.c
index 21eceb9e2e13..d9dbab95e5da 100644
--- a/drivers/rtc/rtc-meson.c
+++ b/drivers/rtc/rtc-meson.c
@@ -266,7 +266,7 @@ static int meson_rtc_regmem_read(void *context, unsigned int offset,
 }
 
 static int meson_rtc_regmem_write(void *context, unsigned int offset,
-				  void *buf, size_t bytes)
+				  const void *buf, size_t bytes)
 {
 	struct meson_rtc *rtc = context;
 	unsigned int write_offset, write_size;
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 0f90065e352c..63a555697ddf 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -699,11 +699,11 @@ static int omap_rtc_scratch_read(void *priv, unsigned int offset, void *_val,
 	return 0;
 }
 
-static int omap_rtc_scratch_write(void *priv, unsigned int offset, void *_val,
+static int omap_rtc_scratch_write(void *priv, unsigned int offset, const void *_val,
 				  size_t bytes)
 {
 	struct omap_rtc	*rtc = priv;
-	u32 *val = _val;
+	const u32 *val = _val;
 	int i;
 
 	rtc->type->unlock(rtc);
diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 1995e9f2756d..77b1a4a6a8b5 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -460,7 +460,7 @@ static int pcf2127_nvmem_read(void *priv, unsigned int offset,
 }
 
 static int pcf2127_nvmem_write(void *priv, unsigned int offset,
-			       void *val, size_t bytes)
+			       const void *val, size_t bytes)
 {
 	struct pcf2127 *pcf2127 = priv;
 	int ret;
diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 01e209d88f5f..7cb59a105b5d 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -340,7 +340,7 @@ static int pcf85063_nvmem_read(void *priv, unsigned int offset,
 }
 
 static int pcf85063_nvmem_write(void *priv, unsigned int offset,
-				void *val, size_t bytes)
+				const void *val, size_t bytes)
 {
 	return regmap_write(priv, PCF85063_REG_RAM, *(u8 *)val);
 }
diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 540042b9eec8..d652a9353fd6 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -328,7 +328,7 @@ static int pcf85363_nvram_read(void *priv, unsigned int offset, void *val,
 				val, bytes);
 }
 
-static int pcf85363_nvram_write(void *priv, unsigned int offset, void *val,
+static int pcf85363_nvram_write(void *priv, unsigned int offset, const void *val,
 				size_t bytes)
 {
 	struct pcf85363 *pcf85363 = priv;
@@ -350,7 +350,7 @@ static int pcf85x63_nvram_read(void *priv, unsigned int offset, void *val,
 	return ret;
 }
 
-static int pcf85x63_nvram_write(void *priv, unsigned int offset, void *val,
+static int pcf85x63_nvram_write(void *priv, unsigned int offset, const void *val,
 				size_t bytes)
 {
 	struct pcf85363 *pcf85363 = priv;
diff --git a/drivers/rtc/rtc-rp5c01.c b/drivers/rtc/rtc-rp5c01.c
index 44afa6d996e7..b38799525043 100644
--- a/drivers/rtc/rtc-rp5c01.c
+++ b/drivers/rtc/rtc-rp5c01.c
@@ -188,11 +188,11 @@ static int rp5c01_nvram_read(void *_priv, unsigned int pos, void *val,
 	return 0;
 }
 
-static int rp5c01_nvram_write(void *_priv, unsigned int pos, void *val,
+static int rp5c01_nvram_write(void *_priv, unsigned int pos, const void *val,
 			      size_t bytes)
 {
 	struct rp5c01_priv *priv = _priv;
-	u8 *buf = val;
+	const u8 *buf = val;
 
 	spin_lock_irq(&priv->lock);
 
diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index d96f6bb68850..e95600493f7f 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -602,7 +602,7 @@ static int rv3028_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 	}
 }
 
-static int rv3028_nvram_write(void *priv, unsigned int offset, void *val,
+static int rv3028_nvram_write(void *priv, unsigned int offset, const void *val,
 			      size_t bytes)
 {
 	return regmap_bulk_write(priv, RV3028_RAM1 + offset, val, bytes);
@@ -614,13 +614,13 @@ static int rv3028_nvram_read(void *priv, unsigned int offset, void *val,
 	return regmap_bulk_read(priv, RV3028_RAM1 + offset, val, bytes);
 }
 
-static int rv3028_eeprom_write(void *priv, unsigned int offset, void *val,
+static int rv3028_eeprom_write(void *priv, unsigned int offset, const void *val,
 			       size_t bytes)
 {
 	struct rv3028_data *rv3028 = priv;
 	u32 status, eerd;
 	int i, ret;
-	u8 *buf = val;
+	const u8 *buf = val;
 
 	ret = rv3028_enter_eerd(rv3028, &eerd);
 	if (ret)
diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index 98953af2a24a..a6a01e0c5d9d 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -472,7 +472,7 @@ static int rv3029_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 	}
 }
 
-static int rv3029_nvram_write(void *priv, unsigned int offset, void *val,
+static int rv3029_nvram_write(void *priv, unsigned int offset, const void *val,
 			      size_t bytes)
 {
 	return regmap_bulk_write(priv, RV3029_RAM_PAGE + offset, val, bytes);
diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
index 6bafdec637ae..b6b401be09bb 100644
--- a/drivers/rtc/rtc-rv3032.c
+++ b/drivers/rtc/rtc-rv3032.c
@@ -483,7 +483,7 @@ static int rv3032_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 	}
 }
 
-static int rv3032_nvram_write(void *priv, unsigned int offset, void *val, size_t bytes)
+static int rv3032_nvram_write(void *priv, unsigned int offset, const void *val, size_t bytes)
 {
 	return regmap_bulk_write(priv, RV3032_RAM1 + offset, val, bytes);
 }
@@ -493,7 +493,7 @@ static int rv3032_nvram_read(void *priv, unsigned int offset, void *val, size_t
 	return regmap_bulk_read(priv, RV3032_RAM1 + offset, val, bytes);
 }
 
-static int rv3032_eeprom_write(void *priv, unsigned int offset, void *val, size_t bytes)
+static int rv3032_eeprom_write(void *priv, unsigned int offset, const void *val, size_t bytes)
 {
 	struct rv3032_data *rv3032 = priv;
 	u32 status, eerd;
diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index b9b5fee16ee4..f2adccf611dd 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -536,10 +536,10 @@ static int rv8803_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 	}
 }
 
-static int rv8803_nvram_write(void *priv, unsigned int offset, void *val,
+static int rv8803_nvram_write(void *priv, unsigned int offset, const void *val,
 			      size_t bytes)
 {
-	return rv8803_write_reg(priv, RV8803_RAM, *(u8 *)val);
+	return rv8803_write_reg(priv, RV8803_RAM, *(const u8 *)val);
 }
 
 static int rv8803_nvram_read(void *priv, unsigned int offset,
diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index cf4dab94c337..6da6219ed8fe 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -188,7 +188,7 @@ static int rx8571_nvram_read(void *priv, unsigned int offset, void *val,
 	return regmap_bulk_read(regmap, RX8571_USER_RAM + offset, val, bytes);
 }
 
-static int rx8571_nvram_write(void *priv, unsigned int offset, void *val,
+static int rx8571_nvram_write(void *priv, unsigned int offset, const void *val,
 			      size_t bytes)
 {
 	struct regmap *regmap = priv;
@@ -209,7 +209,7 @@ static int rx85x1_nvram_read(void *priv, unsigned int offset, void *val,
 	return ret;
 }
 
-static int rx85x1_nvram_write(void *priv, unsigned int offset, void *val,
+static int rx85x1_nvram_write(void *priv, unsigned int offset, const void *val,
 			      size_t bytes)
 {
 	struct regmap *regmap = priv;
diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index b72eef4fb099..73ff0491f675 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -67,7 +67,7 @@ struct s35390a {
 	int twentyfourhour;
 };
 
-static int s35390a_set_reg(struct s35390a *s35390a, int reg, u8  *buf, int len)
+static int s35390a_set_reg(struct s35390a *s35390a, int reg, const u8 *buf, int len)
 {
 	struct i2c_client *client = s35390a->client[reg];
 	struct i2c_msg msg[] = {
@@ -426,7 +426,7 @@ static int s35390a_nvmem_read(void *priv, unsigned int offset, void *val,
 	return s35390a_get_reg(s35390a, S35390A_CMD_FREE_REG, val, bytes);
 }
 
-static int s35390a_nvmem_write(void *priv, unsigned int offset, void *val,
+static int s35390a_nvmem_write(void *priv, unsigned int offset, const void *val,
 			       size_t bytes)
 {
 	struct s35390a *s35390a = priv;
diff --git a/drivers/rtc/rtc-stk17ta8.c b/drivers/rtc/rtc-stk17ta8.c
index 7cb6be1b7815..c667be6829d6 100644
--- a/drivers/rtc/rtc-stk17ta8.c
+++ b/drivers/rtc/rtc-stk17ta8.c
@@ -242,12 +242,12 @@ static int stk17ta8_nvram_read(void *priv, unsigned int pos, void *val,
 	return 0;
 }
 
-static int stk17ta8_nvram_write(void *priv, unsigned int pos, void *val,
+static int stk17ta8_nvram_write(void *priv, unsigned int pos, const void *val,
 				size_t bytes)
 {
 	struct rtc_plat_data *pdata = priv;
 	void __iomem *ioaddr = pdata->ioaddr;
-	u8 *buf = val;
+	const u8 *buf = val;
 
 	for (; bytes; bytes--)
 		writeb(*buf++, ioaddr + pos++);
diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 7fc60880e409..67af5198f815 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -688,10 +688,10 @@ static int sun6i_rtc_nvmem_read(void *priv, unsigned int offset, void *_val, siz
 	return 0;
 }
 
-static int sun6i_rtc_nvmem_write(void *priv, unsigned int offset, void *_val, size_t bytes)
+static int sun6i_rtc_nvmem_write(void *priv, unsigned int offset, const void *_val, size_t bytes)
 {
 	struct sun6i_rtc_dev *chip = priv;
-	u32 *val = _val;
+	const u32 *val = _val;
 	int i;
 
 	for (i = 0; i < bytes / 4; ++i)
diff --git a/drivers/rtc/rtc-ti-k3.c b/drivers/rtc/rtc-ti-k3.c
index 8df00319cb6b..03b7a7fe631e 100644
--- a/drivers/rtc/rtc-ti-k3.c
+++ b/drivers/rtc/rtc-ti-k3.c
@@ -491,7 +491,7 @@ static int ti_k3_rtc_scratch_read(void *priv_data, unsigned int offset,
 }
 
 static int ti_k3_rtc_scratch_write(void *priv_data, unsigned int offset,
-				   void *val, size_t bytes)
+				   const void *val, size_t bytes)
 {
 	struct ti_k3_rtc *priv = (struct ti_k3_rtc *)priv_data;
 	int ret;
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index e6106e67e1f4..6b5dc1f09884 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -493,7 +493,7 @@ static int twl_nvram_read(void *priv, unsigned int offset, void *val,
 	return twl_i2c_read((long)priv, val, offset, bytes);
 }
 
-static int twl_nvram_write(void *priv, unsigned int offset, void *val,
+static int twl_nvram_write(void *priv, unsigned int offset, const void *val,
 			   size_t bytes)
 {
 	return twl_i2c_write((long)priv, val, offset, bytes);
-- 
2.55.0

