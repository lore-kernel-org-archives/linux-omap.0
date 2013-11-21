From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: OMAP2+: Fix eMMC on n900 with device tree
Date: Thu, 21 Nov 2013 10:51:06 -0800
Message-ID: <1385059866-10646-4-git-send-email-tony@atomide.com>
References: <1385059866-10646-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21558 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754218Ab3KUSvN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Nov 2013 13:51:13 -0500
In-Reply-To: <1385059866-10646-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@debian.org>

Looks like we need to configure the regulators and use the pdata
quirk to make eMMC work with device tree.

It seems that mostly vmmc2 is used, and only some earlier revisions
like the macro board used vaux3.

Note that we can add support for the macro board later as needed
by including the common n900 .dts file and configuring the vaux3
instead of vmmc2, and adding support for the smc91x Ethernet.

Cc: devicetree@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Sebastian Reichel <sre@debian.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Can you guys please test this on production n900 devices?

I've tested it with my old macro board where I had to patch in vaux3
instead of vmmc2. I think there's some confusion in the legacy code
comments, or else I'm confused. In any case, vaux3 works for the macro
board, and I suspect that the production versions have vmmc2.

If this does not work and vaux3 as regulator works, please also dump
out the system_rev from your board.

---
 arch/arm/boot/dts/omap3-n900.dts   | 6 +++++-
 arch/arm/mach-omap2/pdata-quirks.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index c4f20bf..392ced2 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -359,7 +359,11 @@
 };
 
 &mmc2 {
-	status = "disabled";
+	/* most boards use vmmc2, only the macro boards use vaux3 */
+	vmmc-supply = <&vmmc2>;
+	vmmc_aux-supply = <&vsim>;
+	bus-width = <8>;
+	non-removable;
 };
 
 &mmc3 {
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 10c7145..39f020c 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -139,6 +139,7 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 
 static struct pdata_init pdata_quirks[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP3
+	{ "nokia,omap3-n900", hsmmc2_internal_input_clk, },
 	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
 	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
 	{ "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
-- 
1.8.1.1

