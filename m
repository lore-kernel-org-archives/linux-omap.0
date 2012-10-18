From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 8/8] ARM: OMAP4: USB: power down MUSB PHY if not used
Date: Thu, 18 Oct 2012 12:20:10 +0300
Message-ID: <1350552010-28760-9-git-send-email-t-kristo@ti.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38940 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754982Ab2JRJUr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 05:20:47 -0400
In-Reply-To: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Commit c9e4412ab8eb8ef82d645d8749c4ce96ad490007 removed all of the USB
PHY functions for OMAP4, but this causes a problem with core retention
as the MUSB module remains enabled if omap-usb2 phy driver is not used.
This keeps the USB DPLL enabled and prevents l3_init pwrdm from idling.

Fixed by adding a minimal function back that disables the USB PHY in
case omap-usb2 driver is not used.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_phy_internal.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index d992db8..6a4b9cf 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -33,6 +33,33 @@
 #include "soc.h"
 #include "control.h"
 
+#define CONTROL_DEV_CONF		0x300
+#define PHY_PD				0x1
+
+#ifndef CONFIG_OMAP_USB2
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
+#endif
+
 void am35x_musb_reset(void)
 {
 	u32	regval;
-- 
1.7.4.1

