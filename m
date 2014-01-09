From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/4] omap device tree fixes for v3.14 merge window
Date: Wed, 8 Jan 2014 17:20:54 -0800
Message-ID: <20140109012053.GJ31323@atomide.com>
References: <20140109011940.GI31323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64720 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaAIBU6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jan 2014 20:20:58 -0500
Content-Disposition: inline
In-Reply-To: <20140109011940.GI31323@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit adfe9361b236154215d4b0fc8b6d79995394b15c:

  ARM: dts: Add basic devices on am3517-evm (2013-12-08 14:15:46 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/dt-signed

for you to fetch changes up to e37e1cb0ee231ffdc9b5ef1da63a0c7e1077c603:

  ARM: dts: OMAP2: fix interrupt number for rng (2014-01-08 10:24:44 -0800)

----------------------------------------------------------------
Split omap3 core padconf area into two as some of the registers in
the padconf area are not accessible and used for other devices.
Also fix the interrupt number for omap2 RNG, and add basic support
for sbc-3xxx with cm-t3730.

Note that the minor merge conflicts for omap_hwmod_2xxx_ipblock_data.c
can be solved by just dropping the legacy hwmod data for interrupts
for v3.14.

----------------------------------------------------------------
Laurent Pinchart (1):
      ARM: dts: Split omap3 pinmux core device

Suman Anna (1):
      ARM: dts: OMAP2: fix interrupt number for rng

Tony Lindgren (2):
      ARM: dts: Add support for sbc-3xxx with cm-t3730
      ARM: dts: Add omap specific pinctrl defines to use padconf addresses

 arch/arm/boot/dts/Makefile            |   2 +
 arch/arm/boot/dts/omap2.dtsi          |   2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts |  40 ++++++++-----
 arch/arm/boot/dts/omap3-beagle.dts    |  40 ++++++++-----
 arch/arm/boot/dts/omap3-cm-t3730.dts  | 104 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi |  95 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-igep.dtsi     |   2 -
 arch/arm/boot/dts/omap3-igep0020.dts  |  52 +++++++++--------
 arch/arm/boot/dts/omap3-igep0030.dts  |  10 ++--
 arch/arm/boot/dts/omap3-sb-t35.dtsi   |  40 +++++++++++++
 arch/arm/boot/dts/omap3-sbc-t3730.dts |  30 ++++++++++
 arch/arm/boot/dts/omap3-zoom3.dts     |  23 +++++---
 arch/arm/boot/dts/omap3.dtsi          |   2 +-
 arch/arm/boot/dts/omap34xx.dtsi       |  13 +++++
 arch/arm/boot/dts/omap36xx.dtsi       |  11 ++++
 arch/arm/mach-omap2/pdata-quirks.c    |  31 ++++++++++
 include/dt-bindings/pinctrl/omap.h    |  20 +++++++
 17 files changed, 450 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-cm-t3730.dts
 create mode 100644 arch/arm/boot/dts/omap3-cm-t3x30.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-sb-t35.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-sbc-t3730.dts
