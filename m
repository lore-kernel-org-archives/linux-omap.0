From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v5 00/14] GPMC driver conversion
Date: Mon, 11 Jun 2012 19:55:02 +0530
Message-ID: <cover.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49971 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632Ab2FKOko (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 10:40:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Hi,

This series is based on 3.5-rc1, and is dependent on [1,2,3]

This series has been tested on omap3evm (smsc911x) rev G & C and
beagle board(nand) using patch series which is going to be posted
shortly (this series only creates a driver out of GPMC code)

Also using private patches, nand & onenand was tested on omap3evm,
rev G & C respectively (as support for these were not in mainline)

Many of GPMC peripherals depend on bootloader for configuration.
This is going to be deprecated. feature-removal-schedule.txt will be
updated in one of the upcoming patch series regarding the same.


[PATCH 03/13] ARM: OMAP2+: gpmc: driver migration helper, is to be
reverted once all GPMC peripherals are migrated to use driver
interface.

GPMC (General Purpose Memory Controller) in brief:
GPMC is an unified memory controller dedicated to interfacing external
memory devices like
 Asynchronous SRAM like memories and application specific integrated circuit devices.
 Asynchronous, synchronous, and page mode burst NOR flash devices NAND flash
 Pseudo-SRAM devices

GPMC details can be referred in AM335X Technical Reference Manual
@ http://www.ti.com/lit/pdf/spruh73

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69501.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69881.html
[3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69891.html

v5: Make this a purely driver conversion series, i.e. gpmc-mtd
    interactions has been made as a separate series, so is adding
    hwmod entry for OMAP2/3.
    And modifying gpmc peripheral platform initialization has been
    separated out of this series, so is migrating boards to use new
    driver interface. GPMC driver conversion which was done in a few
    patches in v4 has been tranformed to series of small patches.
    Also care has been taken care that old interface will not break
    with any of these patches, so both interfaces can coexist.
    This helps in converting boards one-by-one gradually. Acquiring
    CS has been thrown out. And conclusive comments on v4 has been
    addressed.
v4: Handle wait pin (except for interrupts), enhance configuration
    & timing interface of GPMC to take care of all boards. Dynamic
    allocation of interrupt instead of static. Convert remaining
    peripherals to work with GPMC driver. Handle acquiring NAND CS#,
    adapt to HWMOD, update HWMOD OMAP2/3 entries, other minor
    commenst on v3.
v3: Single device structure passed from platform for peripherals using
    multiple CS instead of using multiple device structure having a few
    redundant data, handle interrupts, GPMC NAND handling by GPMC NAND
    driver instead of GPMC driver
v2: Avoid code movement that kept similar code together (for easy review)

Afzal Mohammed (14):
  ARM: OMAP2+: gpmc: platform definitions
  ARM: OMAP2+: gpmc: Adapt to HWMOD
  ARM: OMAP2+: gpmc: driver migration helper
  ARM: OMAP2+: gpmc: minimal driver support
  ARM: OMAP2+: gpmc: resource creation helpers
  ARM: OMAP2+: gpmc: CS configuration helper
  ARM: OMAP2+: gpmc: time setting (register#) helper
  ARM: OMAP2+: gpmc: bool type timing helper
  ARM: OMAP2+: gpmc: holler if no configuration
  ARM: OMAP2+: gpmc: waitpin helper
  ARM: OMAP2+: gpmc: handle connected peripherals
  ARM: OMAP2+: gpmc: cs reconfigure helper
  ARM: OMAP2+: gpmc: update nand register info
  ARM: OMAP2+: gpmc: writeprotect helper

 arch/arm/mach-omap2/gpmc.c             |  817 ++++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/gpmc.h |   68 +++
 2 files changed, 842 insertions(+), 43 deletions(-)

-- 
1.7.10.2

