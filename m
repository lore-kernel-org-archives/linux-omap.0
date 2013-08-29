From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 31/45] ARM: OMAP2+: Add support to parse 'main_clk' info from DT
Date: Thu, 29 Aug 2013 16:16:23 +0300
Message-ID: <1377782197-10611-32-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48020 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584Ab3H2NS0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:18:26 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

From: Rajendra Nayak <rnayak@ti.com>

With clocks for OMAP moving to DT, its now possible to pass the 'main_clk'
data for each device from DT instead of having it in hwmod.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index ef61582..838af96 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -730,14 +730,18 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
  * functional clock pointer) if a main_clk is present.  Returns 0 on
  * success or -EINVAL on error.
  */
-static int _init_main_clk(struct omap_hwmod *oh)
+static int _init_main_clk(struct omap_hwmod *oh, struct device_node *np)
 {
 	int ret = 0;
 
-	if (!oh->main_clk)
+	if (!oh->main_clk && !of_get_property(np, "clocks", NULL))
 		return 0;
 
-	oh->_clk = clk_get(NULL, oh->main_clk);
+	if (oh->main_clk)
+		oh->_clk = clk_get(NULL, oh->main_clk);
+	else
+		oh->_clk = of_clk_get_by_name(np, "fck");
+
 	if (IS_ERR(oh->_clk)) {
 		pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
 			   oh->name, oh->main_clk);
@@ -1563,7 +1567,8 @@ static int _init_clkdm(struct omap_hwmod *oh)
  * Resolves all clock names embedded in the hwmod.  Returns 0 on
  * success, or a negative error code on failure.
  */
-static int _init_clocks(struct omap_hwmod *oh, void *data)
+static int _init_clocks(struct omap_hwmod *oh, void *data,
+			struct device_node *np)
 {
 	int ret = 0;
 
@@ -1575,7 +1580,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 	if (soc_ops.init_clkdm)
 		ret |= soc_ops.init_clkdm(oh);
 
-	ret |= _init_main_clk(oh);
+	ret |= _init_main_clk(oh, np);
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
 
@@ -2363,11 +2368,11 @@ static struct device_node *of_dev_hwmod_lookup(struct device_node *np,
  * are part of the device's address space can be ioremapped properly.
  * No return value.
  */
-static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
+static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
+				     struct device_node *np)
 {
 	struct omap_hwmod_addr_space *mem;
 	void __iomem *va_start = NULL;
-	struct device_node *np;
 
 	if (!oh)
 		return;
@@ -2383,12 +2388,10 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 			 oh->name);
 
 		/* Extract the IO space from device tree blob */
-		if (!of_have_populated_dt())
+		if (!np)
 			return;
 
-		np = of_dev_hwmod_lookup(of_find_node_by_name(NULL, "ocp"), oh);
-		if (np)
-			va_start = of_iomap(np, oh->mpu_rt_idx);
+		va_start = of_iomap(np, 0);
 	} else {
 		va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
 	}
@@ -2420,14 +2423,19 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 static int __init _init(struct omap_hwmod *oh, void *data)
 {
 	int r;
+	struct device_node *np = NULL;
 
 	if (oh->_state != _HWMOD_STATE_REGISTERED)
 		return 0;
 
+	/* If booting with DT, parse the DT node for IO space/clocks etc */
+	if (of_have_populated_dt())
+		np = of_dev_hwmod_lookup(of_find_node_by_name(NULL, "ocp"), oh);
+
 	if (oh->class->sysc)
-		_init_mpu_rt_base(oh, NULL);
+		_init_mpu_rt_base(oh, NULL, np);
 
-	r = _init_clocks(oh, NULL);
+	r = _init_clocks(oh, NULL, np);
 	if (r < 0) {
 		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
 		return -EINVAL;
-- 
1.7.9.5

