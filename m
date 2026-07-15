Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD004A13B9;
	Wed, 15 Jul 2026 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137980; cv=none; b=PNkOUCjG8jjD2SA00lRYOTIhaUNhDSegivUcodnkRYJKKXIM+sSbddr44y39Gs7PoOW0LWVdURaguf4sEiS7WhIph5vcUvWwARiXYroYfX8f2Db1G8sMq4qEZFMIfs4J17DS+rfoQXe5meR1AnO+BdYejFHs+2SPD4SM+W+9NvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137980; c=relaxed/simple;
	bh=uOz8qHflYfhCLHUoFf+DPpLsT3ojAu4y0xHkt0KrZYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYYXNpK3hhQyu0Jjws0aAhT5T4H70ZBJOLgn8GumQTmZmP3jV9KLfowfA93nMfYMIbwm6O6qiO1etdXX3eaCpT1vGfCY0vi1gdcOsWPqLg/UbfJGk5YK6AsZxWB0HDQ/8/ihekJrp6TOeJukp21YZqN2bi92npapBbtM3DtVtcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id B9800F40D23; Wed, 15 Jul 2026 19:52:48 +0200 (CEST)
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
Subject: [PATCH 6/8] firmware: meson_sm: make reg_write callback take const void *
Date: Wed, 15 Jul 2026 19:52:22 +0200
Message-ID: <20260715175229.24672-7-linkmauve@linkmauve.fr>
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
 drivers/firmware/meson/meson_sm.c       | 2 +-
 include/linux/firmware/meson/meson_sm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index ab9751a59b55..5d4da2e3c3a9 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -196,7 +196,7 @@ EXPORT_SYMBOL(meson_sm_call_read);
  *
  * Return:	size of sent data on success, a negative value on error
  */
-int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
+int meson_sm_call_write(struct meson_sm_firmware *fw, const void *buffer,
 			unsigned int size, unsigned int cmd_index, u32 arg0,
 			u32 arg1, u32 arg2, u32 arg3, u32 arg4)
 {
diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
index 3ebc2bd9a976..92cc61f3a1c0 100644
--- a/include/linux/firmware/meson/meson_sm.h
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -21,7 +21,7 @@ struct meson_sm_firmware;
 
 int meson_sm_call(struct meson_sm_firmware *fw, unsigned int cmd_index,
 		  s32 *ret, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
-int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
+int meson_sm_call_write(struct meson_sm_firmware *fw, const void *buffer,
 			unsigned int b_size, unsigned int cmd_index, u32 arg0,
 			u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
-- 
2.55.0

