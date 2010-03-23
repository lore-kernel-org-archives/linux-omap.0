From: Roger Quadros <roger.quadros@nokia.com>
Subject: [PATCH 0/5] OMAP: RX51: Add LCD Panel Support for N900
Date: Tue, 23 Mar 2010 11:56:26 +0200
Message-ID: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18669 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486Ab0CWJ5V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 05:57:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: Tomi.Valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

These patches get the N900 LCD panel working.
Apply's cleanly on 2.6.34-rc2

Pre-requisites:
https://patchwork.kernel.org/patch/86318/
https://patchwork.kernel.org/patch/86319/
https://patchwork.kernel.org/patch/86320/

---
Roger Quadros (5):
  OMAP: RX51: Add LCD Panel support
  OMAP: RX51: Add "vdds_sdi" supply voltage for SDI
  OMAP: RX51: Add Touch Controller in SPI board info
  OMAP: DSS2: Add ACX565AKM Panel Driver
  OMAP: RX51: Add LCD Panel and framebuffer console to defconfig

 arch/arm/configs/rx51_defconfig                |   37 ++-
 arch/arm/mach-omap2/Makefile                   |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c   |   43 ++
 arch/arm/mach-omap2/board-rx51-video.c         |   95 ++++
 drivers/video/omap2/displays/Kconfig           |    5 +
 drivers/video/omap2/displays/Makefile          |    1 +
 drivers/video/omap2/displays/panel-acx565akm.c |  551 ++++++++++++++++++++++++
 7 files changed, 732 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-rx51-video.c
 create mode 100644 drivers/video/omap2/displays/panel-acx565akm.c

