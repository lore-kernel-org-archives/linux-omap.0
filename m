From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/4] part 2 of omap dts changes for v3.18 merge window
Date: Thu, 18 Sep 2014 13:11:02 -0700
Message-ID: <12774.5484271601$1411071126@news.gmane.org>
References: <pull-1411070912-460910>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25524 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756171AbaIRUL4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 16:11:56 -0400
In-Reply-To: <pull-1411070912-460910>
In-Reply-To: <pull-1411070912-460910>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The following changes since commit d27704d1ec2f9ba06247b402c58a6f2febecef78:

  ARM: dts: OMAP2+: Add sub mailboxes device node information (2014-09-11 11:46:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/dt-part2-v2-for-v3.18

for you to fetch changes up to f53e3c538da314913e5d3d82c9610f8da42bd894:

  ARM: dts: DRA7: Add PMU nodes (2014-09-18 09:58:10 -0700)

----------------------------------------------------------------
Changes to add dra7 PMU, display support for cm-t54, misc
changes needed for omap3 boards for device tree support.

----------------------------------------------------------------
Dmitry Lifshitz (6):
      ARM: dts: sbc-t54: fix mux mode comment style
      ARM: dts: cm-t54: fix mux mode comment style
      ARM: dts: cm-t54: add HDMI/DVI display data
      ARM: dts: cm-t54: add Startek LCD support
      ARM: dts: cm-t54: add ADS7846 touchscreen support
      ARM: dts: cm-t54: setup omap_dwc3

Lucas Weaver (1):
      ARM: dts: DRA7: Add PMU nodes

Tony Lindgren (5):
      ARM: dts: omap3-overo: Fix UART wake-up events
      ARM: dts: omap: Remove WAKEUPENABLE mux options for UARTs
      ARM: dts: Do not set pulls for I2C lines
      ARM: dts: Add support for Ethernet on some N900 macro boards
      ARM: dts: Enable PMIC idle configuration for LDP

 arch/arm/boot/dts/dra72x.dtsi                      |   5 +
 arch/arm/boot/dts/dra74x.dtsi                      |   6 +
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   4 +-
 arch/arm/boot/dts/omap3-ldp.dts                    |   5 +
 arch/arm/boot/dts/omap3-n900.dts                   |  54 +++-
 .../boot/dts/omap3-overo-common-peripherals.dtsi   |   5 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 | 272 ++++++++++++++++++++-
 arch/arm/boot/dts/omap5-sbc-t54.dts                |   4 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |   3 +
 9 files changed, 344 insertions(+), 14 deletions(-)
