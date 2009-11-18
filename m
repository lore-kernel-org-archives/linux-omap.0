From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/8] OMAP: hwmod: warn on missing clockdomain
Date: Wed, 18 Nov 2009 07:03:34 -0800
Message-ID: <878we3euyh.fsf@deeprootsystems.com>
References: <1258506313-17115-1-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-2-git-send-email-khilman@deeprootsystems.com>
	<1258506313-17115-3-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.0911180404050.25515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:62061 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757389AbZKRPD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 10:03:29 -0500
Received: by pzk1 with SMTP id 1so849363pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 07:03:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0911180404050.25515@utopia.booyaka.com> (Paul Walmsley's message of "Wed\, 18 Nov 2009 04\:07\:23 -0700 \(MST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin
>
> On Tue, 17 Nov 2009, Kevin Hilman wrote:
>
>> WARN if a clock/hwmod is missing a clockdomain association since
>> resulting hwmod will not be able to correctly enable/disable clocks.
>
> Wouldn't this check be best placed in the clock code?  

Possibly.  The idea here was to flag an issue that will prevent the
hwmod code from crashing.

Doing something like below in the clock code may be the right
place, but it creates lots of noise that didn't help debug the hwmod
problem.

clock omap_32k_fck is missing clockdomain
clock virt_12m_ck is missing clockdomain
clock virt_13m_ck is missing clockdomain
clock virt_16_8m_ck is missing clockdomain
clock virt_19_2m_ck is missing clockdomain
clock virt_26m_ck is missing clockdomain
clock virt_38_4m_ck is missing clockdomain
clock osc_sys_ck is missing clockdomain
clock sys_ck is missing clockdomain
clock sys_altclk is missing clockdomain
clock mcbsp_clks is missing clockdomain
clock sys_clkout1 is missing clockdomain
clock core_ck is missing clockdomain
clock omap_96m_alwon_fck is missing clockdomain
clock omap_96m_fck is missing clockdomain
clock cm_96m_fck is missing clockdomain
clock omap_54m_fck is missing clockdomain
clock omap_48m_fck is missing clockdomain
clock omap_12m_fck is missing clockdomain
clock sys_clkout2 is missing clockdomain
clock corex2_fck is missing clockdomain
clock dpll1_fck is missing clockdomain
clock emu_mpu_alwon_ck is missing clockdomain
clock dpll2_fck is missing clockdomain
clock rm_ick is missing clockdomain
clock cpefuse_fck is missing clockdomain
clock ts_fck is missing clockdomain
clock usbtll_fck is missing clockdomain
clock mcspi_fck is missing clockdomain
clock mcspi_fck is missing clockdomain
clock mcspi_fck is missing clockdomain
clock mcspi_fck is missing clockdomain
clock hdq_fck is missing clockdomain
clock ssi_sst_fck is missing clockdomain
clock security_l3_ick is missing clockdomain
clock pka_ick is missing clockdomain
clock omapctrl_ick is missing clockdomain
clock security_l4_ick2 is missing clockdomain
clock aes1_ick is missing clockdomain
clock rng_ick is missing clockdomain
clock sha11_ick is missing clockdomain
clock des1_ick is missing clockdomain
clock usim_fck is missing clockdomain
clock sr1_fck is missing clockdomain
clock sr2_fck is missing clockdomain
clock secure_32k_fck is missing clockdomain
clock gpt12_fck is missing clockdomain
clock wdt1_fck is missing clockdomain

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 4716206..9022858 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -153,8 +153,10 @@ void omap2_init_clk_clkdm(struct clk *clk)
 {
 	struct clockdomain *clkdm;
 
-	if (!clk->clkdm_name)
+	if (!clk->clkdm_name) {
+		pr_debug("clock %s is missing clockdomain\n", clk->name);
 		return;
+	}
 
 	clkdm = clkdm_lookup(clk->clkdm_name);
 	if (clkdm) {
k
