From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap1 changes for v3.3 merge window
Date: Fri, 9 Dec 2011 13:28:05 -0800
Message-ID: <20111209212804.GA31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13052 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751843Ab1LIV2J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 16:28:09 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi And & Olof,

Please pull omap1 changes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap1

These changes are necessary to always reprogram the core clock
based on the SoC type so we can boot at the fastest supported rate.

Regards,

Tony


The following changes since commit 6560ee07dc946e94f7cc2cd8e3b5a5f5ee7340c1:
  Janusz Krzysztofik (1):
        ARM: OMAP1: recalculate loops per jiffy after dpll1 reprogram

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap1

Janusz Krzysztofik (3):
      ARM: OMAP1: Move dpll1 rates selection from config to runtime
      ARM: OMAP1: Update dpll1 default rate reprogramming method
      ARM: OMAP1: Always reprogram dpll1 rate at boot

Tony Lindgren (1):
      ARM: OMAP1: Set the omap1623 sram size to 16K

 arch/arm/configs/omap1_defconfig              |    1 -
 arch/arm/mach-omap1/Kconfig                   |   64 -------------------------
 arch/arm/mach-omap1/clock.c                   |   14 ++---
 arch/arm/mach-omap1/clock.h                   |    3 +
 arch/arm/mach-omap1/clock_data.c              |   19 ++++----
 arch/arm/mach-omap1/opp.h                     |    1 +
 arch/arm/mach-omap1/opp_data.c                |   63 +++++++++++-------------
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 arch/arm/plat-omap/sram.c                     |    9 ++--
 9 files changed, 55 insertions(+), 120 deletions(-)
