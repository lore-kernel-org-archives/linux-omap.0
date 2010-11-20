From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv4 0/14] dmtimer adaptation to platform_driver
Date: Sat, 20 Nov 2010 08:09:24 +0530
Message-ID: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52651 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831Ab0KSPgf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 10:36:35 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAJFaWRe021865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 09:36:34 -0600
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAJFaVV6027878
	for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 21:06:31 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

dmtimer adaptation to platform_driver.

This patch series is adaptation of dmtimer code to platform driver
using omap_device and omap_hwmod abstraction.

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

TODO:
(1) off mode support

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

Baseline:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
origin/master



Tarun Kanti DebBarma (14):
  OMAP2+: dmtimer: add device names to flck nodes
  OMAP: dmtimer: infrastructure to support hwmod
  OMAP2420: dmtimer: add hwmod database
  OMAP2430: dmtimer: add hwmod database
  OMAP3: dmtimer: add hwmod database
  OMAP4: dmtimer: add hwmod database
  OMAP: dmtimer: use list instead of static array
  OMAP: dmtimer: platform driver
  OMAP1: dmtimer: conversion to platform devices
  OMAP: dmtimer: access routines to interrupt registers
  OMAP2+: dmtimer: convert to platform devices
  OMAP: dmtimer: switch-over to platform device driver
  OMAP: dmtimer: remove reset function
  OMAP: dmtimer: pm_runtime support

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/dmtimer.c              |  174 +++++++
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/clock2420_data.c       |   60 ++-
 arch/arm/mach-omap2/clock2430_data.c       |   60 ++-
 arch/arm/mach-omap2/clock3xxx_data.c       |   48 ++-
 arch/arm/mach-omap2/clock44xx_data.c       |   44 ++-
 arch/arm/mach-omap2/dmtimer.c              |  296 ++++++++++++
 arch/arm/mach-omap2/dmtimer.h              |   32 ++
 arch/arm/mach-omap2/io.c                   |    2 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  633 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  632 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  674 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  622 +++++++++++++++++++++++++
 arch/arm/mach-omap2/timer-gp.c             |    1 -
 arch/arm/plat-omap/dmtimer.c               |  581 +++++++++++++-----------
 arch/arm/plat-omap/include/plat/dmtimer.h  |   19 +
 17 files changed, 3559 insertions(+), 323 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dmtimer.c
 create mode 100644 arch/arm/mach-omap2/dmtimer.c
 create mode 100644 arch/arm/mach-omap2/dmtimer.h

