From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/2] ARM: OMAP2420: Fix ethernet support
Date: Tue, 13 Nov 2012 16:02:18 -0600
Message-ID: <1352844140-11103-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38561 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158Ab2KMWC1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 17:02:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Fix ethernet support for OMAP2420 and remove legacy code for ethernet
configuration.

Jon Hunter (2):
  ARM: OMAP2420: Fix ethernet support for OMAP2420 H4
  ARM: OMAP: Remove debug-devices.c

 arch/arm/mach-omap2/board-h4.c      |   80 +++++++-----------------------
 arch/arm/mach-omap2/debug-devices.h |    9 ----
 arch/arm/plat-omap/Makefile         |    1 -
 arch/arm/plat-omap/debug-devices.c  |   93 -----------------------------------
 4 files changed, 19 insertions(+), 164 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/debug-devices.h
 delete mode 100644 arch/arm/plat-omap/debug-devices.c

-- 
1.7.9.5

