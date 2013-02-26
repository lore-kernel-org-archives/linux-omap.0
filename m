From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 00/14] ARM: OMAP2+: GPMC clean-up and DT update
Date: Tue, 26 Feb 2013 11:30:27 -0600
Message-ID: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36714 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984Ab3BZRbE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Feb 2013 12:31:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Jon Hunter <jon-hunter@ti.com>

While adding device-tree support for NOR memories, it became apparent
that there is no common way for configuring various GPMC settings for
devices that interface to the GPMC. These settings include bus-width,
synchronous/asynchronous mode, burst settings, wait monitoring etc.
Therefore, to simplify the GPMC code and add device-tree support for
NOR, it was first necessary to consolidate how these settings are
programmed.

Summary of changes:
- Clean-up/simplification of ONENAND initialisation code.
- Add a new GPMC structure to unify storage of various GPMC settings
  (that are non-timing related) for client devices and add a new
  function to program these settings in a common way.
- Migrate initialisation code for existing flash, usb and networking
  devices to use the new structure and function for GPMC settings.
- Add device-tree support for NOR flash memories.
- Add additional GPMC timing parameters to GPMC device-tree binding.
- Update GPMC NAND and ONENAND device-tree support to retrieve GPMC
  settings from device-tree.

Testing includes:
- Boot testing on OMAP2420 H4, OMAP3430 SDP and OMAP4430 SDP with
  and without device-tree present.
- OMAP2420 H4 board has NOR flash and OMAP3430 SDP has NOR, NAND
  and ONENAND flash. So verified that flash is detected on boot
  as expected. Note additional patches [1] are required for OMAP2420
  H4 and OMAP3430 SDP dts files in order to enable flash memory
  support.
- All of the above boards use GPMC for interfacing to a networking
  chip and so verified that networking is working wit this series.
  However, please note that networking is not currently supported
  on these boards when booting with DT and so networking is only
  tested without DT.

[1] https://github.com/jonhunter/linux/tree/dev-gpmc

Jon Hunter (14):
  ARM: OMAP2+: Simplify code configuring ONENAND devices
  ARM: OMAP2+: Add variable to store number of GPMC waitpins
  ARM: OMAP2+: Add structure for storing GPMC settings
  ARM: OMAP2+: Add function for configuring GPMC settings
  ARM: OMAP2+: Convert ONENAND to use gpmc_cs_program_settings()
  ARM: OMAP2+: Convert NAND to use gpmc_cs_program_settings()
  ARM: OMAP2+: Convert SMC91x to use gpmc_cs_program_settings()
  ARM: OMAP2+: Convert TUSB to use gpmc_cs_program_settings()
  ARM: OMAP2+: Don't configure of chip-select options in
    gpmc_cs_configure()
  ARM: OMAP2+: Add function to read GPMC settings from device-tree
  ARM: OMAP2+: Add device-tree support for NOR flash
  ARM: OMAP2+: Add additional GPMC timing parameters
  ARM: OMAP2+: Convert NAND to retrieve GPMC settings from DT
  ARM: OMAP2+: Convert ONENAND to retrieve GPMC settings from DT

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |   44 ++-
 Documentation/devicetree/bindings/mtd/gpmc-nor.txt |   98 ++++++
 .../devicetree/bindings/mtd/gpmc-onenand.txt       |    3 +
 arch/arm/mach-omap2/gpmc-nand.c                    |   38 +-
 arch/arm/mach-omap2/gpmc-onenand.c                 |  110 +++---
 arch/arm/mach-omap2/gpmc-smc91x.c                  |   30 +-
 arch/arm/mach-omap2/gpmc.c                         |  367 +++++++++++++++++---
 arch/arm/mach-omap2/gpmc.h                         |   32 +-
 arch/arm/mach-omap2/usb-tusb6010.c                 |   62 ++--
 9 files changed, 605 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nor.txt

-- 
1.7.10.4

