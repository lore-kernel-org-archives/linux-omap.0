From: Romit Dasgupta <romit@ti.com>
Subject: [PATCH 0/10] OPP layer and additional cleanups.
Date: Thu, 31 Dec 2009 18:59:00 +0530
Message-ID: <1262266140.20175.176.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40807 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbZLaN3M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Dec 2009 08:29:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, nm@ti.com, khilman@deeprootsystems.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
   The following set of patches apply on top of the Kevin's pm-wip-opp
branch. What I have tried to do in this set of patches are:

(Not in patch-set order)
* OPP layer internals have moved to list based implementation.
* The OPP layer APIs have been changed. The search APIs have been
reduced to one instead of opp_find_{exact|floor|ceil}.
* OPP book-keeping is now done inside OPP layer. We do not have to
maintain pointers to {mpu|dsp|l3}_opp, outside this layer.
* removed omap_opp_def as this is very similar to omap_opp.
* Cleaned up the SRF framework to use new OPP APIs.
* Removed VDD1,2 OPP resources and instead introduced voltage resources.
   This results in leaner code.
* L3 frequency change now happens from cpufreq notifier mechanism.
* cpufreq driver now honors the CPUFREQ{H|L} flags.
* uv to vsel precision loss is handled cleanly.

Verified this on zoom2 with and without lock debugging. 

Some output from cpufreq translation statistics.

#
cat /sys/devices/system/cpu/cpu0/cpufreq/stats/trans_table                    
   From  :
To                                                                
          600000    550000    500000    250000 125000
600000:      0      6804      4536      4536    4535

550000:   4536         0      6804      4536    4535

500000:   4537      4536         0      6804    4535

250000:   4536      4536      4536         0    6802

125000:   6802      4535      4535      4535     0


diffstat output!

 mach-omap2/pm.h              |   17 +
 mach-omap2/pm34xx.c          |   79 ++++--
 mach-omap2/resource34xx.c    |  542 ++++++++++++++-----------------------------
 mach-omap2/resource34xx.h    |   62 ++--
 mach-omap2/smartreflex.c     |  285 +++++++++++-----------
 mach-omap2/smartreflex.h     |   16 -
 plat-omap/common.c           |    6 
 plat-omap/cpu-omap.c         |   73 +++++
 plat-omap/include/plat/io.h  |    1 
 plat-omap/include/plat/opp.h |  265 +++++----------------
 plat-omap/omap-pm-noop.c     |   35 --
 plat-omap/omap-pm-srf.c      |   38 ---
 plat-omap/opp.c              |  497 +++++++++++++++++++++------------------
 plat-omap/opp_twl_tps.c      |   11 
 14 files changed, 851 insertions(+), 1076 deletions(-)


