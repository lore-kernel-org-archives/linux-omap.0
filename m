From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for -rc series and merge window
Date: Mon, 3 Oct 2011 11:52:37 -0700
Message-ID: <20111003185237.GI6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21882 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564Ab1JCSwo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 14:52:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd,

Please pull omap fixes from:

git://github.com/tmlind/linux.git fixes

Out of these the first three commits would be nice to get
into the -rc series with the first two causing boot issues
and the musb fixing an ugly warning.

Note however the recent commit message update on the third patch.
I added Bjarne's SOB to the third patch because of the earlier
reference.

The last two are mostly cosmetic and not so urgent.

Regards,

Tony


The following changes since commit a102a9ece5489e1718cd7543aa079082450ac3a2:
  Linus Torvalds (1):
        Linux 3.1-rc8

are available in the git repository at:

  git://github.com/tmlind/linux.git fixes

Axel Lin (1):
      ARM: OMAP: musb: Remove a redundant omap4430_phy_init call in usb_musb_init

Bjarne Steinsbo (1):
      ARM: OMAP4: Keyboard: Fix section mismatch in the board file

Bryan Buckley (1):
      ARM: OMAP4: MMC: fix power and audio issue, decouple USBC1 from MMC1

Tapani Utriainen (1):
      ARM: OMAP: irq: loop counter fix in omap_init_irq()

Tony Lindgren (1):
      ARM: OMAP: Fix i2c init for twl4030

 arch/arm/mach-omap2/board-2430sdp.c |    3 ++-
 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 arch/arm/mach-omap2/hsmmc.c         |   12 ++++--------
 arch/arm/mach-omap2/irq.c           |    4 ++--
 arch/arm/mach-omap2/usb-musb.c      |    3 ---
 5 files changed, 9 insertions(+), 15 deletions(-)
