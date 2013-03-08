From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 00/17] ARM: OMAP2+: GPMC clean-up and DT update
Date: Fri, 8 Mar 2013 10:58:21 -0600
Message-ID: <1362761918-8696-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43367 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933517Ab3CHQ7K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 11:59:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Mark Jackson <mpfj-list@mimc.co.uk>, Jon Hunter <jon-hunter@ti.com>

While adding device-tree support for NOR memories, it became apparent
that there is no common way for configuring various GPMC settings for
devices that interface to the GPMC. These settings include bus-width,
synchronous/asynchronous mode, burst settings, wait monitoring etc.
Therefore, to simplify the GPMC code and add device-tree support for
NOR, it was first necessary to consolidate how these settings are
programmed.

Series based upon Mark Jackson's patch [1] and Ezequiel Garcia GPMC
clean-up series [2]. Entire series available here [3].

V2 changes:
- Made gpmc_settings structure local in gpmc_nand_init().
- Use resource_size() API in probe_nor().
- Add kernel-doc for gpmc_cs_program_settings() function.
- Use of_platform_device_create() to register NOR devices in probe_nor().
- Add support for GPMC address-address-data multiplexing which required
  changing GPMC DT property "gpmc,mux-add-data" to store a 32-bit value
  and changing mux_add_data member of gpmc_settings to be a 32-bit type
  instead of bool.
- Add detection for incorrect GPMC chip-select base addresses.
- Cleaned-up code in gpmc_mem_init() and changed gpmc_mem_init() so that
  it would not return an error when the GPMC driver is being probed.

V1 changes:
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
  as expected. Note additional patches [4] are required for OMAP2420
  H4 and OMAP3430 SDP dts files in order to enable flash memory
  support.
- All of the above boards use GPMC for interfacing to a networking
  chip and so verified that networking is working wit this series.
  However, please note that networking is not currently supported
  on these boards when booting with DT and so networking is only
  tested without DT.

[1] http://permalink.gmane.org/gmane.linux.ports.arm.omap/94765
[2] http://comments.gmane.org/gmane.linux.ports.arm.omap/93784
[3] https://github.com/jonhunter/linux/tree/omap-gpmc-for-v3.10
[4] https://github.com/jonhunter/linux/tree/omap-dt-for-v3.10

Jon Hunter (17):
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
  ARM: OMAP2+: Detect incorrectly aligned GPMC base address
  ARM: OMAP2+: Remove unnecesssary GPMC definitions and variable
  ARM: OMAP2+: Allow GPMC probe to complete even if CS mapping fails

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |   48 +-
 Documentation/devicetree/bindings/mtd/gpmc-nor.txt |   98 ++++
 .../devicetree/bindings/mtd/gpmc-onenand.txt       |    3 +
 arch/arm/mach-omap2/gpmc-nand.c                    |   37 +-
 arch/arm/mach-omap2/gpmc-onenand.c                 |  110 ++---
 arch/arm/mach-omap2/gpmc-smc91x.c                  |   30 +-
 arch/arm/mach-omap2/gpmc.c                         |  521 +++++++++++++++-----
 arch/arm/mach-omap2/gpmc.h                         |   37 +-
 arch/arm/mach-omap2/usb-tusb6010.c                 |   62 ++-
 9 files changed, 686 insertions(+), 260 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nor.txt

-- 
1.7.10.4

