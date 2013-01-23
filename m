From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 0/4] ARM: AM335x: LCDC platform support
Date: Wed, 23 Jan 2013 17:11:28 +0530
Message-ID: <cover.1358937533.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

This series make am335x lcdc capable of providing display.
Certain changes were required in generic OMAP clock handling
to attain it. Clock nodes in LCDC path is marked such that
rate can get propogated to upstream clocks till display PLL.

Based on 3.8-rc3.

Tested on AM335x EVM.

To test on AM335x based boards, tree
@ git://gitorious.org/x0148406-public/linux-kernel.git tags/da8xx-fb-dt-v4

Regards
Afzal

v2: As DEFINE_CLK_DIVIDER args has no change, make it's usage as reqd.

Afzal Mohammed (4):
  ARM: OMAP2+: dpll: round rate to closest value
  ARM: OMAP2+: dpll: am335x - avoid freqsel
  ARM: OMAP2+: clock: DEFINE_STRUCT_CLK_FLAGS helper
  ARM: AM33XX: clock: SET_RATE_PARENT in lcd path

 arch/arm/mach-omap2/cclock33xx_data.c | 10 ++++++----
 arch/arm/mach-omap2/clkt_dpll.c       | 12 +++++++-----
 arch/arm/mach-omap2/clock.h           | 11 +++++++++++
 arch/arm/mach-omap2/dpll3xxx.c        |  5 +++--
 4 files changed, 27 insertions(+), 11 deletions(-)

-- 
1.7.12
