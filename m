From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap device tree changes for v3.15, part 3
Date: Thu, 13 Mar 2014 13:01:35 -0700
Message-ID: <20140313200135.GA5981@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42202 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755383AbaCMUBl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 16:01:41 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

Resending these two, looks like my updated scripts have some issues hitting
the mailing lists..

The following changes since commit 18c49af3ee9e32a535413a949672bea726699f04:

  ARM: dts: am335x-evmsk: enable dual_emac mode (2014-03-05 11:53:36 -0800)

are available in the git repository at:
  
  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/dt-part3

for you to fetch changes up to e1902bbe44844597a38c8cbae30ca895f6e126ee:

  ARM: dts: Add MMC2/SDIO/WLAN support for cm-t3530 (2014-03-12 10:40:37 -0700)

----------------------------------------------------------------
Device tree related changes to the omap iommu driver as that
is finally getting updated. Also few trivial board related
.dts updates to add more devices.

----------------------------------------------------------------
Florian Vaussard (4):
      ARM: OMAP3: remove deprecated CONFIG_OMAP_IOMMU_IVA2
      ARM: dts: OMAP3: Update ISP IOMMU node
      ARM: dts: OMAP3: Add IVA IOMMU node
      ARM: dts: OMAP4: Add IOMMU nodes

Stefan Roese (1):
      ARM: dts: Add MMC2/SDIO/WLAN support for cm-t3530

Suman Anna (6):
      ARM: OMAP3: fix iva mmu programming issues
      ARM: OMAP2+: change the ISP device archdata MMU name for DT
      ARM: OMAP2+: use pdata quirks for iommu reset lines
      ARM: OMAP5: hwmod data: add mmu data for ipu & dsp
      ARM: OMAP2+: extend iommu pdata-quirks to OMAP5
      ARM: dts: OMAP5: Add IOMMU nodes

Yegor Yefremov (1):
      ARM: dts: am335x-evmsk: enable DMA controller for USB

 arch/arm/boot/dts/am335x-evmsk.dts          |  4 ++
 arch/arm/boot/dts/omap3-cm-t3530.dts        | 36 +++++++++++++
 arch/arm/boot/dts/omap3.dtsi                | 15 ++++--
 arch/arm/boot/dts/omap4.dtsi                | 15 ++++++
 arch/arm/boot/dts/omap5.dtsi                | 15 ++++++
 arch/arm/mach-omap2/clockdomains3xxx_data.c |  2 +-
 arch/arm/mach-omap2/devices.c               |  3 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  | 12 ++---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c  | 83 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pdata-quirks.c          | 24 +++++++++
 arch/arm/plat-omap/Kconfig                  |  3 --
 11 files changed, 197 insertions(+), 15 deletions(-)

