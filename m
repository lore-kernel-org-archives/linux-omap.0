From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Clock driver for dm814x ADPLL
Date: Wed,  2 Dec 2015 17:35:02 -0800
Message-ID: <1449106504-7645-1-git-send-email-tony@atomide.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's a clock driver for the ADPLL on dm814x. It's still in read-only
mode for the PLL, but is already usable with the gates and dividers
and allows us to add devices like MMC and USB.

To test this please apply the patches from below on v4.4-rc3:

http://marc.info/?l=linux-omap&m=144901336001085&w=2

And also make sure you have the initcall level change patch that
is needed for having omap clock drivers regular Linux device
drivers:

http://marc.info/?l=linux-omap&m=144890081111207&w=2


Regards,

Tony

Tony Lindgren (2):
  clk: ti: Add support for dm814x ADPLL
  ARM: dts: Add clocks for dm814x ADPLL

 .../devicetree/bindings/clock/ti/adpll.txt         |   42 +
 arch/arm/boot/dts/dm814x-clocks.dtsi               |  256 ++++-
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/ti/Kconfig                             |    6 +
 drivers/clk/ti/Makefile                            |    2 +
 drivers/clk/ti/adpll.c                             | 1027 ++++++++++++++++++++
 drivers/clk/ti/clk-814x.c                          |   53 +
 7 files changed, 1356 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/adpll.txt
 create mode 100644 drivers/clk/ti/Kconfig
 create mode 100644 drivers/clk/ti/adpll.c

-- 
2.6.2

