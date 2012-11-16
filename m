From: Joel A Fernandes <joelagnel@ti.com>
Subject: [PATCH] AM33XX: Clock: Fix JTAG disconnect during kernel boot
Date: Fri, 16 Nov 2012 17:30:01 -0600
Message-ID: <1353108601-25813-1-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43042 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653Ab2KPX2B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 18:28:01 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id qAGNS0FZ010164
	for <linux-omap@vger.kernel.org>; Fri, 16 Nov 2012 17:28:01 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id qAGNRwUI018589
	for <linux-omap@vger.kernel.org>; Sat, 17 Nov 2012 04:57:59 +0530 (IST)
Received: from joelbox.am.dhcp.ti.com (dbdp20.itg.ti.com [172.24.170.38])	by
 dbdp32.itg.ti.com (8.13.8/8.13.8) with ESMTP id qAGNRuuo032028	for
 <linux-omap@vger.kernel.org>; Sat, 17 Nov 2012 04:57:57 +0530
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

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

