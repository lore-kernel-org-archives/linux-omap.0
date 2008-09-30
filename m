From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/23] twl4030 patches (v4)
Date: Tue, 30 Sep 2008 16:05:11 +0300
Message-ID: <20080930130511.GB15828@atomide.com>
References: <1222769160-31615-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50447 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbYI3NCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 09:02:19 -0400
Content-Disposition: inline
In-Reply-To: <1222769160-31615-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>

* Felipe Balbi <felipe.balbi@nokia.com> [080930 13:34]:
> In this version there are irq fixes from David Brownell.
> 
> David Brownell (11):
>   twl4030 gpio platform data
>   twl4030 uses gpiolib
>   minor twl4030-core cleanups
>   provide detailed diagnostics in add_children()
>   move twl4030-gpio to drivers/gpio
>   minor irq-related cleanups
>   Move I2C driver model init earlier in the boot sequence
>   twl4030-gpio irq_chip.set_type
>   twl4030-gpio: remove legacy irq triggering calls and user
>   twl4030-gpio: irq and other cleanup
>   twl4030-core: portability updates
> 
> Felipe Balbi (11):
>   twl4030: fix potential null pointer dereference
>   i2c: clean add_children a bit
>   i2c: move twl4030_keypad to new style registration
>   i2c: move twl4030-usb to platform_device
>   i2c: twl4030-usb: add 'vbus' sysfs file
>   i2c: move twl4030-madc to new registration style
>   i2c: added a few missing gotos to add_children()
>   i2c: switch twl4030-usb to use a resource for irq
>   i2c: minor cleanups to twl4030-pwrbutton.c
>   twl4030: minor cleanups to twl4030_bci_battery.c
>   twl4030-bci: move to new style registration method
> 
> Jagadeesh Bhaskar Pakaravoor (1):
>   twl4030-gpio: Remove default pullup enable/disable of GPIO

Let's plan on applying these tomorrow unless there are more comments.

Tony


> 
>  arch/arm/mach-omap2/Makefile                |    4 +-
>  arch/arm/mach-omap2/bci.c                   |   57 ----
>  arch/arm/mach-omap2/board-2430sdp.c         |   32 ++-
>  arch/arm/mach-omap2/board-3430sdp.c         |   49 +++-
>  arch/arm/mach-omap2/board-ldp.c             |   37 +++-
>  arch/arm/mach-omap2/board-omap2evm.c        |   33 ++-
>  arch/arm/mach-omap2/board-omap3beagle.c     |   19 ++
>  arch/arm/mach-omap2/board-omap3evm.c        |   85 +++---
>  arch/arm/mach-omap2/board-overo.c           |   11 +
>  arch/arm/mach-omap2/hsmmc.c                 |    5 -
>  arch/arm/plat-omap/include/mach/bci.h       |   17 -
>  arch/arm/plat-omap/include/mach/irqs.h      |    2 +-
>  drivers/gpio/Kconfig                        |    7 +
>  drivers/gpio/Makefile                       |    1 +
>  drivers/{i2c/chips => gpio}/twl4030-gpio.c  |  418 +++++++++++++++++++--------
>  drivers/i2c/chips/Kconfig                   |   20 --
>  drivers/i2c/chips/Makefile                  |    1 -
>  drivers/i2c/chips/twl4030-core.c            |  344 +++++++++++++++++++---
>  drivers/i2c/chips/twl4030-madc.c            |  243 ++++++++++------
>  drivers/i2c/chips/twl4030-pwrbutton.c       |   10 +-
>  drivers/i2c/chips/twl4030-usb.c             |  373 ++++++++++++------------
>  drivers/i2c/i2c-core.c                      |    2 +-
>  drivers/input/keyboard/omap-twl4030keypad.c |   10 +-
>  drivers/mmc/host/omap_hsmmc.c               |    4 +-
>  drivers/power/twl4030_bci_battery.c         |  184 ++++++------
>  drivers/rtc/rtc-twl4030.c                   |   11 +-
>  include/linux/i2c/twl4030.h                 |   64 ++++-
>  27 files changed, 1306 insertions(+), 737 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/bci.c
>  delete mode 100644 arch/arm/plat-omap/include/mach/bci.h
>  rename drivers/{i2c/chips => gpio}/twl4030-gpio.c (67%)
> 
