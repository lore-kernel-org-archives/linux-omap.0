From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v4 REPOST 0/5] Refactor common Kconfigs for easier maintenance
Date: Wed, 14 Dec 2011 11:39:36 +0000
Message-ID: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54476 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab1LNLjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 06:39:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, Anton Vorontsov <avorontsov@mvista.com>, Barry Song <baohua.song@csr.com>, Catalin Marinas <catalin.marinas@arm.com>, Colin Cross <ccross@google.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <rob.herring@calxeda.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Tony Lindgren <tony@atomide.com>, Will Deacon <will.deacon@arm.com>

Common Kconfig options which depend on a long list of board- and
SoC- specific Kconfigs can be cumbersome to maintain, leading to
annoying merge conflicts (although rather trivial ones).

This series factors out the dependencies of CACHE_L2X0 and SMP so
that the knowledge about when these can be enabled is moved to the
relevant board/SoC Kconfig files instead.  New
MIGHT_HAVE_CACHE_L2X0 and HAVE_SMP options are defined to mediate
the dependencies.

This series has been substantially reworked compared with the
previous post, and is now in two parts:

  * The first two patches simply refactor the way the Kconfig
    options for CACHE_L2X0 and SMP are implemented, without
    making any other changes.

  * The final three patches apply functional changes suggested by
    the contributors to this series, to make the config
    dependencies more correct for some specific boards.


Thanks to Rob Herring, Shawn Guo and Russell King for their
contributions to this series.  Thanks also to David Brown for
pointing out the lack of a comprehensive CC list.


I have briefly build-tested on some of the affected boards, but any
further reviews or Tested-Bys would be much appreciated.


Dave Martin (5):
  ARM: l2x0/pl310: Refactor Kconfig to be more maintainable
  ARM: SMP: Refactor Kconfig to be more maintainable
  omap4: Unconditionally require l2x0 L2 cache controller support
  highbank: Unconditionally require l2x0 L2 cache controller support
  imx6q: Remove unconditional dependency on l2x0 L2 cache support

 arch/arm/Kconfig               |   23 +++++++++++++++++++----
 arch/arm/mach-exynos/Kconfig   |    2 ++
 arch/arm/mach-imx/Kconfig      |    3 ++-
 arch/arm/mach-msm/Kconfig      |    1 +
 arch/arm/mach-omap2/Kconfig    |    2 ++
 arch/arm/mach-realview/Kconfig |    9 +++++++++
 arch/arm/mach-vexpress/Kconfig |    2 ++
 arch/arm/mm/Kconfig            |   15 ++++++++-------
 arch/arm/plat-mxc/Kconfig      |    1 +
 9 files changed, 46 insertions(+), 12 deletions(-)

-- 
1.7.4.1

