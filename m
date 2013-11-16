From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Prepare making omap3 device tree only and convert LDP
Date: Fri, 15 Nov 2013 16:36:02 -0800
Message-ID: <1384562167-14725-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31535 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928Ab3KPAgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Nov 2013 19:36:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi all,

Here are few patches to deal with the mix of legacy platform data
and device tree that we still need to do at least until DSS has
device tree bindings. These patches should allow the remaining
omap3 boards to be made device tree only so we can remove the
board-*.c files.

I've also converted the old LDP board to be device tree only as that
has the typical TWL GPIO controlled LCD panel setup, and made sure
the basic things work.

These patches are against mainline tree commit 10d0c9705, and also
needs the recently posted patches from following:

[PATCH 0/8] Various omap device tree usability fixes for v3.13 merge window
[PATCH 00/11] Make omap24xx booting device tree based for v3.14 merge window

I've also pushed all the related patches to a temporary branch
omap-for-v3.14/tmp-testing-dt in the linux-omap git tree.

Regards,

Tony


Tony Lindgren (5):
  mfd: twl-core: Fix passing of platform data in the device tree case
  ARM: OMAP2+: Add support for legacy auxdata for twl
  ARM: OMAP2+: Add DT init code for DPI displays and make omap3 LDP to
    use it
  ARM: dts: Add basic support for omap3 LDP zoom1 labrador
  ARM: OMAP2+: Remove legacy booting support for LDP

 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/omap3-ldp.dts    | 231 ++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig        |   6 -
 arch/arm/mach-omap2/Makefile       |   1 -
 arch/arm/mach-omap2/board-ldp.c    | 425 -------------------------------------
 arch/arm/mach-omap2/common.h       |   1 +
 arch/arm/mach-omap2/dss-common.c   |  67 ++++++
 arch/arm/mach-omap2/dss-common.h   |   1 +
 arch/arm/mach-omap2/omap_device.c  |   2 +
 arch/arm/mach-omap2/pdata-quirks.c |  31 +++
 drivers/mfd/twl-core.c             |  15 +-
 11 files changed, 346 insertions(+), 435 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-ldp.dts
 delete mode 100644 arch/arm/mach-omap2/board-ldp.c

-- 
1.8.1.1

