From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] ARM: OMAP2+: clock driver fixes for early v3.16-rc
Date: Tue, 24 Jun 2014 12:36:14 +0300
Message-ID: <53A9468E.8070109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45984 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbaFXJfs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 05:35:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>

Hi Mike,

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

   git@github.com:t-kristo/linux-pm.git for-v3.16-rc/ti-clk-drv

for you to fetch changes up to 7d5fc85d961b807c799786afd175f5d964a2109f:

   clk: ti: set CLK_SET_RATE_NO_REPARENT for ti,mux-clock (2014-06-19 
14:52:32 +0300)

----------------------------------------------------------------
Four fixes for early 3.16-rc builds. Fixes some hidden problems found 
with code checkers, AM43xx only build fix and a fix for the behavior of 
TI mux clocks (by default, no longer select mux parent with rate change, 
most of the other SoCs use similar behavior.)

----------------------------------------------------------------
Dan Carpenter (1):
       clk: ti: apll: not allocating enough data

Julia Lawall (1):
       clk: ti: dra7: return error code in failure case

Roger Quadros (1):
       clk: ti: am43x: Fix boot with CONFIG_SOC_AM33XX disabled

Tomi Valkeinen (1):
       clk: ti: set CLK_SET_RATE_NO_REPARENT for ti,mux-clock

  drivers/clk/ti/apll.c |    8 +++-----
  drivers/clk/ti/dpll.c |    5 +++--
  drivers/clk/ti/mux.c  |    2 +-
  3 files changed, 7 insertions(+), 8 deletions(-)
