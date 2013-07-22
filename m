From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/4] OMAP2+: Fix boot hang with earlycon enabled
Date: Mon, 22 Jul 2013 15:31:13 +0530
Message-ID: <1374487277-26099-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59376 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755285Ab3GVKCC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Jul 2013 06:02:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: paul@pwsan.com, balbi@ti.com, mpfj-list@newflow.co.uk, vaibhav.bedia@ti.com, khilman@linaro.org, sourav.poddar@ti.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, grygorii.strashko@ti.com, Rajendra Nayak <rnayak@ti.com>

Boot on all OMAP2+ devices is broken with earlycon enabled
as discussed here [1]

There were 2 issues which were rootcaused
1. Issue caused due to hwmod doing a reset of console uart while
earlycon was using it (seen only on am335x devices)

2. omap serial causing a NULL context restore with context loss
count missing.

This patch set attempts to fix both the issues and is one of the
different approaches discussed [1] on how to fix these issues.

Boot tested on omap4 panda es with and without earlycon (DT boot)
Boot tested on am335x bone black with and without earlycon (DT boot)
Boot tested on OMAP3 beagle XM with and without earlycon (non-DT boot)

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg91662.html

Grygorii Strashko (1):
  serial: omap: enable PM runtime only when its fully configured

Rajendra Nayak (3):
  ARM: OMAP2+: hwmod: Fix a crash in _setup_reset() with DEBUG_LL
  ARM: OMAP2+: Avoid idling memory controllers with no drivers
  ARM: OMAP2+: Sync hwmod state with the pm_runtime and omap_device
    state

 arch/arm/mach-omap2/omap_device.c                  |   18 ++++++++
 arch/arm/mach-omap2/omap_hwmod.h                   |   48 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    6 +--
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    9 ++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    5 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |    3 +-
 arch/arm/mach-omap2/serial.c                       |   11 -----
 drivers/tty/serial/omap-serial.c                   |    3 +-
 9 files changed, 81 insertions(+), 24 deletions(-)

-- 
1.7.9.5

