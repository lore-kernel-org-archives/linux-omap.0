From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/4] arm: omap2+: complete dm816x hwmod and clkdev
Date: Fri, 13 Nov 2015 17:29:48 +0100
Message-ID: <56460FFC.1000808@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com
List-Id: linux-omap@vger.kernel.org

In order to fix support for the dm816x platform, add missing bits in
the 81xx hwmod data.

The clk related patch adds the missing clkdev entries to fix all source
selection in the dmtimer driver.

The last patch adds hwmod support of the spinbox module.

v2: add error logs for first patch

Neil Armstrong (4):
  arm: omap2+: add missing HWMOD_NO_IDLEST in 81xx hwmod data
  clk: ti816x: Add missing dmtimer clkdev entries
  arm: plat-omap: add DT support for ti,dm816-timer
  arm: omap2+: Add hwmod spinbox support for dm816x

 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 38 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/dmtimer.c               |  4 ++++
 drivers/clk/ti/clk-816x.c                  |  2 ++
 3 files changed, 44 insertions(+)

-- 
1.9.1
