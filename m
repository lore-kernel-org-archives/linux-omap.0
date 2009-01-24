From: Tony Lindgren <tony@atomide.com>
Subject: Re: [ANNOUNCE:RFC] convert OMAP to use clkdev
Date: Sat, 24 Jan 2009 09:04:08 -0800
Message-ID: <20090124170408.GA7172@atomide.com>
References: <20090124120317.GA20593@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Zi0sgQQBxRFxMTsj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60797 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457AbZAXREM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2009 12:04:12 -0500
Content-Disposition: inline
In-Reply-To: <20090124120317.GA20593@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090124 04:03]:
> All,
> 
> In a bid to clean up the clk API implementations, and more importantly
> ensure that implementations are using the clk API correctly, I've
> converted OMAP over to the generic clock lookup (clkdev) implementation.
> 
> In doing so, I've shaken out a number of OMAP quirks and OMAP1 specific
> clock code from the drivers.

To summarize, these patches solve the problem of matching clocks
with the driver where omap1 usually has one clock, and omap2 & 3 devices
have two clocks.

> The set of patches (minus two[*]) are available in my 'omap-clks2' branch.
> This is built on top of the omap-clks1 branch, which some people here
> already know about.

Russell, can you please post your omap-clks[12] patches here too for review
so people can look at them? It's ok to post a large series of patches to
this list.

> I do need to make some points:
> 
> 1. the omap-clks1 branch has been updated with various silly fixes I've
>    found along the way, so this won't be the same as the omap-clks1 branch
>    from a month ago.
> 
> 2. omap-clks2 branch follows on from the omap-clks1 branch - in other words,
>    arm:omap-clks2.diff is a superset of omap-clks1.diff.
> 
> 3. clkdev's current matching algorithm leads to false positives on OMAP,
>    so you need the clkdev fix which is in the master branch as well.
> 
> With this, I've been able to boot my LDP board (with the HS MMC driver)
> through to a shell prompt, and kernel messages look good.  I've also a
> bodgerated QEMU H2-based-on-OMAP310 environment which I've been checking
> OMAP1 on, and that looks reasonable.  Obviously, it's no subsitute for
> real hardware.

Seems to boot on overo after applying the attached hsmmc init fix.

> Reviews and comments obviously welcome, testing more preferred.  Probably
> the easiest way to apply these changes for testing is to download the
> diffs from the FTP site: arm.diff and arm:omap-clks2.diff, and apply
> them in that order to a fresh mainline tree.

Or even easier for the omap folks is to use the new clks-testing branch
I've just added to the linux-omap tree on kernel.org.

That's v2.6.26-rc2 + rmk/master + rmk/omap-clks1 + rmk/omap-clks2 +
one fix for hsmmc init (attached also).

> There's still a bit of work to be done here - I've left the original
> 'name' and 'id' members in the struct clk solely for the debugfs code.
> Obviously this is wasteful if you don't have debugfs enabled.

Is this series missing a patch to just clk_get ick and fck for
omap_hsmmc.c?

> Finally, the diffstat for the clkdev conversion for OMAP (omap-clks1
> to omap-clks2) shows a saving of 500 lines of code - definitely
> something not to be sniffed at:
> 
>  arch/arm/mach-omap1/clock.c              |  152 ++++++++--
>  arch/arm/mach-omap1/clock.h              |  171 ++--------
>  arch/arm/mach-omap1/mcbsp.c              |  133 ++------
>  arch/arm/mach-omap2/clock24xx.c          |  197 +++++++++++-
>  arch/arm/mach-omap2/clock24xx.h          |  353 ++-------------------
>  arch/arm/mach-omap2/clock34xx.c          |  268 ++++++++++++++--
>  arch/arm/mach-omap2/clock34xx.h          |  513 +++++-------------------------
>  arch/arm/mach-omap2/devices.c            |    1 +
>  arch/arm/mach-omap2/mcbsp.c              |  121 -------
>  arch/arm/plat-omap/Kconfig               |    3 +
>  arch/arm/plat-omap/clock.c               |   48 +---
>  arch/arm/plat-omap/include/mach/clkdev.h |   13 +
>  arch/arm/plat-omap/include/mach/clock.h  |   11 +-
>  arch/arm/plat-omap/include/mach/mcbsp.h  |    4 +-
>  arch/arm/plat-omap/mcbsp.c               |   66 +++--
>  drivers/i2c/busses/i2c-omap.c            |   47 ++--
>  drivers/mmc/host/omap.c                  |   24 +-
>  drivers/spi/omap2_mcspi.c                |    4 +-
>  drivers/spi/omap_uwire.c                 |    9 +-
>  drivers/w1/masters/omap_hdq.c            |    4 +-
>  drivers/watchdog/omap_wdt.c              |   94 ++-----
>  21 files changed, 868 insertions(+), 1368 deletions(-)

Shrinking the clock*-h is a good thing.

However my main concern is that this series is going to cause a massive
manual merge pain for us to get in sync with the linux-omap tree.

Regards,

Tony


> [*] - these are for the RNG and OHCI drivers, and have been left out
> for the time being because they conflict with my master branch, and
> would make the omap-clks2 patch unnecessarily difficult for people to
> try.
> 
> Note: please don't think about polluting mach/clkdev.h, thanks.

Huh?

--Zi0sgQQBxRFxMTsj
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="hsmmc-init-fix.patch"

commit 418c92c9fa4e7e56cacd14f0ed24cf7cfdc3f477
Author: Tony Lindgren <tony@atomide.com>
Date:   Sat Jan 24 08:34:37 2009 -0800

    Fix hsmmc init
    
    It accidentally broke while changing the name for the driver
    to not to conflict with the other mmc driver.
    
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index ac15c23..d22529c 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -205,9 +205,15 @@ int __init omap_mmc_add(int id, unsigned long base, unsigned long size,
 {
 	struct platform_device *pdev;
 	struct resource res[OMAP_MMC_NR_RES];
+	char *name;
 	int ret;
 
-	pdev = platform_device_alloc("mmci-omap", id);
+	if (cpu_class_is_omap1() || cpu_is_omap242x())
+		name = "mmci-omap";
+	else
+		name = "mmci-omap-hs";
+
+	pdev = platform_device_alloc(name, id);
 	if (!pdev)
 		return -ENOMEM;
 

--Zi0sgQQBxRFxMTsj--
