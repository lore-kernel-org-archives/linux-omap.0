From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap soc changes for v3.17 merge window
Date: Thu, 24 Jul 2014 04:58:50 -0700
Message-ID: <20140724115850.GC29045@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55408 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbaGXMAR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2014 08:00:17 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 3db53918e306d3960bf9e12eea8b2fd3f7d0fd62:

  Merge tag 'for-v3.17/omap-clock-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.17/soc (2014-07-21 00:35:38 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/soc-new

for you to fetch changes up to 3965f5ba0489c01f419216c8909965b9a6a39388:

  Merge branch 'omap-for-v3.17/mailbox' into omap-for-v3.17/soc (2014-07-23 01:26:02 -0700)

----------------------------------------------------------------

SoC related changes for omaps for v3.17 merge window:

- Add device tree and hwmod data for various devices
  for new SoCs

- Remove legacy mailbox hwmod data that's no longer
  needed for SoCs that are DT only. Note that this may
  cause a minor merge conflict in mach-omap2/devices.c
  with omap_init_mbox() and omap_init_hdmi_audio(), both
  are legacy code that is getting removed

----------------------------------------------------------------
Kishon Vijay Abraham I (2):
      arm: dra7xx: Add hwmod data for pcie1 phy and pcie2 phy
      arm: dra7xx: Add hwmod data for pcie1 and pcie2 subsystems

Lokesh Vutla (1):
      ARM: DRA7: hwmod: Add data for RTC

Mugunthan V N (1):
      arm: dra7xx: Add hwmod data for MDIO and CPSW

Nishanth Menon (2):
      ARM: OMAP2+: DMA: remove requirement of irq for platform-dma driver
      ARM: DRA7: hwmod: remove interrupts for DMA

Roger Quadros (1):
      ARM: DRA7: hwmod: Add OCP2SCP3 module

Sathya Prakash M R (1):
      ARM: AM43xx: hwmod: add DSS hwmod data

Suman Anna (10):
      ARM: dts: OMAP2+: Add mailbox fifo and user information
      ARM: dts: OMAP4: Add mailbox node
      ARM: dts: AM33xx: Add mailbox node
      ARM: dts: AM4372: Correct mailbox node data
      ARM: dts: DRA7: Add mailbox nodes
      ARM: DRA7: hwmod_data: Add mailbox hwmod data
      ARM: OMAP2+: Avoid mailbox legacy device creation for DT-boot
      ARM: OMAP2: hwmod_data: Remove legacy mailbox data and addrs
      ARM: OMAP4: hwmod_data: Remove legacy mailbox addrs
      ARM: AM33xx: hwmod_data: Remove legacy mailbox addrs

Tony Lindgren (2):
      Merge tag 'for-v3.17/omap-hwmod-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.17/soc
      Merge branch 'omap-for-v3.17/mailbox' into omap-for-v3.17/soc

 arch/arm/boot/dts/am33xx.dtsi                      |   9 +
 arch/arm/boot/dts/am4372.dtsi                      |   3 -
 arch/arm/boot/dts/dra7.dtsi                        | 117 +++++
 arch/arm/boot/dts/omap2420.dtsi                    |   2 +
 arch/arm/boot/dts/omap2430.dtsi                    |   2 +
 arch/arm/boot/dts/omap3.dtsi                       |   2 +
 arch/arm/boot/dts/omap4.dtsi                       |   9 +
 arch/arm/boot/dts/omap5.dtsi                       |   2 +
 arch/arm/mach-omap2/Makefile                       |   1 +
 arch/arm/mach-omap2/cm2_7xx.h                      |   4 +
 arch/arm/mach-omap2/devices.c                      |   2 +-
 arch/arm/mach-omap2/dma.c                          |   3 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  14 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  13 -
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |   9 -
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  40 --
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |  10 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 100 ++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  10 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 574 ++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   1 -
 .../mach-omap2/omap_hwmod_common_ipblock_data.c    |  55 ++
 arch/arm/mach-omap2/prcm43xx.h                     |   1 +
 arch/arm/mach-omap2/prm7xx.h                       |   4 +
 arch/arm/plat-omap/dma.c                           |   5 +-
 include/linux/omap-dma.h                           |   1 +
 26 files changed, 881 insertions(+), 112 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_common_ipblock_data.c
