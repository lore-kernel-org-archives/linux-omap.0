From: Joel A Fernandes <joelagnel@ti.com>
Subject: [PATCH] AM33XX: Clock: Fix JTAG disconnect during kernel boot
Date: Fri, 16 Nov 2012 17:44:42 -0600
Message-ID: <1353109482-26478-1-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52025 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537Ab2KPXmr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 18:42:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Russ Dill <Russ.Dill@ti.com>, Matt Porter <mporter@ti.com>, Steve Kipisz <s-kipisz2@ti.com>, Jason Kridner <jkridner@beagleboard.org>, Tony Lindgren <tony@atomide.com>

Set ENABLE_ON_INIT for debugss clock so that it is on during init and the usecount is incremented.
Not doing so causes kernel to disable debugss clock to save power when CONFIG_OMAP_RESET_CLOCKS
is set, causing a JTAG disconnect.

Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
Cc: Russ Dill <Russ.Dill@ti.com>
Cc: Matt Porter <mporter@ti.com>
Cc: Steve Kipisz <s-kipisz2@ti.com>
Cc: Jason Kridner <jkridner@beagleboard.org>
Cc: Tony Lindgren <tony@atomide.com>
---
Resending, as Cc list was dropped.

 arch/arm/mach-omap2/clock33xx_data.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index b7b7995..d0b4313 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -585,6 +585,7 @@ static struct clk debugss_ick = {
 	.clkdm_name	= "l3_aon_clkdm",
 	.parent		= &dpll_core_m4_ck,
 	.ops		= &clkops_omap2_dflt,
+	.flags		= ENABLE_ON_INIT,
 	.enable_reg	= AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
 	.enable_bit	= AM33XX_MODULEMODE_SWCTRL,
 	.recalc		= &followparent_recalc,
-- 
1.7.9.5

