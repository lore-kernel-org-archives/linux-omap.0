From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for linux next for v3.7 merge window
Date: Mon, 17 Sep 2012 19:28:57 -0700
Message-ID: <20120918022856.GN11762@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:59348 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932106Ab2IRC3B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 22:29:01 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Here is the fix for the twl-core compile on non-omap
platforms and few other fixes.

This will probably cause a minor merge conflicts with
the led changes merged in the arm-soc next/drivers branch
as both linux/leds.h and linux/platform_data/gpio-omap.h
now need to be included.

Regards,

Tony


The following changes since commit 68cb700c59fae6cd539c9dc1e9f2584f671935a0:

  ARM: OMAP1: Move SoC specific headers from plat to mach for omap1 (2012-09-12 18:06:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/cleanup-fixes-for-v3.7

for you to fetch changes up to de6ca33a96a6bf61fcb91d3d399703e19ead9d1e:

  ARM: OMAP1: Include gpio-omap.h for board-h2 and board-h3 (2012-09-17 16:28:03 -0700)

----------------------------------------------------------------
These fixes are needed to fix non-omap build breakage for
twl-core driver and to fix omap1_defconfig compile when
led driver changes and omap sparse IRQ changes are merged
together. Also fix warnings for omaps not using pinctrl
framework yet.

----------------------------------------------------------------
Matt Porter (1):
      ARM: OMAP2+: Enable pinctrl dummy states

Tony Lindgren (2):
      mfd: Fix compile for twl-core.c by removing cpu_is_omap usage
      ARM: OMAP1: Include gpio-omap.h for board-h2 and board-h3

 arch/arm/mach-omap1/board-h2.c       |    1 +
 arch/arm/mach-omap1/board-h3.c       |    1 +
 arch/arm/mach-omap2/clock2430_data.c |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c |    1 +
 arch/arm/mach-omap2/devices.c        |    5 +++
 drivers/mfd/twl-core.c               |   56 ++++++++++++++++++----------------
 6 files changed, 39 insertions(+), 26 deletions(-)
