From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv4 0/7] Fix remaining issues to drop more omap platform data
Date: Fri, 29 Sep 2017 15:34:04 -0700
Message-ID: <20170929223411.9691-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's v4 of the remaining fixes needed before we can drop omap hwmod
platform data for interrupts, dma channels and IO ranges.

I've dropped the clockctrl clock nodes and dts patches to avoid a
dependency to Tero's pending clock patches. As we are still relying on
"ti,hwmods" property this is just fine, and can be patched later once
the dependencies have cleared.

These patches are based on current Linux next.

Regards,

Tony


Changes since v3:

- Use sysc compatible names based on the SoC name where they are first
  seen instead of type1/2/3 as suggested by Matthijs

- Use "fck" and "ick" naming instead of "clkctrl" for clocks as we will
  need the interface clock too in many cases, and udpate the ti-sysc
  driver accordingly

- Drop the clock nodes for now to avoid a dependency to pending clock
  patches, the clock nodes can be added later on after the dependencies
  have cleared

Changes since v2:

- Drop attempted bindings for devices with no drivers and start using
  generic ti sysc interconnect target module binding, the bindings
  for the child devices can be sent separately as needed

- Add Tero's pathces for omap4 clkctrl nodes as we need those

- Add support for parsing IO ranges from dts if "ti,hwmods" is set
  and fix-up omap device code to work without platform data for
  legacy dma and smartreflex

- Add minimal ti-sysc driver

Changes since v1:

- Updated hsi, iss, fdif, gpu, and smartreflex patches based on
  the subsystem maintainer comments

- Added Rob and Mark in Cc for the patches touching binding
  documentation

Tony Lindgren (7):
  dt-bindings: bus: Minimal TI sysc interconnect target module binding
  ARM: OMAP2+: Parse module IO range from dts for legacy "ti,hwmods"
    support
  ARM: OMAP2+: Populate legacy resources for dma and smartreflex
  bus: ti-sysc: Add minimal TI sysc interconnect target driver
  ARM: dts: Add nodes for missing omap4 interconnect target modules
  ARM: dts: Configure SmartReflex only to idle the interconnect target
    module
  ARM: dts: Use ti-sysc module driver for omap4 musb

 Documentation/devicetree/bindings/bus/ti-sysc.txt |  93 ++++
 arch/arm/boot/dts/dra7.dtsi                       |  26 +
 arch/arm/boot/dts/omap4.dtsi                      | 195 +++++++-
 arch/arm/mach-omap2/Kconfig                       |   1 +
 arch/arm/mach-omap2/omap_device.c                 | 137 ++++--
 arch/arm/mach-omap2/omap_device.h                 |   4 -
 arch/arm/mach-omap2/omap_hwmod.c                  |  80 +++-
 arch/arm/mach-omap2/omap_hwmod.h                  |   5 +
 drivers/bus/Kconfig                               |   7 +
 drivers/bus/Makefile                              |   1 +
 drivers/bus/ti-sysc.c                             | 558 ++++++++++++++++++++++
 11 files changed, 1047 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/ti-sysc.txt
 create mode 100644 drivers/bus/ti-sysc.c

-- 
2.14.2
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
