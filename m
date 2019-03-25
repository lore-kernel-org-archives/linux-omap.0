From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/14] bus: ti-sysc: Handle missed no-idle property in addition to no-idle-on-init
Date: Mon, 25 Mar 2019 14:58:37 -0700
Message-ID: <20190325215849.13182-3-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We have ti,no-idle in use in addition to ti,no-idle-on-init but we're
missing handling for it in the ti-sysc interconnect target module driver.

Let's also group the idle defines together and update the binding
documentation for it.

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/bus/ti-sysc.txt | 2 ++
 arch/arm/mach-omap2/omap_hwmod.c                  | 2 ++
 drivers/bus/ti-sysc.c                             | 5 ++++-
 include/linux/platform_data/ti-sysc.h             | 5 +++--
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
--- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -94,6 +94,8 @@ Optional properties:
 
 - ti,no-idle-on-init	interconnect target module should not be idled at init
 
+- ti,no-idle		interconnect target module should not be idled
+
 Example: Single instance of MUSB controller on omap4 using interconnect ranges
 using offsets from l4_cfg second segment (0x4a000000 + 0x80000 = 0x4a0ab000):
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3675,6 +3675,8 @@ int omap_hwmod_init_module(struct device *dev,
 	if (error)
 		return error;
 
+	if (data->cfg->quirks & SYSC_QUIRK_NO_IDLE)
+		oh->flags |= HWMOD_NO_IDLE;
 	if (data->cfg->quirks & SYSC_QUIRK_NO_IDLE_ON_INIT)
 		oh->flags |= HWMOD_INIT_NO_IDLE;
 	if (data->cfg->quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -920,7 +920,8 @@ static int sysc_init_module(struct sysc *ddata)
 {
 	int error;
 
-	if (ddata->cfg.quirks & SYSC_QUIRK_NO_IDLE_ON_INIT) {
+	if (ddata->cfg.quirks &
+	    (SYSC_QUIRK_NO_IDLE | SYSC_QUIRK_NO_IDLE_ON_INIT)) {
 		ddata->revision = sysc_read_revision(ddata);
 		goto rev_quirks;
 	}
@@ -1281,6 +1282,8 @@ static const struct sysc_dts_quirk sysc_dts_quirks[] = {
 	  .mask = SYSC_QUIRK_NO_IDLE_ON_INIT, },
 	{ .name = "ti,no-reset-on-init",
 	  .mask = SYSC_QUIRK_NO_RESET_ON_INIT, },
+	{ .name = "ti,no-idle",
+	  .mask = SYSC_QUIRK_NO_IDLE, },
 };
 
 static void sysc_parse_dts_quirks(struct sysc *ddata, struct device_node *np,
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -46,8 +46,9 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
-#define SYSC_QUIRK_LEGACY_IDLE		BIT(8)
-#define SYSC_QUIRK_RESET_STATUS		BIT(7)
+#define SYSC_QUIRK_LEGACY_IDLE		BIT(9)
+#define SYSC_QUIRK_RESET_STATUS		BIT(8)
+#define SYSC_QUIRK_NO_IDLE		BIT(7)
 #define SYSC_QUIRK_NO_IDLE_ON_INIT	BIT(6)
 #define SYSC_QUIRK_NO_RESET_ON_INIT	BIT(5)
 #define SYSC_QUIRK_OPT_CLKS_NEEDED	BIT(4)
-- 
2.21.0
