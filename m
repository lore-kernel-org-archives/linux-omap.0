From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Remove few inactive omap3 legacy board-*.c files
Date: Mon, 16 Mar 2015 17:25:08 -0700
Message-ID: <1426551911-17356-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nov-007-i575.relay.mailchannels.net ([46.232.183.129]:57344
	"EHLO relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751989AbbCQAab (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 20:30:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi all,

I'm hoping to get the status of the remaining omap3 legacy board-*.c
files into a known state.

And I figured the best way to do that is by removing few of them that
I think are all inactive. If you are using these, please yell now!

The reason for trying to remove them now is that I don't want any
suprises with missing .dts files later on when we remove the
remaining omap3 legacy booting support.

For now, we can just simply revert these patches as needed until we
have the related .dts files done. After we've dropped the remaining
omap3 legacy booting support in a few merge cycles, reverting will
be much harder.

Regards,

Tony


Tony Lindgren (3):
  ARM: OMAP3: Remove legacy support for EMA-Tech Stalker board
  ARM: OMAP3: Remove legacy support for devkit8000
  ARM: OMAP2+: Remove legacy support for omap3 TouchBook

 arch/arm/mach-omap2/Kconfig                |  18 -
 arch/arm/mach-omap2/Makefile               |   4 -
 arch/arm/mach-omap2/board-devkit8000.c     | 654 -----------------------------
 arch/arm/mach-omap2/board-omap3stalker.c   | 433 -------------------
 arch/arm/mach-omap2/board-omap3touchbook.c | 395 -----------------
 5 files changed, 1504 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-devkit8000.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3stalker.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c

-- 
2.1.4

