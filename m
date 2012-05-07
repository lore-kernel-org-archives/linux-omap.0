From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.4-rc6
Date: Mon, 7 May 2012 15:36:33 -0700
Message-ID: <20120507223632.GP5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:43446 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340Ab2EGWgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 18:36:37 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:

  Linux 3.4-rc5 (2012-04-29 15:19:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-for-v3.4-rc6

for you to fetch changes up to 4d975027cc327d4486bb74b6908e874f2fee8c47:

  ARM: OMAP: igep0020: Specify the VPLL2 regulator unconditionally (2012-05-04 12:45:21 -0700)

----------------------------------------------------------------
Few more regression fixes that are mostly board specific

----------------------------------------------------------------
Archit Taneja (1):
      ARM: OMAP: Revert "ARM: OMAP: ctrl: Fix CONTROL_DSIPHY register fields"

Enrico Butera (1):
      ARM: OMAP: igep0020: fix smsc911x dummy regulator id

Janusz Krzysztofik (1):
      ARM: OMAP1: Amstrad Delta: Fix wrong IRQ base in FIQ handler

Laurent Pinchart (1):
      ARM: OMAP: igep0020: Specify the VPLL2 regulator unconditionally

 arch/arm/mach-omap1/ams-delta-fiq.c                |    2 +-
 arch/arm/mach-omap2/board-igep0020.c               |   12 ++++++------
 .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)
