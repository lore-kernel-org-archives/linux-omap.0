From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 0/4] Fix 104MHz support for OMAP OneNAND
Date: Mon,  7 Feb 2011 10:46:57 +0200
Message-ID: <1297068421-14430-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:36796 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031Ab1BGIrI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Feb 2011 03:47:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd Mailing List <linux-mtd@lists.infradead.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>

Hi

Adrian Hunter (3):
      OMAP: OneNAND: fix 104MHz support
      OMAP: OneNAND: determine frequency in one place
      OMAP: OneNAND: let boards determine OneNAND frequency

Roman Tereshonkov (1):
      mtd: OneNAND: OMAP2: increase multiblock erase verify timeout

 arch/arm/mach-omap2/gpmc-onenand.c        |  113 +++++++++++++++++++++--------
 arch/arm/plat-omap/include/plat/onenand.h |   10 +++-
 drivers/mtd/onenand/omap2.c               |   36 ++-------
 include/linux/mtd/onenand_regs.h          |    1 +
 4 files changed, 100 insertions(+), 60 deletions(-)
 
Regards
Adrian

