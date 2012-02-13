From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 0/2] AM335X: SoC type detection & SRAM support
Date: Mon, 13 Feb 2012 11:44:18 +0530
Message-ID: <1329113658-7417-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37817 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166Ab2BMGbL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Feb 2012 01:31:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hvaibhav@ti.com, nsekhar@ti.com, Afzal Mohammed <afzal@ti.com>

Hi,

These changes does,
1. detect SoC type (i.e. GP or not)
2. add minimal SRAM support
 for AM335X devices

These are required to get AM335X boot to prompt (but not sufficient)

v2: Use OMAP naming conventions for subject

Regards
Afzal

Afzal Mohammed (1):
  ARM: OMAP2+: id: Add am33xx SoC type detection

Vaibhav Bedia (1):
  ARM: OMAP: sram: Add am33xx SRAM support (minimal)

 arch/arm/mach-omap2/control.h          |    5 +++++
 arch/arm/mach-omap2/id.c               |    2 ++
 arch/arm/plat-omap/include/plat/sram.h |    1 +
 arch/arm/plat-omap/sram.c              |   14 ++++++++++++--
 4 files changed, 20 insertions(+), 2 deletions(-)

