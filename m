From: Gregoire Gentil <gregoire@gentil.com>
Subject: [PATCH 0/5] AI TB: Always Innovating OMAP3-based Touch Book
Date: Sun, 15 Nov 2009 20:30:09 -0800
Message-ID: <1258345809.9089.15.camel@gregoire-laptop>
References: <1258228079.16065.17.camel@runt>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:52290 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbZKPEaG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Nov 2009 23:30:06 -0500
Received: by pwi3 with SMTP id 3so3039846pwi.21
        for <linux-omap@vger.kernel.org>; Sun, 15 Nov 2009 20:30:10 -0800 (PST)
In-Reply-To: <1258228079.16065.17.camel@runt>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>

This series adds support for the Always Innovating OMAP3-based Touch
Book,

Gr=C3=A9goire Gentil




Gregoire Gentil (5):
  Defconfig file of the Always Innovating OMAP3-based Touch Book.
  Board file of the Always Innovating OMAP3-based Touch Book.
  Driver for the Freescale MMA7455L accelerometer
  Driver for the Always Innovating Touch Book keyboard.
  Additional modifications for the Always Innovating OMAP3-based

arch/arm/configs/omap3_touchbook_defconfig | 2441
++++++++++++++++++++++++++++
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
drivers/input/misc/mma7455l.c              |  625 +++++++
drivers/video/omap/lcd_omap3touchbook.c    |  130 ++
include/linux/mma7455l.h                   |   11 +
sound/soc/omap/Kconfig                     |    8 +
sound/soc/omap/Makefile                    |    2 +
sound/soc/omap/omap3touchbook.c            |  211 +++
17 files changed, 4402 insertions(+), 1 deletions(-)
create mode 100644 arch/arm/configs/omap3_touchbook_defconfig
create mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c
create mode 100644 drivers/hid/hid-alwaysinnovating.c
create mode 100644 drivers/input/misc/mma7455l.c
create mode 100644 drivers/video/omap/lcd_omap3touchbook.c
create mode 100644 include/linux/mma7455l.h
create mode 100644 sound/soc/omap/omap3touchbook.c



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
