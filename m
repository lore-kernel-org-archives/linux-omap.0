From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] clk: ti: clkctrl support for 4.13 merge window
Date: Thu, 8 Jun 2017 17:51:38 +0300
Message-ID: <6d66f78a-5d39-6396-c492-b79a687ce58a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi Stephen, Mike,

This pull contains the v3 of the clkctrl base driver support posted 
couple of weeks back, with Tony's acks added to patch #2 and #4.

-Tero

===============================================

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

   https://github.com/t-kristo/linux-pm.git for-4.13-ti-clkctrl

for you to fetch changes up to 19b5ebbe7680a754e3bf6ad80f3b8e9dd91a8463:

   clk: ti: omap4: add clkctrl clock data (2017-06-08 17:46:32 +0300)

----------------------------------------------------------------
Tero Kristo (3):
       clk: ti: add support for clkctrl clocks
       dt-bindings: clk: add omap4 clkctrl definitions
       clk: ti: omap4: add clkctrl clock data

Tony Lindgren (1):
       Documentation: dt-bindings: Add binding documentation for TI 
clkctrl clocks

  .../devicetree/bindings/clock/ti-clkctrl.txt       |  56 ++
  drivers/clk/ti/Makefile                            |   3 +-
  drivers/clk/ti/clk-44xx.c                          | 663 
+++++++++++++++++++++
  drivers/clk/ti/clkctrl.c                           | 486 +++++++++++++++
  drivers/clk/ti/clock.h                             |  31 +
  include/dt-bindings/clock/omap4.h                  | 146 +++++
  6 files changed, 1384 insertions(+), 1 deletion(-)
  create mode 100644 Documentation/devicetree/bindings/clock/ti-clkctrl.txt
  create mode 100644 drivers/clk/ti/clkctrl.c
  create mode 100644 include/dt-bindings/clock/omap4.h
