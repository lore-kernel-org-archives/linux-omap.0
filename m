From: hvaibhav@ti.com
Subject: [PATCH 0/6] Added DSS2/FBDEV support for OMAP3EVM & AM3517EVM
Date: Mon,  4 Jan 2010 20:04:13 +0530
Message-ID: <1262615657-22723-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38649 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122Ab0ADOeZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jan 2010 09:34:25 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

This patch added DSS2 + OMAPFB support for OMAP3EVM and AM3517/05 EVM along
with sharp LQ043T1DG01 panel support.

Vaibhav Hiremath (4):
  OMAP: DSS2: Fix compile warning
  OMAP: DSS2: Add Sharp LQ043T1DG01 panel drivers
  OMAP: Enable DSS2 for OMAP3EVM board
  OMAP: AM3517: Enable DSS2 for AM3517EVM board

 arch/arm/configs/am3517_evm_defconfig              |   52 ++++-
 arch/arm/configs/omap3_evm_defconfig               |   51 ++++-
 arch/arm/mach-omap2/board-am3517evm.c              |  144 ++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c               |  246 +++++++++++++++++++-
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  120 ++++++++++
 drivers/video/omap2/dss/core.c                     |    2 +
 8 files changed, 609 insertions(+), 13 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c

