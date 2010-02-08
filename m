From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV6 2/4] OMAP3: Remove FreqSel for 3630
Date: Mon,  8 Feb 2010 19:48:02 +0530
Message-ID: <1265638684-30250-3-git-send-email-vishwanath.bs@ti.com>
References: <1265638684-30250-1-git-send-email-vishwanath.bs@ti.com>
 <1265638684-30250-2-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53156 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499Ab0BHONf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Feb 2010 09:13:35 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o18EDVkN016768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 8 Feb 2010 08:13:34 -0600
In-Reply-To: <1265638684-30250-2-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

DPLL_FREQSEL field in CLKEN_PLL register is no longer valid for
OMAP3630. So remove
references to that.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index dd66871..b768e4c 100755
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -279,8 +279,11 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
 	_omap3_noncore_dpll_bypass(clk);
 
-	/* Set jitter correction */
-	if (!cpu_is_omap44xx()) {
+	/*
+	 * Set jitter correction. No jitter correction for OMAP4 and 3630
+	 * since freqsel is field is no longer present
+	 */
+	if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
 		v = __raw_readl(dd->control_reg);
 		v &= ~dd->freqsel_mask;
 		v |= freqsel << __ffs(dd->freqsel_mask);
@@ -432,8 +435,8 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 		if (dd->last_rounded_rate == 0)
 			return -EINVAL;
 
-		/* No freqsel on OMAP4 */
-		if (!cpu_is_omap44xx()) {
+		/* No freqsel on OMAP4 and OMAP3630 */
+		if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
 			freqsel = _omap3_dpll_compute_freqsel(clk,
 						dd->last_rounded_n);
 			if (!freqsel)
-- 
1.5.6.3

