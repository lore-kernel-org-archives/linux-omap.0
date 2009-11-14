From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 0/3] htcherald: Add board support for HTC Herald
Date: Sat, 14 Nov 2009 11:47:49 -0800
Message-ID: <1258228069.16065.14.camel@runt>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:58105 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbZKNTrt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Nov 2009 14:47:49 -0500
Received: by pwi3 with SMTP id 3so2592054pwi.21
        for <linux-omap@vger.kernel.org>; Sat, 14 Nov 2009 11:47:54 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

This series of patches introduces board support for the HTC
Herald (T-Mobile Wing, etc.) series of OMAP850-based smart
phones.

This is a reposting of this series refreshed to the latest
for-next branch and updated for comments made by Tony
Lindgren.

Cory Maccarrone (3):
  [OMAP] htcherald: Add board support and LCD for HTC Herald
  htcherald: Modify Makefiles and Kconfig for HTC Herald
  htcherald: Add default kernel configuration for Herald

 arch/arm/configs/htcherald_defconfig  | 1142
+++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/Kconfig           |    6 +
 arch/arm/mach-omap1/Makefile          |    1 +
 arch/arm/mach-omap1/board-htcherald.c |  247 +++++++
 drivers/video/omap/Makefile           |    1 +
 drivers/video/omap/lcd_htcherald.c    |  129 ++++
 6 files changed, 1526 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/htcherald_defconfig
 create mode 100644 arch/arm/mach-omap1/board-htcherald.c
 create mode 100644 drivers/video/omap/lcd_htcherald.c


