From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 40/86] [ARM] OMAP3: move USBHOST SAR handling from clock framework to powerdomain layer
Date: Thu, 12 Mar 2009 11:27:50 -0700
Message-ID: <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666AbZCLSbm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:31:42 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:31:40 -0700 (PDT)
In-Reply-To: <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Remove usbhost_sar_fclk from the OMAP3 clock framework.  The bit that
the clock was tweaking doesn't actually enable or disable a clock; it
controls whether the hardware will save and restore USBHOST state
when the powerdomain changes state.  (That happens to coincidentally
enable a clock for the duration of the operation, hence the earlier
confusion.)

In place of the clock, mark the USBHOST powerdomain as supporting
hardware save-and-restore functionality.

linux-omap source commit is f3ceac86a9d425d101d606d87a5af44afef27179.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock34xx.c        |    1 -
 arch/arm/mach-omap2/clock34xx.h        |   11 -----------
 arch/arm/mach-omap2/powerdomains34xx.h |    1 +
 3 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 943ac63..439a669 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -209,7 +209,6 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2),
 	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2),
 	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2),
-	CLK(NULL,	"usbhost_sar_fck", &usbhost_sar_fck, CK_3430ES2),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_343X),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_343X),
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index f811a09..a2dcf57 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2218,17 +2218,6 @@ static struct clk usbhost_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usbhost_sar_fck = {
-	.name		= "usbhost_sar_fck",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &osc_sys_ck,
-	.init		= &omap2_init_clk_clkdm,
-	.enable_reg	= OMAP_PRM_REGADDR(OMAP3430ES2_USBHOST_MOD, PM_PWSTCTRL),
-	.enable_bit	= OMAP3430ES2_SAVEANDRESTORE_SHIFT,
-	.clkdm_name	= "usbhost_clkdm",
-	.recalc		= &followparent_recalc,
-};
-
 /* WKUP */
 
 static const struct clksel_rate usim_96m_rates[] = {
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index f573f71..3a8e4fb 100644
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
-- 
1.6.1.2

