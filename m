From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] clk: ti: clkctrl driver updates for 4.16 merge window
Date: Tue, 5 Dec 2017 14:41:05 +0200
Message-ID: <fe379081-62e6-11c9-285d-234e2d1a61e4@ti.com>
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

This pull request contains the v2 of the series posted 
(https://www.spinics.net/lists/linux-omap/msg140042.html), with 
Stephen's acks added to the mentioned patches, and just applied on top 
of 4.15-rc1. I actually wonder if you wanted to add your acks to the 
rest of the patches also, but couldn't find any comment about this anywhere.

-Tero

====

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

   https://github.com/t-kristo/linux-pm.git 4.15-rc1-clkctrl-driver

for you to fetch changes up to fe7020e64f042db4b5ca50c358b232e866523447:

   clk: ti: omap4: clkctrl data fixes for opt-clocks (2017-12-01 
15:18:08 +0200)

----------------------------------------------------------------
Tero Kristo (28):
       clk: ti: clkctrl: fix error messages to print out node name properly
       clk: ti: clkctrl: add support for clkdm init for clkctrl clocks
       clk: ti: add support for clkctrl aliases
       clk: ti: clkctrl: use fallback udelay approach if timekeeping is 
suspended
       clk: ti: convert retry_init param to use void data type
       clk: ti: clkctrl: add support for retrying failed init
       clk: ti: clkctrl: fix flags for mux and divider opt clocks
       clk: ti: omap4: cleanup unnecessary clock aliases
       clk: ti: dra7: drop unnecessary clock aliases
       clk: ti: omap5: cleanup unnecessary clock aliases
       clk: ti: dm814x: cleanup unnecessary clock aliases
       clk: ti: dm816x: cleanup unnecessary clock aliases
       clk: ti: am33xx: cleanup unnecessary clock aliases
       clk: ti: am43xx: cleanup unnecessary clock aliases
       clk: ti: omap3: cleanup unnecessary clock aliases
       dt-bindings: clk: add omap5 clkctrl definitions
       clk: ti: omap5: add clkctrl clock data
       dt-bindings: clk: add dra7 clkctrl definitions
       clk: ti: dra7: add clkctrl clock data
       dt-bindings: clk: add am33xx clkctrl definitions
       clk: ti: am33xx: add clkctrl clock data
       dt-bindings: clk: add am43xx clkctrl definitions
       clk: ti: am43xx: add clkctrl clock data
       dt-bindings: clk: add dm814 clkctrl definitions
       clk: ti: dm814: add clkctrl clock data
       dt-bindings: clk: add dm816 clkctrl definitions
       clk: ti: dm816: add clkctrl clock data
       clk: ti: omap4: clkctrl data fixes for opt-clocks

  drivers/clk/ti/apll.c             |    3 +-
  drivers/clk/ti/clk-33xx.c         |  279 +++++++---
  drivers/clk/ti/clk-3xxx.c         |  263 +--------
  drivers/clk/ti/clk-43xx.c         |  295 ++++++----
  drivers/clk/ti/clk-44xx.c         |  200 ++++---
  drivers/clk/ti/clk-54xx.c         |  697 +++++++++++++++++-------
  drivers/clk/ti/clk-7xx.c          | 1076 
+++++++++++++++++++++++++++----------
  drivers/clk/ti/clk-814x.c         |   50 +-
  drivers/clk/ti/clk-816x.c         |   62 ++-
  drivers/clk/ti/clk.c              |   70 ++-
  drivers/clk/ti/clkctrl.c          |   91 +++-
  drivers/clk/ti/clock.h            |   13 +-
  drivers/clk/ti/composite.c        |    3 +-
  drivers/clk/ti/dpll.c             |    3 +-
  include/dt-bindings/clock/am3.h   |  108 ++++
  include/dt-bindings/clock/am4.h   |  113 ++++
  include/dt-bindings/clock/dm814.h |   45 ++
  include/dt-bindings/clock/dm816.h |   53 ++
  include/dt-bindings/clock/dra7.h  |  172 ++++++
  include/dt-bindings/clock/omap5.h |  118 ++++
  20 files changed, 2662 insertions(+), 1052 deletions(-)
  create mode 100644 include/dt-bindings/clock/am3.h
  create mode 100644 include/dt-bindings/clock/am4.h
  create mode 100644 include/dt-bindings/clock/dm814.h
  create mode 100644 include/dt-bindings/clock/dm816.h
  create mode 100644 include/dt-bindings/clock/dra7.h
  create mode 100644 include/dt-bindings/clock/omap5.h
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
