From: jean.pihet@newoldbits.com
Subject: [PATCH v6 0/7] PM QoS: add a per-device latency constraints framework
Date: Wed, 17 Aug 2011 21:39:18 +0200
Message-ID: <1313609965-6568-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41207 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab1HQTkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Aug 2011 15:40:25 -0400
Received: by wyg24 with SMTP id 24so914733wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Aug 2011 12:40:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.ke
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

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
  . a global mutex protects the constraints users from the data being
    allocated and free'd.

3. add a global notification mechanism for the device constraints
  . add a global notification chain that gets called upon changes to the
    aggregated constraint value for any device.
  . the notification callbacks are passing the full constraint request data
    in order for the callees to have access to it. The current use is for the
    platform low-level code to access the target device of the constraint


Questions:
1. the user space API is still under discussions on linux-omap and linux-pm MLs,
   cf. [1]. The idea is to add a user-space API for the devices constratins
   PM QoS, using a sysfs entry per device

[1] http://marc.info/?l=linux-omap&m=131232344503327&w=2

ToDo:
1. write Documentation for the new PM QoS class, once the code is agreed on
2. submit patches for the OMAP low level code to control the power domains
   states from the device constraints, using a global notification callback

   
Based on the master branch of the linux-omap git tree (3.1.0-rc1). Compile
tested using OMAP and x86 generic defconfigs.

Tested on OMAP3 Beagleboard (ES2.x).
Need testing on platforms other than OMAP, because of the impact on the
device insertion/removal in device_pm_add/remove


Changelog:

v6:
. Split the code into the generic PM QoS code and OMAP specific code; only
  the PM QoS is included in this release
. Added copyright in the device PM QoS code
. Re-organize the code for improved readability
. Changed the dev_pm_qos_* API functions type to int and improved the
  error checking
. Added kerneldoc compliant functions headers

v5:
. Added a global mutex to protect the per-device data allocation/free from
  the users
. More robust error checking in the device PM QoS code
. Clean-up of the device PM QoS code: refactor some duplicated code, removal
  of unneeded includes

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



Jean Pihet (7):
  PM QoS: move and rename the implementation files
  PM QoS: minor clean-ups
  PM QoS: code re-organization
  PM QoS: re-organize data structs
  PM QoS: generalize and export the constraints management code
  PM QoS: implement the per-device PM QoS constraints
  PM QoS: add a global notification mechanism for the device
    constraints

 arch/arm/mach-msm/clock.c              |    2 +-
 drivers/acpi/processor_idle.c          |    2 +-
 drivers/base/power/Makefile            |    4 +-
 drivers/base/power/main.c              |    3 +
 drivers/base/power/qos.c               |  400 ++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle.c              |    2 +-
 drivers/cpuidle/governors/ladder.c     |    2 +-
 drivers/cpuidle/governors/menu.c       |    2 +-
 drivers/media/video/via-camera.c       |    4 +-
 drivers/net/e1000e/netdev.c            |    2 +-
 drivers/net/wireless/ipw2x00/ipw2100.c |    4 +-
 include/linux/netdevice.h              |    4 +-
 include/linux/pm.h                     |    9 +
 include/linux/pm_qos.h                 |  147 ++++++++++
 include/linux/pm_qos_params.h          |   38 ---
 include/sound/pcm.h                    |    4 +-
 kernel/Makefile                        |    2 +-
 kernel/pm_qos_params.c                 |  481 -------------------------------
 kernel/power/Makefile                  |    2 +-
 kernel/power/qos.c                     |  490 ++++++++++++++++++++++++++++++++
 net/mac80211/main.c                    |    2 +-
 net/mac80211/mlme.c                    |    2 +-
 net/mac80211/scan.c                    |    2 +-
 sound/core/pcm_native.c                |    2 +-
 24 files changed, 1071 insertions(+), 541 deletions(-)
 create mode 100644 drivers/base/power/qos.c
 create mode 100644 include/linux/pm_qos.h
 delete mode 100644 include/linux/pm_qos_params.h
 delete mode 100644 kernel/pm_qos_params.c
 create mode 100644 kernel/power/qos.c

-- 
1.7.4.1

