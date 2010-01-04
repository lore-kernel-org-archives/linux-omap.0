From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/10] OPP layer and additional cleanups.
Date: Mon, 4 Jan 2010 15:41:47 -0600
Message-ID: <4B42609B.7050403@ti.com>
References: <1262266140.20175.176.camel@boson>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46802 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842Ab0ADVlv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jan 2010 16:41:51 -0500
In-Reply-To: <1262266140.20175.176.camel@boson>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dasgupta, Romit had written, on 12/31/2009 07:29 AM, the following:
> Hi,
>    The following set of patches apply on top of the Kevin's pm-wip-opp
> branch. What I have tried to do in this set of patches are:
> 
> (Not in patch-set order)
> * OPP layer internals have moved to list based implementation.

Is there a benefit of list based implementation?

> * The OPP layer APIs have been changed. The search APIs have been
> reduced to one instead of opp_find_{exact|floor|ceil}.

Could you let us know the benefit of merging this? the split is aligned 
in the community as such after the very first implementation which had 
all three merged as a single function, but was split after multiple 
review comments on readability aspects.

> * OPP book-keeping is now done inside OPP layer. We do not have to
> maintain pointers to {mpu|dsp|l3}_opp, outside this layer.
nice idea, BUT, you need some sort of domain reference mechanism, 
introducing a enum (as done in enum volt_rail - patch 6/10) is the same 
as providing named struct pointers, they perform the same function = 
identifying the voltage domain for the operation. what is the benefit of 
using enum?

> * removed omap_opp_def as this is very similar to omap_opp.
yes, but the original intent was that registration mechanism will use a 
structure that is visible to the caller, this allows for isolated 
modification of structure and handling mechanism keeping the overall 
system impact minimal.

> * Cleaned up the SRF framework to use new OPP APIs.
nice :) lets align on your opp improvement patches as the first go.

> * Removed VDD1,2 OPP resources and instead introduced voltage resources.
>    This results in leaner code.
good to hear this.
> * L3 frequency change now happens from cpufreq notifier mechanism.
> * cpufreq driver now honors the CPUFREQ{H|L} flags.
> * uv to vsel precision loss is handled cleanly.
:) thanks.

> 
> Verified this on zoom2 with and without lock debugging. 
zoom3/sdp3630?

> 
> Some output from cpufreq translation statistics.
> 
> #
> cat /sys/devices/system/cpu/cpu0/cpufreq/stats/trans_table                    
>    From  :
> To                                                                
>           600000    550000    500000    250000 125000
> 600000:      0      6804      4536      4536    4535
> 
> 550000:   4536         0      6804      4536    4535
> 
> 500000:   4537      4536         0      6804    4535
> 
> 250000:   4536      4536      4536         0    6802
> 
> 125000:   6802      4535      4535      4535     0
> 
> 
> diffstat output!
> 
>  mach-omap2/pm.h              |   17 +
>  mach-omap2/pm34xx.c          |   79 ++++--
>  mach-omap2/resource34xx.c    |  542 ++++++++++++++-----------------------------
>  mach-omap2/resource34xx.h    |   62 ++--
>  mach-omap2/smartreflex.c     |  285 +++++++++++-----------
>  mach-omap2/smartreflex.h     |   16 -
>  plat-omap/common.c           |    6 
>  plat-omap/cpu-omap.c         |   73 +++++
>  plat-omap/include/plat/io.h  |    1 
>  plat-omap/include/plat/opp.h |  265 +++++----------------
>  plat-omap/omap-pm-noop.c     |   35 --
>  plat-omap/omap-pm-srf.c      |   38 ---
>  plat-omap/opp.c              |  497 +++++++++++++++++++++------------------
>  plat-omap/opp_twl_tps.c      |   11 
>  14 files changed, 851 insertions(+), 1076 deletions(-)
> 
> 
minor comment:
Might be good if your patches 1/10 to 9/10 had different subjects.

-- 
Regards,
Nishanth Menon
