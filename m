From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] one regression fix and two more omap dt fixes
 against v3.13-rc2
Date: Fri, 6 Dec 2013 13:30:41 -0800
Message-ID: <20131206213041.GL26766@atomide.com>
References: <pull-1386293533-80127>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47882 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab3LFVas (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 16:30:48 -0500
Content-Disposition: inline
In-Reply-To: <pull-1386293533-80127>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [131205 17:33]:
> The following changes since commit dc1ccc48159d63eca5089e507c82c7d22ef60839:
> 
>   Linux 3.13-rc2 (2013-11-29 12:57:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/yet-more-dt-regressions
> 
> for you to fetch changes up to 341ba42e76723f2c39da7e288703896ae3d85620:
> 
>   ARM: OMAP2+: Fix the machine entry for am3517 (2013-12-05 16:25:30 -0800)
> 
> ----------------------------------------------------------------
> A rather big fix for a regression where we have dropped omap4 hwmod
> data earlier but are not initializing it from device tree. In addition
> to this fix we eventually also be fix the issues in the .dts files
> and drivers, but that's too intrusive for the -rc cycle and must be
> done later on.
> 
> Also two more legacy booting vs device tree based booting fixes for
> am3517 that I did not notice earlier until Nishant Menon reported
> these to me few days ago. With these we're good to go having v3.13
> working both for legacy booting and device tree based booting, and we
> can then go ahed and drop the legacy booting for mach-omap2 for v3.14.
> 
> ----------------------------------------------------------------
> Nishanth Menon (1):
>       ARM: OMAP2+: Fix the machine entry for am3517

Looks like this needs the following patch folded in.

Please ignore this pull request if not yet pulled, I'll post a new one
shortly.

Regards,

Tony

8< ----------------------------------

From: Tony Lindgren <tony@atomide.com>
Date: Fri, 6 Dec 2013 13:21:03 -0800
Subject: [PATCH] ARM: OMAP2+: Fix build when am3517 is selected without omap3

We should have the am3517 related entry under ARCH_OMAP3, not
under CONFIG_SOC_AM33XX.

Otherwise we can get build errors like this:

undefined reference to `omap3_map_io'
undefined reference to `am35xx_init_early'
undefined reference to `omap3_init_late'

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index e94a215..8d972ff1 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -131,13 +131,6 @@ DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Flattened Device Tree)")
 	.dt_compat	= omap3_gp_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
-#endif
-
-#ifdef CONFIG_SOC_AM33XX
-static const char *am33xx_boards_compat[] __initdata = {
-	"ti,am33xx",
-	NULL,
-};
 
 static const char *am3517_boards_compat[] __initdata = {
 	"ti,am3517",
@@ -156,6 +149,13 @@ DT_MACHINE_START(AM3517_DT, "Generic AM3517 (Flattened Device Tree)")
 	.dt_compat	= am3517_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
+#endif
+
+#ifdef CONFIG_SOC_AM33XX
+static const char *am33xx_boards_compat[] __initdata = {
+	"ti,am33xx",
+	NULL,
+};
 
 DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.reserve	= omap_reserve,
