Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA9345CCA;
	Fri,  4 Sep 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545851; cv=none; b=LwahGRIO5G3R9Uh5GY9i4UQDDiUPXseg10VjKUPlc6zH/q/tCTOYtNNwdRDhFfZa2hoUwx8X4JFWt+A7tRUmbii5LNxcAZPKDuJoO9LHmesjMSl69y/iTbFdPbicd3BvKNGVj1gO9BZOMk01xayc+nsi2OcYKMWdRWkEo6ZYoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545851; c=relaxed/simple;
	bh=VsnS007wh0sFiE9YAIKe95TPm3S3rLH78d0O1zLuIMo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F+zYwUcgO1+hRwQVaMkNLP2jjWpHvdFuXv8u8bZgzTPfJYjDVP2Q9IVoO7yGPi+D0OssG+e6SIkLaQCrV+UK+U+XgpJqemYcnP2MYt8jR8P33qGVj6tHzSwyv2m5uTnFmiRfPackOHTj22YnQgtFMh0gf+acVgjaRd6AHqqZVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Jz3fMcFB; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Jz3fMcFB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=y3ymHnKhdswdztxRlebmLmLOrkWSnm2XWakmHOi2uPU=; t=1788545849; x=1789755449; 
	b=Jz3fMcFBahrLnvaR+HlILwfqgty8ab/8ZMWbKkQsH9mGUElmNTi0XgTzPJngV18HoCWahbo8kec
	gRBwDR5JLPGFsJI8wh3gVbkPxExbtt066pEYZfImR4mYFY81nZcsLsY0XhwG5eViCx0FX1torFu2d
	rJnTtcA8Hr/N4S/3IN0IUKzOmqzzgBuLYDpaQZZouF4o3W8yaNzDczjFfQOwAOYcQ0s0ClrwBzemS
	dgfYe3F5zqch+hFFji156NHrkHlW+qYVpsUVkH2IFePdtWgFVcPOf8wLv9Y03CtGSEPXPQpHpezLZ
	3HLrUqvuh07/KnaD/nKeNGs2RwQKlEwNi0iA==;
From: Andreas Kemnade <andreas@kemnade.info>
To: kristo@kernel.org,
	sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	kees@kernel.org,
	mathieu.dubois-briand@bootlin.com,
	andreas@kemnade.info,
	linux-omap@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hns@goldelico.com
Subject: [PATCH] clk: ti: composite: resolve parent clocks by name again
Date: Fri,  4 Sep 2026 20:17:16 +0200
Message-ID: <20260904181716.631201-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to resolve them by DT index causes massive havoc on OMAP3, Clocks
around the timers used as a system clocksource are not properly resolved
causing ealy boot failures. The problem seems to be that parents must be
resolved by looking into the clocks property of the component node marked
with "ti,composite-mux-clock", with the switch to dt index, that node
was not used anymore. It was used by the of_clk_parent_fill() call.
To a lesser extent also OMAP4/5 boards are affected.

Since this patch was introduced just because of a cleanup request
and not to solve the actual problem
(https://lore.kernel.org/linux-omap/alkZmw-XmnCOZfOD@redhat.com/)
just revert it. Cleanup needs really more thought here.
The similar change to the TI mux clock, which solves a problem on the AM3
platform, seems to be harmless.

So just revert
commit fe3dd92ac54a ("clk: ti: composite: resolve parent clocks by DT index, not by name")
for now.

Fixes: fe3dd92ac54a ("clk: ti: composite: resolve parent clocks by DT index, not by name")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/clk/ti/composite.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 01eae8995254..c379bbdae25a 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -52,7 +52,7 @@ static const struct clk_ops ti_composite_gate_ops = {
 
 struct component_clk {
 	int num_parents;
-	struct clk_parent_data *parent_data;
+	const char **parent_names;
 	struct device_node *node;
 	int type;
 	struct clk_hw *hw;
@@ -116,7 +116,7 @@ static void __init _register_composite(void *user,
 	struct clk_hw_omap_comp *cclk = to_clk_hw_comp(hw);
 	struct component_clk *comp;
 	int num_parents = 0;
-	struct clk_parent_data *parent_data = NULL;
+	const char **parent_names = NULL;
 	const char *name;
 	int i;
 	int ret;
@@ -155,7 +155,7 @@ static void __init _register_composite(void *user,
 			continue;
 		if (comp->num_parents) {
 			num_parents = comp->num_parents;
-			parent_data = comp->parent_data;
+			parent_names = comp->parent_names;
 			break;
 		}
 	}
@@ -166,8 +166,8 @@ static void __init _register_composite(void *user,
 	}
 
 	name = ti_dt_clk_name(node);
-	clk = clk_register_composite_pdata(NULL, name,
-				     parent_data, num_parents,
+	clk = clk_register_composite(NULL, name,
+				     parent_names, num_parents,
 				     _get_hw(cclk, CLK_COMPONENT_TYPE_MUX),
 				     &ti_clk_mux_ops,
 				     _get_hw(cclk, CLK_COMPONENT_TYPE_DIVIDER),
@@ -190,7 +190,7 @@ static void __init _register_composite(void *user,
 		if (!cclk->comp_clks[i])
 			continue;
 		list_del(&cclk->comp_clks[i]->link);
-		kfree(cclk->comp_clks[i]->parent_data);
+		kfree(cclk->comp_clks[i]->parent_names);
 		kfree(cclk->comp_clks[i]);
 	}
 
@@ -237,9 +237,8 @@ int __init ti_clk_add_component(struct device_node *node, struct clk_hw *hw,
 				int type)
 {
 	unsigned int num_parents;
-	struct clk_parent_data *parent_data;
+	const char **parent_names;
 	struct component_clk *clk;
-	unsigned int i;
 
 	num_parents = of_clk_get_parent_count(node);
 
@@ -248,21 +247,20 @@ int __init ti_clk_add_component(struct device_node *node, struct clk_hw *hw,
 		return -EINVAL;
 	}
 
-	parent_data = kcalloc(num_parents, sizeof(*parent_data), GFP_KERNEL);
-	if (!parent_data)
+	parent_names = kcalloc(num_parents, sizeof(char *), GFP_KERNEL);
+	if (!parent_names)
 		return -ENOMEM;
 
-	for (i = 0; i < num_parents; i++)
-		parent_data[i].index = i;
+	of_clk_parent_fill(node, parent_names, num_parents);
 
 	clk = kzalloc_obj(*clk);
 	if (!clk) {
-		kfree(parent_data);
+		kfree(parent_names);
 		return -ENOMEM;
 	}
 
 	clk->num_parents = num_parents;
-	clk->parent_data = parent_data;
+	clk->parent_names = parent_names;
 	clk->hw = hw;
 	clk->node = node;
 	clk->type = type;
-- 
2.47.3

