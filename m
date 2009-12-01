From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rfc/rft/patch 0/9] omap warning cleanup
Date: Tue,  1 Dec 2009 15:03:46 +0200
Message-ID: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22907 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbZLANFP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 08:05:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kalle Valo <kalle.valo@iki.fi>, Jean Pihet <jpihet@mvista.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

The following series removes a few compile warnings from
omap builds. It was compile tested with all omap defconfigs
for the ones who have the boards, a boot test would be
nice, although there aren't any functional changes.

Felipe Balbi (9):
  arm: omap: kill compile warning in irq.c
  arm: omap: remove unused variables
  arm: omap: zoom: use vmmc1 regulator supply
  arm: omap: io: kill compile warning
  arm: omap: kill compile warning on board-4430-sdp.c
  arm: omap: gpio: kill compile warning in gpio.c
  arm: omap: innovator: kill compile warning on board-innovator.c
  arm: omap: perseus: kill compile warning on board-perseus2.c
  arm: omap: mailbox: kill compile warning in mailbox.c

 arch/arm/mach-omap2/board-4430sdp.c          |    4 ----
 arch/arm/mach-omap2/board-zoom-peripherals.c |    1 +
 arch/arm/mach-omap2/io.c                     |    2 ++
 arch/arm/mach-omap2/irq.c                    |    2 ++
 arch/arm/mach-omap2/mailbox.c                |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430.h        |    2 --
 arch/arm/plat-omap/gpio.c                    |    3 +++
 arch/arm/plat-omap/include/plat/fpga.h       |    4 ++--
 8 files changed, 11 insertions(+), 9 deletions(-)

