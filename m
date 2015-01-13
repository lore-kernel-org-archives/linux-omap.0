From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Minimal FAPLL clock support for dm816x
Date: Tue, 13 Jan 2015 14:51:26 -0800
Message-ID: <1421189488-9657-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's a minimal support for the FAPLL (Flying Adder PLL) on dm816x
which is a omap variant.

Regards,

Tony


Tony Lindgren (2):
  clk: ti: Add support for FAPLL on dm816x
  clk: ti: Initialize clocks for dm816x

 .../devicetree/bindings/clock/ti/fapll.txt         |  33 ++
 drivers/clk/ti/Makefile                            |   1 +
 drivers/clk/ti/clk-3xxx.c                          |   8 +-
 drivers/clk/ti/clk-816x.c                          |  53 +++
 drivers/clk/ti/fapll.c                             | 410 +++++++++++++++++++++
 5 files changed, 498 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/fapll.txt
 create mode 100644 drivers/clk/ti/clk-816x.c
 create mode 100644 drivers/clk/ti/fapll.c

-- 
2.1.4
