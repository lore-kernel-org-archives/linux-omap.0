From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v9 00/11] dmtimer adaptation to platform_driver
Date: Fri, 11 Feb 2011 16:47:09 +0530
Message-ID: <1297423040-19917-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45984 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069Ab1BKLO7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 06:14:59 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1BBEtWa022267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 05:14:58 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

dmtimer adaptation to platform_driver.

This patch series is adaptation of dmtimer code to platform driver
using omap_device and omap_hwmod abstraction.

Baseline:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
Branch: master

Test Platforms:
OMAP1710
OMAP2420
OMAP2430
OMAP3430
OMAP3630
OMAP4430

Test Summary:
(1) Tesetd request, enable, disable, clock source configuration, start,
stop, free of timers.
(2) OMAP3: Tested Retention and Off modes.
(3) On OMAP1710: (i) Boot test (ii) Instrumented driver code to test
request, start, stop and free of timers during boot.

v9:
(1) In OMAP3 hwmod database, added entry for timer12 which was missing.
Beagle board uses timer12 as its millisecond timer.
(2) In OMAP3 hwmod database, rectified in-correct prcm configurations
for timer10 and timer11.
From:
       .prcm           = {
                       .module_bit = OMAP24XX_EN_GPT10_SHIFT,
                       .idlest_idle_bit = OMAP24XX_ST_GPT10_SHIFT,
       },
To:
       .prcm           = {
                       .module_bit = OMAP3430_EN_GPT10_SHIFT,
                       .idlest_idle_bit = OMAP3430_ST_GPT10_SHIFT,
               },
(3) In OMAP3 hwmod database, removed timer master port entry for all
timers because it is not supported.

static struct omap_hwmod_ocp_if *omap3xxx_timer7_masters[] = {
       &omap3xxx_l4_per__timer7,
};

(4) In OMAP4 hwmod database, added SIDLE_SMART_WKUP flag for
non-millisecond timers.
(5) In OMAP3 hwmod database, rectified sysconfig configuration for
non-millisecond timers.
From: omap_hwmod_sysc_type2 To: omap_hwmod_sysc_type1.
This was preventing system to go to RETENTION and OFF modes.

v8:
(1) Baselined on Tony's tree in omap-for-linus branch
(2) The last patch in v7 series has been removed because it is fixed
by following patch:
commit: 78f26e872f77b6312273216de1a8f836c6f2e143
OMAP: hwmod: Set autoidle after smartidle during _sysc_enable

v7:
(1) In omap1_dm_timer_set_src(), the computation of shift value to respective
dmtimer clock source was corrected:
From:
int n = (pdev->id) << 1;
To:
int n = (pdev->id - 1) << 1;
This change is needed because dmtimer is indexed from 1 now instead of 0.
(2) In  omap1_dm_timer_init(void) memory resource end address chnaged:
From:
res[0].end = base + 0xff;
To:
res[0].end = base + 0x46;
This was causing request_mem_region() failure in driver probe().
(3) In the export APIs there are some calls which are not applicable to OMAP1.
They have been made conditional now. They include following calls:

timer->fclk = clk_get(&timer->pdev->dev, "fck");
omap_dm_timer_enable()
omap_dm_timer_disable()

(4) Remove usage of cpu_is_omap16xx() and instead a flag has been added in
struct dmtimer_platform_data {
...
u32 is_omap16xx:1;
}
This flag is set to 1 in mach-omap1/dmtimer.c and set to 0 in mach-omap2/dmtimer.c
This flag is used in plat-omap/dmtimer.c wherever it needs to distiguish omap16xx.
(5) Remove #include <plat/omap_device.h> from mach-omap1/dmtimer.c
(6) Instead of using macros like INT_24XX_GPTIMERx, use the numbers
directly in OMAP2420, OMAP2430 and OMAP3xxx hwmod database.
(7) pm_runtime_get_sync() and pm_runtime_put_sync() return value check modified
from positive to negative value:

if (pm_runtime_get_sync(...) < 0) {
...
}

v6:
(1) Removed reset functions to mach-omap1/dmtimer.c.
Access to reset function from plat-omap/dmtimer.c is provided by means
of function pointer.
(2) Remove multiple calls to omap_device_build() for registering timer devices
during early and regular initialization. Regular device registration is now done
by reading data from temporary list. This list is populated during early init
where timer data is read from hwmod database and corresponding memory allocated.
(3) kfree(pdata) under error condition since platform_device_unregister does
not free its pdata.
(4) Removed extra header inclusion in mach-omap2 and plat-omap
NOTE: omap_dm_timer.<id> field could not be removed because during regular boot
there is no mechanism to match the current pdev with corresponding entry in the
timer list which was partially initialized during early boot.

v5:
(1) In mach-omap2/dmtimer.c merged the merged two different init functions
into a single one, viz: omap_timer_init(*oh, *user). Now this function is
used both during early init and later. The distinction is between the two
is made thriugh the *user field.
(2) Added timeout to low-level access routines in place of infinite while
loop which waits on write-pend register bit.
(3) Modified devices names from "omap-timer.x" to "omap_timer.x"
(4) Modified module description from "OMAP DUAL MODE TIMER DRIVER" to:
MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
(5) Use well-defined constants for new IP revision register constants instead
of hard-coded values.
(6) Use consistent naming mechanism by using _dm_timer_ instead of _dmtimer_
wherever applicable.
(7) Removed id field from omap_dm_timer{} since the same can be obtained from
pdev.
(8) clk_get() and clk_put() moved from probe() and remove() functions.
Now clk_get() is called when timer is acquired in the omap_dm_timer_prepare()
and clk_put() is called in omap_dm_timer_free().
(9) Incorporated general comments:
(i) Redundant Copyright information.
(ii) Typos in comments.
(iii) Modify subjects for hwmod database related patches.
(iv) Remove redundant comments from hwmod database as they would be lost during
auto-generation in the future.

