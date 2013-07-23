From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/3] ARM: OMAP2+: Add support to parse optional clk info from DT
Date: Tue, 23 Jul 2013 11:54:38 +0530
Message-ID: <1374560679-14666-3-git-send-email-rnayak@ti.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43962 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab3GWGZX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jul 2013 02:25:23 -0400
In-Reply-To: <1374560679-14666-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, t-kristo@ti.com, benoit.cousson@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

With clocks for OMAP moving to DT, its now possible to pass all optional clock
data for each device from DT instead of having it in hwmod.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   66 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 12fa589..e5c804b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -805,6 +805,65 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 	return ret;
 }
 
+static const char **_parse_opt_clks_dt(struct omap_hwmod *oh,
+				       struct device_node *np,
+				       int *opt_clks_cnt)
+{
+	int i, clks_cnt;
+	const char *clk_name;
+	const char **opt_clk_names;
+
+	clks_cnt = of_property_count_strings(np, "clock-names");
+	if (!clks_cnt)
+		return NULL;
+
+	opt_clk_names = kzalloc(sizeof(char *)*clks_cnt, GFP_KERNEL);
+	if (!opt_clk_names)
+		return NULL;
+
+	for (i = 0; i < clks_cnt; i++) {
+		of_property_read_string_index(np, "clock-names", i, &clk_name);
+		if (!strcmp(clk_name, "fck"))
+			continue;
+		opt_clks_cnt++;
+		opt_clk_names[i] = clk_name;
+	}
+	return opt_clk_names;
+}
+
+static int _init_opt_clks_dt(struct omap_hwmod *oh, struct device_node *np)
+{
+	struct clk *c;
+	int i, opt_clks_cnt = 0;
+	int ret = 0;
+	const char **opt_clk_names;
+
+	opt_clk_names = _parse_opt_clks_dt(oh, np, &opt_clks_cnt);
+	if (!opt_clk_names)
+		return -EINVAL;
+
+	oh->opt_clks = kzalloc(sizeof(struct omap_hwmod_opt_clk *)
+			       * opt_clks_cnt, GFP_KERNEL);
+	if (!oh->opt_clks)
+		return -ENOMEM;
+
+	oh->opt_clks_cnt = opt_clks_cnt;
+
+	for (i = 0; i < oh->opt_clks_cnt; i++) {
+		c = of_clk_get_by_name(np, opt_clk_names[i]);
+		if (IS_ERR(c)) {
+			pr_warn("omap_hwmod: %s: cannot clk_get opt_clk %s\n",
+				oh->name, opt_clk_names[i]);
+			ret = -EINVAL;
+		}
+		oh->opt_clks[i]._clk = c;
+		oh->opt_clks[i].role = opt_clk_names[i];
+		oh->opt_clks_cnt++;
+		clk_prepare(oh->opt_clks[i]._clk);
+	}
+	return ret;
+}
+
 /**
  * _init_opt_clk - get a struct clk * for the the hwmod's optional clocks
  * @oh: struct omap_hwmod *
@@ -812,13 +871,16 @@ static int _init_interface_clks(struct omap_hwmod *oh)
  * Called from _init_clocks().  Populates the @oh omap_hwmod_opt_clk
  * clock pointers.  Returns 0 on success or -EINVAL on error.
  */
-static int _init_opt_clks(struct omap_hwmod *oh)
+static int _init_opt_clks(struct omap_hwmod *oh, struct device_node *np)
 {
 	struct omap_hwmod_opt_clk *oc;
 	struct clk *c;
 	int i;
 	int ret = 0;
 
+	if (of_get_property(np, "clocks", NULL))
+		return _init_opt_clks_dt(oh, np);
+
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++) {
 		c = clk_get(NULL, oc->clk);
 		if (IS_ERR(c)) {
@@ -1580,7 +1642,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data,
 
 	ret |= _init_main_clk(oh, np);
 	ret |= _init_interface_clks(oh);
-	ret |= _init_opt_clks(oh);
+	ret |= _init_opt_clks(oh, np);
 
 	if (!ret)
 		oh->_state = _HWMOD_STATE_CLKS_INITED;
-- 
1.7.9.5

