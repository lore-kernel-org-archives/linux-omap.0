From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 0/2] ARM: OMAP4: fix MMC failure due to regulator enable/disable ops
Date: Wed, 1 Jun 2011 16:45:21 +0530
Message-ID: <1306926923-3398-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58175 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161127Ab1FALRS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Jun 2011 07:17:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, cjb@laptop.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com, Balaji T K <balajitk@ti.com>

Balaji T K (2):
  ARM: OMAP4: MMC: increase delay for pbias
  ARM: OMAP4: MMC: no regulator off during probe for eMMC

 arch/arm/mach-omap2/board-4430sdp.c   |    1 +
 arch/arm/mach-omap2/hsmmc.c           |   16 +++++++++++++---
 arch/arm/mach-omap2/hsmmc.h           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    3 +++
 drivers/mmc/host/omap_hsmmc.c         |    3 +++
 5 files changed, 21 insertions(+), 3 deletions(-)

