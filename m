From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rfc/rft/patch-v2.6.32-omap1+ 0/2] misc patches
Date: Wed, 16 Dec 2009 23:52:33 +0200
Message-ID: <1261000355-2174-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63930 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbZLPVxi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 16:53:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <kjh@hilman.org>, Felipe Balbi <felipe.balbi@nokia.com>

The first patch adds omap_udc's clocks to clkdev structures
on the clock*_data.c files, then we will be able to remove
the cpu conditional code when clk_getting.

The second simply adds __initdata to all omap_board_config_kernel
which didn't have the __initdata mark yet, every build was
complaining about section mismatches. I'm not sure, though
whether the lcd drivers can cope with this, the best way
would be to move that to platform_data ASAP and get rid
of the last OMAP_TAG.

Felipe Balbi (2):
  arm: omap: clock: add omap_udc to clkdev
  arm: omap: add missing __initdata to omap_board_config_kernel

 arch/arm/mach-omap1/board-ams-delta.c |    2 +-
 arch/arm/mach-omap1/board-fsample.c   |    2 +-
 arch/arm/mach-omap1/board-innovator.c |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c |    2 +-
 arch/arm/mach-omap1/clock_data.c      |   10 +++++-----
 arch/arm/mach-omap2/board-2430sdp.c   |    2 +-
 arch/arm/mach-omap2/board-apollon.c   |    2 +-
 arch/arm/mach-omap2/board-generic.c   |    2 +-
 arch/arm/mach-omap2/board-h4.c        |    2 +-
 arch/arm/mach-omap2/board-rx51.c      |    2 +-
 arch/arm/mach-omap2/clock2xxx_data.c  |    4 ++--
 11 files changed, 16 insertions(+), 16 deletions(-)

