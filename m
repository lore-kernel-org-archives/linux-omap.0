From: jean.pihet@newoldbits.com
Subject: [PATCH v4 00/15] PM QoS: add a per-device latency constraints class
Date: Thu, 11 Aug 2011 17:06:37 +0200
Message-ID: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46608 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab1HKPH3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 11:07:29 -0400
Received: by wyg24 with SMTP id 24so1487550wyg.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Aug 2011 08:07:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.ke
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

This patch set is in an RFC state, for review and comments.

High level implementation:

1. Preparation of the PM QoS for the addition of a device PM QoS constraints
   framework:
  . rename and move of the PM QoS implementation files to kernel/power/qos.c
    and include/linux/pm_qos.h
  . rename of API parameters and internal fields names
  . Move around the PM QoS misc devices management code for better readability
  . re-organize the internal data structs
  . generalize and export the constraints management core code

2. Implementation of the per-device PM QoS constraints:
  . create drivers/base/power/qos.c for the implementation
  . create a device PM QoS API, which calls the PM QoS constraints management
    core code
  . the per-device latency constraints data strctures are stored in the device
    dev_pm_info struct
  . the device PM code calls the init and destroy of the per-device constraints
    data struct in order to support the dynamic insertion and removal of the
    devices in the system.
  . to minimize the data usage by the per-device constraints, the data struct
    is only allocated at the first call to dev_pm_qos_add_request. The data
    is later free'd when the device is removed from the system
  . per-device notification callbacks can be registered and called upon a
    change to the aggregated constraint value

3. add a global notification mechanism for the device constraints
  . add a global notification chain that gets called upon changes to the
    aggregated constraint value for any device.
  . the notification callbacks are passing the full constraint request data
    in order for the callees to have access to it. The current use is for the
    platform low-level code to access the target device of the constraint

4. Implement the OMAP low level constraints management code
  . create a PM layer plugin for per-device constraints, compiled under
    CONFIG_OMAP_PM_CONSTRAINTS=y
  . implement the devices wake-up latency constraints using the global
    device PM QoS notification handler which applies the constraints to the
    underlying layer
  . implement the low level code which controls the power domains next power
    states, through the hwmod and pwrdm layers
  . add (preliminary) power domains wake-up latency figures for OMAP3&4
  . cpuidle is a CPU centric framework so it decides the MPU next power state
    based on the MPU exit_latency and target_residency figures. The rest of
    the power domains get their next power state programmed from the devices
    PM QoS framework, via the devices wake-up latency constraints.
  . convert the OMAP I2C driver to the PM QoS API for MPU latency constraints


Questions:
1. the user space API is still under discussions on linux-omap and linux-pm MLs,
   cf. [1]. The idea is to add a user-space API for the devices constratins
   PM QoS, using a sysfs entry per device

[1] http://marc.info/?l=linux-omap&m=131232344503327&w=2

ToDo:
1. write Documentation for the new PM QoS class, once the RFC is agreed on
2. validate the constraints framework on OMAP4 HW (done on OMAP3)
3. Need testing on platforms other than OMAP
4. refine the power domains wake-up latency and the cpuidle figures
5. re-visit the OMAP power domains states initialization procedure. Currently
   the power states that have been changed from the constraints API which were
   applied before the initialization of the power domains are lost

   
Based on the master branch of the linux-omap git tree (3.0.0-rc7). Compile
tested using OMAP and x86 generic defconfigs.

Lightly tested on OMAP3 Beagleboard (ES2.x).
Need testing on platforms other than OMAP, because of the impact on the
device insertion/removal in device_pm_add/remove


Changelog:

v4:
. Complete devices PM QoS re-design:
  . Separation from the existing PM QoS classes by adding a device PM QoS
    API. The device code is re-using the PM QoS core code for constraints
    lists management and notification mechanism
  . Addition of a devices PM QoS global notification mechanism, for interaction
    with the low level platform code

v3:
. Complete PM QoS re-design after the comments on MLs
. Patch set split up for improved readability and easier maintenance