v4:
(1) clock aliases are renamed as "32k_ck", "sys_ck" and "alt_ck"
(2) incorporate missing clk_put() for corresponding clk_get()
(3) modified clk_get()/clk_put() to be called once once in platform driver.
(4) consistent header for new files
(5) check return value of omap_hwmod_for_each_by_class() in device init
routines.
(6) remove is_abe_timer field in dmtimer_platform_data structure. this is
no longer needed with new input clock source aliasing.
(7) proper splitting of patch series
(8) remove register map from hwmod database.
(9) remove clock source strings array from hwmod database and associated
structure declaration from plat/dmtimer.h. this is no longer needed.
(10) remove dev_attr from hwmod database. this is no longer needed.
(11) use register offsets to identify OMAP 4 registers instead of register map.
(12) remove clock source name strings from hwmod database.
(13) introduce new mechanism for getting struct clk associated with clock source
names. this is achieved by adding clock alisases for all supported clock sources.
(14) remove clock setup functions in mach-omap2 for populating struct clk
associated with all input clock sources because this is no longer needed with
above implementation.
(15) device names changed from dmtimer to omap-timer
(16) device index starts from 1 instead of 0
(17) remove .init_name from hwmod database. this is not needed.
(18) introduce separate functions for reading/writing interrupt registers instead of
doing all operations within a single function.

v3:
(1) multi-line comment error correction
(2) provision to allow any of the available dmtimers as early timers
instead of restricting them to millisecond timers only.
(3) in 'struct omap_dmtimer{}' is_initialized flag is redundant and
so must be removed. if the element is found in the list it is already
initialized.
(4) remove 'found' flag in omap_dm_timer_request() and
omap_dm_timer_request_specific() functions.
this is not needed with alternate implementation.
(5) use .init_name to initialize device names so that it can be identified
during early boot as well. This is to avoid duplicate functions for clock
manipulations during early boot and later.
(6) remove redundant functions from mach-omap2 which are created just to
call pm functions like: pm_runtime_get_sync(),pm_runtime_put_sync(),..
and instead call them directly from plat-omap function api's.
(7) timer clock source names made part of hwmod database. source_clock[]
of type 'struct clk' is made part of platform data.
(8) clockactivity field initialized in hwmod database to preserve fclk
during idle. code which manipulate OCP config removed since they are
already taken care by hwmod framework.
(9) omap2_dm_timer_set_src() is optimized. Clock enable/disbale routines
moved to plat-omap layer and simplfied to the level so as not to sacrifice
intended functionality.
NOTE: During early boot clock management was requested to be placed upon
client drivers responsibility. this has not been done keeping in mind
that it would entail (i) multiple modifications of client drivers (ii) it
would violate the purpose of having a framework (open to debate).
(10) dmtimer register maps moved to hwmod database

v2:
(1) removed dedicated functions for early timer clock access.
instead, now we have common functions for early and normal timers.
(2) removed usage of clock source strings for reading corresponding
struct clks. this is now achieved through clock aliases introduced
for each input clock sources.
(3) IP revision to distinguish new IP standard and the rest and then
initialize dmtimer interrupt and functional offsets.
(4) provision to initialize all dmtimers as early timers.
(5) remove dm_timer_setup() function because this is no longer needed.
(6) modify the device index to start from 1 instead of 0.
(7) device name changed from dmtimer to omap-timer
(8) extract device ids' from hwmod name and same used for device build.
(9) additional resource allocation checks and free
(10) early timer variable initialization
(11) initialize timer_ip_type and register offsets in platform data structure.
(12) some more comments/logs


Tarun Kanti DebBarma (10):
  OMAP2+: dmtimer: add device names to flck nodes
  OMAP2420: hwmod data: add dmtimer
  OMAP2430: hwmod data: add dmtimer
  OMAP3: hwmod data: add dmtimer
  OMAP4: hwmod data: add dmtimer
  OMAP1: dmtimer: conversion to platform devices
  OMAP2+: dmtimer: convert to platform devices
  OMAP: dmtimer: switch-over to platform device driver
  OMAP: dmtimer: pm_runtime support
  OMAP: dmtimer: add timeout to low-level routines

Thara Gopinath (1):
  OMAP: dmtimer: platform driver

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/dmtimer.c              |  214 +++++++++
 arch/arm/mach-omap1/timer32k.c             |    4 -
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/clock2420_data.c       |   60 ++-
 arch/arm/mach-omap2/clock2430_data.c       |   60 ++-
 arch/arm/mach-omap2/clock3xxx_data.c       |   48 ++-
 arch/arm/mach-omap2/clock44xx_data.c       |   44 ++-
 arch/arm/mach-omap2/dmtimer.c              |  260 +++++++++++
 arch/arm/mach-omap2/dmtimer.h              |   30 ++
 arch/arm/mach-omap2/io.c                   |    3 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  634 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  633 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  649 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  623 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/timer-gp.c             |    1 -
 arch/arm/plat-omap/dmtimer.c               |  609 +++++++++++++-------------
 arch/arm/plat-omap/include/plat/dmtimer.h  |   38 ++-
 18 files changed, 3556 insertions(+), 358 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dmtimer.c
 create mode 100644 arch/arm/mach-omap2/dmtimer.c
 create mode 100644 arch/arm/mach-omap2/dmtimer.h

