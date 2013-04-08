From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 0/8] staging: ti-soc-thermal: fixes and TODO update
Date: Mon, 8 Apr 2013 08:19:06 -0400
Message-ID: <1365423555-2669-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello Greg,

Here is a series of fixes and I am also updating and revising
the TODO list.

The fixes present in this series  are:
. Extrapolation rules for OMAP4/5 (have been updated)
. Defer probe whenever cpufreq is not ready (Thanks to Keerthy for reporting)
. Device removal was checking for wrong callback

The TODO list has shrink as many of them was already DONE by
previous series of patches.

These patches are based on top of your staging-next. Tested
on OMAP4430 and OMAP5430.

These patches are also available here:
git@gitorious.org:thermal-framework/thermal-framework.git thermal_work/omap/ti-soc-thermal-fixes
https://git.gitorious.org/thermal-framework/thermal-framework.git thermal_work/omap/ti-soc-fixes

All best,

Eduardo Valentin (8):
  staging: ti-soc-thermal: update TODO list
  staging: ti-soc-thermal: fix min/max TODO (already done)
  staging: ti-soc-thermal: Remove TC1/TC2 TODO (already done)
  staging: ti-soc-thermal: introduce OMAP4430 extrapolation constants
  staging: ti-soc-thermal: update OMAP5 extrapolation rules
  staging: ti-soc-thermal: remove extrapolation rules from TODO
  staging: ti-soc-thermal: defer probe if cpufreq is not ready
  staging: ti-soc-thermal: fix device removal

 drivers/staging/ti-soc-thermal/TODO                |   12 --------
 .../staging/ti-soc-thermal/omap4-thermal-data.c    |    8 +++---
 .../staging/ti-soc-thermal/omap5-thermal-data.c    |    1 -
 drivers/staging/ti-soc-thermal/ti-bandgap.c        |   29 +++++++++++++++----
 drivers/staging/ti-soc-thermal/ti-thermal-common.c |    8 ++++-
 drivers/staging/ti-soc-thermal/ti-thermal.h        |   20 ++++++++-----
 6 files changed, 45 insertions(+), 33 deletions(-)

-- 
1.7.7.1.488.ge8e1c

