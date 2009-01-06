From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 08/23] OMAP clock: remove VIRTUAL_CLOCK
Date: Mon, 5 Jan 2009 19:34:35 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0901051918440.16829@utopia.booyaka.com>
References: <20090105022953.12661.57701.stgit@localhost.localdomain> <20090105023451.12661.18427.stgit@localhost.localdomain> <87hc4dp4w0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36898 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbZAFCeh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2009 21:34:37 -0500
In-Reply-To: <87hc4dp4w0.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>

On Mon, 5 Jan 2009, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > From: Russell King <rmk@dyn-67.arm.linux.org.uk>
> >
> > Nothing tests the clock flags for this bit, so it serves no purpose.
> > Remove it.
> 
> Actually, the CPUfreq support patches (from TI) in the PM branch are
> currently using VIRTUAL_CLOCK.
> 
> I'm working on rebasing the PM branch onto this series but had to
> revert this one for now.

Better to just fix that code in the PM branch to conform with the practice 
that clock24xx.h uses for its OPP clock.  Here is an example patch that 
will probably fix it.  More needs to be done here obviously: fixing the 
code style to conform to the rest of clock{2,3}4xx.h would be a good 
start.  Guess that work will probably fall to you, unless the original 
author can be persuaded to clean it up.


- Paul


diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index a106e1a..08eb2de 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -786,8 +786,7 @@ int __init omap2_clk_init(void)
 	     clkp++) {
 		if ((*clkp)->flags & cpu_clkflg) {
 			clk_register(*clkp);
-			if (!((*clkp)->flags & VIRTUAL_CLOCK))
-				omap2_init_clk_clkdm(*clkp);
+			omap2_init_clk_clkdm(*clkp);
 		}
 	}
 
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index a8a5814..3c6a2c8 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -3432,8 +3432,9 @@ static struct clk wdt1_fck = {
 
 static struct clk virt_vdd1_prcm_set = {
 	.name = "virt_vdd1_prcm_set",
-	.flags = CLOCK_IN_OMAP343X | VIRTUAL_CLOCK | ALWAYS_ENABLED,
+	.flags = CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.parent = &mpu_ck, /* Indexed by mpu speed, no parent */
+	.clkdm		= { .name = "virt_opp_clkdm" ,}
 	.recalc = &omap3_table_recalc, /*sets are keyed on mpu rate */
 	.set_rate = &omap3_select_table_rate,
 	.round_rate = &omap3_round_to_table_rate,
@@ -3441,8 +3442,9 @@ static struct clk virt_vdd1_prcm_set = {
 
 static struct clk virt_vdd2_prcm_set = {
 	.name = "virt_vdd2_prcm_set",
-	.flags = CLOCK_IN_OMAP343X | VIRTUAL_CLOCK | ALWAYS_ENABLED,
+	.flags = CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
 	.parent = &core_ck,
+	.clkdm		= { .name = "virt_opp_clkdm" },
 	.recalc = &omap3_table_recalc,
 	.set_rate = &omap3_select_table_rate,
 	.round_rate = &omap3_round_to_table_rate,
