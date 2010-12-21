From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 0/2] Add 104MHz support for OMAP OneNAND
Date: Tue, 21 Dec 2010 21:44:33 +0200
Message-ID: <20101221194433.3127.74744.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:27356 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab0LUTo5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 14:44:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-mtd Mailing List <linux-mtd@lists.infradead.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Adrian Hunter <adrian.hunter@nokia.com>

Hi

Here is OMAP2/3: OneNAND: add 104MHz support.

Adrian Hunter (2):
      OMAP2/3: GPMC: put sync_clk value in picoseconds instead of nanoseconds
      OMAP2/3: OneNAND: add 104MHz support

 arch/arm/mach-omap2/gpmc-nand.c        |    2 +-
 arch/arm/mach-omap2/gpmc-onenand.c     |   19 ++++++++++++++-----
 arch/arm/mach-omap2/gpmc.c             |   12 +++++++++++-
 arch/arm/mach-omap2/usb-tusb6010.c     |    4 ++--
 arch/arm/plat-omap/include/plat/gpmc.h |    9 +++++----
 drivers/mtd/onenand/omap2.c            |    3 +++
 6 files changed, 36 insertions(+), 13 deletions(-)
 
Regards
Adrian

