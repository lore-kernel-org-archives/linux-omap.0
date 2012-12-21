From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Fri, 21 Dec 2012 09:28:00 -0700
Message-ID: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:38728 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2LUQ2c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Dec 2012 11:28:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

[This series supersedes the hwmod related patches sent in the
 "crypto: omap-sham updates" and "crypto: omap-aes updates"
 series a few weeks ago.]

This series adds hwmod support for the OMAP SHAM and AES
modules on OMAP2, OMAP3, and OMAP4/AM33XX SoCs.  It also
adds device tree info for those modules.

The patches are based on the latest k.o. kernel, plus:
 - patches from the EDMA dmaengine series submitted by Matt Porter
   "[RFC PATCH v3 00/16] DMA Engine support for AM33XX"
   (https://lkml.org/lkml/2012/10/18/256).
 - some misc patches required by the EDMA patches
 - a hack to fix the compilation error that it currently has

The driver changes that will take advantage of these changes will
be submitted in a different series (and to a different mail list).

A working example is here:

	git@github.com:mgreeraz/linux-mag.git submitted/crypto/hwmod

Mark A. Greer (15):
  ARM: OMAP2xxx: hwmod: Convert SHAM crypto device data to hwmod
  ARM: OMAP2xxx: hwmod: Add DMA support for SHAM module
  ARM: OMAP3xxx: hwmod: Convert SHAM crypto device data to hwmod
  ARM: OMAP2+: Remove unnecessary message when no SHA IP is present
  ARM: OMAP2+: Only manually add hwmod data when DT not used.
  ARM: AM33XX: Add sha0 crypto clock data
  ARM: AM33XX: hwmod: Update and uncomment SHA0 module data
  ARM: dts: Add SHAM data and documentation for AM33XX
  ARM: OMAP2xxx: hwmod: Convert AES crypto devcie data to hwmod
  ARM: OMAP3xxx: hwmod: Convert AES crypto device data to hwmod
  ARM: OMAP2+: Remove unnecessary message when no AES IP is present
  ARM: OMAP2+: Only manually add hwmod data when DT not used.
  ARM: AM33XX: Add aes0 crypto clock data
  ARM: AM33XX: hwmod: Update and uncomment AES0 module data
  ARM: dts: Add AES data and documentation for AM33XX

 .../devicetree/bindings/crypto/omap-aes.txt        |  37 +++++
 .../devicetree/bindings/crypto/omap-sham.txt       |  35 +++++
 arch/arm/boot/dts/am335x-bone.dts                  |   8 ++
 arch/arm/boot/dts/am335x-evm.dts                   |   8 ++
 arch/arm/boot/dts/am335x-evmsk.dts                 |   8 ++
 arch/arm/boot/dts/am33xx.dtsi                      |  25 ++++
 arch/arm/mach-omap2/cclock2430_data.c              |   4 +-
 arch/arm/mach-omap2/cclock33xx_data.c              |  10 ++
 arch/arm/mach-omap2/cclock3xxx_data.c              |   4 +-
 arch/arm/mach-omap2/devices.c                      | 149 +++------------------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   2 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   2 +
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  36 +++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  81 +++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  92 +++++++++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 128 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   4 +
 17 files changed, 488 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-aes.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt

-- 
1.7.12

