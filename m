From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 0/8] arm: omap: add support for RM-680
Date: Thu,  9 Dec 2010 18:39:16 +0200
Message-ID: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:45526 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420Ab0LIQie (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 11:38:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

These patches add initial support for Nokia RM-680 board.

Patches 1-7 are just preparation and make board-rx51-sdram.c reusable
by renaming it to sdram-nokia.c etc.

Patch 8 adds a new board and requires updated mach-types from
http://www.arm.linux.org.uk/developer/machines/download.php in order
to compile.

These are based on top of linux-omap/master
(92f446c47b18827e61483787668b0bb5f7a033b6).

...

Aaro Koskinen (8):
  arm: omap: rename board-rx51-sdram.c to sdram-nokia.c
  arm: omap: add sdram-nokia.h
  arm: omap: sdram-nokia: prepare for new memory timings
  arm: omap: sdram-nokia: use array to list timings
  arm: omap: sdram-nokia: improve error handling
  arm: omap: sdram-nokia: delete redundant timing data
  arm: omap: sdram-nokia: add 97.6/195.2 MHz timing data
  arm: omap: add minimal support for RM-680

 arch/arm/mach-omap2/Kconfig                        |    6 +
 arch/arm/mach-omap2/Makefile                       |    5 +-
 arch/arm/mach-omap2/board-rm680.c                  |  187 ++++++++++++++++++++
 arch/arm/mach-omap2/board-rx51.c                   |    4 +-
 .../{board-rx51-sdram.c => sdram-nokia.c}          |  102 +++++++++---
 arch/arm/mach-omap2/sdram-nokia.h                  |   12 ++
 arch/arm/plat-omap/include/plat/uncompress.h       |    1 +
 7 files changed, 292 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-rm680.c
 rename arch/arm/mach-omap2/{board-rx51-sdram.c => sdram-nokia.c} (66%)
 create mode 100644 arch/arm/mach-omap2/sdram-nokia.h

