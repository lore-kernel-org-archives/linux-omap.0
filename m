From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/4] OPP usage fixes for RCU locking
Date: Fri, 18 Jan 2013 13:52:31 -0600
Message-ID: <1358538755-29109-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-pm <linux-pm@vger.kernel.org>
Cc: Rafael <rjw@sisk.pl>, Kevin <khilman@deeprootsystems.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, lkml <linux-kernel@vger.kernel.org>, lo <linux-omap@vger.kernel.org>, Jack <jack@embed.me.uk>, Alexander <holler@ahsoftware.de>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
Despite being documented in function documentation and in
Documentation/power/opp.txt, many of the users of OPP APIs
dont honor RCU lock usage appropriately.

This recently appeared in IRC discussion earlier today [1]. 
I did an audit of current usage and the following series
is a result of this.

NOTE:
1. The patch "PM / devfreq: exynos4_bus: honor RCU lock usage" has only
   been build tested as I dont have an exynos platform to try it on. I have
   tried to make it as least intrusive as possible and at least reviewed
   to ensure I haven't screwed anything up.

Other than this, I have added appropriate tested by information in requisite
patches.

Series is based off: v3.8-rc4 tag
Also available in the following location[2]:
https://github.com/nmenon/linux-2.6-playground branch: post/pm/opp-fixes-v1

Nishanth Menon (4):
  cpufreq: OMAP: use RCU locks around usage of OPP
  cpufreq: cpufreq-cpu0: use RCU locks around usage of OPP
  PM / devfreq: add locking documentation for recommend_opp
  PM / devfreq: exynos4_bus: honor RCU lock usage

 drivers/cpufreq/cpufreq-cpu0.c |    5 +++
 drivers/cpufreq/omap-cpufreq.c |    3 ++
 drivers/devfreq/devfreq.c      |    5 +++
 drivers/devfreq/exynos4_bus.c  |   94 ++++++++++++++++++++++++++++------------
 4 files changed, 80 insertions(+), 27 deletions(-)

[1] http://www.beagleboard.org/irclogs/index.php?date=2013-01-18#T14:14:07
[2] https://github.com/nmenon/linux-2.6-playground/commits/post/pm/opp-fixes-v1

Regards,
Nishanth Menon
-- 
1.7.9.5
