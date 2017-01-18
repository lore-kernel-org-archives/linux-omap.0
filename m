From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/5] ARM: OMAP2+: omap_hwmod: Add support for earlycon
Date: Wed, 18 Jan 2017 09:33:22 +0530
Message-ID: <20170118040326.29259-2-lokeshvutla@ti.com>
References: <20170118040326.29259-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170118040326.29259-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hwmod core tries to reset and idles each IP that is registered with hwmod.
In case of earlycon, that specific uart IP cannot be reset or keep it in
idle state else earlycon hangs once hwmod resets that uart IP. So add support
to not reset uart that is being used as earlycon only if CONFIG_SERIAL_EARLYCON
is enabled.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e8b988714a09..0da4f2ea76c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3249,6 +3249,36 @@ int __init omap_hwmod_setup_one(const char *oh_name)
 }
 
 /**
+ * omap_hwmod_setup_earlycon_flags - set up flags for early console
+ *
+ * Enable DEBUG_OMAPUART_FLAGS for uart hwmod that is being used as
+ * early concole so that hwmod core doesn't reset and keep it in idle
+ * that specific uart.
+ */
+#ifdef CONFIG_SERIAL_EARLYCON
+static void __init omap_hwmod_setup_earlycon_flags(void)
+{
+	struct device_node *np;
+	struct omap_hwmod *oh;
+	const char *uart;
+
+	np = of_find_node_by_path("/chosen");
+	if (np) {
+		uart = of_get_property(np, "stdout-path", NULL);
+		if (uart) {
+			np = of_find_node_by_path(uart);
+			if (np) {
+				uart = of_get_property(np, "ti,hwmods", NULL);
+				oh = omap_hwmod_lookup(uart);
+				if (oh)
+					oh->flags |= DEBUG_OMAPUART_FLAGS;
+			}
+		}
+	}
+}
+#endif
+
+/**
  * omap_hwmod_setup_all - set up all registered IP blocks
  *
  * Initialize and set up all IP blocks registered with the hwmod code.
@@ -3261,6 +3291,9 @@ static int __init omap_hwmod_setup_all(void)
 	_ensure_mpu_hwmod_is_setup(NULL);
 
 	omap_hwmod_for_each(_init, NULL);
+#ifdef CONFIG_SERIAL_EARLYCON
+	omap_hwmod_setup_earlycon_flags();
+#endif
 	omap_hwmod_for_each(_setup, NULL);
 
 	return 0;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
