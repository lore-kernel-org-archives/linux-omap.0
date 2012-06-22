From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 00/13] GPMC driver conversion
Date: Fri, 22 Jun 2012 18:25:38 +0530
Message-ID: <cover.1340367480.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34575 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762062Ab2FVNLF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 09:11:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Hi,

This series is based on 3.5-rc1, and is dependent on [1,2,3], and has
been tested on omap3evm (smsc911x) rev G & C and beagle board(nand).
Also using private patches, nand & onenand was tested on omap3evm,
rev G & C respectively (as support for these were not in mainline)

All boards will work using the old existing interface. Further patch
series would convert all boards to use new interface.

Many of GPMC peripherals depend on bootloader for configuration.
This is going to be deprecated. feature-removal-schedule.txt will be
updated in one of the upcoming patch series.

Thanks to Tony & Jon for their various suggestions.

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

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70096.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70730.html
[3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69881.html

v6: Capability flag added that stores features based on revision
    Macros used for finding revision
    Return value from memory setup function corrected
    Comments added to clarify handling of device type, size
    Bool type time setting patch removed as has been taken care in [2]
    Handle variable number of waitpin
    Warn if driver is unable to configure interrupt
    Enhance some of commit messages
    Handle shared writeprotect case
    Fix a bug in gpmc_create_device
    Get clk from hwmod
    Remove unwanted code
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


Afzal Mohammed (13):
  ARM: OMAP2+: gpmc: platform definitions
  ARM: OMAP2+: gpmc: Adapt to HWMOD
  ARM: OMAP2+: gpmc: driver migration helper
  ARM: OMAP2+: gpmc: minimal driver support
  ARM: OMAP2+: gpmc: resource creation helpers
  ARM: OMAP2+: gpmc: CS configuration helper
  ARM: OMAP2+: gpmc: register time setting helper
  ARM: OMAP2+: gpmc: holler if no configuration
  ARM: OMAP2+: gpmc: waitpin helper
  ARM: OMAP2+: gpmc: handle connected peripherals
  ARM: OMAP2+: gpmc: cs reconfigure helper
  ARM: OMAP2+: gpmc: update nand register info
  ARM: OMAP2+: gpmc: configure writeprotect

 arch/arm/mach-omap2/gpmc.c             |  797 ++++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/gpmc.h |   58 +++
 2 files changed, 812 insertions(+), 43 deletions(-)

-- 
1.7.10.2

