From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 0/2] OMAP: DSS2: Add new display panel
Date: Thu, 28 Oct 2010 16:43:00 +0200
Message-ID: <1288276982-17225-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46395 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab0J1OnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Oct 2010 10:43:15 -0400
Received: by wyf28 with SMTP id 28so2029886wyf.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Oct 2010 07:43:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, hvaibhav@ti.com, notasas@gmail.com, roger.quadros@nokia.com, mike@compulab.co.il, linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Hi,

Next patches adds support for the two new LCD panel display used
on IGEP boards.

 Powertip PH480272T LCD 4.3inch (480x242) display
 Seiko 70WVW1TZ3 LCD 7.0inch WVGA (800x480) display

Please, consider adding in next merge window.

Cheers,

Enric Balletbo i Serra (2):
  OMAP: DSS2: Add Powertip PH480272T display panel
  OMAP: DSS2: Add Seiko 70WVW1TZ3 display panel

 drivers/video/omap2/displays/Kconfig               |   14 ++
 drivers/video/omap2/displays/Makefile              |    2 +
 .../omap2/displays/panel-powertip-ph480272t.c      |  155 +++++++++++++++++++
 .../video/omap2/displays/panel-seiko-70wvw1tz3.c   |  157 ++++++++++++++++++++
 4 files changed, 328 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-powertip-ph480272t.c
 create mode 100644 drivers/video/omap2/displays/panel-seiko-70wvw1tz3.c

