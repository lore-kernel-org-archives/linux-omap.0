From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 00/34] omap drivers going upstream
Date: Sat, 30 Aug 2008 20:16:00 +0300
Message-ID: <1220116593-862-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43706 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbYH3RQ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 13:16:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

The following drivers are going upstream for integration.
They have been sitting on linux-omap for quite a while just
increasing the diff against mainline and probability of
merge conflicts.

Idealy, we would have people maintaining those drivers
but unfortunately it looks like it won't happen soon.

linux-omap will be kept on the loop so we can comment
on the patches and see the comments coming for the
proper mailing lists.

If anyone has objections to the patches, please say now
before I send them to mainline. I'm planning to send them
on next 9/11.

Here's the dirstat between l-o and mainline tree before
and after the patches:

before:

$ git diff --dirstat linus | sort -n
   3.2% drivers/input/keyboard/
   4.2% arch/arm/plat-omap/
   4.2% drivers/cbus/
   4.2% drivers/spi/
   4.8% sound/oss/
   6.0% drivers/i2c/chips/
   7.0% sound/arm/omap/
   7.2% drivers/media/video/
   8.4% drivers/dsp/dspgateway/
   9.0% arch/arm/configs/
  15.6% arch/arm/mach-omap2/
  20.6% drivers/

after:

$ git diff --dirstat linus | sort -n
   4.8% drivers/bluetooth/
   7.0% arch/arm/plat-omap/
   7.7% drivers/
   7.9% sound/oss/
  11.6% sound/arm/omap/
  13.9% drivers/dsp/dspgateway/
  14.9% arch/arm/configs/
  25.7% arch/arm/mach-omap2/

