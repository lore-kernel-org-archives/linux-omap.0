Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095657;
	b=OqfBByjivhXVI297lL0xNPYEjfhQLb4TGeVUGXDjE1JcDRd5gZ8xyvoiHCKhEo4e5MJz
	 3FwdGMShr7duW2XFEDdbKt1jFd68v5LywaH5rK7EqQDnAKGNy+59l+UlwZ4mnE+pY3EpM
	 dfTOhghQADLTnpvnjLiRqqnGJCug1fwE5SmEAVYl37pD7U9Rgw2BFdCays4uazUxbPbuw
	 3vby/yYDILakjPzwfCD4Uj2rwjoXemDwyhA9ByFAvd7X7j3OmO1GMODR8j2lMVontaOsH
	 mw5ZXAvHc3Ntr52VPybgucohylPueSL/tQSruPW7+hBIXTHOSp46KwyUbLqBvYa0P9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095657;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=p4FAEsQidBpC1UpvncRDg0TRSeb6iFnqZovHCW0yqoA=;
	b=KwokPB0Nldiq4anEFHQx/ZbVztPdfvvSGihyU/OA4ezrKCOMFnfsZNmgekTz9t8YvVwe
	 02lWI1vmJ6ctxFsRV2gEkoEctx6/OvrIhZS8Rh9eQ6hXP5ktVeFaQord7G0W2mMtWbBru
	 SWvtDyYimNQ69KELrRqZtMZk23l0ub5C5xC4+o1EbFHf9ArnqpOYOx9UskpvwnWHWsQjA
	 KtL0jn9hUD+OTUQKBov4L2yojzHsHFQ/ktNhBmCYAqx/ATtoVd6uJ71mFR/QcXDIZ4sUr
	 ZOuPbHzqoJSC7ZHzY/Lww6C48AsY5hpHQJ+dKkgl80D2FNy3S2FVc7NUyCOSpS5A/8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AB606A320;
	Thu, 19 Nov 2026 13:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C58C1F000C5;
	Thu, 19 Nov 2026 13:40:52 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <paul@pwsan.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andyshrk@163.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/6] clk: Remove unused clk.dev
