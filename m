From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 00/22] twl4030 patches
Date: Mon, 29 Sep 2008 16:14:17 +0300
Message-ID: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29682 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbYI2NP0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:15:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

I think now things are in pretty good shape and should be applied
to linux-omap mailing list.

With this patchset, we're moving twl4030 forward to a new registration
method and several children were already moved to this new style.

There are plenty of bug fixes as well, mainly to gpio and core modules
and still a lot of stuff to go.

I'd ask people to test the card detect features since I don't have
(damn it) the expansion board for 3430sdp but it looks fine as long
as Dave's tests can say.

This series was boot tested on 3430sdp and beagle B5 (couldn't mount fs
since hsmmc.c is broken on current l-o) and compile tested for all
omap3-based defconfigs plus 2430sdp.

We have a list of TODO so if people wanna help, go for it:

- twl4030-pwrirq.c needs atention. Probably get merged into
  twl4030-core.c

- twl4030_bci_battery.c needs rework as well. Move to new style
  registration is a must now.

- twl4030-power.c needs to get rid of the board specific calls

- twl4030-pwrbutton.c could move to drivers/input/misc

- mmc card detect should be stress tested since we've been
  playing with the edge control stuff. If that's working
  we can probaly switch hsmmc.c to standard gpio calls soon.

- there are too many header files for twl4030, we could merge them
  into one, maybe.

- twl4030-keypad.h should vanish. It's small and all those register
  definitions are used only by the keypad driver. Moving all that
  stuff should be simple.

- sound/soc/codecs/twl4030.c will probably need some attention as
  well.

- twl4030-madc.c could move to sysfs files and hwmon rules (??)

This list will probably grow as we continue doing stuff. Dave
has another queue waiting some other patches to get merged
upstream. After that, I'd say twl4030-core.c could go
upstream as well.

As these patches are quite important, give it a good review
and test so we avoid surprises later.

All-in-all, I'd say we can apply these patches and fix hsmmc.c
in the road. What say you Dave ? I put a few printk to hsmmc.c
and could see that the request_irq for card_detect is the one
which is failing. Maybe that TWL4030_GPIO_IRQ_NO() crap should
be changed. Better, removed.

David Brownell (11):
  twl4030 gpio platform data
  twl4030 uses gpiolib
  minor twl4030-core cleanups
  provide detailed diagnostics in add_children()
  move twl4030-gpio to drivers/gpio
  minor irq-related cleanups
  Move I2C driver model init earlier in the boot sequence
  twl4030-gpio irq_chip.set_type
  twl4030-gpio: remove legacy irq triggering calls and user
  twl4030-gpio: irq and other cleanup
  twl4030-core: portability updates

Felipe Balbi (10):
  twl4030: fix potential null pointer dereference
  i2c: clean add_children a bit
  i2c: move twl4030_keypad to new style registration
  i2c: move twl4030-usb to platform_device
  i2c: twl4030-usb: add 'vbus' sysfs file
  i2c: move twl4030-madc to new registration style
  i2c: added a few missing gotos to add_children()
  twl4030: move pm_power_off initialization to twl4030-core.c
  i2c: switch twl4030-usb to use a resource for irq
  i2c: minor cleanups to twl4030-pwrbutton.c

Jagadeesh Bhaskar Pakaravoor (1):
  twl4030-gpio: Remove default pullup enable/disable of GPIO

 arch/arm/mach-omap2/board-2430sdp.c         |   32 +-
 arch/arm/mach-omap2/board-3430sdp.c         |   31 +-
 arch/arm/mach-omap2/board-ldp.c             |   19 +
 arch/arm/mach-omap2/board-omap2evm.c        |   33 +-
 arch/arm/mach-omap2/board-omap3beagle.c     |   19 +
 arch/arm/mach-omap2/board-omap3evm.c        |   85 ++-
 arch/arm/mach-omap2/board-overo.c           |    7 +
 arch/arm/mach-omap2/hsmmc.c                 |    5 -
 arch/arm/plat-omap/include/mach/irqs.h      |    2 +-
 drivers/gpio/Kconfig                        |    7 +
 drivers/gpio/Makefile                       |    1 +
 drivers/gpio/twl4030-gpio.c                 |  951 +++++++++++++++++++++++++++
 drivers/i2c/chips/Kconfig                   |   24 -
 drivers/i2c/chips/Makefile                  |    2 -
 drivers/i2c/chips/twl4030-core.c            |  311 ++++++++--
 drivers/i2c/chips/twl4030-gpio.c            |  788 ----------------------
 drivers/i2c/chips/twl4030-madc.c            |  243 +++++---
 drivers/i2c/chips/twl4030-poweroff.c        |   76 ---
 drivers/i2c/chips/twl4030-pwrbutton.c       |   10 +-
 drivers/i2c/chips/twl4030-usb.c             |  375 ++++++-----
 drivers/i2c/i2c-core.c                      |    2 +-
 drivers/input/keyboard/omap-twl4030keypad.c |   10 +-
 drivers/mmc/host/omap_hsmmc.c               |    4 +-
 drivers/rtc/rtc-twl4030.c                   |   11 +-
 include/linux/i2c/twl4030.h                 |   59 ++-
 25 files changed, 1796 insertions(+), 1311 deletions(-)
 create mode 100644 drivers/gpio/twl4030-gpio.c
 delete mode 100644 drivers/i2c/chips/twl4030-gpio.c
 delete mode 100644 drivers/i2c/chips/twl4030-poweroff.c