Felipe Balbi (33):
  add lp5521 driver
  Add cbus driver
  add omap-sha1 driver
  add omap gpio expander driver
  add tlv320aic23 driver
  add tsl2563 driver
  add twl4030 drivers
  add innovator ps2 keypad driver
  add lm8323 keypad driver
  Add twl4030 keypad driver
  add tsc2301 keypad driver
  Add tsc2005 touchscreen driver
  Add omap touchscreen driver
  add tsc210x touchscreen driver
  add tsc2301 touchscreen driver
  add omap led drivers
  add tea5761 radio driver
  add ov9640 sensor driver
  add omap video drivers
  add omap Serial Trace Interface driver
  add OMAP HighSpeed mmc controller driver
  add omap nand drivers
  add omap irda driver
  add bq27x00 battery driver
  add TWL4030 Battery Charger Interface driver
  add TWL4030 RealTime Clock driver
  add tsc210x driver
  add tsc2301 driver
  add omap ehci bus glue
  add omap backlight support
  add several omap lcd drivers
  add omap 1-wire interface driver
  add bq27000 1-wire slave driver

 arch/arm/mach-omap2/board-2430sdp.c         |   59 +
 arch/arm/plat-omap/include/mach/irqs.h      |    2 +
 arch/arm/plat-omap/include/mach/keypad.h    |    1 +
 drivers/Makefile                            |    2 +-
 drivers/cbus/Kconfig                        |   89 ++
 drivers/cbus/Makefile                       |   14 +
 drivers/cbus/cbus.c                         |  293 ++++
 drivers/cbus/cbus.h                         |   36 +
 drivers/cbus/retu-headset.c                 |  355 +++++
 drivers/cbus/retu-pwrbutton.c               |  118 ++
 drivers/cbus/retu-rtc.c                     |  477 +++++++
 drivers/cbus/retu-user.c                    |  423 ++++++
 drivers/cbus/retu-wdt.c                     |  202 +++
 drivers/cbus/retu.c                         |  466 +++++++
 drivers/cbus/retu.h                         |   77 ++
 drivers/cbus/tahvo-usb.c                    |  777 +++++++++++
 drivers/cbus/tahvo-user.c                   |  405 ++++++
 drivers/cbus/tahvo.c                        |  441 ++++++
 drivers/cbus/tahvo.h                        |   61 +
 drivers/cbus/user_retu_tahvo.h              |   75 ++
 drivers/crypto/Kconfig                      |    7 +
 drivers/crypto/Makefile                     |    1 +
 drivers/crypto/omap-sha1-md5.c              |  575 ++++++++
 drivers/i2c/chips/Kconfig                   |   90 ++
 drivers/i2c/chips/Makefile                  |   11 +-
 drivers/i2c/chips/gpio_expander_omap.c      |   71 +
 drivers/i2c/chips/lp5521.c                  |  585 ++++++++
 drivers/i2c/chips/tlv320aic23.c             |  675 ++++++++++
 drivers/i2c/chips/tsl2563.c                 |  739 +++++++++++
 drivers/i2c/chips/twl4030-core.c            | 1006 ++++++++++++++
 drivers/i2c/chips/twl4030-gpio.c            |  788 +++++++++++
 drivers/i2c/chips/twl4030-madc.c            |  455 +++++++
 drivers/i2c/chips/twl4030-poweroff.c        |   76 ++
 drivers/i2c/chips/twl4030-pwrbutton.c       |  163 +++
 drivers/i2c/chips/twl4030-pwrirq.c          |  226 ++++
 drivers/i2c/chips/twl4030-usb.c             |  779 +++++++++++
 drivers/input/keyboard/Kconfig              |   33 +
 drivers/input/keyboard/Makefile             |    4 +
 drivers/input/keyboard/innovator_ps2.c      | 1280 ++++++++++++++++++
 drivers/input/keyboard/lm8323.c             |  925 +++++++++++++
 drivers/input/keyboard/omap-twl4030keypad.c |  415 ++++++
 drivers/input/keyboard/tsc2301_kp.c         |  475 +++++++
 drivers/input/keyboard/twl4030-keypad.h     |   82 ++
 drivers/input/touchscreen/Kconfig           |   25 +
 drivers/input/touchscreen/Makefile          |    4 +
 drivers/input/touchscreen/omap/Makefile     |   10 +
 drivers/input/touchscreen/omap/omap_ts.c    |  267 ++++
 drivers/input/touchscreen/omap/omap_ts.h    |   57 +
 drivers/input/touchscreen/omap/ts_hx.c      |  184 +++
 drivers/input/touchscreen/tsc2005.c         |  736 +++++++++++
 drivers/input/touchscreen/tsc210x_ts.c      |  160 +++
 drivers/input/touchscreen/tsc2301_ts.c      |  676 ++++++++++
 drivers/leds/Kconfig                        |   21 +
 drivers/leds/Makefile                       |    2 +
 drivers/leds/leds-omap-pwm.c                |  376 ++++++
 drivers/leds/leds-omap.c                    |  135 ++
 drivers/media/radio/Kconfig                 |   13 +
 drivers/media/radio/Makefile                |    1 +
 drivers/media/radio/radio-tea5761.c         |  517 ++++++++
 drivers/media/video/Kconfig                 |   19 +
 drivers/media/video/Makefile                |    3 +
 drivers/media/video/omap/Kconfig            |    7 +
 drivers/media/video/omap/Makefile           |    9 +
 drivers/media/video/omap/camera_core.c      | 1280 ++++++++++++++++++
 drivers/media/video/omap/camera_core.h      |  156 +++
 drivers/media/video/omap/camera_hw_if.h     |   50 +
 drivers/media/video/omap/omap16xxcam.c      |  579 ++++++++
 drivers/media/video/omap/omap16xxcam.h      |  106 ++
 drivers/media/video/omap24xxcam-dma.c       |  601 +++++++++
 drivers/media/video/omap24xxcam.c           | 1908 +++++++++++++++++++++++++++
 drivers/media/video/omap24xxcam.h           |  593 +++++++++
 drivers/media/video/ov9640.c                | 1279 ++++++++++++++++++
 drivers/media/video/ov9640.h                |  194 +++
 drivers/misc/Kconfig                        |   14 +
 drivers/misc/Makefile                       |    1 +
 drivers/misc/sti/Makefile                   |    8 +
 drivers/misc/sti/sdti.c                     |  185 +++
 drivers/misc/sti/sti-console.c              |  189 +++
 drivers/misc/sti/sti-fifo.c                 |  117 ++
 drivers/misc/sti/sti-netlink.c              |  152 +++
 drivers/misc/sti/sti.c                      |  432 ++++++
 drivers/mmc/host/Kconfig                    |   13 +-
 drivers/mmc/host/Makefile                   |    1 +
 drivers/mmc/host/omap_hsmmc.c               | 1069 +++++++++++++++
 drivers/mtd/nand/Kconfig                    |   19 +
 drivers/mtd/nand/Makefile                   |    3 +
 drivers/mtd/nand/omap-hw.c                  |  860 ++++++++++++
 drivers/mtd/nand/omap-nand-flash.c          |  186 +++
 drivers/mtd/nand/omap2.c                    |  757 +++++++++++
 drivers/net/irda/Kconfig                    |   10 +
 drivers/net/irda/Makefile                   |    1 +
 drivers/net/irda/omap-ir.c                  |  901 +++++++++++++
 drivers/power/Kconfig                       |   29 +
 drivers/power/Makefile                      |    2 +
 drivers/power/bq27x00_battery.c             |  564 ++++++++
 drivers/power/twl4030_bci_battery.c         | 1080 +++++++++++++++
 drivers/rtc/Kconfig                         |   10 +
 drivers/rtc/Makefile                        |    1 +
 drivers/rtc/rtc-twl4030.c                   |  649 +++++++++
 drivers/spi/Kconfig                         |   41 +
 drivers/spi/Makefile                        |    4 +
 drivers/spi/tsc210x.c                       | 1262 ++++++++++++++++++
 drivers/spi/tsc2301-core.c                  |  301 +++++
 drivers/spi/tsc2301-mixer.c                 | 1004 ++++++++++++++
 drivers/usb/host/Kconfig                    |   19 +
 drivers/usb/host/ehci-hcd.c                 |    5 +
 drivers/usb/host/ehci-omap.c                |  562 ++++++++
 drivers/usb/host/ehci-omap.h                |  125 ++
 drivers/video/backlight/Kconfig             |    9 +
 drivers/video/backlight/Makefile            |    1 +
 drivers/video/backlight/omap_bl.c           |  218 +++
 drivers/video/omap/Kconfig                  |   18 +
 drivers/video/omap/Makefile                 |   11 +
 drivers/video/omap/lcd_2430sdp.c            |  182 +++
 drivers/video/omap/lcd_ams_delta.c          |  140 ++
 drivers/video/omap/lcd_apollon.c            |  137 ++
 drivers/video/omap/lcd_h2.c                 |  155 +++
 drivers/video/omap/lcd_mipid.c              |  617 +++++++++
 drivers/video/omap/lcd_omap2evm.c           |  195 +++
 drivers/video/omap/lcd_omap3beagle.c        |  133 ++
 drivers/video/omap/lcd_omap3evm.c           |  197 +++
 drivers/video/omap/lcd_p2.c                 |  342 +++++
 drivers/w1/masters/Kconfig                  |    7 +
 drivers/w1/masters/Makefile                 |    1 +
 drivers/w1/masters/omap_hdq.c               |  704 ++++++++++
 drivers/w1/slaves/Kconfig                   |    8 +
 drivers/w1/slaves/Makefile                  |    2 +-
 drivers/w1/slaves/w1_bq27000.c              |  120 ++
 drivers/w1/w1.h                             |    1 +
 drivers/w1/w1_io.c                          |    3 +-
 include/linux/i2c/lm8323.h                  |   37 +
 include/linux/i2c/twl4030-gpio.h            |   76 ++
 include/linux/i2c/twl4030-madc.h            |  134 ++
 include/linux/i2c/twl4030-pwrirq.h          |   37 +
 include/linux/i2c/twl4030-rtc.h             |  230 ++++
 include/linux/i2c/twl4030.h                 |  137 ++
 include/linux/spi/tsc2005.h                 |   29 +
 include/linux/spi/tsc210x.h                 |  231 ++++
 138 files changed, 38485 insertions(+), 5 deletions(-)
 create mode 100644 drivers/cbus/Kconfig
 create mode 100644 drivers/cbus/Makefile
 create mode 100644 drivers/cbus/cbus.c
 create mode 100644 drivers/cbus/cbus.h
 create mode 100644 drivers/cbus/retu-headset.c
 create mode 100644 drivers/cbus/retu-pwrbutton.c
 create mode 100644 drivers/cbus/retu-rtc.c
 create mode 100644 drivers/cbus/retu-user.c
 create mode 100644 drivers/cbus/retu-wdt.c
 create mode 100644 drivers/cbus/retu.c
 create mode 100644 drivers/cbus/retu.h
 create mode 100644 drivers/cbus/tahvo-usb.c
 create mode 100644 drivers/cbus/tahvo-user.c
 create mode 100644 drivers/cbus/tahvo.c
 create mode 100644 drivers/cbus/tahvo.h
 create mode 100644 drivers/cbus/user_retu_tahvo.h
 create mode 100644 drivers/crypto/omap-sha1-md5.c
 create mode 100644 drivers/i2c/chips/gpio_expander_omap.c
 create mode 100644 drivers/i2c/chips/lp5521.c
 create mode 100644 drivers/i2c/chips/tlv320aic23.c
 create mode 100644 drivers/i2c/chips/tsl2563.c
 create mode 100644 drivers/i2c/chips/twl4030-core.c
 create mode 100644 drivers/i2c/chips/twl4030-gpio.c
 create mode 100644 drivers/i2c/chips/twl4030-madc.c
 create mode 100644 drivers/i2c/chips/twl4030-poweroff.c
 create mode 100644 drivers/i2c/chips/twl4030-pwrbutton.c
 create mode 100644 drivers/i2c/chips/twl4030-pwrirq.c
 create mode 100644 drivers/i2c/chips/twl4030-usb.c
 create mode 100644 drivers/input/keyboard/innovator_ps2.c
 create mode 100644 drivers/input/keyboard/lm8323.c
 create mode 100644 drivers/input/keyboard/omap-twl4030keypad.c
 create mode 100644 drivers/input/keyboard/tsc2301_kp.c
 create mode 100644 drivers/input/keyboard/twl4030-keypad.h
 create mode 100644 drivers/input/touchscreen/omap/Makefile
 create mode 100644 drivers/input/touchscreen/omap/omap_ts.c
 create mode 100644 drivers/input/touchscreen/omap/omap_ts.h
 create mode 100644 drivers/input/touchscreen/omap/ts_hx.c
 create mode 100644 drivers/input/touchscreen/tsc2005.c
 create mode 100644 drivers/input/touchscreen/tsc210x_ts.c
 create mode 100644 drivers/input/touchscreen/tsc2301_ts.c
 create mode 100644 drivers/leds/leds-omap-pwm.c
 create mode 100644 drivers/leds/leds-omap.c
 create mode 100644 drivers/media/radio/radio-tea5761.c
 create mode 100644 drivers/media/video/omap/Kconfig
 create mode 100644 drivers/media/video/omap/Makefile
 create mode 100644 drivers/media/video/omap/camera_core.c
 create mode 100644 drivers/media/video/omap/camera_core.h
 create mode 100644 drivers/media/video/omap/camera_hw_if.h
 create mode 100644 drivers/media/video/omap/omap16xxcam.c
 create mode 100644 drivers/media/video/omap/omap16xxcam.h
 create mode 100644 drivers/media/video/omap24xxcam-dma.c
 create mode 100644 drivers/media/video/omap24xxcam.c
 create mode 100644 drivers/media/video/omap24xxcam.h
 create mode 100644 drivers/media/video/ov9640.c
 create mode 100644 drivers/media/video/ov9640.h
 create mode 100644 drivers/misc/sti/Makefile
 create mode 100644 drivers/misc/sti/sdti.c
 create mode 100644 drivers/misc/sti/sti-console.c
 create mode 100644 drivers/misc/sti/sti-fifo.c
 create mode 100644 drivers/misc/sti/sti-netlink.c
 create mode 100644 drivers/misc/sti/sti.c
 create mode 100644 drivers/mmc/host/omap_hsmmc.c
 create mode 100644 drivers/mtd/nand/omap-hw.c
 create mode 100644 drivers/mtd/nand/omap-nand-flash.c
 create mode 100644 drivers/mtd/nand/omap2.c
 create mode 100644 drivers/net/irda/omap-ir.c
 create mode 100644 drivers/power/bq27x00_battery.c
 create mode 100644 drivers/power/twl4030_bci_battery.c
 create mode 100644 drivers/rtc/rtc-twl4030.c
 create mode 100644 drivers/spi/tsc210x.c
 create mode 100644 drivers/spi/tsc2301-core.c
 create mode 100644 drivers/spi/tsc2301-mixer.c
 create mode 100644 drivers/usb/host/ehci-omap.c
 create mode 100644 drivers/usb/host/ehci-omap.h
 create mode 100644 drivers/video/backlight/omap_bl.c
 create mode 100644 drivers/video/omap/lcd_2430sdp.c
 create mode 100644 drivers/video/omap/lcd_ams_delta.c
 create mode 100644 drivers/video/omap/lcd_apollon.c
 create mode 100644 drivers/video/omap/lcd_h2.c
 create mode 100644 drivers/video/omap/lcd_mipid.c
 create mode 100644 drivers/video/omap/lcd_omap2evm.c
 create mode 100644 drivers/video/omap/lcd_omap3beagle.c
 create mode 100644 drivers/video/omap/lcd_omap3evm.c
 create mode 100644 drivers/video/omap/lcd_p2.c
 create mode 100644 drivers/w1/masters/omap_hdq.c
 create mode 100644 drivers/w1/slaves/w1_bq27000.c
 create mode 100644 include/linux/i2c/lm8323.h
 create mode 100644 include/linux/i2c/twl4030-gpio.h
 create mode 100644 include/linux/i2c/twl4030-madc.h
 create mode 100644 include/linux/i2c/twl4030-pwrirq.h
 create mode 100644 include/linux/i2c/twl4030-rtc.h
 create mode 100644 include/linux/i2c/twl4030.h
 create mode 100644 include/linux/spi/tsc2005.h
 create mode 100644 include/linux/spi/tsc210x.h