Date: Thu, 19 Nov 2026 14:40:34 +0100
Message-ID: <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This basically reverts commit efa850487a6b6742 ("clk: Inform the core
about consumer devices").

This commit added a struct device pointer member to struct clk and a
parameter to clk_hw_create_clk(), but the new member was never used
beyond setting.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/clk.c    | 14 +++++---------
 drivers/clk/clk.h    | 11 ++++-------
 drivers/clk/clkdev.c | 14 ++++----------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 673eac47450b1e1c..858f4d60ed2d97c4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -160,7 +160,6 @@ struct clk_core {
 
 struct clk {
 	struct clk_core	*core;
-	struct device *dev;
 	const char *dev_id;
 	const char *con_id;
 	unsigned long min_rate;
@@ -4249,7 +4248,6 @@ static void free_clk(struct clk *clk)
 /**
  * clk_hw_create_clk: Allocate and link a clk consumer to a clk_core given
  * a clk_hw
- * @dev: clk consumer device
  * @hw: clk_hw associated with the clk being consumed
  * @dev_id: string describing device name
  * @con_id: connection ID string on device
@@ -4259,9 +4257,8 @@ static void free_clk(struct clk *clk)
  * consumers. It connects a consumer to the clk_core and clk_hw structures
  * used by the framework and clk provider respectively.
  */
-struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
-			      const char *dev_id, const char *con_id,
-			      struct module *owner)
+struct clk *clk_hw_create_clk(struct clk_hw *hw, const char *dev_id,
+			      const char *con_id, struct module *owner)
 {
 	struct clk *clk;
 	struct clk_core *core;
@@ -4274,7 +4271,6 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 	clk = alloc_clk(core, dev_id, con_id);
 	if (IS_ERR(clk))
 		return clk;
-	clk->dev = dev;
 
 	/*
 	 * Pin the provider module only when the consumer lives in a different
@@ -4303,7 +4299,7 @@ struct clk *__clk_hw_get_clk(struct clk_hw *hw, const char *con_id,
 	struct device *dev = hw->core->dev;
 	const char *name = dev ? dev_name(dev) : NULL;
 
-	return clk_hw_create_clk(dev, hw, name, con_id, owner);
+	return clk_hw_create_clk(hw, name, con_id, owner);
 }
 EXPORT_SYMBOL(__clk_hw_get_clk);
 
@@ -5392,7 +5388,7 @@ struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 {
 	struct clk_hw *hw = of_clk_get_hw_from_clkspec(clkspec);
 
-	return clk_hw_create_clk(NULL, hw, NULL, __func__, NULL);
+	return clk_hw_create_clk(hw, NULL, __func__, NULL);
 }
 EXPORT_SYMBOL_GPL(of_clk_get_from_provider);
 
@@ -5420,7 +5416,7 @@ static struct clk *__of_clk_get(struct device_node *np,
 {
 	struct clk_hw *hw = of_clk_get_hw(np, index, con_id);
 
-	return clk_hw_create_clk(NULL, hw, dev_id, con_id, NULL);
+	return clk_hw_create_clk(hw, dev_id, con_id, NULL);
 }
 
 struct clk *of_clk_get(struct device_node *np, int index)
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 5009380863a9dc6f..ba23700149de0445 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -5,8 +5,6 @@
  */
 
 struct clk_hw;
-struct device;
-struct of_phandle_args;
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk_hw *of_clk_get_hw(struct device_node *np,
@@ -22,15 +20,14 @@ static inline struct clk_hw *of_clk_get_hw(struct device_node *np,
 struct clk_hw *clk_find_hw(const char *dev_id, const char *con_id);
 
 #ifdef CONFIG_COMMON_CLK
-struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
-			      const char *dev_id, const char *con_id,
-			      struct module *owner);
+struct clk *clk_hw_create_clk(struct clk_hw *hw, const char *dev_id,
+			      const char *con_id, struct module *owner);
 void __clk_put(struct clk *clk);
 #else
 /* All these casts to avoid ifdefs in clkdev... */
 static inline struct clk *
-clk_hw_create_clk(struct device *dev, struct clk_hw *hw, const char *dev_id,
-		  const char *con_id, struct module *owner)
+clk_hw_create_clk(struct clk_hw *hw, const char *dev_id, const char *con_id,
+		  struct module *owner)
 {
 	return (struct clk *)hw;
 }
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 919fc680ae4dd6ec..e963f878290564da 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -83,17 +83,11 @@ struct clk_hw *clk_find_hw(const char *dev_id, const char *con_id)
 	return hw;
 }
 
-static struct clk *__clk_get_sys(struct device *dev, const char *dev_id,
-				 const char *con_id)
+struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 {
 	struct clk_hw *hw = clk_find_hw(dev_id, con_id);
 
-	return clk_hw_create_clk(dev, hw, dev_id, con_id, NULL);
-}
-
-struct clk *clk_get_sys(const char *dev_id, const char *con_id)
-{
-	return __clk_get_sys(NULL, dev_id, con_id);
+	return clk_hw_create_clk(hw, dev_id, con_id, NULL);
 }
 EXPORT_SYMBOL(clk_get_sys);
 
@@ -105,10 +99,10 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 	if (dev && dev->of_node) {
 		hw = of_clk_get_hw(dev->of_node, 0, con_id);
 		if (!IS_ERR(hw) || PTR_ERR(hw) == -EPROBE_DEFER)
-			return clk_hw_create_clk(dev, hw, dev_id, con_id, NULL);
+			return clk_hw_create_clk(hw, dev_id, con_id, NULL);
 	}
 
-	return __clk_get_sys(dev, dev_id, con_id);
+	return clk_get_sys(dev_id, con_id);
 }
 EXPORT_SYMBOL(clk_get);
 
-- 
2.43.0

