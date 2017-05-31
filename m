From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/11] ARM: OMAP2+: Remove unused legacy code for interconnects
Date: Wed, 31 May 2017 15:51:37 -0700
Message-ID: <20170531225139.30723-10-tony@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531225139.30723-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We are now booting all mach-omap2 in device tree only mode.
Any code that is only called in legacy boot mode where
of_have_populated_dt() is not set is safe to remove now.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_device.c          |  5 +----
 arch/arm/mach-omap2/omap_hwmod.c           | 23 ++++++++++-------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  3 +--
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -65,7 +65,7 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 
 	r = clk_get_sys(NULL, clk_name);
 
-	if (IS_ERR(r) && of_have_populated_dt()) {
+	if (IS_ERR(r)) {
 		struct of_phandle_args clkspec;
 
 		clkspec.np = of_find_node_by_name(NULL, clk_name);
@@ -953,9 +953,6 @@ static int __init omap_device_late_init(void)
 {
 	bus_for_each_dev(&platform_bus_type, NULL, NULL, omap_device_late_idle);
 
-	WARN(!of_have_populated_dt(),
-		"legacy booting deprecated, please update to boot with .dts\n");
-
 	return 0;
 }
 omap_late_initcall_sync(omap_device_late_init);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2336,24 +2336,21 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 {
 	int r, index;
 	struct device_node *np = NULL;
+	struct device_node *bus;
 
 	if (oh->_state != _HWMOD_STATE_REGISTERED)
 		return 0;
 
-	if (of_have_populated_dt()) {
-		struct device_node *bus;
-
-		bus = of_find_node_by_name(NULL, "ocp");
-		if (!bus)
-			return -ENODEV;
+	bus = of_find_node_by_name(NULL, "ocp");
+	if (!bus)
+		return -ENODEV;
 
-		r = of_dev_hwmod_lookup(bus, oh, &index, &np);
-		if (r)
-			pr_debug("omap_hwmod: %s missing dt data\n", oh->name);
-		else if (np && index)
-			pr_warn("omap_hwmod: %s using broken dt data from %s\n",
-				oh->name, np->name);
-	}
+	r = of_dev_hwmod_lookup(bus, oh, &index, &np);
+	if (r)
+		pr_debug("omap_hwmod: %s missing dt data\n", oh->name);
+	else if (np && index)
+		pr_warn("omap_hwmod: %s using broken dt data from %s\n",
+			oh->name, np->name);
 
 	r = _init_mpu_rt_base(oh, NULL, index, np);
 	if (r < 0) {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3204,8 +3204,7 @@ int __init omap3xxx_hwmod_init(void)
 	 * If DT information is missing, enable them only for GP devices.
 	 */
 
-	if (of_have_populated_dt())
-		bus = of_find_node_by_name(NULL, "ocp");
+	bus = of_find_node_by_name(NULL, "ocp");
 
 	if (h_sham && omap3xxx_hwmod_is_hs_ip_block_usable(bus, "sham")) {
 		r = omap_hwmod_register_links(h_sham);
-- 
2.13.0
