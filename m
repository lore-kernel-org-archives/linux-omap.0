From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC 0/2] mach-omap2: handle autoidle denial
Date: Thu,  4 Oct 2018 07:51:45 +0200
Message-ID: <20181004055147.23048-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

On the gta04 with a dm3730 omap_hdq does not work properly when the
device enters lower power states. Idling uart1 and 2 is enough
to show up that problem, if there are no other things enabled.
Further research reveals that hdq iclk must not be turned off during
transfers, also according to the TRM. That fact is also correctly described
in the flags but the code to handle that is incomplete.

Since the order is first disable all autoidles, then disable selected
and then enable all, we need to either change that order or add
a usecount. Since it is done only in init, we could think about changing
order.

Andreas Kemnade (2):
  clk: ti: add a usecount for autoidle
  arm: mach-omap2: setup iclk autoidle according to flags

 arch/arm/mach-omap2/omap_hwmod.c |  8 ++++++--
 drivers/clk/ti/autoidle.c        | 20 ++++++++++++--------
 include/linux/clk/ti.h           |  1 +
 3 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.11.0
