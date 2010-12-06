From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/3] OMAP: I2C and UART device name cleanup
Date: Mon, 6 Dec 2010 11:41:30 +0100
Message-ID: <1291632093-18799-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33425 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732Ab0LFKln (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 05:41:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi All,

In order to enforce a little bit of consistency in the omap devices name,
the convention for omap devices name will be now omap_XXX. All the drivers
adapted to hwmod will be named like that during the on-going adaptations.

The I2C and UART drivers are already adapted to hwmod but with
the original names.

Rename i2c and uart using this convention:
i2c_omap -> omap_i2c
omap-hsuart -> omap_uart

Tested on OMAP4 ES2 on Panda / sdp4430. Some more validation will be needed on OMAP2 & 3.

This series is based on Kevin's pm-hwmod-i2c branch and is available here:
git://gitorious.org/omap-pm/linux.git for_2.6.38/device_name


Regards,
Benoit


Benoit Cousson (3):
  OMAP: clock: Change device name in clock nodes: i2c_omap -> omap_i2c
  OMAP: i2c: Change device name: i2c_omap -> omap_i2c
  OMAP: serial: Change device name: omap-hsuart -> omap_uart

 arch/arm/mach-omap1/clock_data.c              |    6 +++---
 arch/arm/mach-omap2/clock2420_data.c          |    8 ++++----
 arch/arm/mach-omap2/clock2430_data.c          |    8 ++++----
 arch/arm/mach-omap2/clock3xxx_data.c          |   12 ++++++------
 arch/arm/mach-omap2/clock44xx_data.c          |   16 ++++++++--------
 arch/arm/plat-omap/i2c.c                      |    2 +-
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +-
 drivers/i2c/busses/i2c-omap.c                 |    4 ++--
 8 files changed, 29 insertions(+), 29 deletions(-)

