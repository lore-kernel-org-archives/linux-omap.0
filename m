From: jean.pihet@newoldbits.com
Subject: [RFC/PATCH 00/26] PM: Create the AVS class of drivers
Date: Tue, 22 Nov 2011 16:05:44 +0100
Message-ID: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab1KVPGt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:06:49 -0500
Received: by fagn18 with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:06:48 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The following patches are in RFC state; the code is still WIP and has been
compile tested only. Feedback on the code organization is welcome!

AVS is a power management technique which controls the operating
voltage of a device in order to optimize (i.e. reduce) its power
consumption. The voltage is adapted depending on static factors
(chip manufacturing process) and dynamic factors (temperature
depending performance).
AVS is also called SmartReflex on OMAP devices.

To that end, create the AVS framework in drivers/power/avs and
move the OMAP SmartReflex code to the new directory.

In preparation to the move of the OMAP code the following changes have been
made:
- split into common code (not semiconductor specific), a v1 IP driver,
  a v2 IP driver and a class driver for SmartReflex Class3,
- initialize the v1 driver for OMAP34xx platform and v2 driver for
   OMAP36xx and OMAP4xxx platforms,
- create CONFIG_AVS* config options accordingly,
- split the include files into generic and platform specific code,
- removal of unused code in SmartReflex: notification machanism, PMIC
  specific code.

The following features are supported:
- read the SmartReflex values from the e-fuses and allow the board file code
  to override the values,
- platform integration data for SmartReflex is passed to the driver using
  pdata.


ToDo:
- integration with the platform code,
- kerneldoc should be added to the new structs and functions,
- use correct device attribute data for OMAP4,
- test on board (OMAP3/4),
- integrate latest SmartReflex fixes [1]

The code is based on Paul's original version of the SmartReflex driver conversion
[2].

Compile tested only using omap2plus_defconfig with the CONFIG_POWER_AVS* options set.
Based on latest master branch of the l-o git tree (3.2.0-rc2) [3].

[1] http://marc.info/?l=linux-omap&m=132134699423547&w=2
[2] smartreflex_cleanup_3.1 branch of git://git.pwsan.com/linux-2.6 
[3] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git


Jean Pihet (14):
  OMAP3/4: SmartReflex: class drivers should use struct omap_sr *
  OMAP3/4: SmartReflex: API should use struct omap_sr *, not struct
    voltagedomain *
  OMAP: SmartReflex: drop _sr_lookup()
  OMAP3+: Pass SmartReflex instance-specific data via hwmod dev_attr
  OMAP3+: hwmod: get rid of vdd_name field
  OMAP2+: rename struct omap_sr_class_data to smartreflex_class_data
  OMAP2+: Use the names from the SmartReflex data instead of voltage
    domains.
  OMAP2+: SmartReflex: make driver generic
  OMAP2+: SmartReflex: get rid of superfluous data that is duplicated
    between platform_data and the struct omap_sr
  OMAP2+: SmartReflex: remove OMAP specific code
  OMAP2+: SmartReflex: conversion into generic driver
  OMAP3+: voltage: export functions to plat/voltage.h
  OMAP: PM: convert the SmartReflex code into the AVS driver framework
  PM: Create the AVS class of drivers

Paul Walmsley (12):
  OMAP2+: smartreflex: use sane default values
  OMAP: hwmod/SmartReflex: remove IP block instance-specific data from
    the driver code
  OMAP: SmartReflex: make pdata distinct from other data
  OMAP: SmartReflex: Use 'sr' for struct smartreflex
  OMAP3+: SmartReflex: remove unused PMIC code
  OMAP: SmartReflex: remove some SoC-specific implementation details
    from driver
  OMAP: SmartReflex driver interface: allow core to override eFuse data
  OMAP2+: SmartReflex: rename nvalue table
  OMAP2+: SmartReflex: cosmetic changes
  OMAP3+: Add SmartReflex clocks
  OMAP2+: Use the TRM formula to calculate the SmartReflex clock rate
  OMAP2+: SmartReflex: Remove the notifier handler

 arch/arm/mach-omap2/Makefile                  |    4 +-
 arch/arm/mach-omap2/clock3xxx_data.c          |    6 +
 arch/arm/mach-omap2/clock44xx_data.c          |    3 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |   37 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |   40 +-
 arch/arm/mach-omap2/pm.h                      |    2 +-
 arch/arm/mach-omap2/smartreflex-class3.c      |   59 --
 arch/arm/mach-omap2/smartreflex.c             | 1056 -------------------------
 arch/arm/mach-omap2/smartreflex.h             |  246 ------
 arch/arm/mach-omap2/sr_device.c               |  129 ++--
 arch/arm/mach-omap2/voltage.h                 |    3 +-
 arch/arm/mach-omap2/vp.h                      |    2 -
 arch/arm/plat-omap/Kconfig                    |   31 -
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    3 -
 arch/arm/plat-omap/include/plat/smartreflex.h |  106 +++
 arch/arm/plat-omap/include/plat/voltage.h     |    3 +
 drivers/power/Kconfig                         |    2 +
 drivers/power/Makefile                        |    2 +
 drivers/power/avs/Kconfig                     |   56 ++
 drivers/power/avs/Makefile                    |    4 +
 drivers/power/avs/smartreflex-class3.c        |   64 ++
 drivers/power/avs/smartreflex-common.c        |  543 +++++++++++++
 drivers/power/avs/smartreflex.h               |  231 ++++++
 drivers/power/avs/smartreflex_v1.c            |  183 +++++
 drivers/power/avs/smartreflex_v2.c            |  186 +++++
 25 files changed, 1544 insertions(+), 1457 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
 delete mode 100644 arch/arm/mach-omap2/smartreflex.c
 delete mode 100644 arch/arm/mach-omap2/smartreflex.h
 create mode 100644 arch/arm/plat-omap/include/plat/smartreflex.h
 create mode 100644 drivers/power/avs/Kconfig
 create mode 100644 drivers/power/avs/Makefile
 create mode 100644 drivers/power/avs/smartreflex-class3.c
 create mode 100644 drivers/power/avs/smartreflex-common.c
 create mode 100644 drivers/power/avs/smartreflex.h
 create mode 100644 drivers/power/avs/smartreflex_v1.c
 create mode 100644 drivers/power/avs/smartreflex_v2.c

-- 
1.7.5.4

