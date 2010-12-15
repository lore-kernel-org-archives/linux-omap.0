From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v6 0/12] dmtimer adaptation to platform_driver
Date: Wed, 15 Dec 2010 09:34:58 +0530
Message-ID: <1292385910-5234-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32995 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759311Ab0LNRBm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 12:01:42 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBEH1cKt025224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 11:01:41 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

dmtimer adaptation to platform_driver.

This patch series is adaptation of dmtimer code to platform driver
using omap_device and omap_hwmod abstraction.

Tested on following platforms:
OMAP4430, OMAP3430, OMAP3630, OMAP2430
OMAP2420, OMAP1710(in-progress)

Baseline:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

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


TODO:
(1) OFF Mode support

(2) Upgrade timeout implementation in low-level read/write access to return
error condition to EXPORT APIs. This is re-frained in the present implementation
because that would involve change to EXPORTED APIs. Besides, there is no clear
design as yet which is agreed upon by the community.


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


Cousson, Benoit (1):
  OMAP4: hwmod data: add dmtimer

Tarun Kanti DebBarma (4):
  OMAP2+: dmtimer: convert to platform devices
  OMAP: dmtimer: switch-over to platform device driver
  OMAP: dmtimer: pm_runtime support
  OMAP: dmtimer: add timeout to low-level routines

Thara Gopinath (6):
  OMAP2+: dmtimer: add device names to flck nodes
  OMAP2420: hwmod data: add dmtimer
  OMAP2430: hwmod data: add dmtimer
  OMAP3: hwmod data: add dmtimer
  OMAP1: dmtimer: conversion to platform devices
  OMAP: dmtimer: platform driver

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/dmtimer.c              |  209 +++++++++
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/clock2420_data.c       |   60 ++-
 arch/arm/mach-omap2/clock2430_data.c       |   60 ++-
 arch/arm/mach-omap2/clock3xxx_data.c       |   48 ++-
 arch/arm/mach-omap2/clock44xx_data.c       |   44 ++-
 arch/arm/mach-omap2/dmtimer.c              |  240 ++++++++++
 arch/arm/mach-omap2/dmtimer.h              |   30 ++
 arch/arm/mach-omap2/io.c                   |    2 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  634 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  633 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  675 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  623 +++++++++++++++++++++++++
 arch/arm/mach-omap2/timer-gp.c             |    1 -
 arch/arm/plat-omap/dmtimer.c               |  577 ++++++++++++------------
 arch/arm/plat-omap/include/plat/dmtimer.h  |   40 ++-
 17 files changed, 3544 insertions(+), 336 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dmtimer.c
 create mode 100644 arch/arm/mach-omap2/dmtimer.c
 create mode 100644 arch/arm/mach-omap2/dmtimer.h
