From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v2 0/7] OMAP: add PM CONSTRAINTS framework
Date: Thu, 10 Mar 2011 18:47:20 +0100
Message-ID: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49858 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015Ab1CJRrn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 12:47:43 -0500
Received: by wwa36 with SMTP id 36so2236471wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 09:47:41 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>, Vibhore Vardhan <vvardhan@ti.com>

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

Based on Vibhore's original patch and completely reworked using
omap_device, omap_hwmod and PM QOS frameworks.
Cc: Vibhore Vardhan <vvardhan@ti.com>

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Based on khilman's pm-core branch

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
. add the support for the INACTIVE power state,
. move the power domains state initialization from pwrdms_setup to an early init call,
. debug: add some control knobs for the wake-up latencies in /sysfs,
. add a user-space API to request and remove constraints.


Jean Pihet (7):
  OMAP PM: create a PM layer plugin for per-device constraints
  OMAP: PM CONSTRAINTS: add an enum for the classes of constraint
  OMAP: PM CONSTRAINTS: implement wake-up latency constraints
  OMAP: PM CONSTRAINTS: implement the constraints management code
  OMAP: PM CONSTRAINTS: add a power domains state update function in
    hwmod
  OMAP: PM CONSTRAINTS: control power domains next state
  OMAP: PM CONSTRAINTS: add power domains wake-up latency figures

 arch/arm/mach-omap2/omap_hwmod.c              |   29 ++-
 arch/arm/mach-omap2/powerdomain.c             |  100 +++++++
 arch/arm/mach-omap2/powerdomain.h             |   24 ++-
 arch/arm/mach-omap2/powerdomains3xxx_data.c   |   63 +++++
 arch/arm/plat-omap/Kconfig                    |    7 +
 arch/arm/plat-omap/Makefile                   |    1 +
 arch/arm/plat-omap/include/plat/omap-pm.h     |    4 +
 arch/arm/plat-omap/include/plat/omap_device.h |   14 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/omap-pm-constraints.c      |  371 +++++++++++++++++++++++++
 arch/arm/plat-omap/omap_device.c              |  202 ++++++++++++++
 11 files changed, 813 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-omap/omap-pm-constraints.c

-- 
1.7.2.3

