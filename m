From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [RFC PATCH v2 00/11] OMAP System Control Module
Date: Mon, 18 Jun 2012 15:31:57 +0400
Message-ID: <4FDF11AD.4040305@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:48562 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751658Ab2FRLb7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 07:31:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

  Hello.

  This is a next version of series of patches(based on Eduardo Valentin's patch set) adding a basic support for system control module, on OMAP4+ context. It is a working in progress.

Main changes since previous patch set version:
- Bandgap and usb phy: drivers are now independent from control module driver, they use their own API functions.
Dependency was removed from Kconfig.
- omap-control-core: driver is basically the same as arch/arm/mach-omap2/control.c, but resources aren't hardcoded, they are specified in dts file.
- omap-control-core: Control module is a built-in driver - added control module select to ARCH_HAS_CONTROL_MODULE and ARCH_OMAP4.
Probably, no configuration option is required!
- omap-control-core: Added early init call that ioremaps control module IOMEM window, this allows
omap-control-core.c API to be called very early, for example from omap_type()
- omap-control-core: Removed device pointer from omap-control-core API arguments, becuase there can be only one instance control
module device.
- Bandgap and usb phy: Added private spinlocks for bandgap and usb drivers.
- Bandgap: Check the type of bandgap dynamically in bandgap driver probe function by reading
omap core control module revision register CONTROL_GEN_CORE_REVISION.

TODO list for bandgap driver:
- Currently, bandgap and usb phy are children of control module, but, in fact, the drivers are independent,
so probably they should be independent entries in dts as well.
- Reserve omap-control-core IOMEM window.
- Improve thermal zone definition for OMAP4
- Introduce the thermal zones for OMAP5

Overall series has been tested only with panda board OMAP4430, so bandgap and usb phy drivers weren't tested at all.

---
 Documentation/devicetree/bindings/mfd/omap_control.txt       |   44 
 Documentation/devicetree/bindings/thermal/omap_bandgap.txt   |   27 
 arch/arm/boot/dts/omap4.dtsi                                 |   17 
 arch/arm/mach-omap2/Kconfig                                  |    1 
 arch/arm/mach-omap2/am35xx-emac.c                            |    2 
 arch/arm/mach-omap2/board-3430sdp.c                          |    2 
 arch/arm/mach-omap2/board-4430sdp.c                          |    2 
 arch/arm/mach-omap2/board-am3517crane.c                      |    2 
 arch/arm/mach-omap2/board-am3517evm.c                        |    2 
 arch/arm/mach-omap2/board-apollon.c                          |    2 
 arch/arm/mach-omap2/board-cm-t3517.c                         |    2 
 arch/arm/mach-omap2/board-h4.c                               |    2 
 arch/arm/mach-omap2/board-igep0020.c                         |    2 
 arch/arm/mach-omap2/board-ldp.c                              |    2 
 arch/arm/mach-omap2/board-omap3logic.c                       |    2 
 arch/arm/mach-omap2/board-omap4panda.c                       |    2 
 arch/arm/mach-omap2/clock2420_data.c                         |    2 
 arch/arm/mach-omap2/clock2430_data.c                         |    2 
 arch/arm/mach-omap2/clock3xxx_data.c                         |    2 
 arch/arm/mach-omap2/clock44xx_data.c                         |    2 
 arch/arm/mach-omap2/common.c                                 |    2 
 arch/arm/mach-omap2/control.c                                |    2 
 arch/arm/mach-omap2/control.h                                |  416 --
 arch/arm/mach-omap2/cpuidle34xx.c                            |    2 
 arch/arm/mach-omap2/devices.c                                |    2 
 arch/arm/mach-omap2/display.c                                |    2 
 arch/arm/mach-omap2/hsmmc.c                                  |    2 
 arch/arm/mach-omap2/id.c                                     |    7 
 arch/arm/mach-omap2/include/mach/control.h                   |  567 +++
 arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h     |  391 --
 arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h | 1409 ---------
 arch/arm/mach-omap2/include/mach/ctrl_module_pad_wkup_44xx.h |  236 -
 arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h     |   92 
 arch/arm/mach-omap2/mcbsp.c                                  |    2 
 arch/arm/mach-omap2/mux.c                                    |    2 
 arch/arm/mach-omap2/omap_phy_internal.c                      |    2 
 arch/arm/mach-omap2/opp3xxx_data.c                           |    2 
 arch/arm/mach-omap2/opp4xxx_data.c                           |    2 
 arch/arm/mach-omap2/pm24xx.c                                 |    2 
 arch/arm/mach-omap2/pm34xx.c                                 |    2 
 arch/arm/mach-omap2/prcm.c                                   |    2 
 arch/arm/mach-omap2/serial.c                                 |    2 
 arch/arm/mach-omap2/sleep34xx.S                              |    2 
 arch/arm/mach-omap2/sr_device.c                              |    2 
 arch/arm/mach-omap2/usb-fs.c                                 |    2 
 arch/arm/mach-omap2/voltage.c                                |    2 
 arch/arm/plat-omap/Kconfig                                   |    4 
 drivers/mfd/Kconfig                                          |    9 
 drivers/mfd/Makefile                                         |    1 
 drivers/mfd/omap-control-core.c                              |  141 
 drivers/thermal/Kconfig                                      |   24 
 drivers/thermal/Makefile                                     |    5 
 drivers/thermal/omap-bandgap.c                               | 1658 +++++++++++
 drivers/thermal/omap-bandgap.h                               |   76 
 drivers/thermal/omap4-thermal.c                              |   72 
 drivers/usb/otg/Kconfig                                      |   12 
 drivers/usb/otg/Makefile                                     |    1 
 drivers/usb/otg/omap4-usb-phy.c                              |  167 +
 include/linux/mfd/omap_control.h                             |   70 
 include/linux/usb/omap4_usb_phy.h                            |   53 
 60 files changed, 2988 insertions(+), 2582 deletions(-)



