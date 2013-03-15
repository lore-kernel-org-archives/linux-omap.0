From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 8/8] ARM: OMAP5: clock: No Freqsel on OMAP5 devices
Date: Fri, 15 Mar 2013 14:09:22 +0530
Message-ID: <5142DE3A.1070804@ti.com>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com> <1361374034-21831-9-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37709 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab3COIhm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Mar 2013 04:37:42 -0400
In-Reply-To: <1361374034-21831-9-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Wednesday 20 February 2013 08:57 PM, Santosh Shilimkar wrote:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> OMAP5 does not have freqsel either, so add the missing
> checks for !soc_is_omap54xx()
> 
> Reported-by: Archit Taneja <archit@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/dpll3xxx.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> index 0a02aab5..6e3811b 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -310,7 +310,8 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
>  	 * Set jitter correction. No jitter correction for OMAP4 and 3630
>  	 * since freqsel field is no longer present
>  	 */
> -	if (!soc_is_am33xx() && !cpu_is_omap44xx() && !cpu_is_omap3630()) {
> +	if (!soc_is_am33xx() && !cpu_is_omap44xx() && !cpu_is_omap3630()
> +            && !soc_is_omap54xx()) {
After re-looking at the freqsel patch, since the feature is available on
only OMAP343X devices, its is better to just check that device to
avoid future patching.

For the record, updated patch end of the email.

Regards,
Santosh

>From c31041957873bc524fe5d4fcd96688dc0d02e2db Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Tue, 29 Jan 2013 18:33:49 +0530
Subject: [PATCH 8/8] ARM: OMAP5: clock: No Freqsel on OMAP5 devices too

OMAP5 does not have freqsel either, so checks needs to be extended.

Infact only OMAP343X devices has the freqsel support, so fix the check
accordingly so that future patching can be avoided.

Reported-by: Archit Taneja <archit@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 3aed4b0..ae84c9d 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -307,10 +307,10 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 	_omap3_noncore_dpll_bypass(clk);
 
 	/*
-	 * Set jitter correction. No jitter correction for OMAP4 and 3630
-	 * since freqsel field is no longer present
+	 * Set jitter correction. Jitter correction applicable for OMAP343X
+	 * only since freqsel field is no longer present on other devices.
 	 */
-	if (!soc_is_am33xx() && !cpu_is_omap44xx() && !cpu_is_omap3630()) {
+	if (cpu_is_omap343x()) {
 		v = __raw_readl(dd->control_reg);
 		v &= ~dd->freqsel_mask;
 		v |= freqsel << __ffs(dd->freqsel_mask);
@@ -500,9 +500,8 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 		if (dd->last_rounded_rate == 0)
 			return -EINVAL;
 
-		/* No freqsel on AM335x, OMAP4 and OMAP3630 */
-		if (!soc_is_am33xx() && !cpu_is_omap44xx() &&
-		    !cpu_is_omap3630()) {
+		/* Freqsel is available only on OMAP343X devices */
+		if (cpu_is_omap343x()) {
 			freqsel = _omap3_dpll_compute_freqsel(clk,
 						dd->last_rounded_n);
 			WARN_ON(!freqsel);
-- 
1.7.9.5


