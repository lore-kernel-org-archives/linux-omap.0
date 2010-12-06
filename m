From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v5 0/12] dmtimer adaptation to platform_driver
Date: Tue,  7 Dec 2010 05:14:07 +0530
Message-ID: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51106 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab0LFMkl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 07:40:41 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB6Cecd5023923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 6 Dec 2010 06:40:40 -0600
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id oB6CeaDJ025919
	for <linux-omap@vger.kernel.org>; Mon, 6 Dec 2010 18:10:37 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

dmtimer adaptation to platform_driver.

This patch series is adaptation of dmtimer code to platform driver
using omap_device and omap_hwmod abstraction.

Tested on following platforms:
OMAP4430, OMAP3430, OMAP3630, OMAP2430
OMAP2420 -- Image with omap2plus_defconfig in too large to download on N800.

Baseline:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

v5:
(1) In mach-omap2/dmtimer.c the two different init functions are merged
into a single one, viz: omap_timer_init(*oh, *user). Now this function is
used both during early init and later. The distinction between the two is
made by the *user field.

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

(9) Modified the device name in mach-omap1/dmtimer.c to "omap_timer"

(10) Incorporated general comments:
(i) Redundant Copyright information.
(ii) Typos in comments.
(iii) Modify subjects for hwmod database related patches.
(iv) Remove redundant comments from hwmod database as they would be lost during
auto-generation in the future.
(v) replaced dev_dbg() with dev_err() wherever error condition is printed.

TODO:
(1) OFF Mode support

(2) Upgrade timeout implementation in low-level read/write access to return
error condition to EXPORT APIs. This is re-frained in the present implementation
because that would involve change to EXPORTED APIs. Besides, there is no clear
design as yet which is agreed upon by the community.

(3) Try to get rid of dmtimer list maintained separately in the driver. Instead
use the device list maintained by the device model. The devices can be accessed
using available API driver_find_device().

At present we are unable to use driver_find_device() because it does not look
into device list which is created during early boot.
Therefore, until suitable solutions are found we have to wait.

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

Tarun Kanti DebBarma (13):
  OMAP2+: dmtimer: add device names to flck nodes
  OMAP: dmtimer: infrastructure to support hwmod
  OMAP2420: hwmod data: add dmtimer
  OMAP2430: hwmod data: add dmtimer
  OMAP3: hwmod data: add dmtimer
  OMAP4: hwmod data: add dmtimer
  OMAP: dmtimer: use list instead of static array
  OMAP: dmtimer: platform driver
  OMAP1: dmtimer: conversion to platform devices
  OMAP2+: dmtimer: convert to platform devices
  OMAP: dmtimer: switch-over to platform device driver
  OMAP: dmtimer: pm_runtime support
  OMAP: dmtimer: add timeout to low-level routines

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/dmtimer.c              |  171 +++++++
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/clock2420_data.c       |   60 ++-
 arch/arm/mach-omap2/clock2430_data.c       |   60 ++-
 arch/arm/mach-omap2/clock3xxx_data.c       |   48 ++-
 arch/arm/mach-omap2/clock44xx_data.c       |   44 ++-
 arch/arm/mach-omap2/dmtimer.c              |  213 +++++++++
 arch/arm/mach-omap2/dmtimer.h              |   30 ++
 arch/arm/mach-omap2/io.c                   |    2 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  635 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  634 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  676 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  624 +++++++++++++++++++++++++
 arch/arm/mach-omap2/timer-gp.c             |    1 -
 arch/arm/plat-omap/dmtimer.c               |  558 ++++++++++++------------
 arch/arm/plat-omap/include/plat/dmtimer.h  |   30 ++
 17 files changed, 3460 insertions(+), 330 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dmtimer.c
 create mode 100644 arch/arm/mach-omap2/dmtimer.c
 create mode 100644 arch/arm/mach-omap2/dmtimer.h

