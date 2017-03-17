From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] clk: ti: cleanups for 4.12 merge window
Date: Fri, 17 Mar 2017 14:53:37 +0200
Message-ID: <8157b2e6-99c8-dc02-0c02-3d99778f255b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi Stephen/Mike,

This is basically the TI clock driver cleanup series v2 posted last 
week, sending a pull request now as there hasn't been any additional 
comments.

-Tero

==================================================================

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

   https://github.com/t-kristo/linux-pm.git for-4.12-ti-clk-cleanups

for you to fetch changes up to 6c0afb503937a12a8d20a805fcf263e31afa9871:

   clk: ti: convert to use proper register definition for all accesses 
(2017-03-08 13:06:15 +0200)

----------------------------------------------------------------
Tero Kristo (15):
       clk: ti: remove un-used definitions from public clk_hw_omap struct
       clk: ti: add support for automatic clock alias generation
       clk: ti: add API for creating aliases automatically for simple 
clock types
       clk: ti: use automatic clock alias generation framework
       clk: ti: add clkdm_lookup to the exported functions
       clk: ti: move omap2_init_clk_clkdm under TI clock driver
       clk: ti: enforce const types on string arrays
       clk: ti: omap4: cleanup unnecessary clock aliases
       clk: ti: drop unnecessary MEMMAP_ADDRESSING flag
       clk: ti: mux: convert TI mux clock to use its internal data 
representation
       clk: ti: divider: convert TI divider clock to use its own data 
representation
       clk: ti: divider: add driver internal API for parsing divider data
       clk: ti: gate: export gate_clk_ops locally
       clk: ti: dpll44xx: fix clksel register initialization
       clk: ti: convert to use proper register definition for all accesses

  arch/arm/mach-omap2/clkt2xxx_dpllcore.c |   3 +-
  arch/arm/mach-omap2/clock.c             |  35 +-----
  arch/arm/mach-omap2/clock.h             |   2 +
  arch/arm/mach-omap2/cm.h                |   5 +-
  arch/arm/mach-omap2/cm2xxx.c            |   9 +-
  arch/arm/mach-omap2/cm3xxx.c            |  10 +-
  arch/arm/mach-omap2/cm_common.c         |   2 +-
  drivers/clk/ti/apll.c                   |  50 ++++-----
  drivers/clk/ti/autoidle.c               |  18 +--
  drivers/clk/ti/clk-3xxx.c               |  55 +++++-----
  drivers/clk/ti/clk-44xx.c               | 188 
+-------------------------------
  drivers/clk/ti/clk-dra7-atl.c           |  11 +-
  drivers/clk/ti/clk.c                    | 157 +++++++++++++++++++++-----
  drivers/clk/ti/clkt_dflt.c              |  61 ++++-------
  drivers/clk/ti/clkt_dpll.c              |   6 +-
  drivers/clk/ti/clkt_iclk.c              |  29 +++--
  drivers/clk/ti/clock.h                  |  41 ++++++-
  drivers/clk/ti/clockdomain.c            |  38 +++++--
  drivers/clk/ti/composite.c              |  18 ++-
  drivers/clk/ti/divider.c                | 111 +++++++++++--------
  drivers/clk/ti/dpll.c                   |  59 +++++-----
  drivers/clk/ti/dpll3xxx.c               |  38 +++----
  drivers/clk/ti/dpll44xx.c               |  14 +--
  drivers/clk/ti/fixed-factor.c           |   1 +
  drivers/clk/ti/gate.c                   |  44 ++++----
  drivers/clk/ti/interface.c              |  25 ++---
  drivers/clk/ti/mux.c                    |  59 +++++-----
  include/linux/clk/ti.h                  |  55 +++++-----
  28 files changed, 543 insertions(+), 601 deletions(-)
