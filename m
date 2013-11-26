From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 34/41] ARM: OMAP3: hwmod: initialize clkdm from clkdm_name
Date: Tue, 26 Nov 2013 10:06:15 +0200
Message-ID: <1385453182-24421-35-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53704 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754792Ab3KZIKc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Nov 2013 03:10:32 -0500
In-Reply-To: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

DT clocks are mostly missing clkdm info now, and this causes an issue with
counter32k which makes its slave idlemode wrong and prevents core idle.

Fixed by initializing the hwmod clkdm pointers for omap3 also which makes
sure the clkdm flag matching logic works properly.

This patch also changes the return value for _init_clkdm to 0 for
incorrect clkdm_name, as this a warning, not a fatal error.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9296b69..d0cf926 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1546,7 +1546,7 @@ static int _init_clkdm(struct omap_hwmod *oh)
 	if (!oh->clkdm) {
 		pr_warning("omap_hwmod: %s: could not associate to clkdm %s\n",
 			oh->name, oh->clkdm_name);
-		return -EINVAL;
+		return 0;
 	}
 
 	pr_debug("omap_hwmod: %s: associated to clkdm %s\n",
@@ -4136,6 +4136,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.assert_hardreset = _omap2_assert_hardreset;
 		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
+		soc_ops.init_clkdm = _init_clkdm;
 	} else if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
-- 
1.7.9.5

