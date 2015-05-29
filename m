From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/5] clk: Use of_clk_get_parent_count() instead of open coding
Date: Fri, 29 May 2015 11:25:44 +0200
Message-ID: <1432891549-23295-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:52364 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652AbbE2J0K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2015 05:26:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: linux-clk@vger.kernel.org, kernel@stlinux.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

In several places, the functionality of of_clk_get_parent_count() is open
coded. Replace them by of_clk_get_parent_count() to reduce code size.

The first 3 patches can be applied independently, as the affected clock
drivers are used with CONFIG_COMMON_CLK=y and CONFIG_OF=y only.

Patch 4 adds dummy implementations of of_clk_get_parent_count() for the
cases where CONFIG_OF or CONFIG_COMMON_CLK are not set.
This is an RFC, as
  1. Dummies are needed in two places,
  2. We don't have any dummies yet for the !CCF case.

Patch 5 depends on patch 4, since the arm,sp804 timer is also used on
platforms where CONFIG_OF or CONFIG_COMMON_CLK are not set.

This was compile-tested using:
  - multi_v7_defconfig (CCF, OF)
  - realview_defconfig (CCF, no OF)
  - versatile_defconfig (no CCF, no OF)
  - bcm2835_defconfig (CCF, OF)
  - axm55xx_defconfig (CCF, OF)
  - at91_dt_defconfig (CCF, OF)
  - omap2plus_defconfig (CCF, OF)

Thanks!

Geert Uytterhoeven (5):
  clk: at91: Use of_clk_get_parent_count() instead of open coding
  clk: st: Use of_clk_get_parent_count() instead of open coding
  clk: ti: Use of_clk_get_parent_count() instead of open coding
  [RFC] clk: Provide dummy of_clk_get_parent_count() for !OF/!CCF
  [RFC] ARM: timer-sp: Use of_clk_get_parent_count() instead of open
    coding

 arch/arm/common/timer-sp.c          |  3 ++-
 drivers/clk/at91/clk-main.c         |  2 +-
 drivers/clk/at91/clk-master.c       |  2 +-
 drivers/clk/at91/clk-programmable.c |  2 +-
 drivers/clk/at91/clk-slow.c         |  4 ++--
 drivers/clk/at91/clk-smd.c          |  2 +-
 drivers/clk/at91/clk-usb.c          |  2 +-
 drivers/clk/st/clk-flexgen.c        |  2 +-
 drivers/clk/st/clkgen-mux.c         |  2 +-
 drivers/clk/ti/clockdomain.c        |  2 +-
 include/linux/clk-provider.h        | 11 ++++++++++-
 11 files changed, 22 insertions(+), 12 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
