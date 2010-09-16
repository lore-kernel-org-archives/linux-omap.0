From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 0/5] Support for CompuLab CM-T3517 modules
Date: Thu, 16 Sep 2010 10:54:36 +0200
Message-ID: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:52544 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224Ab0IPIyv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 04:54:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

CompuLab CM-T3517 module is based on AM3517 (Sitara) SoC.
CM-T3517 supports on-board 256/128MB DDR2 DRAM, 512/128MB NAND flash,
WIFI-BlueTooth combo chip, USB HUB, AC97 Codec,
TouchScreen controller, RTC.

This patch series add a basic support for CM-T3517
and some of its peripheral devices.

Based on:
commit da22d713d1149f528a734a10ea264c91a804662a
Merge: 8f3ce99 8475b9e
Author: Tony Lindgren <tony@atomide.com>
Date:   Mon Sep 13 21:17:04 2010 -0700

    Linux-omap rebuilt: Updated to -rc4


Igor Grinberg (5):
  omap3: Introduce CompuLab CM-T3517 module.
  omap3: cm-t3517: add support for v3020 rtc.
  omap3: cm-t3517: add support for usb host.
  omap3: cm-t3517: add support for NAND flash
  omap3: cm-t3517: add support for TI HECC

 arch/arm/mach-omap2/Kconfig          |    7 +
 arch/arm/mach-omap2/Makefile         |    1 +
 arch/arm/mach-omap2/board-cm-t3517.c |  295 ++++++++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-cm-t3517.c

