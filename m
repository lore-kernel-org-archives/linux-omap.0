From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap hwmod changes for v3.3 merge window
Date: Mon, 19 Dec 2011 11:48:18 -0800
Message-ID: <20111219194818.GQ6464@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57287 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752364Ab1LSTsW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 14:48:22 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull omap hwmod changes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap hwmod

These changes are mostly needed for the USB *HCI support to
behave. These depend on the fixes-non-critical-part2 posted
earlier.

Regards,

Tony


The following changes since commit 30c95692f62a40170833e87f3cd50fcbfe87c1a2:
  Santosh Shilimkar (1):
        ARM: OMAP4: clock: Add CPU local timer clock node

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap hwmod

Benoit Cousson (1):
      ARM: OMAP: USB: EHCI and OHCI hwmod structures for OMAP4

Keshava Munegowda (1):
      ARM: OMAP: USB: EHCI and OHCI hwmod structures for OMAP3

Kyle Manna (1):
      ARM: OMAP: hwmod data: Add support for AM35xx UART4/ttyO3

Paul Walmsley (1):
      ARM: OMAP3: hwmod data: disable multiblock reads on MMC1/2 on OMAP34xx/35xx <= ES2.1

Shubhrajyoti D (1):
      ARM: OMAP3+: hwmod data: Add the default clockactivity for I2C

Tony Lindgren (1):
      Merge branch 'hwmod_data_devel_3.3' of git://git.pwsan.com/linux-2.6 into hwmod

 arch/arm/mach-omap2/clock3xxx_data.c       |   11 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  374 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  217 ++++++++++++++++-
 arch/arm/mach-omap2/prcm-common.h          |    2 +
 arch/arm/plat-omap/include/plat/irqs.h     |    2 +-
 arch/arm/plat-omap/include/plat/serial.h   |    1 +
 6 files changed, 594 insertions(+), 13 deletions(-)
