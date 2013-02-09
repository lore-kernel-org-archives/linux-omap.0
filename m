From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH RFC 3/7] ARM: OMAP: gpmc-smsc911x: add DT dev node init function
Date: Sat,  9 Feb 2013 21:44:27 +0100
Message-ID: <1360442671-15216-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40069 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548Ab3BIUo6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 15:44:58 -0500
In-Reply-To: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

This patch adds a helper function to parse a device node that
contains all the properties needed to initialize an smsc911x
device connected to an OMAP processor through OMAP's GPMC.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 .../devicetree/bindings/net/gpmc-smsc911x.txt      |   39 ++++++++++++++++++++
 arch/arm/mach-omap2/gpmc-smsc911x.c                |   29 +++++++++++++++
 arch/arm/mach-omap2/gpmc-smsc911x.h                |    6 +++
 3 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/gpmc-smsc911x.txt

diff --git a/Documentation/devicetree/bindings/net/gpmc-smsc911x.txt b/Documentation/devicetree/bindings/net/gpmc-smsc911x.txt
new file mode 100644
index 0000000..8bb0df2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/gpmc-smsc911x.txt
@@ -0,0 +1,39 @@
+* GPMC connected Smart Mixed-Signal Connectivity (SMSC) LAN911x/912x Controller
+
+GPMC connected SMSC LAN911x/912x Controllers are represented as child nodes
+of the OMAP General-Purpose Memory Controller with a name of "gpmc_smsc911x".
+
+All timing relevant properties as well as generic gpmc child properties are
+explained in a separate documents - please refer to
+Documentation/devicetree/bindings/bus/ti-gpmc.txt
+
+Required properties:
+- gpmc,cs : The chip select line the pheripheral is connected to
+- gpmc,gpio_irq : The GPIO pin that is connected to the SMSC LAN IRQ line
+
+Optional properties:
+- gpmc,flags : SMSC LAN flags - please refer to include/linux/smsc911x.h
+- gpmc,gpio_reset : The GPIO pin connected to the SMSC LAN reset line
+
+Note: Besides these properties, the gpmc_smsc911x device node could need
+aditional setup such as pin/pad mux settings and voltage regulators. This
+depend on how the pheripheral is wired and his board specific.
+
+Example (for an OMAP3 board):
+
+gpmc@6e000000 {
+	      compatible = "ti,omap3430-gpmc";
+	      ti,hwmods = "gpmc";
+	      reg = <0x6e000000 0x1000000>;
+	      interrupts = <20>;
+	      gpmc,num-cs = <8>;
+	      gpmc,num-waitpins = <4>;
+	      #address-cells = <2>;
+	      #size-cells = <1>;
+
+	      gpmc_smsc911x@0 {
+			      gpmc,cs = <5>;
+			      gpmc,gpio_irq = <176>;
+			      gpmc,flags = <4>; /* SMSC911X_USE_32BIT */
+	      };
+};
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index 5ce00ad2..59a2ee4 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
+#include <linux/of.h>
 
 #include "gpmc.h"
 #include "gpmc-smsc911x.h"
@@ -98,3 +99,31 @@ free1:
 
 	pr_err("Could not initialize smsc911x device\n");
 }
+
+int gpmc_smsc911x_init_dt(struct device_node *node)
+{
+	struct omap_smsc911x_platform_data gpmc_cfg;
+
+	if (WARN_ON(!node))
+		return -ENODEV;
+
+	if (of_property_read_u32(node, "gpmc,cs", &gpmc_cfg.cs)) {
+		pr_err("Unable to get GPMC smsc911x chip select\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "gpmc,gpio_irq", &gpmc_cfg.gpio_irq)) {
+		pr_err("Unable to get GPMC smsc911x GPIO IRQ\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "gpmc,gpio_reset", &gpmc_cfg.gpio_reset))
+		gpmc_cfg.gpio_reset = -EINVAL;
+
+	if (of_property_read_u32(node, "gpmc,flags", &gpmc_cfg.flags))
+		gpmc_cfg.flags = 0;
+
+	gpmc_smsc911x_init(&gpmc_cfg);
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.h b/arch/arm/mach-omap2/gpmc-smsc911x.h
index ea6c9c8..bbcb8bc 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.h
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.h
@@ -25,11 +25,17 @@ struct omap_smsc911x_platform_data {
 
 extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d);
 
+extern int gpmc_smsc911x_init_dt(struct device_node *node);
+
 #else
 
 static inline void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d)
 {
 }
 
+static inline int gpmc_smsc911x_init_dt(struct device_node *node)
+{
+}
+
 #endif
 #endif
-- 
1.7.7.6

