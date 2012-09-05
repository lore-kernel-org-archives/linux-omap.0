From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v8 0/3] GPMC driver conversion
Date: Wed, 5 Sep 2012 18:06:26 +0530
Message-ID: <cover.1346846464.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51630 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab2IEMgh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 08:36:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Hi,

Basic gpmc driver conversion series. Driver that is now created out of
gpmc code is a simple one, it handles tasks that were earlier executed
by gpmc_init. Now instead of relying on cpu_is_* checks, it obtains
resources and clk handle in the standard Linux way. The existing gpmc
interface works as was without this series.

HWMOD patch also has been brought into this series back with v7 series

As this creates only a basic driver, further gpmc driver work can be
based over this, while having a driver first in place.

This series is based on l-o/testing-cleanup as on 5-Sep-12,
i.e. over commit,

e3a5c14 ARM: OMAP1: Move SoC specific headers from plat to mach for omap1

per Tony's suggestion.

It is available
@git://gitorious.org/x0148406-public/linux-kernel.git gpmc-drv-v8

This series has been tested on omap3evm (rev G).


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

v8:
    Use feature flag to decide whether wr_access and wr_data_mux_bus
    timings has to be configured (PATCH 3/3)

v7:
    Create a simple driver that gets resources & clk the standard Linux way
    Pull in HMWOD patch back into this series
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


Afzal Mohammed (3):
  ARM: OMAP2/3: hwmod data: add gpmc
  ARM: OMAP2+: gpmc: Adapt to HWMOD
  ARM: OMAP2+: gpmc: minimal driver support

 arch/arm/mach-omap2/gpmc.c                         |  197 +++++++++++++++-----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   18 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   18 ++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   44 +++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   54 ++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 +
 arch/arm/mach-omap2/prcm-common.h                  |    2 +
 7 files changed, 284 insertions(+), 50 deletions(-)

