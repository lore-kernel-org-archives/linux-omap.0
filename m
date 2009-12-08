From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: [PATCH 0/2] OMAP: use physmap-flash
Date: Tue, 8 Dec 2009 20:21:11 +0100
Message-ID: <20091208192111.GA32268@localhost.localdomain>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:33387 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965486AbZLHSVG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Dec 2009 13:21:06 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mtd@lists.infradead.org

There is nothing special on omapflash driver, so it can be replaced with
physmap-flash. First patch in serie does exactly this and second one removes
drivers/mtd/maps/omap_nor.c and associated Kconfig option. I'd like to have
either ack or merge into mtd git tree by mtd maintainers for that second part.

 arch/arm/mach-omap1/flash.c                          |   33 ++
 arch/arm/plat-omap/include/plat/flash.h              |   16 +
 arch/arm/mach-omap1/Makefile                         |    2 
 arch/arm/mach-omap1/board-fsample.c                  |    9 
 arch/arm/mach-omap1/board-h2.c                       |    9 
 arch/arm/mach-omap1/board-h3.c                       |    9 
 arch/arm/mach-omap1/board-innovator.c                |    9 
 arch/arm/mach-omap1/board-osk.c                      |    9 
 arch/arm/mach-omap1/board-palmte.c                   |    9 
 arch/arm/mach-omap1/board-palmtt.c                   |    9 
 arch/arm/mach-omap1/board-palmz71.c                  |   10 
 arch/arm/mach-omap1/board-perseus2.c                 |    9 
 arch/arm/mach-omap1/board-sx1.c                      |   11 
 arch/arm/mach-omap1/board-voiceblue.c                |    9 
 arch/arm/mach-omap2/board-2430sdp.c                  |    7 
 arch/arm/mach-omap2/board-h4.c                       |    7 
 drivers/mtd/maps/Kconfig                             |    9 
 drivers/mtd/maps/Makefile                            |    1 
 drivers/mtd/maps/omap_nor.c                          |  188 -----------------
 19 files changed, 112 insertions(+), 253 deletions(-)
