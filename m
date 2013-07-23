From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/3] ARM: OMAP2+: Add support to parse 'main_clk' info from DT
Date: Tue, 23 Jul 2013 11:54:37 +0530
Message-ID: <1374560679-14666-2-git-send-email-rnayak@ti.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56041 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab3GWGZQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 02:25:16 -0400
In-Reply-To: <1374560679-14666-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, t-kristo@ti.com, benoit.cousson@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

With clocks for OMAP moving to DT, its now possible to pass the 'main_clk'
data for each device from DT instead of having it in hwmod.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5cc5123..12fa589 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -728,14 +728,18 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
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
@@ -1561,7 +1565,8 @@ static int _init_clkdm(struct omap_hwmod *oh)
  * Resolves all clock names embedded in the hwmod.  Returns 0 on
  * success, or a negative error code on failure.
  */
-static int _init_clocks(struct omap_hwmod *oh, void *data)
+static int _init_clocks(struct omap_hwmod *oh, void *data,
+			struct device_node *np)
 {
 	int ret = 0;
 
@@ -1573,7 +1578,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 	if (soc_ops.init_clkdm)
 		ret |= soc_ops.init_clkdm(oh);
 
-	ret |= _init_main_clk(oh);
+	ret |= _init_main_clk(oh, np);
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
 
@@ -2361,11 +2366,11 @@ static struct device_node *of_dev_hwmod_lookup(struct device_node *np,
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
@@ -2381,12 +2386,10 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
 			 oh->name);
 
 		/* Extract the IO space from device tree blob */
-		if (!of_have_populated_dt())
+		if (!np)
 			return;
 
-		np = of_dev_hwmod_lookup(of_find_node_by_name(NULL, "ocp"), oh);
-		if (np)
-			va_start = of_iomap(np, 0);
+		va_start = of_iomap(np, 0);
 	} else {
 		va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
 	}
@@ -2418,14 +2421,19 @@ static void __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data)
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

