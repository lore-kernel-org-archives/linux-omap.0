From: Stefan Roese <sr@denx.de>
Subject: [PATCH 1/4 v2] arm: omap: tao3530: Add pdata-quirk for the mmc2 internal clock
Date: Fri, 29 Aug 2014 12:40:03 +0200
Message-ID: <1409308806-27036-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.180]:27937 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbaH2KkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2014 06:40:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>, Tapani Utriainen <tapani@technexion.com>, Tony Lindgren <tony@atomide.com>

Set internal clock source for MMC2 on tao3530.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
Cc: Tapani Utriainen <tapani@technexion.com>
Cc: Tony Lindgren <tony@atomide.com>
---
v2:
- Patch description added to commit text

 arch/arm/mach-omap2/pdata-quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 90c88d4..b9d091b 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -253,6 +253,11 @@ static void __init nokia_n900_legacy_init(void)
 
 	}
 }
+
+static void __init omap3_tao3530_legacy_init(void)
+{
+	hsmmc2_internal_input_clk();
+}
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_ARCH_OMAP4
@@ -377,6 +382,7 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
 	{ "ti,omap3-zoom3", omap3_zoom_legacy_init, },
 	{ "ti,am3517-evm", am3517_evm_legacy_init, },
+	{ "technexion,omap3-tao3530", omap3_tao3530_legacy_init, },
 #endif
 #ifdef CONFIG_ARCH_OMAP4
 	{ "ti,omap4-sdp", omap4_sdp_legacy_init, },
-- 
2.1.0

