From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] somewhat urgent omap fixes against v3.15-rc1, fixes gpmc
Date: Fri, 25 Apr 2014 13:30:48 -0700
Message-ID: <20140425203047.GG20807@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13541 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752757AbaDYUay (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2014 16:30:54 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit fb677ef70b65e22cd4401d31b700a8b4041efae1:

  ARM: OMAP2+: Fix GPMC remap for devices using an offset (2014-04-23 11:09:22 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/fixes-gpmc

for you to fetch changes up to 4c05160342f16361fc37ae34dcae9210306a83e9:

  ARM: dts: AM3517: Disable absent IPs inherited from OMAP3 (2014-04-25 09:55:00 -0700)

----------------------------------------------------------------
Mostly fixes for occasional memory corruption caused by bad
timings for smc911x LAN9220 (and potentially LAN9221) devices
that were noted on a cm-t3730 system. Also fix THUMB mode
for SMP, and mailbox related warnings when booted with device
tree.

----------------------------------------------------------------
Dave Gerlach (1):
      ARM: dts: am437x-gp-evm: Do not reset gpio5

Javier Martinez Canillas (1):
      ARM: dts: omap3-igep0020: use SMSC9221 timings

Joel Fernandes (1):
      ARM: OMAP5: Switch to THUMB mode if needed on secondary CPU

Suman Anna (3):
      ARM: dts: OMAP5: Add mailbox dt node to fix boot warning
      ARM: dts: OMAP2: Fix interrupts for OMAP2420 mailbox
      ARM: dts: AM3517: Disable absent IPs inherited from OMAP3

Tony Lindgren (3):
      ARM: dts: Fix bad OTG muxing for cm-t boards
      ARM: dts: Fix GPMC Ethernet timings for omap cm-t sbc-t boards for device tree
      ARM: dts: Fix GPMC timings for LAN9220

 arch/arm/boot/dts/am3517.dtsi             | 16 ++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts       |  5 +++
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi | 19 ++++-----
 arch/arm/boot/dts/omap2.dtsi              |  7 ----
 arch/arm/boot/dts/omap2420.dtsi           |  8 ++++
 arch/arm/boot/dts/omap2430.dtsi           |  7 ++++
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi     | 66 +++++++------------------------
 arch/arm/boot/dts/omap3-igep.dtsi         |  2 +-
 arch/arm/boot/dts/omap3-igep0020.dts      |  4 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi       | 37 +++++------------
 arch/arm/boot/dts/omap3-sbc-t3517.dts     | 13 ++++++
 arch/arm/boot/dts/omap3.dtsi              |  2 +-
 arch/arm/boot/dts/omap5.dtsi              |  7 ++++
 arch/arm/mach-omap2/omap-headsmp.S        |  8 +++-
 14 files changed, 99 insertions(+), 102 deletions(-)
