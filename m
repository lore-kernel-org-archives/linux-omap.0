From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] bus: ti-sysc: Check for no-reset and no-idle flags at the child level
Date: Mon, 10 Dec 2018 14:13:34 -0800
Message-ID: <20181210221334.24982-2-tony@atomide.com>
References: <20181210221334.24982-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210221334.24982-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

With ti-sysc, we need to now have the device tree properties for
ti,no-reset-on-init and ti,no-idle-on-init at the module level instead
of the child device level.

Let's check for these properties at the child device level to enable
quirks, and warn about moving the properties to the module level.

Otherwise am335x-evm based boards tagging gpio1 with ti,no-reset-on-init
will have their DDR power disabled if wired up in such a tricky way.

Note that this should not be an issue for earlier kernels as we don't
rely on this until the dts files have been updated to probe with ti-sysc
interconnect target driver.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -91,6 +91,9 @@ struct sysc {
 	struct delayed_work idle_work;
 };
 
+static void sysc_parse_dts_quirks(struct sysc *ddata, struct device_node *np,
+				  bool is_child);
+
 void sysc_write(struct sysc *ddata, int offset, u32 value)
 {
 	writel_relaxed(value, ddata->module_va + offset);
@@ -379,6 +382,7 @@ static int sysc_check_one_child(struct sysc *ddata,
 		dev_warn(ddata->dev, "really a child ti,hwmods property?");
 
 	sysc_check_quirk_stdout(ddata, np);
+	sysc_parse_dts_quirks(ddata, np, true);
 
 	return 0;
 }
@@ -1279,23 +1283,37 @@ static const struct sysc_dts_quirk sysc_dts_quirks[] = {
 	  .mask = SYSC_QUIRK_NO_RESET_ON_INIT, },
 };
 
-static int sysc_init_dts_quirks(struct sysc *ddata)
+static void sysc_parse_dts_quirks(struct sysc *ddata, struct device_node *np,
+				  bool is_child)
 {
-	struct device_node *np = ddata->dev->of_node;
 	const struct property *prop;
-	int i, len, error;
-	u32 val;
-
-	ddata->legacy_mode = of_get_property(np, "ti,hwmods", NULL);
+	int i, len;
 
 	for (i = 0; i < ARRAY_SIZE(sysc_dts_quirks); i++) {
-		prop = of_get_property(np, sysc_dts_quirks[i].name, &len);
+		const char *name = sysc_dts_quirks[i].name;
+
+		prop = of_get_property(np, name, &len);
 		if (!prop)
 			continue;
 
 		ddata->cfg.quirks |= sysc_dts_quirks[i].mask;
+		if (is_child) {
+			dev_warn(ddata->dev,
+				 "dts flag should be at module level for %s\n",
+				 name);
+		}
 	}
+}
+
+static int sysc_init_dts_quirks(struct sysc *ddata)
+{
+	struct device_node *np = ddata->dev->of_node;
+	int error;
+	u32 val;
+
+	ddata->legacy_mode = of_get_property(np, "ti,hwmods", NULL);
 
+	sysc_parse_dts_quirks(ddata, np, false);
 	error = of_property_read_u32(np, "ti,sysc-delay-us", &val);
 	if (!error) {
 		if (val > 255) {
-- 
2.19.2
