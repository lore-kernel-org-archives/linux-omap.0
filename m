From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 00/10 v4] omap3: pm: introduce support for 3630 OPPs
Date: Wed,  9 Dec 2009 00:17:05 -0600
Message-ID: <1260339435-20294-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36521 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754374AbZLIGRS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 01:17:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Hi,
Thanks for all the comments. Here is V4 of the patch series.
What changed in V4 (or stage1 as discussed in l-o v3):
* Search OPP APIs changed.
* review comment incorporated

History:
V3: http://marc.info/?t=125912234200001&r=1&w=2
V2: http://marc.info/?l=linux-omap&m=125809232732700&w=2
V1: http://marc.info/?l=linux-omap&m=125800488923479&w=2

Ref: http://elinux.org/OMAP_Power_Management#Future_directions

Also note that OMAP3630 is dependent on clk tree changes which needs
to come in - but that is an independent parallel activity.

NOTE: SR should be disabled for testing on 3630, there are deltas for
OMAP3630 which are not in place in SR codebase and behavior is not
trustworthy.

TODO Cleanups:
* Kevin's recommended cleanups in:
  http://marc.info/?l=linux-omap&m=125917007423545&w=2
  (requesting this be posted once we get the initial set in..)
* SRF cleanup in a detailed and to make it robust.
* Smartreflex cleanups/refactor + support 3630

TODO items (other than cleanups):
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
(pushed to l-o, will be available once pm is rebased)

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

Testing: mostly on SDP3430 and SDP3630: using cpufreq-utils, sysfs
vddx_lock, RET/OFF using shell scripts. Further testing requested.
Most of the commands used documented here:
http://elinux.org/OMAP_Power_Management

Reposting the series for consistency as only 3 patches retained the v1
status due to change in accessor function names and nature.

Nishanth Menon (10):
Following are the OPP accessor function introduction:
  omap3: pm: introduce enabled flag to omap_opp
  omap3: pm: introduce opp accessor functions - v4
  omap3: pm: use opp accessor functions for omap34xx - v4

The following are attempts to cleanup existing code from VDDx dep:
  omap3: pm: srf: use opp accessor functions - v4
  omap3: pm: sr: replace get_opp with freq_to_opp - v4
  omap3: pm: use opp accessor functions for omap-target - v4
  omap3: clk: use pm accessor functions for cpufreq table - v4
  omap3: pm: remove VDDx_MIN/MAX macros

The following two introduce 3630 support:
  omap3: pm: introduce 3630 opps - v4
  omap3: pm: omap3630 boards: enable 3630 opp tables

 arch/arm/mach-omap2/board-3430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3630sdp.c        |    9 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
 arch/arm/mach-omap2/board-omap3evm.c       |    1 +
 arch/arm/mach-omap2/board-rx51.c           |    1 +
 arch/arm/mach-omap2/board-zoom2.c          |    2 +
 arch/arm/mach-omap2/board-zoom3.c          |    9 +-
 arch/arm/mach-omap2/clock34xx.c            |   40 +++--
 arch/arm/mach-omap2/omap3-opp.h            |   58 +------
 arch/arm/mach-omap2/pm.h                   |    6 +
 arch/arm/mach-omap2/pm34xx.c               |  106 +++++++++++
 arch/arm/mach-omap2/resource34xx.c         |  238 ++++++++++++++++++-------
 arch/arm/mach-omap2/smartreflex.c          |   44 ++---
 arch/arm/plat-omap/Makefile                |    3 +
 arch/arm/plat-omap/cpu-omap.c              |   12 +-
 arch/arm/plat-omap/include/plat/omap-pm.h  |   15 +--
 arch/arm/plat-omap/include/plat/omap34xx.h |    5 -
 arch/arm/plat-omap/include/plat/opp.h      |  230 +++++++++++++++++++++++
 arch/arm/plat-omap/opp.c                   |  271 ++++++++++++++++++++++++++++
 19 files changed, 863 insertions(+), 189 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/opp.h
 create mode 100644 arch/arm/plat-omap/opp.c

Regards,
Nishanth Menon
