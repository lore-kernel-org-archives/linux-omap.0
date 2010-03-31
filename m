From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC/PATCH 0/4] teach gpiolib about gpio debouncing
Date: Wed, 31 Mar 2010 15:27:11 +0300
Message-ID: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31696 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932764Ab0CaM2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 08:28:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

Hi all,

the following *UNTESTED* patches teach gpiolib about
gpio_debouncing. If you have the board, please give it
a shot and report to this mailing.

Dave, do you have any comments regarding these ??

Felipe Balbi (4):
  gpiolib: introduce set_debounce method
  arm: omap: gpio: implement set_debounce method
  arm: omap: switch over to gpio_set_debounce
  arm: omap: remove the unused omap_gpio_set_debounce methods

 arch/arm/mach-omap2/board-3430sdp.c        |    4 +-
 arch/arm/mach-omap2/board-ldp.c            |    3 +-
 arch/arm/mach-omap2/board-omap3evm.c       |    4 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |    4 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    3 +-
 arch/arm/plat-omap/gpio.c                  |   85 ++++++++++------------------
 drivers/gpio/gpiolib.c                     |   39 +++++++++++++
 include/asm-generic/gpio.h                 |    5 ++
 include/linux/gpio.h                       |    5 ++
 9 files changed, 84 insertions(+), 68 deletions(-)

