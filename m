From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 0/7] RFC: convert OMAP to common struct clk
Date: Tue, 13 Dec 2011 20:11:51 -0800
Message-ID: <1323835918-2371-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:47958 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754417Ab1LNEPz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 23:15:55 -0500
Received: by mail-yw0-f47.google.com with SMTP id o47so1005496yho.20
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 20:15:54 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, rnayak@ti.com, jeremy.kerr@canonical.com, paul@pwsan.com, broonie@opensource.wolfsonmicro.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org, mturquette@linaro.org, mturquette@ti.com, andrew@lunn.ch

This patch series is an RFC for converting OMAP to the common struct
clk.  These patches are based on v4 of the common struct clk series:
https://lkml.org/lkml/2011/12/13/451

OMAP's old struct clk has been renamed to struct clk_hw_omap, but left
essentially the same.  This series only targets OMAP4 and was only
tested on a 4430 Panda.

The next step is to figure out:
 * what are the various clk types we want to support in separate
   structures
 * where does the "clk driver" code live (still in mach-omap2?)
 * kill off plat-omap/clock.* completely?  I vote yes.

These patches can also be found at,
http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=shortlog;h=refs/heads/v3.2-rc5-clkv4-omap

The same series merged with Kevin's PM branch (to get CPUfreq working)
can be found at,
http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=shortlog;h=refs/heads/v3.2-rc5-clkv4-omap-pm

This series will be followed up shortly with another set of patches for
"testing" the clk rate change notifiers, parent propagation of rate
changes and debugfs re-parenting.

Mike Turquette (7):
  OMAP: Kconfig: select GENERIC_CLK
  HACK: omap4: clk: convert to common struct clk
  HACK: omap: convert 44xx data to common struct clk
  omap: hwmod: convert to use common struct clk
  omap: panda: use clk_prepare in ehci init
  omap: dss: use clk_prepare in dss reset
  HACK: comment WARN_ON in _clkdm_clk_hwmod_disable

 arch/arm/mach-omap2/Kconfig             |    1 +
 arch/arm/mach-omap2/board-omap4panda.c  |    1 +
 arch/arm/mach-omap2/clkt_clksel.c       |  195 +-
 arch/arm/mach-omap2/clkt_dpll.c         |   54 +-
 arch/arm/mach-omap2/clock.c             |  363 +--
 arch/arm/mach-omap2/clock.h             |   59 +-
 arch/arm/mach-omap2/clock44xx_data.c    | 4615 ++++++++++++++++++-------------
 arch/arm/mach-omap2/clockdomain.c       |    2 +-
 arch/arm/mach-omap2/display.c           |    4 +-
 arch/arm/mach-omap2/dpll3xxx.c          |  228 +-
 arch/arm/mach-omap2/dpll44xx.c          |   62 +-
 arch/arm/mach-omap2/omap_hwmod.c        |   54 +-
 arch/arm/plat-omap/clock.c              |  315 +--
 arch/arm/plat-omap/include/plat/clock.h |   96 +-
 14 files changed, 3415 insertions(+), 2634 deletions(-)

-- 
1.7.5.4

