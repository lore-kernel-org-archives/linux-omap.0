Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2527B4F799F;
	Wed, 15 Jul 2026 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138591; cv=none; b=BKhgXH0QN0xU5Kdw2Gb6cjD2ECVM3whBZDWjW/jXABaxnpNJdAs6RMlzfNsu0O69WFYtHLMn7+48/rDgX2FZF3WXhj4WNkTIZQEKsQ6fuBqiErF/9MCijVlbftdGX5rEOmCxaMvcys4Rs+2M9a1w+scQd75E/SfODsARU8ROY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138591; c=relaxed/simple;
	bh=AIwv1dMAgPC64aAqgm7IBUDJSKzgbgrmJihLTEJ2wrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3qfVuLfnFKmitjZdXRFV7Rg6sHimiaZZKJD9qeIjiU30OptBY+1M1C27DxZA4cSFaqAojxmdOXFWkKpiy05+mB4HsPjB2TQ+n9HxeBsAMw1OjB8+UI9sK4UYaevXVRgzfLR+xYw7Wig30R1pVlg3PQUkGnrmLYdgBNYGsLz4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 55353F40D1D; Wed, 15 Jul 2026 19:52:38 +0200 (CEST)
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
Subject: [PATCH 2/8] nvmem: make all reg_write callbacks take const void *
Date: Wed, 15 Jul 2026 19:52:18 +0200
Message-ID: <20260715175229.24672-3-linkmauve@linkmauve.fr>
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
to immutable data, so let’s fix all users of this API.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
---
 drivers/nvmem/bcm-ocotp.c           | 4 ++--
 drivers/nvmem/imx-ocotp-scu.c       | 4 ++--
 drivers/nvmem/imx-ocotp.c           | 4 ++--
 drivers/nvmem/lan9662-otpc.c        | 4 ++--
 drivers/nvmem/lpc18xx_eeprom.c      | 4 ++--
 drivers/nvmem/max77759-nvmem.c      | 2 +-
 drivers/nvmem/meson-efuse.c         | 4 ++--
 drivers/nvmem/qcom-spmi-sdam.c      | 2 +-
 drivers/nvmem/qfprom.c              | 4 ++--
 drivers/nvmem/rave-sp-eeprom.c      | 4 ++--
 drivers/nvmem/snvs_lpgpr.c          | 2 +-
 drivers/nvmem/sprd-efuse.c          | 4 ++--
 drivers/nvmem/stm32-bsec-optee-ta.c | 2 +-
 drivers/nvmem/stm32-bsec-optee-ta.h | 4 ++--
 drivers/nvmem/stm32-romem.c         | 6 +++---
 drivers/nvmem/zynqmp_nvmem.c        | 4 ++--
 16 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index 2490f44caa40..2c9c734187f7 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -179,11 +179,11 @@ static int bcm_otpc_read(void *context, unsigned int offset, void *val,
 	return 0;
 }
 
-static int bcm_otpc_write(void *context, unsigned int offset, void *val,
+static int bcm_otpc_write(void *context, unsigned int offset, const void *val,
 	size_t bytes)
 {
 	struct otpc_priv *priv = context;
-	u32 *buf = val;
+	const u32 *buf = val;
 	u32 bytes_written;
 	u32 address = offset / priv->config->word_size;
 	int i, ret;
diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 517d83e11af2..ee04e7d33cb5 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -178,11 +178,11 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
 }
 
 static int imx_scu_ocotp_write(void *context, unsigned int offset,
-			       void *val, size_t bytes)
+			       const void *val, size_t bytes)
 {
 	struct ocotp_priv *priv = context;
 	struct arm_smccc_res res;
-	u32 *buf = val;
+	const u32 *buf = val;
 	u32 tmp;
 	u32 index;
 	int ret;
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 108d78d7f6cb..3ede755ab429 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -310,11 +310,11 @@ static void imx_ocotp_set_imx7_timing(struct ocotp_priv *priv)
 	writel(timing, priv->base + IMX_OCOTP_ADDR_TIMING);
 }
 
