Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE1499F38;
	Wed,  9 Sep 2026 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956210; cv=none; b=UepDNSk7ZtZ39FAZbQNH9vw5pC/VDVKXyaNBou5sLUVNu9vMHDrYzEE3GDvzH5j4jm/+YGWpMBPBB8T580RSOcs0OSOQY+h67m7PM7Vty0gz7/OsPSsxM/MCwVab02RhgD/UStjaKaqP8h7+FemlXz4jrwsoQ77AZYZG24h1mak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956210; c=relaxed/simple;
	bh=C5A/agygBsU5mhKK2NWjZwspkUSViI8u5dZaU6CC5Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BIOec6D0Uh75V3aqiobKvZfdhVLvXo120e+X4sGNDGU40BCBG8ZA40nAEKYNzP5RBvxGJXdCZBO2d/BBzlzWx5EwgSJr0kKvcKZQepvArPeWa2SSHK2xIIB6S2XqyrQSRdNZhP8QOSHvxPk2lDOT2s6d5wP/wMnCW3tqT6cWXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=BbGAYWGh; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="BbGAYWGh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=4GqZl21kFrqnWffuKNmyqEkSCl4r2d98AlT0aBN2x0M=; t=1788956208; x=1790165808; 
	b=BbGAYWGhHivcV0tyLCN503/DBHPM6Zg4nuFg9TC5NukI2jbkluWYTr46GtiPxU7nbjC2C35loF0
	C2oLzMvm+yrnAfK5VXhMcCe/VcUzXbmWUu67os8pt0pik1x5Vl1O7EZs5hPnKOc7W2Ko+fvNaSORD
	wdzUngTjrIO/j6iXVYWRHLmRTM6dq4tT+NRtw2UaC80b9+dYUAnIuhTElaJSEmcBXI/0DDY95ieMA
	tqhZiEfWs2VcKcm0WyyQst5KtXbRjS3ZItfKrq1oZ4X5/U/Hm2whIvv8iHNeOs8/Fw1QqRAXZnyrE
	tsu7UQCL5iXL/A3KHT+zV8kCSwpYv3es7TIA==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 09 Sep 2026 14:16:36 +0200
Subject: [PATCH v2] clk: ti: composite: resolve parent clocks by name again
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-v7-3rc-omap-fixes-v2-1-83e95e162330@kemnade.info>
X-B4-Tracking: v=1; b=H4sIACNOoWoC/yXMQQrCMBCF4auUWXcgpCYmXkVcJOmoI9iWjAYh5
 O7Guvx4/K+CUGYSOA0VMhUWXpcOPQ6Q7mG5EfLcDVppq7zyWI445YTrM2x45Q8JqmiTMc4Fdwj
 Quy3TPvTsfPlb3vFB6fU7gta+9YE6AnUAAAA=
X-Change-ID: 20260909-v7-3rc-omap-fixes-0b6c5588a84a
To: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Brian Masney <bmasney@redhat.com>, linux-omap@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4393; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=C5A/agygBsU5mhKK2NWjZwspkUSViI8u5dZaU6CC5Io=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFkL/XT+X3qUfYPFb6NMStHOQ/nfBR88+3WH38i+Si9pj
 VTpsjDpjlIWBjEuBlkxRZZf1gpun1Se5QZPjbCHmcPKBDKEgYtTACbyp5+R4TlHyjpf3TA3VrkP
 7iFNcx4v3VQvFJNm/G2Z8vN/aRN6fzH8FecK6rQUf7i39umplu3ejac+O8+KuznX0/uG0dGQ7Sf
 5GQA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

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
Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
 - rebased onto rc2, needed due to kcalloc -> kcalloc_obj changes
 - Link to v1:
   https://patch.msgid.link/20260904181716.631201-1-andreas@kemnade.info
---
 drivers/clk/ti/composite.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 83c3592cd179..c379bbdae25a 100644
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
 
-	parent_data = kzalloc_objs(*parent_data, num_parents);
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

---
base-commit: ab4fc07d3d8123182d58a2ca6b98d4a26e92a3a0
change-id: 20260909-v7-3rc-omap-fixes-0b6c5588a84a

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

