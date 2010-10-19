From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/4] Horray, more CBUS patches
Date: Tue, 19 Oct 2010 10:29:14 +0300
Message-ID: <1287473358-25634-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32974 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757835Ab0JSH3g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 03:29:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

I believe now everything is fine. Still, it's only
compile tested with n770_defconfig and omap2plus_defconfig.

Felipe Balbi (4):
  cbus: remove unneded includes
  cbus: retu: move platform_device to board file
  cbus: tahvo: move platform_device to board file
  cbus: tahvo-usb: move platform_device to board file

 arch/arm/mach-omap1/board-nokia770.c |   72 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-n8x0.c     |   73 ++++++++++++++++++++++++++++++++++
 drivers/cbus/cbus.c                  |    5 --
 drivers/cbus/retu.c                  |   69 +-------------------------------
 drivers/cbus/tahvo-usb.c             |   15 +------
 drivers/cbus/tahvo.c                 |   65 +-----------------------------
 6 files changed, 149 insertions(+), 150 deletions(-)

-- 
1.7.3.rc0.35.g8ac8c

