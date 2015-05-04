From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Drop more omap3 legacy board-*.c files for v4.2
Date: Mon,  4 May 2015 13:01:54 -0700
Message-ID: <1430769717-4088-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ftx-008-i769.relay.mailchannels.net ([50.61.143.69]:57162 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750951AbbEDUCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2015 16:02:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi all,

It seems we're ready to drop these board-*.c files for v4.2.

Please respond if you still have issues so we can fix those
for the device tree based booting.

For dropping the remaining omap3 legacy boot support, we still
have the following board-*.c files:

BOARD			REASON NEEDED
board-ldp.c             Still used in RMKs boot test system
board-omap3logic.c      Getting a .dts file for v4.2
board-omap3pandora.c    Got a .dts file for v4.1
board-rx51-*.c          Needs /proc/atags support for user space

I'm hoping we can drop those for v4.3 merge window, then keep
the platform data around for one more merge window in case of
reverting needed, then drop the platform data too for v4.4
if no issues needing reverting are found.

Regards,

Tony


Tony Lindgren (3):
  ARM: OMAP2+: Remove legacy booting support for cm-t35
  ARM: OMAP2+: Remove legacy booting support for Overo
  ARM: OMAP2+: Remove legacy booting support for Beagleboards

 arch/arm/mach-omap2/Kconfig             |  22 -
 arch/arm/mach-omap2/Makefile            |   3 -
 arch/arm/mach-omap2/board-cm-t35.c      | 769 --------------------------------
 arch/arm/mach-omap2/board-omap3beagle.c | 595 ------------------------
 arch/arm/mach-omap2/board-overo.c       | 571 ------------------------
 5 files changed, 1960 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-cm-t35.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3beagle.c
 delete mode 100644 arch/arm/mach-omap2/board-overo.c

-- 
2.1.4

