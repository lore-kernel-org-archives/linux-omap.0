From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 0/2] Minor DMA fixes
Date: Tue, 30 Nov 2010 15:23:41 +0200
Message-ID: <20101130132341.13286.25157.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:30195 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab0K3NYB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 08:24:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <Santosh.shilimkar@ti.com>, Manjunatha GK <manjugk@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

Hi

Adrian Hunter (2):
      OMAP: DMA: prevent races while setting M idle mode to nostandby
      OMAP: DMA: clear interrupt status correctly

 arch/arm/plat-omap/dma.c |   66 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 47 insertions(+), 19 deletions(-)
 
Regards
Adrian

