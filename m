From: jean.pihet@newoldbits.com
Subject: [RFC/PATCH 0/9] PM QoS: add a per-device wake-up latency constraint class
Date: Fri, 24 Jun 2011 17:30:45 +0200
Message-ID: <1308929445-31289-1-git-send-email-j-pihet@ti.com>
References: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49341 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab1FXPbG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 11:31:06 -0400
Received: by wwe5 with SMTP id 5so2990752wwe.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 08:31:04 -0700 (PDT)
In-Reply-To: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foun>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

This patch set is in an RFC state, for review and comments.

In order to implement the new class in PM QoS the following changes have been
made:

1. Add a new PM QoS class for device wake-up constraints
(PM_QOS_DEV_WAKEUP_LATENCY).
Due to the per-device nature of the new class the constraints lists are stored
inside the device dev_pm_info struct instead of the internal per-class
constraints lists.
The new class is only available from kernel drivers and so is not exported to
user space.

2. Make the pm_qos_add_request API more generic by using a
struct pm_qos_parameters parameter. This allows easy extension in the future.

3. Upon a change of the strongest constraint in the PM_QOS_DEV_WAKEUP_LATENCY
class a notification chain mechanism is used to take action on the system.
This is the proposed way to have PM QoS and the platform dependant code to
interact with each other, cf. 4 below.
The notification mechanism now passes the constraint request struct ptr in
order for the notifier callback to have access to the full set of constraint
data, e.g. the struct device ptr.

4. cpuidle interaction with the OMAP3 cpuidle handler
Since cpuidle is a CPU centric framework it decides the MPU next power state
based on the MPU exit_latency and target_residency figures.
    
The rest of the power domains get their next power state programmed from
the PM_QOS_DEV_WAKEUP_LATENCY class of the PM QoS framework, via the device
wake-up latency constraints.

Note: the exit_latency and target_residency figures of the MPU include the MPU
itself and the peripherals needed for the MPU to execute instructions (e.g.
main memory, caches, IRQ controller, MMU etc).
Some of those peripherals can belong to other power domains than the MPU
subsystem and so the corresponding latencies must be included in this figure.

5. Update the pm_qos_add_request callers to the generic API

6. Minor clean-ups and rename of struct fields

Questions:
1. How to retrieve the device ptr from a given device driver in order to add
a constraint on it?
2. The device struct has recently been extended with the power domain
information. Can this be used to apply the constraints on power domains?

On-going developments, patches in preparation:
1. write Documentation for the new PM QoS class
2. validate the constraints framework on OMAP3&4 HW
3. refine the power domains wake-up latency and the cpuidle figures

Based on the master branch of the linux-omap git tree (3.0.0-rc3). Compile
tested only using OMAP and x86 generic defconfigs.


Jean Pihet (8):
  PM: add a per-device wake-up latency constraints plist
  PM: extend PM QoS with per-device wake-up constraints
  OMAP PM: create a PM layer plugin for per-device constraints
  OMAP2+: powerdomain: control power domains next state
  OMAP3: powerdomain data: add wake-up latency figures
  OMAP2+: omap_hwmod: manage the wake-up latency constraints
  OMAP: PM CONSTRAINTS: implement the devices wake-up latency
    constraints
  OMAP2+: cpuidle only influences the MPU state

Vishwanath BS (1):
  OMAP4: powerdomain data: add wake-up latency figures

 arch/arm/mach-omap2/cpuidle34xx.c            |   42 +---
 arch/arm/mach-omap2/omap_hwmod.c             |   26 ++-
 arch/arm/mach-omap2/pm.h                     |   17 ++-
 arch/arm/mach-omap2/powerdomain.c            |  187 ++++++++++++++
 arch/arm/mach-omap2/powerdomain.h            |   33 +++-
 arch/arm/mach-omap2/powerdomains3xxx_data.c  |   77 ++++++
 arch/arm/mach-omap2/powerdomains44xx_data.c  |   85 +++++++
 arch/arm/plat-omap/Kconfig                   |    7 +
 arch/arm/plat-omap/Makefile                  |    1 +
 arch/arm/plat-omap/i2c.c                     |   20 --
 arch/arm/plat-omap/include/plat/omap-pm.h    |  128 ----------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 arch/arm/plat-omap/omap-pm-constraints.c     |  344 ++++++++++++++++++++++++++
 arch/arm/plat-omap/omap-pm-noop.c            |   89 -------
 drivers/base/power/main.c                    |    1 +
 drivers/i2c/busses/i2c-omap.c                |   35 ++-
 drivers/media/video/via-camera.c             |    5 +-
 drivers/net/e1000e/netdev.c                  |    9 +-
 drivers/net/wireless/ipw2x00/ipw2100.c       |    6 +-
 include/linux/pm.h                           |    2 +
 include/linux/pm_qos_params.h                |   40 ++--
 kernel/pm_qos_params.c                       |  142 ++++++-----
 sound/core/pcm_native.c                      |    8 +-
 23 files changed, 939 insertions(+), 367 deletions(-)
 create mode 100644 arch/arm/plat-omap/omap-pm-constraints.c

-- 
1.7.4.1