v2:
. Rework after comments on the mailing lists
. Added a notification of device insertion/removal from the device PM framework
. Validated on OMAP3 HW

v1:
. Initial implementation


Jean Pihet (14):
  PM QoS: move and rename the implementation files
  PM QoS: minor clean-ups
  PM QoS: code re-organization
  PM QoS: re-organize data structs
  PM QoS: generalize and export the constraints management code
  PM QoS: implement the per-device PM QoS constraints
  PM QoS: add a global notification mechanism for the device
    constraints
  OMAP: convert I2C driver to PM QoS for latency constraints
  OMAP: PM: create a PM layer plugin for per-device constraints
  OMAP2+: powerdomain: control power domains next state
  OMAP3: powerdomain data: add wake-up latency figures
  OMAP2+: omap_hwmod: manage the wake-up latency constraints
  OMAP: PM CONSTRAINTS: implement the devices wake-up latency
    constraints
  OMAP2+: cpuidle only influences the MPU state

Vishwanath BS (1):
  OMAP4: powerdomain data: add wake-up latency figures

 arch/arm/mach-msm/clock.c                    |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c            |   42 +--
 arch/arm/mach-omap2/omap_hwmod.c             |   26 ++-
 arch/arm/mach-omap2/pm.h                     |   17 +-
 arch/arm/mach-omap2/powerdomain.c            |  191 ++++++++++
 arch/arm/mach-omap2/powerdomain.h            |   33 ++-
 arch/arm/mach-omap2/powerdomains3xxx_data.c  |   77 ++++
 arch/arm/mach-omap2/powerdomains44xx_data.c  |   84 +++++
 arch/arm/plat-omap/Kconfig                   |    7 +
 arch/arm/plat-omap/Makefile                  |    1 +
 arch/arm/plat-omap/i2c.c                     |   20 -
 arch/arm/plat-omap/include/plat/omap-pm.h    |  128 -------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 arch/arm/plat-omap/omap-pm-constraints.c     |  350 ++++++++++++++++++
 arch/arm/plat-omap/omap-pm-noop.c            |   89 -----
 drivers/acpi/processor_idle.c                |    2 +-
 drivers/base/power/Makefile                  |    4 +-
 drivers/base/power/main.c                    |    3 +
 drivers/base/power/qos.c                     |  350 ++++++++++++++++++
 drivers/cpuidle/cpuidle.c                    |    2 +-
 drivers/cpuidle/governors/ladder.c           |    2 +-
 drivers/cpuidle/governors/menu.c             |    2 +-
 drivers/i2c/busses/i2c-omap.c                |   31 +-
 drivers/media/video/via-camera.c             |    4 +-
 drivers/net/e1000e/netdev.c                  |    2 +-
 drivers/net/wireless/ipw2x00/ipw2100.c       |    4 +-
 drivers/staging/msm/lcdc.c                   |    2 +-
 drivers/staging/msm/tvenc.c                  |    2 +-
 include/linux/netdevice.h                    |    4 +-
 include/linux/pm.h                           |    9 +
 include/linux/pm_qos.h                       |  144 ++++++++
 include/linux/pm_qos_params.h                |   38 --
 include/sound/pcm.h                          |    4 +-
 kernel/Makefile                              |    2 +-
 kernel/pm_qos_params.c                       |  481 -------------------------
 kernel/power/Makefile                        |    2 +-
 kernel/power/qos.c                           |  489 ++++++++++++++++++++++++++
 net/mac80211/main.c                          |    2 +-
 net/mac80211/mlme.c                          |    2 +-
 net/mac80211/scan.c                          |    2 +-
 sound/core/pcm_native.c                      |    2 +-
 41 files changed, 1833 insertions(+), 827 deletions(-)
 create mode 100644 arch/arm/plat-omap/omap-pm-constraints.c
 create mode 100644 drivers/base/power/qos.c
 create mode 100644 include/linux/pm_qos.h
 delete mode 100644 include/linux/pm_qos_params.h
 delete mode 100644 kernel/pm_qos_params.c
 create mode 100644 kernel/power/qos.c

-- 
1.7.2.5

