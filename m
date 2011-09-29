From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/2] arm: omap4: hsmmc: pbias fixes
Date: Thu, 29 Sep 2011 20:14:58 +0530
Message-ID: <1317307500-5514-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44722 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349Ab1I2Ooe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Sep 2011 10:44:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, kishore.kadiyala@ti.com, vishp@ti.com, Balaji T K <balajitk@ti.com>

MMC1 pbias and speed control fix for SDMMC1 extended I/O cell

Balaji T K (2):
  arm: omap4: hsmmc: Fix Pbias configuration on regulator OFF
  arm: omap4: hsmmc: configure SDMMC1_DR0 properly

 arch/arm/mach-omap2/hsmmc.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

