From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
Date: Fri, 17 Feb 2012 14:37:36 -0800
Message-ID: <20120217223736.GH18185@atomide.com>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <4F3E6323.9020101@ti.com>
 <20120217202125.GF18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:38043 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab2BQWhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Feb 2012 17:37:40 -0500
Content-Disposition: inline
In-Reply-To: <20120217202125.GF18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120217 11:50]:
> * Rajendra Nayak <rnayak@ti.com> [120217 05:53]:
> > Tony,
> > 
> > On Wednesday 15 February 2012 11:58 PM, Tony Lindgren wrote:
> > >Hi all,
> > >
> > >This series fixes up the issues noted by Russell on omap2_hsmmc_init()
> > >where if TWL PMIC is compiled as a module we can't keep a bunch of
> > >functions marked as __init like they should be. This series fixes
> > >the issues by splitting omap2_hsmmc_init() into two functions.
> > 
> > I have a re-spin of this series ready with all the fixes I did
> > while testing the insmod/unbind/bind test suggested by Russell.
> > I could not figure out what branch your original patches were
> > based on. So let me know what branch of your tree you want me
> > to post this series on.
> 
> I have them on mainline commit a269c2f5a5ad2b24a19fdd723363daf18394ec85.
> 
> Note that we should fix what Russell noted separately for the -rc
> series for the issue where reloading gpio-twl4030.ko calls
> omap2_hsmmc_init() twice, maybe something like below for that.

Here's a better fix for -rc series that also fixes a panic that I was
getting on zoom3.

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Fri, 17 Feb 2012 11:33:37 -0800
Subject: [PATCH] ARM: OMAP: Fix kernel panic with HSMMC when twl4030_gpio is a module

On some omaps twl4030_gpio has a callback to try to initialize
the MMC controller. If twl4030_gpio is compiled as a module,
bad things can happen because the callback function starts
calling functions that are supposed to be marked __init:

Kernel panic - not syncing: Attempted to kill the idle task!
twl4030_gpio twl4030_gpio: can't dispatch IRQs from modules
gpiochip_add: registered GPIOs 192 to 209 on device: twl4030
Unable to handle kernel paging request at virtual address b82a4c74
...

Additionally if this does not fail, warnings are produced
about trying to register the MMC multiple times.

Fix this by removing __init from omap_mux_get_by_name,
and add checks if omap2_hsmmc_init() is getting called more
than once.

Note that this will get fixed properly later on by splitting
omap2_hsmmc_init into two functions.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index b40c288..19dd165 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -428,6 +428,7 @@ static int omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	return 0;
 }
 
+static int omap_hsmmc_done;
 #define MAX_OMAP_MMC_HWMOD_NAME_LEN		16
 
 void omap_init_hsmmc(struct omap2_hsmmc_info *hsmmcinfo, int ctrl_nr)
@@ -491,6 +492,11 @@ void omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
 	u32 reg;
 
+	if (omap_hsmmc_done)
+		return;
+
+	omap_hsmmc_done = 1;
+
 	if (!cpu_is_omap44xx()) {
 		if (cpu_is_omap2430()) {
 			control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index fb8bc9f..611a0e3 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -218,7 +218,7 @@ static int _omap_mux_get_by_name(struct omap_mux_partition *partition,
 	return -ENODEV;
 }
 
-static int __init
+static int
 omap_mux_get_by_name(const char *muxname,
 			struct omap_mux_partition **found_partition,
 			struct omap_mux **found_mux)
