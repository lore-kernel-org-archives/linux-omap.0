From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 0/4] ASOC: Add AM3517 EVM support in ASOC
Date: Fri, 30 Oct 2009 00:22:17 +0530
Message-ID: <1256842337-30334-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36022 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620AbZJ2Sw1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Oct 2009 14:52:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, tony@atomide.com, Anuj Aggarwal <anuj.aggarwal@ti.com>

This patch series add support for OMAP3517 / AM3517 EVM in ASOC.
It also enables the required drivers - I2C and McBSP, along with
Alsa SoC subsystem, in the default configuration for the EVM.

Anuj Aggarwal (4):
  Audio: Adding OMAP3517 / AM3517 EVM support in ASOC
  Audio: Modifying Kconfig/Makefile for AM3517 EVM
  Audio: Modifying board-evm file for audio codec
  Audio: Modifying the defconfig for OMAP3517 / AM3517 EVM

 arch/arm/configs/am3517_evm_defconfig |   78 ++++++++++++-
 arch/arm/mach-omap2/board-am3517evm.c |   21 ++++
 sound/soc/omap/Kconfig                |    9 ++
 sound/soc/omap/Makefile               |    2 +
 sound/soc/omap/am3517evm.c            |  202 +++++++++++++++++++++++++++++++++
 5 files changed, 309 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/omap/am3517evm.c

