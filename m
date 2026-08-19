Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D5352C3C;
	Wed, 19 Aug 2026 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166354; cv=none; b=F9Gz9XjWtP2Agr7OCZwSjziCgaWlwruj4AVc/kjiNS6fKGbf21611m3OKHKkxjTzVmsSQ6k1e6voU5qfPw1vM2T6/yksd4K8NXRIUIewrNDbEBX/s5lWP/fsg0BlhnVa6J2j1rmGWxIuWyrPbdvETd3Oe7DMlmiI18SOZ+xGxCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166354; c=relaxed/simple;
	bh=cHrUhl3NXtEQc1+Yp2b669YHOyJfFfotxvdbLgQjRs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0KSEL7OFOOJMssl1yvlOtBUReHOSqNtCpxUxwwetxv0uKkpBFDOjOEO4wfp34m1vgw5NsOnIDe0sb+x71gwtIyzzbvsCuRDa2UBmLeL9jDbFcnSJP84DqaTjmLmGONRK5s9lr85KmhcMqYi/6qdCE3vVV8wkVT8OQnokvOYT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4040B1F00A3D;
	Wed, 19 Aug 2026 19:05:47 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Tero Kristo <kristo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Nuno Sa <nuno.sa@analog.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH treewide 1/5] clk: ti: Make sure clk_init_data is fully initialized
Date: Wed, 19 Aug 2026 21:05:15 +0200
Message-ID: <e6f52b34163c8e708c1100107b437af0b3b049a6.1787165329.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787165329.git.geert+renesas@glider.be>
References: <cover.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

_register_mux() fills in init.parent_data, and assumes that
init.parent_names is NULL.  However, the latter in uninitialized, and
thus may cause a crash.

Make sure all members are fully initialized, to fix such bugs, and to
avoid future breakage when converting drivers to a different method for
specifying the parents.

Fixes: 667f420c09f1417c ("clk: ti: mux: resolve parent clocks by DT index, not by name")
Closes: https://lore.kernel.org/CAMuHMdU3yVqoyHC4eNF2NuYo8wy+6ODLoYat4R71X99Mxc_=kw@mail.gmail.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/ti/adpll.c   | 4 ++--
 drivers/clk/ti/divider.c | 2 +-
 drivers/clk/ti/mux.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index e305fcbac6475b03..8885d28face50beb 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -483,7 +483,7 @@ static const struct clk_ops ti_adpll_ops = {
 
 static int ti_adpll_init_dco(struct ti_adpll_data *d)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clock;
 	const char *postfix;
 	int width, err;
@@ -576,7 +576,7 @@ static int ti_adpll_init_clkout(struct ti_adpll_data *d,
 				struct clk *clk1)
 {
 	struct ti_adpll_clkout_data *co;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_ops *ops;
 	const char *parent_names[2];
 	const char *child_name;
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index af923b8cb0ed8fbc..3b438c2d68aacd7c 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -311,7 +311,7 @@ static struct clk *_register_divider(struct device_node *node,
 				     u32 flags,
 				     struct clk_omap_divider *div)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	const char *parent_name;
 	const char *name;
 
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index ded4432f7528cc6e..0fef60e82107a5a5 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -124,9 +124,9 @@ static struct clk *_register_mux(struct device_node *node, const char *name,
 				 struct clk_omap_reg *reg, u8 shift, u32 mask,
 				 s8 latch, u8 clk_mux_flags, u32 *table)
 {
+	struct clk_init_data init = {};
 	struct clk_omap_mux *mux;
 	struct clk *clk;
-	struct clk_init_data init;
 
 	/* allocate the mux */
 	mux = kzalloc_obj(*mux);
-- 
2.43.0

