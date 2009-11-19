From: Gregoire Gentil <gregoire@gentil.com>
Subject: [PATCH 0/8] AI TB: Always Innovating OMAP3-based Touch Book
Date: Thu, 19 Nov 2009 09:18:03 -0800
Message-ID: <1258651091-31727-1-git-send-email-gregoire@gentil.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:36031 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbZKSRSV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 12:18:21 -0500
Received: by fg-out-1718.google.com with SMTP id d23so2860846fga.1
        for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2009 09:18:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Gregoire Gentil <gregoire@gentil.com>, Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>


This series adds support for Always Innovating OMAP3-based Touch Book.

I also attach the patches as it seems that the last time, the indentation
was screwed up by the mailer.

Gregoire Gentil (8):
  defconfig file of Always Innovating OMAP3-based Touch Book
  Board file of Always Innovating OMAP3-based Touch Book
  Freescale MMA7455 accelerometer driver
  Driver for Always Innovating OMAP3-based Touch Book keyboard
  HID file for Always Innovating OMAP3-based Touch Book keyboard
  Audio driver of Always Innovating OMAP3-based Touch Book
  Video driver of Always Innovating OMAP3-based Touch Book
  Additional files for Always Innovating OMAP3-based Touch Book

 arch/arm/configs/omap3_touchbook_defconfig | 2441 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig                |    5 +
 arch/arm/mach-omap2/Makefile               |    2 +
 arch/arm/mach-omap2/board-omap3touchbook.c |  683 ++++++++
 drivers/hid/Kconfig                        |    7 +
 drivers/hid/Makefile                       |    1 +
 drivers/hid/hid-alwaysinnovating.c         |  262 +++
 drivers/hid/hid-core.c                     |    1 +
 drivers/hid/hid-ids.h                      |    3 +
 drivers/input/misc/Kconfig                 |    9 +
 drivers/input/misc/Makefile                |    2 +-
 drivers/input/misc/mma7455l.c              |  626 +++++++
 drivers/video/omap/lcd_omap3touchbook.c    |  130 ++
 include/linux/mma7455l.h                   |   11 +
 sound/soc/omap/Kconfig                     |    8 +
 sound/soc/omap/Makefile                    |    2 +
 sound/soc/omap/omap3touchbook.c            |  211 +++
 17 files changed, 4403 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/configs/omap3_touchbook_defconfig
 create mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c
 create mode 100644 drivers/hid/hid-alwaysinnovating.c
 create mode 100644 drivers/input/misc/mma7455l.c
 create mode 100644 drivers/video/omap/lcd_omap3touchbook.c
 create mode 100644 include/linux/mma7455l.h
 create mode 100644 sound/soc/omap/omap3touchbook.c

