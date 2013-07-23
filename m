From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 27/33] ARM: OMAP3: hwmod: initialize clkdm from clkdm_name
Date: Tue, 23 Jul 2013 10:20:22 +0300
Message-ID: <1374564028-11352-28-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58568 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600Ab3GWHXP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:23:15 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

DT clocks are mostly missing clkdm info now, and this causes an issue with
counter32k which makes its slave idlemode wrong and prevents core idle.

Fixed by initializing the hwmod clkdm pointers for omap3 also which makes
sure the clkdm flag matching logic works properly.

This patch also changes the return value for _init_clkdm to 0 for
incorrect clkdm_name, as this a warning, not a fatal error.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index a6a59bd..da26659 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1544,7 +1544,7 @@ static int _init_clkdm(struct omap_hwmod *oh)
 	if (!oh->clkdm) {
 		pr_warning("omap_hwmod: %s: could not associate to clkdm %s\n",
 			oh->name, oh->clkdm_name);
-		return -EINVAL;
+		return 0;
 	}
 
 	pr_debug("omap_hwmod: %s: associated to clkdm %s\n",
@@ -4115,6 +4115,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.assert_hardreset = _omap2_assert_hardreset;
 		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
+		soc_ops.init_clkdm = _init_clkdm;
 	} else if (cpu_is_omap44xx() || soc_is_omap54xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
-- 
1.7.9.5

