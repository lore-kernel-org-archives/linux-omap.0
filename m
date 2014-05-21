From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 00/16] OMAP: GPMC: Restructure OMAP GPMC driver (NAND)
Date: Wed, 21 May 2014 14:20:48 +0300
Message-ID: <1400671264-10702-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: pekon-l0cyMroinI0@public.gmane.org, ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

The existing OMAP GPMC driver has been suffering from ad-hoc architecture
with no clear separation between GPMC driver, Chip Select timing/settings and
Memory Device driver. The device tree implementation also reflects the same
issues.

The purpose of this series is to clean up the OMAP GPMC driver architecture,
provide a cleaner device tree implementation and finally move the gpmc driver
out of arch/arm/mach-omap2 so that it can be used by other non-OMAP
TI platforms.

This series tries to solve the problem as follows

For non-DT boot:
- Create a GPMC platform data structure that holds chip select
  information as well as child platform device
- Board files will build this structure using a helper function
  gpmc_generic_init()
- GPMC driver will configure the chip select region and create the
  platform device for each chip select region. Introduce gpmc_probe_legacy()
  for this purpose.

For DT boot:
- The GPMC controller node should have a chip select (CS) node for each used
  chip select. The CS node must have a child device node for each device
  attached to that chip select. Properties for that child are GPMC agnostic.

  i.e.
	gpmc {
		cs0 {
			nand0 {
			}
		};

		cs1 {
			nor0 {
			}
		}
		...
	};

- The meaning of ranges and how address mapping is done has changed.
  Ranges should now contain 2 ranges
  - GPMC I/O map. This map will be partitioned among the
    chip select (CS) nodes.
  - GPMC register map. This is common for all the CS nodes.
    
- Chip select (CS) number is no longer specified via reg property. Instead
  it is specified via the gpmc,cs property in the CS node.

For NAND:
- Move interrupt handling from GPMC driver to NAND driver. GPMC driver has nothing to do
  with interrupts.
- Expose GPMC register space to NAND driver. Both GPMC and NAND drivers share the same
  register space but don't use the same registers so it is safe. A clear partitioning couldn't
  be done since the GPMC config registers are interleaved with the NAND registers.
- Add compatible id. Move NAND DT parsing code from GPMC to NAND driver.

For now the series only addresses the OMAP NAND driver. I'm working at the moment
to fix other GPMC tied drivers as well (onenand, smc91x, smsc91xx, usb-tusb6010).

Tested on:
- omap3-beagle

NOTE: This series is only for review and most likely breaks everything apart from NAND on beagle board.
I hope to get review comments early so that I can avoid any major rework.

Thanks.

--
cheers,
-roger

Roger Quadros (16):
  ARM: OMAP2+: gpmc: Add platform data
  ARM: OMAP2+: gpmc: Add gpmc timings and settings to platform data
  ARM: OMAP2+: gmpc: add gpmc_generic_init()
  ARM: OMAP2+: gpmc: use platform data to configure CS space and
    poplulate device
  ARM: OMAP2+: gpmc: Use low level read/write for context save/restore
  ARM: OMAP2+: gpmc: add NAND specific setup
  ARM: OMAP2+: nand: Update gpmc_nand_init() to use generic_gpmc_init()
  mtd: nand: omap: Fix build warning
  mtd: nand: omap: Move IRQ handling from GPMC to NAND driver
  mtd: nand: omap: Move gpmc_update_nand_reg to nand driver
  mtd: nand: omap: Move NAND write protect code from GPMC to NAND driver
  mtd: nand: omap: Copy platform data parameters to omap_nand_info data
  mtd: nand: omap: True device tree support
  ARM: OMAP: gpmc: Update DT binding documentation
  mtd: nand: omap: Update DT binding documentation
  ARM: dts: omap3-beagle: Add NAND device

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  | 109 ++-
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  86 ++-
 arch/arm/boot/dts/omap3-beagle.dts                 |  66 ++
 arch/arm/mach-omap2/gpmc-nand.c                    |  85 +--
 arch/arm/mach-omap2/gpmc.c                         | 781 +++++++++++----------
 arch/arm/mach-omap2/gpmc.h                         | 151 +---
 arch/arm/mach-omap2/io.c                           |   2 +
 drivers/mtd/nand/omap2.c                           | 365 ++++++++--
 include/linux/platform_data/gpmc-omap.h            | 168 +++++
 include/linux/platform_data/mtd-nand-omap2.h       |  10 +-
 10 files changed, 1103 insertions(+), 720 deletions(-)
 create mode 100644 include/linux/platform_data/gpmc-omap.h

-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
