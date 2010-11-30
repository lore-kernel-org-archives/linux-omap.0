From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 0/3] OMAP: Introduce Backlight driver for Sharp LS037V7DW01 LCD panel
Date: Tue, 30 Nov 2010 20:07:37 +0800
Message-ID: <1291118860-10325-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:50655 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab0K3MHn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 07:07:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, rpurdie@rpsys.net

After instroducing generic DPI panel driver for OMAP DSS2 system, we need to
split out backlight driver from Sharp LS037V7DW01 panel driver before we move
to the generic DPI panel driver.

This patchset introcuded backlight driver and cleanup the old Sharp LS037V7DW01
panel driver related code.

It's built on mainline 2.6.37-rc4

Bryan Wu (3):
  Backlight: driver for Sharp LS037V7DW01 panel on OMAP machine
  OMAP: move Sharp LS LCD panel device to generic DPI panel driver and new backlight driver
  OMAP: DSS2: remove Sharp LS037V7DW01 panel driver

 arch/arm/mach-omap2/board-3430sdp.c                |   18 ++-
 arch/arm/mach-omap2/board-omap3evm.c               |   20 ++-
 drivers/video/backlight/Kconfig                    |   10 +
 drivers/video/backlight/Makefile                   |    1 +
 drivers/video/backlight/sharp_ls037v7dw01.c        |  144 ++++++++++++
 drivers/video/omap2/displays/Kconfig               |    7 -
 drivers/video/omap2/displays/Makefile              |    1 -
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |  232 --------------------
 8 files changed, 187 insertions(+), 246 deletions(-)
 create mode 100644 drivers/video/backlight/sharp_ls037v7dw01.c
 delete mode 100644 drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c

