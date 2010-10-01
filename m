From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/4] CBUS patches
Date: Fri,  1 Oct 2010 10:47:14 +0300
Message-ID: <1285919238-26555-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57791 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838Ab0JAHrT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 03:47:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

removed a few unneeded includes and moved platform_device
registration to board file.

ps: as usual, compile tested only :-p No working n810 available

Felipe Balbi (4):
  cbus: remove unneded includes
  cbus: retu: move platform_device to board file
  cbus: tahvo: move platform_device to board file
  cbus: tahvo-usb: move platform_device to board file

 arch/arm/mach-omap2/board-n8x0.c |   96 ++++++++++++++++++++++++++++++++++++++
 drivers/cbus/cbus.c              |    5 --
 drivers/cbus/retu.c              |   69 +---------------------------
 drivers/cbus/tahvo-usb.c         |   13 -----
 drivers/cbus/tahvo.c             |   65 +-------------------------
 5 files changed, 98 insertions(+), 150 deletions(-)

-- 
1.7.3.rc0.35.g8ac8c

