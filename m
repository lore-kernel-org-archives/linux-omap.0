From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Check also the first dts child for hwmod flags
Date: Mon, 10 Dec 2018 14:13:33 -0800
Message-ID: <20181210221334.24982-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

Until the board specific dts files are updated to have hwmod
flags at the interconnect target module level, we want to keep
things working both for old and new dts files.

So let's also check the first child for hwmod flags. The module
flags are for the whole module, so only the first child should
ever have them.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2345,6 +2345,17 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
 	return 0;
 }
 
+static void __init parse_module_flags(struct omap_hwmod *oh,
+				      struct device_node *np)
+{
+	if (of_find_property(np, "ti,no-reset-on-init", NULL))
+		oh->flags |= HWMOD_INIT_NO_RESET;
+	if (of_find_property(np, "ti,no-idle-on-init", NULL))
+		oh->flags |= HWMOD_INIT_NO_IDLE;
+	if (of_find_property(np, "ti,no-idle", NULL))
+		oh->flags |= HWMOD_NO_IDLE;
+}
+
 /**
  * _init - initialize internal data for the hwmod @oh
  * @oh: struct omap_hwmod *
@@ -2392,12 +2403,12 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 	}
 
 	if (np) {
-		if (of_find_property(np, "ti,no-reset-on-init", NULL))
-			oh->flags |= HWMOD_INIT_NO_RESET;
-		if (of_find_property(np, "ti,no-idle-on-init", NULL))
-			oh->flags |= HWMOD_INIT_NO_IDLE;
-		if (of_find_property(np, "ti,no-idle", NULL))
-			oh->flags |= HWMOD_NO_IDLE;
+		struct device_node *child;
+
+		parse_module_flags(oh, np);
+		child = of_get_next_child(np, NULL);
+		if (child)
+			parse_module_flags(oh, child);
 	}
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
-- 
2.19.2
