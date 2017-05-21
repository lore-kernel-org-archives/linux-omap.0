From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 0/3] mfd: move include files out of include/linux/i2c
Date: Mon, 22 May 2017 00:02:07 +0200
Message-ID: <20170521220212.1404-1-wsa@the-dreams.de>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <rtc-linux+bncBDP47C6LHEIOXHEIZECRUBCBU26K4-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

It doesn't make sense to use include/linux/i2c for client drivers which may in
fact rather be hwmon or input or whatever devices. As a result, I want to
deprecate include/linux/i2c for good. This series moves the include files to a
better location, for the mfd subsystem to include/linux/mfd. Because of twl.h,
this touches quite some subsystems, but I still think it is worth it.

I prefer the series to go upstream via the subsystem tree; if you prefer that I
take it via I2C, just let me know.

No runtime testing because of no HW, but buildbot is happy with this series at
least. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_data

Thanks and kind regards,

   Wolfram


Wolfram Sang (3):
  mfd: dm355evm_msp: move header file out of I2C realm
  mfd: tps65010: move header file out of I2C realm
  mfd: twl: move header file out of I2C realm

 arch/arm/mach-omap1/board-h2-mmc.c        | 2 +-
 arch/arm/mach-omap1/board-h2.c            | 2 +-
 arch/arm/mach-omap1/board-h3-mmc.c        | 2 +-
 arch/arm/mach-omap1/board-h3.c            | 2 +-
 arch/arm/mach-omap1/board-osk.c           | 2 +-
 arch/arm/mach-omap2/common.h              | 2 +-
 arch/arm/mach-omap2/omap_twl.c            | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c   | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c       | 2 +-
 drivers/gpio/gpio-twl4030.c               | 2 +-
 drivers/iio/adc/twl4030-madc.c            | 2 +-
 drivers/iio/adc/twl6030-gpadc.c           | 2 +-
 drivers/input/keyboard/twl4030_keypad.c   | 2 +-
 drivers/input/misc/dm355evm_keys.c        | 2 +-
 drivers/input/misc/twl4030-pwrbutton.c    | 2 +-
 drivers/input/misc/twl4030-vibra.c        | 2 +-
 drivers/mfd/dm355evm_msp.c                | 2 +-
 drivers/mfd/tps65010.c                    | 2 +-
 drivers/mfd/twl-core.c                    | 6 +++---
 drivers/mfd/twl4030-audio.c               | 2 +-
 drivers/mfd/twl4030-irq.c                 | 2 +-
 drivers/mfd/twl4030-power.c               | 2 +-
 drivers/mfd/twl6030-irq.c                 | 2 +-
 drivers/phy/phy-twl4030-usb.c             | 2 +-
 drivers/power/supply/twl4030_charger.c    | 2 +-
 drivers/pwm/pwm-twl-led.c                 | 2 +-
 drivers/pwm/pwm-twl.c                     | 2 +-
 drivers/regulator/twl-regulator.c         | 2 +-
 drivers/regulator/twl6030-regulator.c     | 2 +-
 drivers/rtc/rtc-dm355evm.c                | 2 +-
 drivers/rtc/rtc-twl.c                     | 2 +-
 drivers/usb/host/ohci-omap.c              | 2 +-
 drivers/usb/phy/phy-isp1301-omap.c        | 2 +-
 drivers/usb/phy/phy-twl6030-usb.c         | 2 +-
 drivers/video/backlight/pandora_bl.c      | 2 +-
 drivers/video/fbdev/omap/lcd_h3.c         | 2 +-
 drivers/watchdog/twl4030_wdt.c            | 2 +-
 include/linux/{i2c => mfd}/dm355evm_msp.h | 0
 include/linux/{i2c => mfd}/tps65010.h     | 2 +-
 include/linux/{i2c => mfd}/twl.h          | 0
 sound/soc/codecs/twl4030.c                | 2 +-
 41 files changed, 41 insertions(+), 41 deletions(-)
 rename include/linux/{i2c => mfd}/dm355evm_msp.h (100%)
 rename include/linux/{i2c => mfd}/tps65010.h (99%)
 rename include/linux/{i2c => mfd}/twl.h (100%)

-- 
2.11.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
