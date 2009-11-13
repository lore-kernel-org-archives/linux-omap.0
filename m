From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/14] Omap low-level device init updates for 2.6.33
Date: Thu, 12 Nov 2009 16:07:07 -0800
Message-ID: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50909 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756AbZKMAHG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:07:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some patches for review for the upcoming merge window.

This series mostly updates the low-level device init code to
support the new omap processors. Few more clean-up patches are
included too.

Regards,

Tony

---

Anand Gadiyar (1):
      omap: update plat/usb.h to allow ehci driver to build

Felipe Balbi (1):
      omap: Add platform init code for EHCI driver

Felipe Contreras (1):
      omap: iommu: reorganize

Hiroshi DOYU (2):
      omap: iommu: avoid remapping if it's been mapped in MPU side
      omap: iovmm: remove cache flush operation

Kevin Hilman (1):
      omap3: keep SoC features on the same line

Madhu (4):
      omap3630: Add HSMMC related checks
      omap3630: Configure HSMMC1 to 4-bit
      omap3630: Set omap3630 MMC1 I/O speed to 52Mhz
      omap3: HSMMC2 8-bit mux configuration

Paul Walmsley (1):
      omap3: drop all IVA-related address base definitions

Peter Ujfalusi (1):
      omap: McBSP: Do not use extensive spin locks for dma_op_mode

Sriram (1):
      omap3: evm: make HSMMC driver built-in

Tony Lindgren (1):
      omap3: move check_revision above check_features


 arch/arm/configs/omap3_evm_defconfig       |    2 
 arch/arm/mach-omap2/Makefile               |    1 
 arch/arm/mach-omap2/board-3430sdp.c        |   13 ++
 arch/arm/mach-omap2/board-omap3beagle.c    |   13 ++
 arch/arm/mach-omap2/board-omap3evm.c       |   15 ++
 arch/arm/mach-omap2/board-omap3pandora.c   |   13 ++
 arch/arm/mach-omap2/board-overo.c          |   21 ++-
 arch/arm/mach-omap2/devices.c              |    8 +
 arch/arm/mach-omap2/id.c                   |   13 +-
 arch/arm/mach-omap2/mmc-twl4030.c          |   17 ++
 arch/arm/mach-omap2/mux.c                  |    8 +
 arch/arm/mach-omap2/omap3-iommu.c          |   62 +++++----
 arch/arm/mach-omap2/usb-ehci.c             |  192 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/control.h  |    3 
 arch/arm/plat-omap/include/plat/mux.h      |    4 +
 arch/arm/plat-omap/include/plat/omap34xx.h |   11 +-
 arch/arm/plat-omap/include/plat/usb.h      |   17 ++
 arch/arm/plat-omap/iovmm.c                 |   13 +-
 arch/arm/plat-omap/mcbsp.c                 |    6 -
 19 files changed, 363 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm/mach-omap2/usb-ehci.c

-- 
Signature
