From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/12] Minimal support for dm814x-evm and hp t410 thin client
Date: Wed,  3 Jun 2015 09:23:09 -0700
Message-ID: <1433348601-8966-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:12997 "HELO
	pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756084AbbFCQXq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 12:23:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi all,

Here are minimal patches to make dm814x boot with mainline kernel.
No rush on these ones for v4.2, they need more testing for sure.

As I did not have a dm814x-evm, I got an hp t410 thin client as
those can be found also second hand :)

There's still no PLL clock driver, but as dm814x boots with serial
and NFSroot working, I figured it's time to post them so others
might be able to use these patches for development too.

I posted some instructions on how to make the t410 boot:

http://muru.com/linux/t410/

And I pushed a temporary testing branch for the patches with an
additional hack patch that's still needed until there's a clock
driver to tmp-testing-dm814x-2015-06-03 at:

https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=tmp-testing-dm814x-2015-06-03

Cheers,

Tony


Tony Lindgren (12):
  ARM: OMAP2+: Fix dm814x DT_MACHINE_START
  ARM: OMAP2+: Fix scrm compatible for dm814x
  ARM: OMAP2+: Add minimal clockdomains for dm814x
  ARM: OMAP2+: Add custom prwdm_operations for 81xx to support dm814x
  ARM: OMAP2+: Add support for initializing dm814x clocks
  ARM: OMAP2+: Prepare dm81xx hwmod code for adding minimal dm814x
    support
  ARM: OMAP2: Add minimal dm814x hwmod support
  ARM: dts: Add minimal dm814x support
  ARM: dts: Add minimal clocks for dm814x
  ARM: dts: Add minimal dts support for dm8148-evm
  ARM: dts: Add minimal support for HP T410
  ARM: OMAP2+: Add custom abort handler for t410

 arch/arm/boot/dts/Makefile                  |   2 +
 arch/arm/boot/dts/dm8148-evm.dts            |  28 ++
 arch/arm/boot/dts/dm8148-t410.dts           |  28 ++
 arch/arm/boot/dts/dm814x-clocks.dtsi        | 109 ++++++
 arch/arm/boot/dts/dm814x.dtsi               | 333 ++++++++++++++++
 arch/arm/mach-omap2/board-generic.c         |   2 +-
 arch/arm/mach-omap2/clockdomain.h           |   3 +-
 arch/arm/mach-omap2/clockdomains81xx_data.c |  23 +-
 arch/arm/mach-omap2/control.c               |   1 +
 arch/arm/mach-omap2/io.c                    |  12 +-
 arch/arm/mach-omap2/omap_hwmod.c            |   3 +-
 arch/arm/mach-omap2/omap_hwmod.h            |   3 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  | 569 ++++++++++++++++++----------
 arch/arm/mach-omap2/pdata-quirks.c          |  29 ++
 arch/arm/mach-omap2/powerdomains3xxx_data.c | 122 +++++-
 arch/arm/mach-omap2/prcm-common.h           |   6 +
 drivers/clk/ti/Makefile                     |   2 +-
 drivers/clk/ti/clk-814x.c                   |  36 ++
 drivers/clk/ti/clk-816x.c                   |   2 +-
 include/linux/clk/ti.h                      |   3 +-
 20 files changed, 1103 insertions(+), 213 deletions(-)
 create mode 100644 arch/arm/boot/dts/dm8148-evm.dts
 create mode 100644 arch/arm/boot/dts/dm8148-t410.dts
 create mode 100644 arch/arm/boot/dts/dm814x-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/dm814x.dtsi
 create mode 100644 drivers/clk/ti/clk-814x.c

-- 
2.1.4

