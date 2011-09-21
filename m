From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v2 0/8] PM QoS: implement the OMAP low level constraints management code
Date: Wed, 21 Sep 2011 18:14:01 +0200
Message-ID: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60394 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab1IUQUe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 12:20:34 -0400
Received: by eya28 with SMTP id 28so1085741eya.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 09:20:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.co>
Cc: Jean Pihet <j-pihet@ti.com>

. Convert the OMAP I2C driver to the PM QoS API for MPU latency constraints
. Remove the remove the latency related functions from OMAP PM in favor of
  the generic per-device PM QoS API
. Implement the devices wake-up latency constraints using the global
  device PM QoS notification handler which applies the constraints to the
  underlying layer
. Implement the low level code which controls the power domains next power
  states, through the hwmod and pwrdm layers
. Add cpuidle and power domains wake-up latency figures for OMAP3, cf. [1]
  for the details on where the numbers are coming from
. Implement the relation between the cpuidle and per-device PM QoS frameworks
  in the OMAP3 specific idle callbacks.
  The chosen C-state shall satisfy the following conditions:
   . the 'valid' field is enabled,
   . it satisfies the enable_off_mode flag,
   . the next state for MPU and CORE power domains is not lower than the
     state programmed by the per-device PM QoS.


ToDo:
1. validate the constraints framework on OMAP4 HW (done on OMAP3)
2. Re-visit the OMAP power domains states initialization procedure. Currently
   the power states that have been changed from the constraints API which were
   applied before the initialization of the power domains are lost
3. Further clean-up the OMAP PM layer, use the generic frameworks instead (OPP,
   PM QoS...)


Based on the pm-qos branch of the linux-pm git tree (3.1.0-rc3), cf. [2].

Tested on OMAP3 Beagleboard (ES2.x) with constraints on MPU, CORE, PER in
RETention and OFF modes.

[1] http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
[2] git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git


Jean Pihet (8):
  OMAP: convert I2C driver to PM QoS for latency constraints
  OMAP: PM: remove the latency related functions from the API
  OMAP2+: powerdomain: control power domains next state
  OMAP2+: omap_hwmod: manage the wake-up latency constraints
  OMAP: PM: register to the per-device PM QoS framework
  OMAP3: cpuidle: next C-state decision depends on the PM QoS MPU and
    CORE constraints
  OMAP3: update cpuidle latency and threshold figures
  OMAP3: powerdomain data: add wake-up latency figures

 Documentation/arm/OMAP/omap_pm               |   55 ++------
 arch/arm/mach-omap2/cpuidle34xx.c            |   77 ++++++-----
 arch/arm/mach-omap2/omap_hwmod.c             |   26 ++++-
 arch/arm/mach-omap2/pm.c                     |   63 ++++++++
 arch/arm/mach-omap2/pm.h                     |   17 ++-
 arch/arm/mach-omap2/powerdomain.c            |  197 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h            |   35 +++++-
 arch/arm/mach-omap2/powerdomains3xxx_data.c  |   78 ++++++++++
 arch/arm/plat-omap/i2c.c                     |   20 ---
 arch/arm/plat-omap/include/plat/omap-pm.h    |   99 -------------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 arch/arm/plat-omap/omap-pm-noop.c            |   88 ------------
 drivers/i2c/busses/i2c-omap.c                |   30 ++--
 include/linux/i2c-omap.h                     |    1 -
 14 files changed, 480 insertions(+), 308 deletions(-)

-- 
1.7.4.1

