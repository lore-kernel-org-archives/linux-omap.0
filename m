From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [ANNOUNCE:RFC] convert OMAP to use clkdev
Date: Sat, 24 Jan 2009 12:03:17 +0000
Message-ID: <20090124120317.GA20593@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56604 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZAXMDZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2009 07:03:25 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1LQhEN-0003t9-Jq
	for linux-omap@vger.kernel.org; Sat, 24 Jan 2009 12:03:20 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1LQhEL-0006Ju-VJ
	for linux-omap@vger.kernel.org; Sat, 24 Jan 2009 12:03:18 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

All,

In a bid to clean up the clk API implementations, and more importantly
ensure that implementations are using the clk API correctly, I've
converted OMAP over to the generic clock lookup (clkdev) implementation.

In doing so, I've shaken out a number of OMAP quirks and OMAP1 specific
clock code from the drivers.

The set of patches (minus two[*]) are available in my 'omap-clks2' branch.
This is built on top of the omap-clks1 branch, which some people here
already know about.

I do need to make some points:

1. the omap-clks1 branch has been updated with various silly fixes I've
   found along the way, so this won't be the same as the omap-clks1 branch
   from a month ago.

2. omap-clks2 branch follows on from the omap-clks1 branch - in other words,
   arm:omap-clks2.diff is a superset of omap-clks1.diff.

3. clkdev's current matching algorithm leads to false positives on OMAP,
   so you need the clkdev fix which is in the master branch as well.

With this, I've been able to boot my LDP board (with the HS MMC driver)
through to a shell prompt, and kernel messages look good.  I've also a
bodgerated QEMU H2-based-on-OMAP310 environment which I've been checking
OMAP1 on, and that looks reasonable.  Obviously, it's no subsitute for
real hardware.

Reviews and comments obviously welcome, testing more preferred.  Probably
the easiest way to apply these changes for testing is to download the
diffs from the FTP site: arm.diff and arm:omap-clks2.diff, and apply
them in that order to a fresh mainline tree.

There's still a bit of work to be done here - I've left the original
'name' and 'id' members in the struct clk solely for the debugfs code.
Obviously this is wasteful if you don't have debugfs enabled.

Finally, the diffstat for the clkdev conversion for OMAP (omap-clks1
to omap-clks2) shows a saving of 500 lines of code - definitely
something not to be sniffed at:

 arch/arm/mach-omap1/clock.c              |  152 ++++++++--
 arch/arm/mach-omap1/clock.h              |  171 ++--------
 arch/arm/mach-omap1/mcbsp.c              |  133 ++------
 arch/arm/mach-omap2/clock24xx.c          |  197 +++++++++++-
 arch/arm/mach-omap2/clock24xx.h          |  353 ++-------------------
 arch/arm/mach-omap2/clock34xx.c          |  268 ++++++++++++++--
 arch/arm/mach-omap2/clock34xx.h          |  513 +++++-------------------------
 arch/arm/mach-omap2/devices.c            |    1 +
 arch/arm/mach-omap2/mcbsp.c              |  121 -------
 arch/arm/plat-omap/Kconfig               |    3 +
 arch/arm/plat-omap/clock.c               |   48 +---
 arch/arm/plat-omap/include/mach/clkdev.h |   13 +
 arch/arm/plat-omap/include/mach/clock.h  |   11 +-
 arch/arm/plat-omap/include/mach/mcbsp.h  |    4 +-
 arch/arm/plat-omap/mcbsp.c               |   66 +++--
 drivers/i2c/busses/i2c-omap.c            |   47 ++--
 drivers/mmc/host/omap.c                  |   24 +-
 drivers/spi/omap2_mcspi.c                |    4 +-
 drivers/spi/omap_uwire.c                 |    9 +-
 drivers/w1/masters/omap_hdq.c            |    4 +-
 drivers/watchdog/omap_wdt.c              |   94 ++-----
 21 files changed, 868 insertions(+), 1368 deletions(-)

[*] - these are for the RNG and OHCI drivers, and have been left out
for the time being because they conflict with my master branch, and
would make the omap-clks2 patch unnecessarily difficult for people to
try.

Note: please don't think about polluting mach/clkdev.h, thanks.
