From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 0/8] ARM: OMAP4: core retention support
Date: Tue, 6 Nov 2012 11:18:02 +0200
Message-ID: <1352193483.8788.43.camel@sokoban>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
	 <87d2zrg04t.fsf@deeprootsystems.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-eaUqxlH8yLtvQ3LI3JGG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55828 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263Ab2KFJSL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 04:18:11 -0500
In-Reply-To: <87d2zrg04t.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

--=-eaUqxlH8yLtvQ3LI3JGG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Kevin,

On Mon, 2012-11-05 at 14:23 -0800, Kevin Hilman wrote:
> Hi Tero,
> 
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Hi,
> >
> > Changes compared to previous version:
> > - rebased on top of 3.7-rc1
> > - applies on top of latest func pwrst code (v6)
> > - added back patch #1 to this set (it wasn't queued yet after all)
> > - added patch #7 for fixing a bug in the functional pwrst code
> > - added patch #8 for fixing a regression with MUSB PHY power handling
> >   (not quite sure if this is the correct way to fix this or not)
> >
> > Tested with omap4460 gp panda + omap4430 emu blaze boards, with cpuidle +
> > suspend.
> >
> > Branch also available here:
> > git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> > branch: mainline-3.7-rc1-omap4-ret-v9
> 
> I tested this branch on 4430/Panda and 4460/Panda-ES and I'm seeing
> several domains not hitting target power state in suspend[1].
> 
> Am I missing some other fixes?  Using omap2plus_defconfig, I tried your
> branch alone, and merged with v3.7-rc4, and I get the same errors.
> 
> Kevin
> 
> [1]
> # echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/power/wakeup
> # echo mem > /sys/power/state 
> [  102.271087] PM: Syncing filesystems ... done.
> [  102.282196] Freezing user space processes ... (elapsed 0.02 seconds) done.
> [  102.312133] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
> [  102.343353] Suspending console(s) (use no_console_suspend to debug)
> �[  102.363433] PM: suspend of devices complete after 10.650 msecs
> [  102.365631] PM: late suspend of devices complete after 2.166 msecs
> [  102.369201] PM: noirq suspend of devices complete after 3.509 msecs
> [  102.369232] Disabling non-boot CPUs ...
> [  102.373016] CPU1: shutdown
> [  104.357421] Powerdomain (core_pwrdm) didn't enter target state 1
> [  104.357452] Powerdomain (tesla_pwrdm) didn't enter target state 1
> [  104.357452] Powerdomain (ivahd_pwrdm) didn't enter target state 1
> [  104.357482] Powerdomain (l3init_pwrdm) didn't enter target state 1
> [  104.357482] Could not enter target state in pm_suspend
> [  104.357666] Enabling non-boot CPUs ...
> [  104.359863] CPU1: Booted secondary processor
> [  104.360626] cpu cpu0: opp_init_cpufreq_table: Device OPP not found (-19)
> [  104.360656] cpu cpu0: omap_cpu_init: cpu1: failed creating freq table[-19]
> [  104.360656] CPU1 is up
> [  104.362579] PM: noirq resume of devices complete after 1.892 msecs
> [  104.364807] PM: early resume of devices complete after 1.373 msecs
> [  104.710937] PM: resume of devices complete after 346.099 msecs
> [  104.817901] Restarting tasks ... done.

This looks like a combination of boot loader/kernel problems. My guess
is that l3init is probably held on by the USB, and both ivahd / tesla
are held on by some DSP/IVA modules which are not idling properly.

The last patch in this set should fix the USB problems at least
partially, but also the USB DPLL itself might be in wrong state,
attached patch might help for that one and get l3init to idle.

For DSP I don't have a patch right now, what is the boot loader you are
using? (Can you provide git / commit / config info?)

-Tero


--=-eaUqxlH8yLtvQ3LI3JGG
Content-Disposition: attachment;
	filename="0003-ARM-OMAP4-clock-setup-USB-DPLL-during-init.patch"
Content-Type: text/x-patch;
	name="0003-ARM-OMAP4-clock-setup-USB-DPLL-during-init.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 2bde02977db605822ee83042ebc0077ba133277e Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Thu, 21 Jun 2012 14:56:40 +0300
Subject: [PATCH 3/7] ARM: OMAP4: clock: setup USB DPLL during init

The reset setup for USB DPLL does not allow idle, thus the kernel must
program it during init. This puts the USB DPLL in locked mode, autoidle
for it is enabled automatically later during the boot sequence.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index e2b701e..e28950a 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3413,6 +3413,7 @@ int __init omap4xxx_clk_init(void)
 {
 	struct omap_clk *c;
 	u32 cpu_clkflg;
+	struct clk *dpll_usb;
 
 	if (cpu_is_omap443x()) {
 		cpu_mask = RATE_IN_4430;
@@ -3456,5 +3457,12 @@ int __init omap4xxx_clk_init(void)
 	 */
 	clk_enable_init_clocks();
 
+	/*
+	 * Setup USB DPLL
+	 */
+	dpll_usb = clk_get(NULL, "dpll_usb_ck");
+
+	clk_set_rate(dpll_usb, 960000000);
+
 	return 0;
 }
-- 
1.7.4.1


--=-eaUqxlH8yLtvQ3LI3JGG--
