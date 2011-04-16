From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 0/2] OMAP: convert boards that use SMSC911x to use gpmc-smsc911x
Date: Sun, 17 Apr 2011 01:29:28 +0300
Message-ID: <cover.1302992702.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:49999
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759340Ab1DPXAe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Apr 2011 19:00:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

There are several OMAP boards that use SMSC911x Ethernet controller. Convert them all to use gpmc-smsc911x for device registration.

Mike Rapoport (2):
  OMAP: gpmc-smsc911x: always set irq flags to IORESOURCE_IRQ_LOWLEVEL
  OMAP: convert boards that use SMSC911x to use gpmc-smsc911x

 arch/arm/mach-omap2/board-cm-t35.c          |   84 +++------------------
 arch/arm/mach-omap2/board-igep0020.c        |   53 ++-----------
 arch/arm/mach-omap2/board-ldp.c             |   65 ++--------------
 arch/arm/mach-omap2/board-omap3evm.c        |   71 +++---------------
 arch/arm/mach-omap2/board-omap3logic.c      |    1 -
 arch/arm/mach-omap2/board-omap3stalker.c    |   48 ++----------
 arch/arm/mach-omap2/board-overo.c           |  108 ++++-----------------------
 arch/arm/mach-omap2/board-zoom-debugboard.c |   56 ++------------
 arch/arm/mach-omap2/gpmc-smsc911x.c         |    7 +-
 9 files changed, 70 insertions(+), 423 deletions(-)

-- 
1.7.3.1

