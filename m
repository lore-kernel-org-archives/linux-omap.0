From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/2] USB: twl4030-usb: fix isp1707 xceiver powering
Date: Mon, 21 Mar 2011 15:50:18 +0200
Message-ID: <1300715420-25602-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:64547 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581Ab1CUNv7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 09:51:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, tony@atomide.com, heikki.krogerus@nokia.com, jhnikula@gmail.com, ilkka.koskinen@nokia.com, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

These two patches introduce phy_power calls form board files
to twl4030-usb. This fixes a problem in Nokia N900, where the
ISP1707 serial tranceiver did not get disabled during phy
power down.

Based on patches used on n900 maemo kernel, mainly from Heikki
Krogerus. Comments&testing appreciated.

Basic test done on MeeGo + linux usb that the ISP powering
happens correctly. Also simple data transfer tests done with
backported patches on MeeGo n900 kernel.

Cross posting to linux-omap, but I propose that we'd push these
to linux-usb. Patches based on linux-usb master.

Kalle Jokiniemi (2):
  USB: twl4030-usb: do board specific phy_power up/down
  OMAP3: rx51: specify phy_power for usb tranceiver

 arch/arm/mach-omap2/board-rx51-peripherals.c |   32 ++++++++++++++++++++++++++
 drivers/usb/otg/twl4030-usb.c                |    9 ++++++-
 2 files changed, 40 insertions(+), 1 deletions(-)

