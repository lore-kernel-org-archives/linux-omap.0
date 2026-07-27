Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A399A3DD866
	for <linux-omap@vger.kernel.org>; Mon, 27 Jul 2026 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138126; cv=none; b=JTfppo0kWN5Di98bMsAsPuBzS0KOXfHTA+WzdRuiGLDGJLYLn6J2W4mg3mJhen4mw5gr3QyGQc2HogzJWESJczN0+tPdaJLCV1K2PQMidLwi2QdZCvgComV5PIzdfzQB7T/TArT7b+Tyt/xvDwJr0+s/Ctvo0/iZnnBRUkD8V8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138126; c=relaxed/simple;
	bh=t07xrrRrUXYK9aJcYdFIgQonM0/UkjH18L6kmm/OK1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyONKtOts/3ajzYg7Y0TjfLoV07bavWqUAGRA+G5KFMg/MNOGVxv4LGUtwPRhl91BAT7UA2lEDD5DbKdP0MkTRTW6RgjqtLjviObQdxS6Fuvx6pt758lGy3HYa9lWeEkbeLaMOSICi1ehBWoaK4PLcXa7vRTePKF73kOcXsIQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LRSo9v3t; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LRSo9v3t"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 359C84E40F93;
	Mon, 27 Jul 2026 07:42:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 089CB601BE;
	Mon, 27 Jul 2026 07:42:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 910B011C12194;
	Mon, 27 Jul 2026 09:41:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785138120; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cLztjZt2dHeiT0DyyyMcgygGiCAxEqzdYsVkzhNavwk=;
	b=LRSo9v3tk9+q9HOiRULf0f3nGMwaF8aLCtkakkSkQDdHfLWPs8epEd9shN0TvYBj6vg4u0
	fgiLSJgp9rlVj9VEzTLTX7cNBH2l0GdSgMNEZTOEPrUsX6KQlNm4NQL9g1nBQie9Ta+Vu/
	lYBBqvJXFgzzZb0FTSiqlc2OkVWnEpKor1Q+cX/3ibnzEtEqtA/OnyRXhEOOAymBfXGBEB
	4RqZPGqYRP0r1ZoGiMKoIhiaR0UIZVa4cK0l8hVvcdX3fsdIGVTz2X8f4SVXY8Cqfcz48O
	tZUl7JoW88I2EsmNAb7j9IQMon8eSU5wofIE25HZ0iEYjwHmtKU8d8KQDlSWCA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 27 Jul 2026 09:41:40 +0200
Subject: [PATCH v2 1/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mathieu-wdt-clock-theo-v2-1-c048a6394436@bootlin.com>
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
In-Reply-To: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
To: Tero Kristo <kristo@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Tony Lindgren <tony@atomide.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785138115; l=3241;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=t07xrrRrUXYK9aJcYdFIgQonM0/UkjH18L6kmm/OK1o=;
 b=0YzGYJ6AxoxZAjdpfj1S7wrOwL2Dt21hFA0tTWheSkp/GCV8ML/I5K1PTZgJWqPYscOfrCSdC
 Jwq9J54ylYvAlvNwJ4I5XpCg8UhzKHRDhToeBYNcd1Ueghzf8iwxyg2
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3

Resolve parent clocks by their index into the device tree "clocks"
property rather than matching names as strings. Name-based matching is
fragile because a clock's "clock-output-names" value in its provider
node can differ from the name used to reference it in a consumer node,
and because names must be globally unique across all clock providers.

On AM335x, this caused broken clock trees where some clocks failed to
enable because their parents could not be found.

Replace of_clk_parent_fill() with a clk_parent_data array that sets
.index to the array position.

Fixes: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/clk/ti/mux.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index d6a0ccfd81db..ded4432f7528 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -119,7 +119,7 @@ const struct clk_ops ti_clk_mux_ops = {
 };
 
 static struct clk *_register_mux(struct device_node *node, const char *name,
-				 const char * const *parent_names,
+				 const struct clk_parent_data *parent_data,
 				 u8 num_parents, unsigned long flags,
 				 struct clk_omap_reg *reg, u8 shift, u32 mask,
 				 s8 latch, u8 clk_mux_flags, u32 *table)
@@ -136,7 +136,7 @@ static struct clk *_register_mux(struct device_node *node, const char *name,
 	init.name = name;
 	init.ops = &ti_clk_mux_ops;
 	init.flags = flags;
-	init.parent_names = parent_names;
+	init.parent_data = parent_data;
 	init.num_parents = num_parents;
 
 	/* struct clk_mux assignments */
@@ -167,24 +167,26 @@ static void of_mux_clk_setup(struct device_node *node)
 	struct clk *clk;
 	struct clk_omap_reg reg;
 	unsigned int num_parents;
-	const char **parent_names;
+	struct clk_parent_data *parent_data;
 	const char *name;
 	u8 clk_mux_flags = 0;
 	u32 mask = 0;
 	u32 shift = 0;
 	s32 latch = -EINVAL;
 	u32 flags = CLK_SET_RATE_NO_REPARENT;
+	int i;
 
 	num_parents = of_clk_get_parent_count(node);
 	if (num_parents < 2) {
 		pr_err("mux-clock %pOFn must have parents\n", node);
 		return;
 	}
-	parent_names = kcalloc(num_parents, sizeof(char *), GFP_KERNEL);
-	if (!parent_names)
-		goto cleanup;
+	parent_data = kcalloc(num_parents, sizeof(*parent_data), GFP_KERNEL);
+	if (!parent_data)
+		return;
 
-	of_clk_parent_fill(node, parent_names, num_parents);
+	for (i = 0; i < num_parents; i++)
+		parent_data[i].index = i;
 
 	if (ti_clk_get_reg_addr(node, 0, &reg))
 		goto cleanup;
@@ -207,7 +209,7 @@ static void of_mux_clk_setup(struct device_node *node)
 	mask = (1 << fls(mask)) - 1;
 
 	name = ti_dt_clk_name(node);
-	clk = _register_mux(node, name, parent_names, num_parents,
+	clk = _register_mux(node, name, parent_data, num_parents,
 			    flags, &reg, shift, mask, latch, clk_mux_flags,
 			    NULL);
 
@@ -215,7 +217,7 @@ static void of_mux_clk_setup(struct device_node *node)
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 
 cleanup:
-	kfree(parent_names);
+	kfree(parent_data);
 }
 CLK_OF_DECLARE(mux_clk, "ti,mux-clock", of_mux_clk_setup);
 

-- 
2.47.3

