From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/2] combine zoom board-files
Date: Mon,  8 Nov 2010 08:56:13 +0200
Message-ID: <1289199375-9001-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59288 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab0KHGzT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 01:55:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <balbi@ti.com>

Those boards are so similar they don't deserve
separate board files.

Felipe Balbi (2):
  arm: omap: combine zoom2 and zoom3 board-files
  arm: omap: zoom: substitute gpio number with symbolic name

 arch/arm/mach-omap2/Makefile                       |    4 +-
 .../arm/mach-omap2/{board-zoom3.c => board-zoom.c} |  104 ++++++++++-------
 arch/arm/mach-omap2/board-zoom2.c                  |  117 --------------------
 3 files changed, 64 insertions(+), 161 deletions(-)
 rename arch/arm/mach-omap2/{board-zoom3.c => board-zoom.c} (75%)
 delete mode 100644 arch/arm/mach-omap2/board-zoom2.c

-- 
1.7.3.2.146.gca209

