From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] drop omap3 legacy clock data
Date: Thu, 21 Dec 2017 07:50:15 -0800
Message-ID: <20171221155015.GV3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit ffb009b24388b896d9ca8b54e39a879302142518:

  clk: ti: convert retry_init param to use void data type (2017-12-01 15:16:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/clk-omap3-legacy-signed

for you to fetch changes up to 7558562a70fbd6b3fa746fa33c76c9333aa0bb32:

  clk: ti: Drop legacy clk-3xxx-legacy code (2017-12-14 08:32:06 -0800)

----------------------------------------------------------------
Drop unused omap3 clock data

We have been booting omap3 in device tree only mode for a while now,
so this is all unused now.

----------------------------------------------------------------
Tony Lindgren (1):
      clk: ti: Drop legacy clk-3xxx-legacy code

 drivers/clk/ti/Makefile          |    4 -
 drivers/clk/ti/clk-3xxx-legacy.c | 4656 --------------------------------------
 drivers/clk/ti/clk.c             |  135 --
 drivers/clk/ti/clock.h           |   68 -
 drivers/clk/ti/composite.c       |   45 -
 drivers/clk/ti/dpll.c            |   90 -
 drivers/clk/ti/gate.c            |   48 -
 drivers/clk/ti/interface.c       |   32 -
 8 files changed, 5078 deletions(-)
 delete mode 100644 drivers/clk/ti/clk-3xxx-legacy.c
