From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/4] OMAP3: move USBHOST SAR handling from clock framework to
	powerdomain layer
Date: Wed, 25 Jun 2008 18:09:39 -0600
Message-ID: <20080626000937.18779.80710.stgit@localhost.localdomain>
References: <20080626000415.18779.25924.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36917 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYFZAQm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 20:16:42 -0400
In-Reply-To: <20080626000415.18779.25924.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com, r-woodruff2@ti.com

Remove usbhost_sar_fclk from the OMAP3 clock framework.  The bit that
the clock was tweaking doesn't actually enable or disable a clock; it
controls whether the hardware will save and restore USBHOST state
when the powerdomain changes state.  (That happens to coincidentally
enable a clock for the duration of the operation, hence the earlier
confusion.)

In place of the clock, mark the USBHOST powerdomain as supporting
hardware save-and-restore functionality.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock34xx.h        |   12 ------------
 arch/arm/mach-omap2/powerdomains34xx.h |    1 +
 2 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index b4dceea..2140463 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2231,17 +2231,6 @@ static struct clk usbhost_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usbhost_sar_fck = {
-	.name		= "usbhost_sar_fck",
-	.parent		= &osc_sys_ck,
-	.init		= &omap2_init_clk_clkdm,
-	.enable_reg	= OMAP34XX_PRM_REGADDR(OMAP3430ES2_USBHOST_MOD, PM_PWSTCTRL),
-	.enable_bit	= OMAP3430ES2_SAVEANDRESTORE_SHIFT,
-	.flags		= CLOCK_IN_OMAP3430ES2,
-	.clkdm_name	= "usbhost_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
 /* WKUP */
 
 static const struct clksel_rate usim_96m_rates[] = {
@@ -3189,7 +3178,6 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&usbhost_120m_fck,
 	&usbhost_48m_fck,
 	&usbhost_ick,
-	&usbhost_sar_fck,
 	&usim_fck,
 	&gpt1_fck,
 	&wkup_32k_fck,
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 1e1146a..88f85ea 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -312,6 +312,7 @@ static struct powerdomain usbhost_pwrdm = {
 	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
+	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBHOST ctrlr only */
 	.banks		  = 1,
 	.pwrsts_mem_ret	  = {
 		[0] = PWRDM_POWER_RET, /* MEMRETSTATE */


