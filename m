From: jean.pihet@newoldbits.com
Subject: [PATCH v3 0/8] OMAP: add PM CONSTRAINTS framework
Date: Wed, 30 Mar 2011 17:19:16 +0200
Message-ID: <1301498364-726-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43060 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572Ab1C3P1q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Mar 2011 11:27:46 -0400
Received: by wya21 with SMTP id 21so1183526wya.19
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 08:27:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>, Vibhore Vardhan <vvardhan@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Implement OMAP PM layer omap_pm_set_max_dev_wakeup_lat API by
creating a unified API which calls omap_device_set_dev_constraint
for all classes of constraints (devices wake-up latency, devices
throughput...).
The implementation of the constraints framework is at the omap_device
level: management and storage of the constraints, dispatching of the
constraints to the appropriate low level layers.

NOTE: only works for devices which have been converted to use
     omap_device/omap_hwmod.

Longer term, we could possibly remove this API from the OMAP PM layer,
and instead directly use the device level API.

For the devices wake-up latency constraints, the power domains get
the next power state programmed directly in the registers via
pwrdm_wakeuplat_update_pwrst.

Note about PM QOS: the MPU and CORE power domains get the next power
state via cpuidle, which get the strongest wake-up latency constraint
by querying PM QOS. The usage of PM QOS is temporary, until a generic
solution is in place.

The bus throughput constraints framework is supported by still is a
no-op for the moment.

For the wake-up latency constraints framework to have effect on the
power domains states, CONFIG_CPU_IDLE and CONFIG_OMAP_PM_CONSTRAINTS
must be enabled.

Based on Vibhore's original patch and completely reworked using
omap_device, omap_hwmod, powerdomain and PM QOS frameworks.
Cc: Vibhore Vardhan <vvardhan@ti.com>

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Based on khilman's pm-core branch

v3:
. updated after review comments from Kevin,
. patches re-ordering for git bisect compliance,
. reworked the constraints storage and management:
  - the omap_device layer stores all constraints in per-omap_device
    constraints lists,
  - the powerdomain layer manages the wake-up latency constraints in
    per-pwrdm constraint list and applies the constraint to the
    corresponding power domain.
. add the support for the INACTIVE power state,
. move the power domains state initialization from pwrdms_setup to an early init call,

v2:
. updated after review comments from Kevin and Paul,
. initial patch split according to the layering,
. added support for ascending or descending order of constraints values,
. added throughput constraints to the framework, although the tput implementation
 currently is a no-op,

To Do:
. refine the wake-up latency figures by defining the conditions of measurements and by
 measuring on actual hardware,
. define the effect of power domains states combinations,
. debug: add some control knobs for the wake-up latencies in /sysfs,
. add a user-space API to request and remove constraints.

Jean Pihet (8):
  OMAP PM: create a PM layer plugin for per-device constraints
  OMAP2+: powerdomain: control power domains next state
  OMAP3: powerdomain data: add wake-up latency figures
  OMAP2+: omap_hwmod: manage the omap_devices the wake-up latency
    constraints
  OMAP: PM CONSTRAINTS: add an enum for the classes of constraint
  OMAP2+: omap_device: implement the constraints management code
  OMAP: PM CONSTRAINTS: implement wake-up latency constraints
  OMAP PM: early init of the pwrdms states

 arch/arm/mach-omap2/omap_hwmod.c              |   26 ++-
 arch/arm/mach-omap2/pm34xx.c                  |    2 +-
 arch/arm/mach-omap2/pm44xx.c                  |    2 +-
 arch/arm/mach-omap2/powerdomain.c             |  211 ++++++++++++++
 arch/arm/mach-omap2/powerdomain.h             |   42 +++-
 arch/arm/mach-omap2/powerdomains3xxx_data.c   |   84 ++++++-
 arch/arm/plat-omap/Kconfig                    |    7 +
 arch/arm/plat-omap/Makefile                   |    1 +
 arch/arm/plat-omap/include/plat/omap-pm.h     |    4 +
 arch/arm/plat-omap/include/plat/omap_device.h |   15 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +
 arch/arm/plat-omap/omap-pm-constraints.c      |  369 +++++++++++++++++++++++++
 arch/arm/plat-omap/omap_device.c              |  189 +++++++++++++
 13 files changed, 946 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/plat-omap/omap-pm-constraints.c

-- 
1.7.2.5

