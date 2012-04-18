From: jean.pihet@newoldbits.com
Subject: [PATCH v7 0/6] PM QoS: implement the OMAP low level constraints management code
Date: Wed, 18 Apr 2012 15:45:14 +0200
Message-ID: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61532 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab2DRNpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 09:45:45 -0400
Received: by wgbdr13 with SMTP id dr13so7543586wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 06:45:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

. Implement the devices wake-up latency constraints using the global
  device PM QoS notification handler which applies the constraints to the
  underlying layer,
. Implement the low level code which controls the power domains next
  functional power states [3], through the hwmod and pwrdm layers,
. Add cpuidle and power domains wake-up latency figures for OMAP3, cf. 
  comments in the code and [1] for the details on where the numbers
  are magically coming from,
. Implement the relation between the cpuidle and per-device PM QoS frameworks
  in the OMAP3 specific idle callbacks.
  The chosen C-state shall satisfy the following conditions:
   . the 'valid' field is enabled,
   . it satisfies the enable_off_mode flag,
   . the next state for MPU and CORE power domains is not lower than the
     state programmed by the per-device PM QoS.


ToDo:
1. support OMAP4 chipset when the low power modes will be supported
2. validate the constraints framework on OMAP4 HW (done on OMAP3)
3. Re-visit the OMAP power domains states initialization procedure. Currently
   the power states that have been changed from the constraints API which were
   applied before the initialization of the power domains are lost
4. Further clean-up the OMAP PM layer, use the generic frameworks instead (OPP,
   PM QoS for throughput constraints ...)


Based on the pm-qos branch of the linux-omap git tree (3.4.0-rc2) [2] with
the functional power states changes applied [3].

Tested cpuidle and suspend on OMAP3 Beagleboard (ES2.x) with constraints
on MPU, CORE, PER in RETention and OFF modes.

[1] http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
[2] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
[3] http://marc.info/?l=linux-omap&m=133475291911194&w=2


History:

v7:
. rebased on top of the functional power state changes [3]

v6:
. minor change in the commits description after Kevin's review
. added Kevin's Reviewed-by

v5:
. rebased on latest linux-omap [2]
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


Jean Pihet (6):
  ARM: OMAP2+: PM QoS: control the power domains next state from the
    constraints
  ARM: OMAP2+: PM QoS: manage the per-device latency constraints in
    hwmod
  ARM: OMAP: omap_device: register to the per-device PM QoS framework
  ARM: OMAP3: cpuidle: next C-state decision depends on the PM QoS MPU
    and CORE constraints
  ARM: OMAP3: update cpuidle latency and threshold figures
  ARM: OMAP3: powerdomain data: add wake-up latency figures

 arch/arm/mach-omap2/cpuidle34xx.c           |  109 ++++++++------
 arch/arm/mach-omap2/omap_hwmod.c            |   22 +--
 arch/arm/mach-omap2/pm.h                    |   17 ++-
 arch/arm/mach-omap2/powerdomain.c           |  216 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h           |   17 ++
 arch/arm/mach-omap2/powerdomains3xxx_data.c |   83 ++++++++++
 arch/arm/plat-omap/omap_device.c            |   81 ++++++++++-
 7 files changed, 481 insertions(+), 64 deletions(-)

-- 
1.7.7.6

