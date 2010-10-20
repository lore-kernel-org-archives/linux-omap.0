From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/2] Combine zoom board-files
Date: Wed, 20 Oct 2010 09:25:10 +0300
Message-ID: <1287555912-16058-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59533 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515Ab0JTGZe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Oct 2010 02:25:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <balbi@ti.com>

Those boards are so similar that they don't
deserve separate board files.

Felipe Balbi (2):
  arm: omap: combine zoom2 and zoom3 board-files
  arm: omap: zoom: substitute gpio number with symbolic name

 arch/arm/mach-omap2/Makefile                       |    4 +-
 .../arm/mach-omap2/{board-zoom2.c => board-zoom.c} |   54 +++++++--
 arch/arm/mach-omap2/board-zoom3.c                  |  133 --------------------
 3 files changed, 47 insertions(+), 144 deletions(-)
 rename arch/arm/mach-omap2/{board-zoom2.c => board-zoom.c} (72%)
 delete mode 100644 arch/arm/mach-omap2/board-zoom3.c

-- 
1.7.3.1.120.g38a18

