From: jean.pihet@newoldbits.com
Subject: [RFC/PATCH 00/13] OMAP2+: PM: isolate PM code in modules
Date: Wed, 18 May 2011 19:32:17 +0200
Message-ID: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56223 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910Ab1ERRcl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:32:41 -0400
Received: by gyd10 with SMTP id 10so621943gyd.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:32:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

First attempt at isolation of the OMAP2+ PM code

RFC quality code but successfully tested on board as a proof
of concept

1) provide PM functionality as modules

To allow for the PM functionality to be built and used as modules a
clean-up and isolation task first has been performed ('spaghetti
unwinding') because there are a lot of cross calls between various parts
of the PM code (core, platform specific, cpuidle ...).

Since the option CONFIG_PM is always set for OMAP chips and since
CONFIG_PM cannot be set to 'm', a new config option CONFIG_OMAP_PM is defined.
This option allows for the OMAP2+ PM code to be enabled, disabled or
built as modules.

Furthermore CONFIG_PM is used to completely enable or disable the whole
PM code.

The PM functionality is split into the following modules:
 - omap_pm_debug
 - omap2_pm
 - omap3_pm
 - omap4_pm

The following functionality is moved to the modules:
 - platform specific PM core
 - suspend
 - cpuidle
 - PM debug
    
The following functionality is needed at boot time and so is left
in the PM core code (i.e. not built as modules):
 - PRCM
 - clock domains
 - power domains
 - voltage domains
 - hwmod
 - smart reflex
 - per-platform PRCM data
 - per-platform clock data
 - per-platform power domains data
 - per-platform hwmod data
 - per-platform OPP data

2) Addition of EXPORT_SYMBOL for functions and variables used by
the code in PM modules. Lots of (too many?) symbols need to exported
to the PM modules.

3) Clean-up of used resources to allow clean insertion and removal
of the PM modules. This allows insmod/rmmod of the PM modules
to work.


Questions/concerns
------------------
- IMHO too many symbols are exported from various layers to the PM modules, e.g.
cpu_init, flush_tlb_all, omap_irq_pending, v7_flush_dcache_all ...) in patches
10/13, 12/13. Is that OK?

- v7_flush_dcache_all which is implemented in assembly is exported using
EXPORT_SYMBOL in pm.c, or by using a C stub function. That obvioulsy looks wrong
but no cleaner way has been found yet.

- export suspend_set_ops to PM modules hack (patch 09/13): a stub is needed
because the suspend_set_ops functions are not exported by the kernel.
Could that be done?

- the most worrysome piece of code to isolate is pm-debug.c aka 'the octopus'.
The main problem is that pm-debug is needed for a useful PM. The reason is
that most of the PM control knobs (enable_off_mode, sleep_while_idle ...)
are controlled by pm-debug via debugfs and are disabled by default.
This patch series is moving the variables and functions from pm-debug to
mach-omap2/pm.c but not the control mechanism.
More clean-up effort is needed.


Tested on OMAP3 Beagleboard with cpuidle in RET mode.

ToDo:
- suspend not tested
- OFF mode in cpuidle not working (console garbage + reboot), investigation on-going
- power domains timer stats initialized with weird values (i.e. not 0), investigation
on-going


Jean Pihet (13):
  perf: export power_start and power_end tracepoints
  OMAP2+: PM: isolate PM code
  OMAP2+: PM: clean up usage of SRAM functions
  OMAP2+: cpuidle: register the board specific C-states table
  OMAP2+: PM: move common code from pm-debug.c to pm.c
  OMAP2+: PM: isolate the scratchpad save function from the PM code
  OMAP2+: PM: move the powerdomains time stats to powerdomain code
  OMAP2+: PM: provide the next timer event API to PM modules
  OMAP2+: PM: export suspend_set_ops to PM modules
  OMAP3: PM: export the v7_flush_dcache_all API to modules
  OMAP2+: PM: implement modules insertion and removal code
  OMAP2+: PM: export functions and variables to PM modules
  OMAP2+: PM: build PM functionality as modules

 arch/arm/kernel/setup.c            |    1 +
 arch/arm/kernel/smp_tlb.c          |    2 +
 arch/arm/mach-omap2/Makefile       |   77 +++++++++++++++++++++-------------
 arch/arm/mach-omap2/clockdomain.c  |    7 +++
 arch/arm/mach-omap2/cm2xxx_3xxx.c  |    7 +++
 arch/arm/mach-omap2/control.c      |   36 ++++++++--------
 arch/arm/mach-omap2/control.h      |    6 +--
 arch/arm/mach-omap2/cpuidle34xx.c  |   27 +++++++++---
 arch/arm/mach-omap2/gpmc.c         |    2 +
 arch/arm/mach-omap2/id.c           |    1 +
 arch/arm/mach-omap2/irq.c          |    7 +++
 arch/arm/mach-omap2/pm-debug.c     |   80 ++++++++++++------------------------
 arch/arm/mach-omap2/pm.c           |   79 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h           |   33 +++++++++++----
 arch/arm/mach-omap2/pm24xx.c       |   33 ++++++++++++--
 arch/arm/mach-omap2/pm34xx.c       |   74 +++++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/pm44xx.c       |   27 +++++++++++-
 arch/arm/mach-omap2/powerdomain.c  |   41 ++++++++++++++++++-
 arch/arm/mach-omap2/powerdomain.h  |    3 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    6 +++
 arch/arm/mach-omap2/sdrc.c         |    2 +
 arch/arm/mach-omap2/serial.c       |    5 ++
 arch/arm/mach-omap2/timer-gp.c     |    1 +
 arch/arm/plat-omap/Kconfig         |    9 ++++
 arch/arm/plat-omap/common.c        |    1 +
 arch/arm/plat-omap/dma.c           |    3 +
 arch/arm/plat-omap/gpio.c          |    4 ++
 arch/arm/plat-omap/omap-pm-noop.c  |    2 +
 arch/arm/plat-omap/omap_device.c   |    1 +
 arch/arm/plat-omap/sram.c          |    4 +-
 kernel/trace/power-traces.c        |    3 +-
 31 files changed, 446 insertions(+), 138 deletions(-)

-- 
1.7.4.1

