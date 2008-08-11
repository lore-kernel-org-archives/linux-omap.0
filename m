From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] OMAP2/3 GPTIMER: allow system tick GPTIMER to be
	configurable at build
Date: Mon, 11 Aug 2008 17:34:23 -0600
Message-ID: <20080811233420.3046.14785.stgit@localhost.localdomain>
References: <20080811233109.3046.54050.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35737 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbYHKXi3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 19:38:29 -0400
In-Reply-To: <20080811233109.3046.54050.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Add Kbuild code to allow the builder to select which GPTIMER block to use
for the Linux clockevents timer.  Practical choices at this point are
GPTIMER1 or GPTIMER12.  Both of these timers are in the WKUP powerdomain,
and so are unaffected by chip power management.  GPTIMER1 can use sys_clk
as a source, for applications where a high-resolution timer is more important
than power management.  GPTIMER12 has the special property that it has
the secure 32kHz oscillator as its source clock, which may be less prone
to glitches than the off-chip 32kHz oscillator.  But on HS devices, it may
not be available for Linux use.

At this point, it appears that most boards are fine with GPTIMER1, but
Beagle should use GPTIMER12.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/Kconfig    |   16 ++++++++++++++++
 arch/arm/mach-omap2/timer-gp.c |    5 ++++-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index bb6d695..365b982 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -122,3 +122,19 @@ config MACH_OMAP3EVM
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
+config OMAP_TICK_GPTIMER
+	int "GPTIMER used for system tick timer"
+	depends on ARCH_OMAP2 || ARCH_OMAP3
+	range 1 12
+	default 1
+	help
+	  Linux uses one of the twelve on-board OMAP GPTIMER blocks to generate
+	  system tick interrupts.  The twelve GPTIMERs have slightly
+	  different powerdomain, source clock, and security properties
+	  (mostly documented in the OMAP3 TRMs) that can affect the selection
+	  of which GPTIMER to use.  The historical default is GPTIMER1.
+	  If CONFIG_OMAP_32K_TIMER is selected, Beagle may require GPTIMER12
+	  due to hardware sensitivity to glitches on the OMAP 32kHz clock
+	  input.
+
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 557603f..691a7f8 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -99,7 +99,7 @@ static void __init omap2_gp_clockevent_init(void)
 {
 	u32 tick_rate;
 
-	gptimer = omap_dm_timer_request_specific(1);
+	gptimer = omap_dm_timer_request_specific(CONFIG_OMAP_TICK_GPTIMER);
 	BUG_ON(gptimer == NULL);
 
 #if defined(CONFIG_OMAP_32K_TIMER)
@@ -109,6 +109,9 @@ static void __init omap2_gp_clockevent_init(void)
 #endif
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
 
+	pr_info("OMAP clockevent source: GPTIMER%d at %u Hz\n",
+		CONFIG_OMAP_TICK_GPTIMER, tick_rate);
+
 	omap2_gp_timer_irq.dev_id = (void *)gptimer;
 	setup_irq(omap_dm_timer_get_irq(gptimer), &omap2_gp_timer_irq);
 	omap_dm_timer_set_int_enable(gptimer, OMAP_TIMER_INT_OVERFLOW);


