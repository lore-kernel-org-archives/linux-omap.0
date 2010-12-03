From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] omap: Board specific muxing using hwmod
Date: Thu, 02 Dec 2010 16:45:14 -0800
Message-ID: <20101203004040.31687.9476.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:19725 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab0LCApX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 19:45:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some patches to allow us to pass the board specific mux data
to the platform level device init code, and then allow hwmod state
changes to do the pin muxing.

Dynamic remuxing is also supported as needed, the last patch in this
series sets up the board-*.c data for n8x0 to do uart3 rx pin remuxing
for the idle modes.

Regards,

Tony

---

Tony Lindgren (6):
      omap2+: Add omap_mux_get_by_name
      omap2+: Add support for hwmod specific muxing of devices
      omap2+: Allow hwmod state changes to mux pads based on the state changes
      omap2+: Add struct omap_device_board_data and allow omap_device_build initialize pads to mux
      omap2+: Use omap_device_board_data for platform level serial init
      omap2+: Initialize serial ports for wake-up events for n8x0


 arch/arm/mach-omap2/board-n8x0.c              |   66 ++++++++-
 arch/arm/mach-omap2/devices.c                 |    2 
 arch/arm/mach-omap2/gpio.c                    |    2 
 arch/arm/mach-omap2/mux.c                     |  188 ++++++++++++++++++++++---
 arch/arm/mach-omap2/mux.h                     |   39 +++++
 arch/arm/mach-omap2/omap_hwmod.c              |   14 +-
 arch/arm/mach-omap2/pm.c                      |    3 
 arch/arm/mach-omap2/serial.c                  |   29 +++-
 arch/arm/plat-omap/i2c.c                      |    4 -
 arch/arm/plat-omap/include/plat/omap_device.h |   19 ++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |   32 ++++
 arch/arm/plat-omap/include/plat/serial.h      |    5 +
 arch/arm/plat-omap/omap_device.c              |   14 ++
 13 files changed, 366 insertions(+), 51 deletions(-)

-- 
Signature
