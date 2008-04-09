From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/5] n810 drivers, take #3
Date: Wed,  9 Apr 2008 15:03:59 +0300
Message-ID: <1207742644-6260-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57328 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbYDIMFO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 08:05:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Felipe Balbi <felipe.balbi@nokia.com>

Now it passes checkpatch.pl:

$ scripts/checkpatch.pl linux-omap-09042008/*
linux-omap-09042008/0001-I2C-LM8323-Introduce-lm8323-keypad-driver.diff has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 767 lines checked

linux-omap-09042008/0002-I2C-TSL2563-Add-support-for-Taos-tsl2563-ambient-li.diff has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 918 lines checked

linux-omap-09042008/0003-INPUT-TOUCHSCREEN-Introduce-tsc2005-driver.diff has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 607 lines checked

linux-omap-09042008/0004-I2C-LP5521-Introduce-lp5521-LED-driver.diff has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 284 lines checked

linux-omap-09042008/0005-ARM-N800-Update-n800-defconfig.diff has no obvious style problems and is ready for submission.

Documentation follows again

---


The following patches are updates from n810 tree to
be able to build on top of current linux-omap.

I'm addind here the keypad driver, touchscreen driver,
ambient light sensor driver and LED driver.

Please give it a good review and comments are welcome. I
might have some design issues due to n800 and n810 be using
the same board files, but as of my tests everything works fine.

In case of the LED and ambient light sensor we're gonna
have to test through sysfs.

Here's some notes about both:

- ambient light sensor:
        # cat /sys/class/i2c-adapter/i2c-2/2-0029/lux
        this will show the light intensity, cover the sensor and it'll change.

- LED driver:
        # echo ff:00:00 > /sys/class/i2c-adapter/i2c-2/2-0032/color
        this will make the led bright red.

        # echo load > /sys/class/i2c-adapter/i2c-2/2-0032/mode
        # echo 40000a7f0aff0000 > /sys/class/i2c-adapter/i2c-2/2-0032/load
        # echo run > /sys/class/i2c-adapter/i2c-2/2-0032/mode
        this will make the LED bright following the pattern in the second echo.

        The pattern format is here:
        40aabbccbbcc0000
        .aa - set pwm [00..ff]
        .bb - step time increase brightness [01..3f]short step or [41..7f] long step
        .cc - brightness increment/decrement steps [00..7f] increment or [80..ff] decrement
        .0000 - goto start

        note: you can put as much 'bbcc' patterns as you want, i mean:
        the following pattern still valid:

        # echo 40000a7f0aff137f13ff0c7f0cff0000 > load

That's all, the last patch just updates n800_defconfig to enable these new drivers.

Daniel Stone (1):
  I2C: LM8323: Introduce lm8323 keypad driver

Felipe Balbi (1):
  ARM: N800: Update n800 defconfig

Lauri Leukkunen (1):
  INPUT: TOUCHSCREEN: Introduce tsc2005 driver

Mathias Nyman (2):
  I2C: TSL2563: Add support for Taos tsl2563 ambient light sensor
  I2C: LP5521: Introduce lp5521 LED driver

 arch/arm/configs/n800_defconfig     |  189 +++++++-
 arch/arm/mach-omap2/board-n800.c    |  180 +++++++-
 arch/arm/mach-omap2/board-n810.c    |    2 +
 drivers/i2c/chips/Kconfig           |   17 +
 drivers/i2c/chips/Makefile          |    3 +-
 drivers/i2c/chips/lp5521.c          |  577 ++++++++++++++++++++++
 drivers/i2c/chips/tsl2563.c         |  731 ++++++++++++++++++++++++++++
 drivers/input/keyboard/Kconfig      |    7 +
 drivers/input/keyboard/Makefile     |    1 +
 drivers/input/keyboard/lm8323.c     |  920 +++++++++++++++++++++++++++++++++++
 drivers/input/touchscreen/Kconfig   |    5 +
 drivers/input/touchscreen/Makefile  |    1 +
 drivers/input/touchscreen/tsc2005.c |  739 ++++++++++++++++++++++++++++
 include/linux/i2c/lm8323.h          |   39 ++
 include/linux/spi/tsc2005.h         |   29 ++
 15 files changed, 3428 insertions(+), 12 deletions(-)
 create mode 100644 drivers/i2c/chips/lp5521.c
 create mode 100644 drivers/i2c/chips/tsl2563.c
 create mode 100644 drivers/input/keyboard/lm8323.c
 create mode 100644 drivers/input/touchscreen/tsc2005.c
 create mode 100644 include/linux/i2c/lm8323.h
 create mode 100644 include/linux/spi/tsc2005.h

