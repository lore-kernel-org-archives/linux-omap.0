From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] OMAP2+: TI clock driver changes for 4.1 merge window
Date: Tue, 24 Mar 2015 21:06:41 +0200
Message-ID: <5511B5C1.8080705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53254 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932547AbbCXTG6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 15:06:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

Hi Mike,

Here are the TI clock driver patches meant for 4.1 merge window.

Some simple data fixes, dm81xx FAPLL changes, and a generic TI clock 
driver register access fix taken from the PRCM/SCM set I have posted to 
linux-omap list earlier.

-Tero

----------------------------------------------------------------

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

   git@github.com:t-kristo/linux-pm.git for-4.1-clk-ti

for you to fetch changes up to 9089848d9afa34a796988b5b666c2c4e611ccb61:

   clk: ti: Implement FAPLL set_rate for the PLL (2015-03-24 20:26:14 +0200)

----------------------------------------------------------------
Peter Ujfalusi (2):
       clk: ti: clk-3xxx: Correct McBSP related DT clock definitions
       clk: ti: clk-3xxx-legacy: Correct McBSP related clock aliases

Suman Anna (4):
       clk: ti: OMAP4: Remove the legacy timer DT clock aliases
       clk: ti: OMAP5: Correct the DT clock aliases for timers
       clk: ti: DRA7: Correct timer_sys_ck clock aliases for Timers
       clk: ti: DRA7: Add timer_sys_ck aliases for Timers 13 through 16

Tero Kristo (1):
       clk: ti: fix ti_clk_get_reg_addr error handling

Tony Lindgren (3):
       clk: ti: Fix FAPLL recalc_rate for rounding errors
       clk: ti: Implement FAPLL set_rate for the synthesizer
       clk: ti: Implement FAPLL set_rate for the PLL

  drivers/clk/ti/apll.c            |    5 +-
  drivers/clk/ti/autoidle.c        |    2 +-
  drivers/clk/ti/clk-3xxx-legacy.c |   16 ++-
  drivers/clk/ti/clk-3xxx.c        |   19 +--
  drivers/clk/ti/clk-44xx.c        |   11 --
  drivers/clk/ti/clk-54xx.c        |   22 ++--
  drivers/clk/ti/clk-7xx.c         |   18 ++-
  drivers/clk/ti/clk.c             |    7 +-
  drivers/clk/ti/divider.c         |    4 +-
  drivers/clk/ti/dpll.c            |    6 +-
  drivers/clk/ti/fapll.c           |  270 
++++++++++++++++++++++++++++++++++++--
  drivers/clk/ti/gate.c            |    4 +-
  drivers/clk/ti/interface.c       |    2 +-
  drivers/clk/ti/mux.c             |    4 +-
  14 files changed, 318 insertions(+), 72 deletions(-)
