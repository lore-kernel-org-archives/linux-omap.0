From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 00/10 v3] omap3: pm: introduce support for 3630 OPPs
Date: Tue, 24 Nov 2009 22:09:09 -0600
Message-ID: <1259122159-1583-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57232 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934382AbZKYEJT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 23:09:19 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAP49PmP009937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 22:09:25 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>

Hi,
Here is V3 of the patch series.  What changed in V3:
* Major rewrite of OPP APIs. This includes changes from offline
  discussions with lots of folks and taking in l-o comments - all
  patches have changed as a result.
* rebased to latest lo-pm

V2: http://marc.info/?l=linux-omap&m=125809232732700&w=2
V1: http://marc.info/?l=linux-omap&m=125800488923479&w=2

NOTE: After a bunch of frustrating efforts, current OPP accessor
implementation is constrained by two files:
smartreflex.c and resource34xx.c. I agree that the current opp
accessor implementation leaves lot to be desired, but the nature of
struct omap_opp cannot change unless we essentially rewrite the
implementation of the mentioned files.

Ref: http://elinux.org/OMAP_Power_Management#Future_directions

I propose we could take this in in three stages:
Stage 1: Introduce this series in as starters if there are no major
 issues
Stage 2: We cleanup/replace resource34xx and smartreflex.c
Stage 3: Go through a second round of optimization/cleanup of opp
 accessors implementation (this time for good hopefully)

Also note that OMAP3630 is dependent on clk tree changes which needs
to come in - but that is an independent parallel activity.

TODO items:
* Add on a dependency b/w vdd1 and vdd2 in a clean manner -> probably
  after we cleanup the resource34xx.c, all folks needing a quick hack
  can easily follow the following pseudo logic:
  resource34xx.c::set_opp:

  if (cpu_is_omap3630()) {
	  vdd1_threshold_freq = 600mhz (opp2)
	  vdd2_required_freq = 200Mhz
  } else {
	  vdd1_threshold_freq = 500 Mhz (opp3)
	  vdd2_required_freq = 100Mhz
  }
  if (vdd1_target < vdd1_threshold_freq)
	free_vdd2_dep_if_acquired();
  /* Do other stuff */
  if (vdd1_target_freq >= vdd1_threshold_freq)
	request_vdd2(at least vdd2_required_freq)

  The 3630 vdd1->vdd2 dependency comes from the OPP table dependency
  of OPP100 and above on VDD1 requires VDD2 to be OPP100. VDD2 is free
  to go as it pleases, but optimal is to be at OPP50 if VDD1 is at
  OPP50. Lots of possible hacks are possible, and I dont recommend any
  at the moment.
* OMAP3630: Add speedbin detection and enable support for OPP-Turbo and
  OPP-SB

Finally,
NOTE: SDP3630 needs the patch for 8250 as discussed here:
http://marc.info/?l=linux-omap&m=125873296522723&w=2

 ====
This patch series is based on previous discussions:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg17632.html

I have modified the initial patch From Sanjeev:
http://patchwork.kernel.org/patch/50998/

Other than these, we cannot use the old VDDx_MAX based usage
anymore as 3630 OPPs are now different and runtime handling
is a must-have, hence introducing these accessor functions is not
avoidable.

The changes are incremental and tries to avoid intrusive change
as much as possible.

The OPP accessor functions introduced in this series is hopefully
a start for us to optimize this heavily used path.

An alternate approach for detecting 3630 OPP is using FEATURES
instead of detecting the cpu_type as I have implemented in this series.

Testing: mostly on SDP3430: using cpufreq-utils, sysfs vddx_lock
RET/OFF using shell scripts. Further testing requested.
Most of the commands used documented here:
http://elinux.org/OMAP_Power_Management

Nishanth Menon (10):
Following are the OPP accessor function introduction:
  omap3: pm: introduce enabled flag to omap_opp
  omap3: pm: introduce opp accessor functions
  omap3: pm: use opp accessor functions for omap34xx

The following are attempts to cleanup existing code from VDDx dep:
  omap3: pm: srf: use opp accessor functions
  omap3: pm: sr: replace get_opp with freq_to_opp
  omap3: pm: use opp accessor functions for omap-target
  omap3: clk: use pm accessor functions for cpufreq table
  omap3: pm: remove VDDx_MIN/MAX macros

The following two introduce 3630 support:
  omap3: pm: introduce 3630 opps
  omap3: pm: omap3630 boards: enable 3630 opp tables

 arch/arm/mach-omap2/board-3430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3630sdp.c        |    9 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
 arch/arm/mach-omap2/board-omap3evm.c       |    1 +
 arch/arm/mach-omap2/board-rx51.c           |    1 +
 arch/arm/mach-omap2/board-zoom2.c          |    2 +
 arch/arm/mach-omap2/board-zoom3.c          |    9 +-
 arch/arm/mach-omap2/clock34xx.c            |   32 ++--
 arch/arm/mach-omap2/omap3-opp.h            |   58 +------
 arch/arm/mach-omap2/pm.h                   |    6 +
 arch/arm/mach-omap2/pm34xx.c               |  113 ++++++++++++
 arch/arm/mach-omap2/resource34xx.c         |  240 +++++++++++++++++++-------
 arch/arm/mach-omap2/smartreflex.c          |   42 ++----
 arch/arm/plat-omap/Makefile                |    3 +
 arch/arm/plat-omap/cpu-omap.c              |   19 ++-
 arch/arm/plat-omap/include/plat/omap-pm.h  |   15 +--
 arch/arm/plat-omap/include/plat/omap34xx.h |    5 -
 arch/arm/plat-omap/include/plat/opp.h      |  208 ++++++++++++++++++++++
 arch/arm/plat-omap/opp.c                   |  260 ++++++++++++++++++++++++++++
 19 files changed, 838 insertions(+), 187 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/opp.h
 create mode 100644 arch/arm/plat-omap/opp.c

 Regards,
 Nishanth Menon
