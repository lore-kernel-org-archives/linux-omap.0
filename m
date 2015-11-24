From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] clk: ti: fixes for 4.4-rc
Date: Tue, 24 Nov 2015 11:38:37 +0200
Message-ID: <5654301D.8070007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

Hi Michael, Stephen,

Here are some TI clock driver fixes for 4.4-rc.

-Tero

================================================================

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

   https://github.com/t-kristo/linux-pm.git for-4.4-rc/ti-clk-fixes

for you to fetch changes up to 167af5ef2cdba14ff14a13c91e5532ed479083d8:

   clk: ti: drop locking code from mux/divider drivers (2015-11-24 
11:30:27 +0200)

----------------------------------------------------------------
Grygorii Strashko (1):
       clk: ti: drop locking code from mux/divider drivers

Neil Armstrong (1):
       clk: ti816x: Add missing dmtimer clkdev entries

Nicolas Pitre (2):
       clk: ti: clkt_dpll: fix wrong do_div() usage
       clk: ti: fapll: fix wrong do_div() usage

  drivers/clk/ti/clk-816x.c  |    2 ++
  drivers/clk/ti/clkt_dpll.c |    4 ++--
  drivers/clk/ti/divider.c   |   16 +++-------------
  drivers/clk/ti/fapll.c     |    4 ++--
  drivers/clk/ti/mux.c       |   15 +++------------
  5 files changed, 12 insertions(+), 29 deletions(-)

