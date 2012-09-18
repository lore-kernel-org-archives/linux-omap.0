From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v9 0/8] PM QoS: implement the OMAP low level constraints management code
Date: Tue, 18 Sep 2012 10:52:04 +0200
Message-ID: <1347958332-2205-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34806 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757671Ab2IRIw1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 04:52:27 -0400
Received: by wgbdr13 with SMTP id dr13so6629535wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 18 Sep 2012 01:52:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

. Implement the devices wake-up latency constraints using the global
  device PM QoS notification handler which applies the constraints to the
  underlying layer,
. Implement the low level code which controls the power domains next
  functional power states, through the hwmod and pwrdm layers,
. Add cpuidle and power domains wake-up latency figures for OMAP3, cf. 
  comments in the code and [1] for the details on where the numbers
  are magically coming from,
. Implement the relation between the cpuidle and per-device PM QoS frameworks
  in the OMAP3 specific idle callbacks.
  The chosen C-state shall satisfy the following conditions:
   . it satisfies the enable_off_mode flag,
   . the next state for MPU and CORE power domains is not lower than the
     state programmed by the per-device PM QoS.
. convert I2C driver to PM QoS for latency constraints,
. remove the latency related functions from the API (omap_pm_set_*) and
  update the kernel Documentation accordingly.


ToDo:
1. Re-visit the OMAP power domains states initialization procedure. Currently
   the power states that have been changed from the constraints API which were
   applied before the initialization of the power domains are lost
2. Further clean-up the OMAP PM layer, use the generic frameworks instead (OPP,
   PM QoS for throughput constraints ...)


Based on mainline kernel 3.6.0-rc4 with the functional power states changes v6 [2]
applied.

Tested cpuidle and suspend on OMAP3 Beagleboard (ES2.x) with constraints
on MPU, CORE, PER in RETention and OFF modes.

[1] http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
[2] http://marc.info/?l=linux-omap&m=134744375320874&w=2


History:
v9:
. ported to latest functional power states code,
. changed the locking from mutex to spinlock, as reported by Djamil Elaidi
  <d-elaidi@ti.com>,
. simplified the memory allocation code, using GFP_ATOMIC since the code can be
  used under spinlock

v8:
. reworked the code after internal review and testing with OMAP3&4 device
   OFF

v7:
. rebased on top of the functional power state changes

v6:
. minor change in the commits description after Kevin's review
. added Kevin's Reviewed-by

v5:
. rebased on latest linux-omap
. rework after Kevin's comments on the MLs

v4:
. split up the patches which remove the omap_pm_ code from the patch set.
  Those patches are to be submitted later, on top of this patch set.
. latency numbers: provide the measurements setup and conditions in the code
  comments, added the link to the details on wiki [1].
. improved kerneldoc
. split big functions into smaller ones, in order to improve the readability

v3: reworked the error return path and improved the kerneldoc

v2: reworked the OMAP specific cpuidle code to demote the initial C-state to
     a valid C-state which fulfills the per-device constraints

v1: initial version


Jean Pihet (8):
  ARM: OMAP2+: PM QoS: control the power domains next state from the
    constraints
  ARM: OMAP2+: hwmod: manage the wake-up latency constraints
  ARM: OMAP: omap_device: register to the per-device PM QoS framework
  ARM: OMAP3: cpuidle: next C-state decision depends on the PM QoS MPU
    and CORE constraints
  ARM: OMAP3: update cpuidle latency and threshold figures
  ARM: OMAP3: powerdomain data: add wake-up latency figures
  ARM: OMAP: convert I2C driver to PM QoS for latency constraints
  ARM: OMAP: PM: remove the latency related functions from the API

 Documentation/arm/OMAP/omap_pm               |   68 +++------
 arch/arm/mach-omap2/cpuidle34xx.c            |  103 +++++++++----
 arch/arm/mach-omap2/omap_hwmod.c             |   44 +++++-
 arch/arm/mach-omap2/powerdomain.c            |  212 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h            |   18 ++-
 arch/arm/mach-omap2/powerdomains3xxx_data.c  |   83 ++++++++++
 arch/arm/plat-omap/i2c.c                     |   21 ---
 arch/arm/plat-omap/include/plat/omap-pm.h    |   99 ------------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    5 +
 arch/arm/plat-omap/omap-pm-noop.c            |   88 -----------
 arch/arm/plat-omap/omap_device.c             |   81 ++++++++++-
 drivers/i2c/busses/i2c-omap.c                |   28 ++--
 include/linux/i2c-omap.h                     |    1 -
 13 files changed, 550 insertions(+), 301 deletions(-)

-- 
1.7.7.6

