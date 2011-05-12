From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 0/4] omap: merge IGEP v2 and v3
Date: Fri, 13 May 2011 00:31:00 +0300
Message-ID: <cover.1305235542.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:50619
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932764Ab1ELVbN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 17:31:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony.Lindgren.tony@atomide.com
Cc: =?UTF-8?q?Enric=20Balletb=F2=20i=20Serra?= <eballetbo@gmail.com>, linux-omap@vger.kernel.org, linux-arm@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

Hi Tony,

This is yet another attempt to reduce code duplication in the board files :)
Only build tested, since I don't have the hardware, so I belive an Ack from
Enric is required.

Mike Rapoport (4):
  omap: igep0020: name refactoring for future merge with IGEP3
  omap: igep0020: minor refactoring
  omap: igep0020: add support for IGEP3
  omap: drop board-igep0030.c

 arch/arm/mach-omap2/Kconfig          |    1 +
 arch/arm/mach-omap2/Makefile         |    2 -
 arch/arm/mach-omap2/board-igep0020.c |  286 +++++++++++++---------
 arch/arm/mach-omap2/board-igep0030.c |  438 ----------------------------------
 4 files changed, 174 insertions(+), 553 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-igep0030.c

-- 
1.7.3.1

