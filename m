From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC/PATCHv2 0/4] teach gpiolib about debouncing
Date: Wed, 31 Mar 2010 18:35:08 +0300
Message-ID: <1270049712-28272-1-git-send-email-felipe.balbi@nokia.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60995 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756497Ab0CaPfw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 11:35:52 -0400
In-Reply-To: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

Changes since v1:
	- add a comment to gpio_set_debounce() describing the
	  arguments

Hi all,

the following patches teach gpiolib about debouncing
time and implement support for OMAP.

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
 arch/arm/plat-omap/gpio.c                  |  103 +++++++++++++---------------
 drivers/gpio/gpiolib.c                     |   43 ++++++++++++
 include/asm-generic/gpio.h                 |    5 ++
 include/linux/gpio.h                       |    5 ++
 9 files changed, 108 insertions(+), 66 deletions(-)

