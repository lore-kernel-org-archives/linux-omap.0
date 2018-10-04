From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] mach-omap2: handle autoidle denial
Date: Thu,  4 Oct 2018 22:38:15 +0200
Message-ID: <20181004203817.22101-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

On the gta04 with a dm3730 omap_hdq does not work properly when the
device enters lower power states. Idling uart1 and 2 is enough
to show up that problem, if there are no other things enabled.
Further research reveals that hdq iclk must not be turned off during
transfers, also according to the TRM. That fact is also correctly described
in the flags but the code to handle that is incomplete.

To handle multiple users of a single ick, autoidle is disabled
when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))

Changes since the RFC version:
- mutex lock for autoidle changes
- deny_idle/allow_idle calls moved to clock enable/disable of the
  individual modules

Andreas Kemnade (2):
  clk: ti: add a usecount for autoidle
  arm: omap_hwmod disable ick autoidling when a hwmod requires that

 arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
 drivers/clk/ti/autoidle.c        | 32 ++++++++++++++++++++++++--------
 include/linux/clk/ti.h           |  1 +
 3 files changed, 37 insertions(+), 12 deletions(-)

-- 
2.11.0
