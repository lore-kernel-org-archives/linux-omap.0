From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/7] TWL4030 Changes
Date: Wed, 19 Mar 2008 15:42:28 +0200
Message-ID: <1205934155-24070-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-fb01.nokia.com ([192.100.122.235]:45157 "EHLO
	mgw-fb01.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757896AbYCSTmE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 15:42:04 -0400
Received: from mgw-mx09.nokia.com ([192.100.105.134])
	by mgw-fb01.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2JEFtII029026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 16:15:57 +0200
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2JDhFjn030621
	for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 08:46:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

The following patches implements some clean ups in twl4030 driver
also let twl4030-usb.c initialize struct otg_transceiver and
deliver it to omap2430.c.

musb clock is now comming from musb_platform_data as it should
and we avoid clk_get():ing twice (on omap2430.c and musb_core.c)

TODO:
	. twl4030-gpio.c: moves to gpiolib
	. twl4030-usb.c: irq is not waking up the phy and
		transceiver doesn't notify musb_core.c id pin
		state.

For now that's all,

Thanks everybody.

As usual, comments are welcome

diffstat:

arch/arm/mach-omap2/board-2430sdp-usb.c     |   27 +
arch/arm/mach-omap2/board-3430sdp-usb.c     |   29 +-
arch/arm/mach-omap2/board-3430sdp.c         |    2 +-
arch/arm/mach-omap2/board-sdp-hsmmc.c       |    2 +-
drivers/i2c/chips/Makefile                  |    8 +-
drivers/i2c/chips/twl4030-core.c            |  904 +++++++++++++++++++++++++++
drivers/i2c/chips/twl4030-gpio.c            |  836 +++++++++++++++++++++++++
drivers/i2c/chips/twl4030-poweroff.c        |   75 +++
drivers/i2c/chips/twl4030-usb.c             |  784 +++++++++++++++++++++++
drivers/i2c/chips/twl4030_core.c            |  900 --------------------------
drivers/i2c/chips/twl4030_gpio.c            |  836 -------------------------
drivers/i2c/chips/twl4030_poweroff.c        |   75 ---
drivers/i2c/chips/twl4030_usb.c             |  693 --------------------
drivers/input/keyboard/omap-twl4030keypad.c |    2 +-
drivers/rtc/rtc-twl4030.c                   |    4 +-
drivers/usb/musb/musb_core.h                |    4 +-
drivers/usb/musb/omap2430.c                 |   34 +-
drivers/usb/musb/omap2430.h                 |    8 -
include/asm-arm/arch-omap/twl4030-rtc.h     |  230 -------
include/asm-arm/arch-omap/twl4030.h         |  118 ----
include/linux/i2c/twl4030-rtc.h             |  230 +++++++
include/linux/i2c/twl4030.h                 |  118 ++++
22 files changed, 3028 insertions(+), 2891 deletions(-)

br,

	- Balbi

