From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/4] CLK: TI: Timer clock alias fixes
Date: Fri, 13 Mar 2015 17:58:34 -0500
Message-ID: <1426287518-47786-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tero,

Please find couple of cleanup/fixes on the DT clock aliases
for the GPTimers. Patches are based on 4.0-rc1 and following
is the summary of the changes,

1. Patch 1 is a cleanup for OMAP4
2. Patch 2 fixes the failures for OMAP5 if omap_dm_timer_set_source() API is
   called to set the parent of any timer using OMAP_TIMER_SRC_SYS_CLK.
3. Patch 3 is for DRA7 and fixes the parent to be set to timer_sys_clk_div
   and not sys_clkin2, which is an optional clock input.
4. Patch 4 adds the DT CLK aliases for GPTimers 13 through 16 on DRA7. These
   timer nodes are currently missing in DTS, and I will be sending the patches
   for them soon.

regards
Suman

Suman Anna (4):
  CLK: TI: OMAP4: Remove the legacy timer DT clock aliases
  CLK: TI: OMAP5: Correct the DT clock aliases for timers
  CLK: TI: DRA7: Correct timer_sys_ck clock aliases for Timers
  CLK: TI: DRA7: Add timer_sys_ck aliases for Timers 13 through 16

 drivers/clk/ti/clk-44xx.c | 11 -----------
 drivers/clk/ti/clk-54xx.c | 22 +++++++++++-----------
 drivers/clk/ti/clk-7xx.c  | 18 +++++++++++-------
 3 files changed, 22 insertions(+), 29 deletions(-)

-- 
2.3.2
