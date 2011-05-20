From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/2] GPIO: move OMAP driver to drivers/gpio
Date: Fri, 20 May 2011 15:41:06 +0200
Message-ID: <1305898868-9188-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:43308 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932098Ab1ETNlP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 09:41:15 -0400
Received: by mail-wy0-f169.google.com with SMTP id 19so3390677wyf.0
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 06:41:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

Move OMAP GPIO driver to drivers/gpio, but leave OMAP-specific
register definitions in <plat/gpio.h>, where they will be used by
SoC-specific code and passed in via platform_data (in forthcoming
series.)

After the move, I have another series that cleans up this
driver, removing all the SoC-specific checks, #ifdefs, etc. and passes
SoC-specific register offsets in from platform_data.

Kevin Hilman (2):
  GPIO: OMAP: move register offset defines into <plat/gpio.h>
  GPIO: OMAP: move to drivers/gpio

 arch/arm/plat-omap/Makefile            |    2 +-
 arch/arm/plat-omap/gpio.c              | 2128 --------------------------------
 arch/arm/plat-omap/include/plat/gpio.h |  103 ++
 drivers/gpio/Makefile                  |    1 +
 drivers/gpio/gpio_omap.c               | 2023 ++++++++++++++++++++++++++++++
 5 files changed, 2128 insertions(+), 2129 deletions(-)
 delete mode 100644 arch/arm/plat-omap/gpio.c
 create mode 100644 drivers/gpio/gpio_omap.c

-- 
1.7.3.4

