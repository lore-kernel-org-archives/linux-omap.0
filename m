From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/16] ARM: OMAP2+: Allow using ti-sysc for system timers
Date: Mon, 23 Apr 2018 10:45:35 -0700
Message-ID: <20180423174549.57412-3-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

If a system timer is configured with an interrconnect target module in
the dts, the ti,hwmods and module fck are at the interconnect target
level. Then there's a separate fck for the timer child device.

If the child device has a separate functional clock, we need to configure
it directly. For example, timer clk clkctrl clock bit 0 is the module
clock for the interconnect target, and bit 24 being the functional clock
for the timer IP.

For system timers, we already mark them as disabled. Now must also mark
the interconnect target module as disabled to prevent ti-sysc to manage
it instead of the system timer.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/timer.c | 67 ++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -167,6 +167,43 @@ static const struct of_device_id omap_timer_match[] __initconst = {
 	{ }
 };
 
+static int omap_timer_add_disabled_property(struct device_node *np)
+{
+	struct property *prop;
+
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop)
+		return -ENOMEM;
+
+	prop->name = "status";
+	prop->value = "disabled";
+	prop->length = strlen(prop->value);
+
+	return of_add_property(np, prop);
+}
+
+static int omap_timer_update_dt(struct device_node *np)
+{
+	int error = 0;
+
+	if (!of_device_is_compatible(np, "ti,omap-counter32k")) {
+		error = omap_timer_add_disabled_property(np);
+		if (error)
+			return error;
+	}
+
+	/* No parent interconnect target module configured? */
+	if (of_get_property(np, "ti,hwmods", NULL))
+		return error;
+
+	/* Tag parent interconnect target module disabled */
+	error = omap_timer_add_disabled_property(np->parent);
+	if (error)
+		return error;
+
+	return 0;
+}
+
 /**
  * omap_get_timer_dt - get a timer using device-tree
  * @match	- device-tree match structure for matching a device type
@@ -182,6 +219,7 @@ static struct device_node * __init omap_get_timer_dt(const struct of_device_id *
 						     const char *property)
 {
 	struct device_node *np;
+	int error;
 
 	for_each_matching_node(np, match) {
 		if (!of_device_is_available(np))
@@ -196,17 +234,9 @@ static struct device_node * __init omap_get_timer_dt(const struct of_device_id *
 				  of_get_property(np, "ti,timer-secure", NULL)))
 			continue;
 
-		if (!of_device_is_compatible(np, "ti,omap-counter32k")) {
-			struct property *prop;
+		error = omap_timer_update_dt(np);
+		WARN(error, "%s: Could not update dt: %i\n", __func__, error);
 
-			prop = kzalloc(sizeof(*prop), GFP_KERNEL);
-			if (!prop)
-				return NULL;
-			prop->name = "status";
-			prop->value = "disabled";
-			prop->length = strlen(prop->value);
-			of_add_property(np, prop);
-		}
 		return np;
 	}
 
@@ -265,8 +295,12 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		return -ENODEV;
 
 	of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
-	if (!oh_name)
-		return -ENODEV;
+	if (!oh_name) {
+		of_property_read_string_index(np->parent, "ti,hwmods", 0,
+					      &oh_name);
+		if (!oh_name)
+			return -ENODEV;
+	}
 
 	timer->irq = irq_of_parse_and_map(np, 0);
 	if (!timer->irq)
@@ -418,9 +452,12 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 	if (!np)
 		return -ENODEV;
 
-	of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
-	if (!oh_name)
-		return -ENODEV;
+	of_property_read_string_index(np->parent, "ti,hwmods", 0, &oh_name);
+	if (!oh_name) {
+		of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
+		if (!oh_name)
+			return -ENODEV;
+	}
 
 	/*
 	 * First check hwmod data is available for sync32k counter
-- 
2.17.0
