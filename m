From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2] ARM: OMAP4: USB: power down MUSB PHY during boot
Date: Fri, 9 Nov 2012 16:30:35 +0200
Message-ID: <1352471435-9560-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59840 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752877Ab2KIOal (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Nov 2012 09:30:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

Commit c9e4412ab8eb8ef82d645d8749c4ce96ad490007 removed all of the USB
PHY functions for OMAP4, but this causes a problem with core retention
as the MUSB module remains enabled if omap-usb2 phy driver is not used.
This keeps the USB DPLL enabled and prevents l3_init pwrdm from idling.

Fixed by adding a minimal function back that disables the USB PHY during
boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_phy_internal.c |   32 +++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index d992db8..9b56e5e 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -33,6 +33,38 @@
 #include "soc.h"
 #include "control.h"
 
+#define CONTROL_DEV_CONF		0x300
+#define PHY_PD				0x1
+
+/**
+ * omap4430_phy_power_down: disable MUSB PHY during early init
+ *
+ * OMAP4 MUSB PHY module is enabled by default on reset, but this will
+ * prevent core retention if not disabled by SW. USB driver will
+ * later on enable this, once and if the driver needs it.
+ */
+static int __init omap4430_phy_power_down(void)
+{
+	void __iomem *ctrl_base;
+
+	if (!cpu_is_omap44xx())
+		return 0;
+
+	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
+	if (!ctrl_base) {
+		pr_err("control module ioremap failed\n");
+		return -ENOMEM;
+	}
+
+	/* Power down the phy */
+	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
+
+	iounmap(ctrl_base);
+
+	return 0;
+}
+early_initcall(omap4430_phy_power_down);
+
 void am35x_musb_reset(void)
 {
 	u32	regval;
-- 
1.7.4.1