-static int imx_ocotp_write(void *context, unsigned int offset, void *val,
+static int imx_ocotp_write(void *context, unsigned int offset, const void *val,
 			   size_t bytes)
 {
 	struct ocotp_priv *priv = context;
-	u32 *buf = val;
+	const u32 *buf = val;
 	int ret;
 
 	u32 ctrl;
diff --git a/drivers/nvmem/lan9662-otpc.c b/drivers/nvmem/lan9662-otpc.c
index 56fc19f092a7..79142b1eb1f5 100644
--- a/drivers/nvmem/lan9662-otpc.c
+++ b/drivers/nvmem/lan9662-otpc.c
@@ -140,10 +140,10 @@ static int lan9662_otp_read(void *context, unsigned int offset,
 }
 
 static int lan9662_otp_write(void *context, unsigned int offset,
-			     void *_val, size_t bytes)
+			     const void *_val, size_t bytes)
 {
 	struct lan9662_otp *otp = context;
-	u8 *val = _val;
+	const u8 *val = _val;
 	u8 data, newdata;
 	int i, rc = 0;
 
diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index 504155e30bab..c752026c9b36 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -87,7 +87,7 @@ static int lpc18xx_eeprom_busywait_until_prog(struct lpc18xx_eeprom_dev *eeprom)
 }
 
 static int lpc18xx_eeprom_gather_write(void *context, unsigned int reg,
-				       void *val, size_t bytes)
+				       const void *val, size_t bytes)
 {
 	struct lpc18xx_eeprom_dev *eeprom = context;
 	unsigned int offset = reg;
@@ -109,7 +109,7 @@ static int lpc18xx_eeprom_gather_write(void *context, unsigned int reg,
 	usleep_range(100, 200);
 
 	while (bytes) {
-		writel(*(u32 *)val, eeprom->mem_base + offset);
+		writel(*(const u32 *)val, eeprom->mem_base + offset);
 		ret = lpc18xx_eeprom_busywait_until_prog(eeprom);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/nvmem/max77759-nvmem.c b/drivers/nvmem/max77759-nvmem.c
index 283000ec3a2c..e47d7a3e578a 100644
--- a/drivers/nvmem/max77759-nvmem.c
+++ b/drivers/nvmem/max77759-nvmem.c
@@ -59,7 +59,7 @@ static int max77759_nvmem_reg_read(void *priv, unsigned int offset,
 }
 
 static int max77759_nvmem_reg_write(void *priv, unsigned int offset,
-				    void *val, size_t bytes)
+				    const void *val, size_t bytes)
 {
 	struct max77759_nvmem *nvmem = priv;
 	DEFINE_FLEX(struct max77759_maxq_command, cmd, cmd, length,
diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index d7f9ac99a212..3aa9ec97ef7d 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -27,12 +27,12 @@ static int meson_efuse_read(void *context, unsigned int offset,
 }
 
 static int meson_efuse_write(void *context, unsigned int offset,
-			     void *val, size_t bytes)
+			     const void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
 	int ret;
 
-	ret = meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
+	ret = meson_sm_call_write(fw, val, bytes, SM_EFUSE_WRITE, offset,
 				  bytes, 0, 0, 0);
 
 	return ret < 0 ? ret : 0;
diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index 4f1cca6eab71..2939c8d7be10 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -81,7 +81,7 @@ static int sdam_read(void *priv, unsigned int offset, void *val,
 	return rc;
 }
 
-static int sdam_write(void *priv, unsigned int offset, void *val,
+static int sdam_write(void *priv, unsigned int offset, const void *val,
 				size_t bytes)
 {
 	struct sdam_chip *sdam = priv;
diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 1de3435df116..e02726dd4413 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -252,13 +252,13 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
  *
  * Return: 0 or -err.
  */
-static int qfprom_reg_write(void *context, unsigned int reg, void *_val,
+static int qfprom_reg_write(void *context, unsigned int reg, void void *_val,
 			    size_t bytes)
 {
 	struct qfprom_priv *priv = context;
 	struct qfprom_touched_values old;
 	int words = bytes / 4;
-	u32 *value = _val;
+	const u32 *value = _val;
 	u32 blow_status;
 	int ret;
 	int i;
diff --git a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
index 9ecf3873cbb7..d9a610ba8a3d 100644
--- a/drivers/nvmem/rave-sp-eeprom.c
+++ b/drivers/nvmem/rave-sp-eeprom.c
@@ -278,10 +278,10 @@ static int rave_sp_eeprom_reg_read(void *eeprom, unsigned int offset,
 }
 
 static int rave_sp_eeprom_reg_write(void *eeprom, unsigned int offset,
-				    void *val, size_t bytes)
+				    const void *val, size_t bytes)
 {
 	return rave_sp_eeprom_access(eeprom, RAVE_SP_EEPROM_WRITE,
-				     offset, val, bytes);
+				     offset, (void *)val, bytes);
 }
 
 static int rave_sp_eeprom_probe(struct platform_device *pdev)
diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index 89c27112320f..2a1f82aa703a 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -50,7 +50,7 @@ static const struct snvs_lpgpr_cfg snvs_lpgpr_cfg_imx7d = {
 	.size		= 16,
 };
 
-static int snvs_lpgpr_write(void *context, unsigned int offset, void *val,
+static int snvs_lpgpr_write(void *context, unsigned int offset, const void *val,
 			    size_t bytes)
 {
 	struct snvs_lpgpr_priv *priv = context;
diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 1a7e4e5d8b86..b42ebef14c68 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -192,7 +192,7 @@ static void sprd_efuse_set_prog_en(struct sprd_efuse *efuse, bool en)
 }
 
 static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
-			       bool lock, u32 *data)
+			       bool lock, const u32 *data)
 {
 	u32 status;
 	int ret = 0;
@@ -321,7 +321,7 @@ static int sprd_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 	return ret;
 }
 
-static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
+static int sprd_efuse_write(void *context, u32 offset, const void *val, size_t bytes)
 {
 	struct sprd_efuse *efuse = context;
 	bool blk_double = efuse->data->blk_double;
diff --git a/drivers/nvmem/stm32-bsec-optee-ta.c b/drivers/nvmem/stm32-bsec-optee-ta.c
index f89ce791dd12..3184b976b1f9 100644
--- a/drivers/nvmem/stm32-bsec-optee-ta.c
+++ b/drivers/nvmem/stm32-bsec-optee-ta.c
@@ -203,7 +203,7 @@ int stm32_bsec_optee_ta_read(struct tee_context *ctx, unsigned int offset,
 
 /* stm32_bsec_optee_ta_write() - nvmem write access using PTA client driver */
 int stm32_bsec_optee_ta_write(struct tee_context *ctx, unsigned int lower,
-			      unsigned int offset, void *buf, size_t bytes)
+			      unsigned int offset, const void *buf, size_t bytes)
 {	struct tee_shm *shm;
 	struct tee_ioctl_invoke_arg arg;
 	struct tee_param param[2];
diff --git a/drivers/nvmem/stm32-bsec-optee-ta.h b/drivers/nvmem/stm32-bsec-optee-ta.h
index 3966a0535179..74658a54fe57 100644
--- a/drivers/nvmem/stm32-bsec-optee-ta.h
+++ b/drivers/nvmem/stm32-bsec-optee-ta.h
@@ -50,7 +50,7 @@ int stm32_bsec_optee_ta_read(struct tee_context *ctx, unsigned int offset,
  *	On success, 0. On failure, -errno.
  */
 int stm32_bsec_optee_ta_write(struct tee_context *ctx, unsigned int lower,
-			      unsigned int offset, void *buf, size_t bytes);
+			      unsigned int offset, const void *buf, size_t bytes);
 
 #else
 
@@ -72,7 +72,7 @@ static inline int stm32_bsec_optee_ta_read(struct tee_context *ctx,
 
 static inline int stm32_bsec_optee_ta_write(struct tee_context *ctx,
 					    unsigned int lower,
-					    unsigned int offset, void *buf,
+					    unsigned int offset, const void *buf,
 					    size_t bytes)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 82879b1c9eb9..30e14c80a4a9 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -118,12 +118,12 @@ static int stm32_bsec_read(void *context, unsigned int offset, void *buf,
 	return 0;
 }
 
-static int stm32_bsec_write(void *context, unsigned int offset, void *buf,
+static int stm32_bsec_write(void *context, unsigned int offset, const void *buf,
 			    size_t bytes)
 {
 	struct stm32_romem_priv *priv = context;
 	struct device *dev = priv->cfg.dev;
-	u32 *buf32 = buf;
+	const u32 *buf32 = buf;
 	int ret, i;
 
 	/* Allow only writing complete 32-bits aligned words */
@@ -153,7 +153,7 @@ static int stm32_bsec_pta_read(void *context, unsigned int offset, void *buf,
 	return stm32_bsec_optee_ta_read(priv->ctx, offset, buf, bytes);
 }
 
-static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
+static int stm32_bsec_pta_write(void *context, unsigned int offset, const void *buf,
 				size_t bytes)
 {
 	struct stm32_romem_priv *priv = context;
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index d297ff150dc0..66bbb873d1d1 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -183,7 +183,7 @@ static int zynqmp_nvmem_read(void *context, unsigned int offset, void *val, size
 }
 
 static int zynqmp_nvmem_write(void *context,
-			      unsigned int offset, void *val, size_t bytes)
+			      unsigned int offset, const void *val, size_t bytes)
 {
 	int pufflag = 0;
 
@@ -194,7 +194,7 @@ static int zynqmp_nvmem_write(void *context,
 		pufflag = 1;
 
 	return zynqmp_efuse_access(context, offset,
-				   val, bytes, EFUSE_WRITE, pufflag);
+				   (void *)val, bytes, EFUSE_WRITE, pufflag);
 }
 
 static const struct of_device_id zynqmp_nvmem_match[] = {
-- 
2.55.0

