From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/3] mach-omap2: handle autoidle denial
Date: Wed, 16 Jan 2019 23:04:26 +0100
Message-ID: <20190116220429.9136-1-andreas@kemnade.info>
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

Changes v3:
- replace CLK_IS_BASIC

Changes v2:
- uses spinlocks instead of mutexes
- invert counter logic
- check whether clock type is basic

Depends on: clk: ti: get rid of CLK_IS_BASIC

Andreas Kemnade (3):
  clk: ti: add a usecount for autoidle
  clk: ti: check clock type before doing autoidle ops
  arm: omap_hwmod disable ick autoidling when a hwmod requires that

 arch/arm/mach-omap2/omap_hwmod.c | 16 +++++++++----
 drivers/clk/ti/autoidle.c        | 52 +++++++++++++++++++++++++++++++++-------
 include/linux/clk/ti.h           |  1 +
 3 files changed, 57 insertions(+), 12 deletions(-)

-- 
2.11.0
