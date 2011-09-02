From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 0/8] PM QoS: implement the OMAP low level constraints management code
Date: Fri,  2 Sep 2011 15:13:16 +0200
Message-ID: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40419 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab1IBNNj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 09:13:39 -0400
Received: by wwf5 with SMTP id 5so2916254wwf.1
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 06:13:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.co>
Cc: Jean Pihet <j-pihet@ti.com>

. create a PM layer plugin for per-device constraints, compiled under
  CONFIG_OMAP_PM_CONSTRAINTS=y
. implement the devices wake-up latency constraints using the global
  device PM QoS notification handler which applies the constraints to the
  underlying layer
. implement the low level code which controls the power domains next power
  states, through the hwmod and pwrdm layers
. add cpuidle and power domains wake-up latency figures for OMAP3, cf. [1]
  for the details on where the numbers are coming from
. cpuidle is a CPU centric framework so it decides the MPU next power state
  based on the MPU exit_latency and target_residency figures. The rest of
  the power domains get their next power state programmed from the devices
  PM QoS framework, via the devices wake-up latency constraints.
. convert the OMAP I2C driver to the PM QoS API for MPU latency constraints

ToDo:
1. validate the constraints framework on OMAP4 HW (done on OMAP3)
2. re-visit the OMAP power domains states initialization procedure. Currently
   the power states that have been changed from the constraints API which were
   applied before the initialization of the power domains are lost

   
Based on the pm-qos branch of the linux-pm git tree (3.1.0-rc3), cf. [2].

Tested on OMAP3 Beagleboard (ES2.x) with constraints on MPU, CORE, PER in
RETention and OFF modes.

[1] http://www.omappedia.org/wiki/Power_Management_Device_Latencies_Measurement
[2] git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git


Jean Pihet (8):
  OMAP: convert I2C driver to PM QoS for latency constraints
  OMAP: PM: create a PM layer plugin for per-device constraints
  OMAP2+: powerdomain: control power domains next state
  OMAP3: powerdomain data: add wake-up latency figures
  OMAP2+: omap_hwmod: manage the wake-up latency constraints
  OMAP: PM CONSTRAINTS: implement the devices wake-up latency
    constraints
  OMAP2+: cpuidle only influences the MPU state
  OMAP3: update cpuidle latency and threshold figures

 arch/arm/mach-omap2/cpuidle34xx.c            |   56 ++---
 arch/arm/mach-omap2/omap_hwmod.c             |   26 ++-
 arch/arm/mach-omap2/pm.h                     |   17 ++-
 arch/arm/mach-omap2/powerdomain.c            |  190 ++++++++++++++
 arch/arm/mach-omap2/powerdomain.h            |   33 +++-
 arch/arm/mach-omap2/powerdomains3xxx_data.c  |   78 ++++++
 arch/arm/plat-omap/Kconfig                   |    7 +
 arch/arm/plat-omap/Makefile                  |    1 +
 arch/arm/plat-omap/i2c.c                     |   20 --
 arch/arm/plat-omap/include/plat/omap-pm.h    |  128 ----------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 arch/arm/plat-omap/omap-pm-constraints.c     |  350 ++++++++++++++++++++++++++
 arch/arm/plat-omap/omap-pm-noop.c            |   89 -------
 drivers/i2c/busses/i2c-omap.c                |   31 ++-
 14 files changed, 737 insertions(+), 291 deletions(-)
 create mode 100644 arch/arm/plat-omap/omap-pm-constraints.c

-- 
1.7.4.1

