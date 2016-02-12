From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv5 0/2] Clock driver for dm814x and dra62x ADPLL
Date: Fri, 12 Feb 2016 13:20:07 -0800
Message-ID: <1455312009-808-1-git-send-email-tony@atomide.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

Here's a clock driver for the ADPLL on dm814x and dra62x. It's still
in read-only mode for the PLL, but is already usable with the gates
and dividers and allows us to add devices like MMC and USB.

Regards,

Tony

Tony Lindgren (2):
  dt-bindings: clock: adpll: Add binding documentation for TI adpll
  clk: ti: Add support for dm814x ADPLL

 .../devicetree/bindings/clock/ti/adpll.txt         |  43 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/ti/Kconfig                             |   6 +
 drivers/clk/ti/Makefile                            |   2 +
 drivers/clk/ti/adpll.c                             | 983 +++++++++++++++++++++
 drivers/clk/ti/clk-814x.c                          |  53 ++
 6 files changed, 1088 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/adpll.txt
 create mode 100644 drivers/clk/ti/Kconfig
 create mode 100644 drivers/clk/ti/adpll.c

-- 
2.7.0

