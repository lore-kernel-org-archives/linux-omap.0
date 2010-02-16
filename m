From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/19] OMAP3 clock: Remove FreqSel for 3630
Date: Mon, 15 Feb 2010 18:24:54 -0700
Message-ID: <20100216012453.1101.96664.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57428 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497Ab0BPB07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:26:59 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

From: Vishwanath BS <vishwanath.bs@ti.com>

DPLL_FREQSEL field in CLKEN_PLL register is no longer valid for
OMAP3630. So remove references to that.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 2b559fc..84be81c 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -243,8 +243,11 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
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
@@ -387,8 +390,8 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 		if (dd->last_rounded_rate == 0)
 			return -EINVAL;
 
-		/* No freqsel on OMAP4 */
-		if (!cpu_is_omap44xx()) {
+		/* No freqsel on OMAP4 and OMAP3630 */
+		if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
 			freqsel = _omap3_dpll_compute_freqsel(clk,
 						dd->last_rounded_n);
 			if (!freqsel)


