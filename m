From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 37/43] ARM: OMAP3: hwmod: initialize clkdm from clkdm_name
Date: Fri, 25 Oct 2013 18:57:31 +0300
Message-ID: <1382716658-6964-38-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37697 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754899Ab3JYQAc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 12:00:32 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
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
index 5f8f587..ae33fae 100644
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
@@ -4117,6 +4117,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.assert_hardreset = _omap2_assert_hardreset;
 		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
+		soc_ops.init_clkdm = _init_clkdm;
 	} else if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
-- 
1.7.9.5

