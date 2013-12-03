From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH 2/4] ARM: AM43xx: fix dpll init in bypass mode
Date: Tue, 3 Dec 2013 14:03:46 +0530
Message-ID: <1386059629-1234-3-git-send-email-sathyap@ti.com>
References: <1386059629-1234-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56701 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253Ab3LCIeM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Dec 2013 03:34:12 -0500
In-Reply-To: <1386059629-1234-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, paul@pwsan.com

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

On AM43xx, if a PLL is in bypass at kernel init, the code in
omap2_get_dpll_rate() will not realize this and will try to calculate
the clock rate using the multiplier and the divider, resulting in
errors.

omap2_init_dpll_parent() has similar issue.

Add the missing soc_is_am43xx() check to make the code work on AM43xx.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 924c230..14e9e45 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -209,7 +209,7 @@ u8 omap2_init_dpll_parent(struct clk_hw *hw)
 		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
 			return 1;
-	} else if (soc_is_am33xx() || cpu_is_omap44xx()) {
+	} else if (soc_is_am33xx() || cpu_is_omap44xx() || soc_is_am43xx()) {
 		if (v == OMAP4XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP4XXX_EN_DPLL_FRBYPASS ||
 		    v == OMAP4XXX_EN_DPLL_MNBYPASS)
@@ -255,7 +255,7 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
 		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
 			return __clk_get_rate(dd->clk_bypass);
-	} else if (soc_is_am33xx() || cpu_is_omap44xx()) {
+	} else if (soc_is_am33xx() || cpu_is_omap44xx() || soc_is_am43xx()) {
 		if (v == OMAP4XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP4XXX_EN_DPLL_FRBYPASS ||
 		    v == OMAP4XXX_EN_DPLL_MNBYPASS)
-- 
1.7.9.5

