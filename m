From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 0/5] PM / clock_ops: provide default runtime ops and cleanup users
Date: Thu, 23 Apr 2015 14:03:08 +0530
Message-ID: <1429777993-11702-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: rjw@rjwysocki.net, ssantosh@kernel.org, tony@atomide.com, khilman@kernel.org, nsekhar@ti.com, magnus.damm@gmail.com, geert@linux-m68k.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Most users of PM clocks do the exact same thing in runtime callbacks.
Provide default callbacks and cleanup the existing users (keystone/davinci
/omap1/sh)

Rajendra Nayak (5):
  PM / clock_ops: Provide default runtime ops to users
  arm: keystone: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
  arm: omap1: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
  arm: davinci: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
  drivers: sh: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS

 arch/arm/mach-davinci/pm_domain.c  | 32 +-------------------------
 arch/arm/mach-keystone/pm_domain.c | 33 +-------------------------
 arch/arm/mach-omap1/pm_bus.c       | 37 ++----------------------------
 drivers/base/power/clock_ops.c     | 38 ++++++++++++++++++++++++++++++
 drivers/sh/pm_runtime.c            | 47 ++------------------------------------
 include/linux/pm_clock.h           | 10 ++++++++
 6 files changed, 54 insertions(+), 143 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

