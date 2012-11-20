From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/3] pwm: Drivers for twl4030/6030 PWMs and LEDs
Date: Tue, 20 Nov 2012 10:56:19 +0100
Message-ID: <1353405382-9226-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Tero Kristo <t-kristo@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hello,

Changes since v2:
- New PWM cycle calculation for twl-pwm driver and twl4030's pwm-twl-led with
  comment to document the expected behaviour.

Changes cince v1:
- The turn on/off sequence has been corrected for twl4030 PWMs as suggested by
  Grazvydas Ignotas
- Comment section added to the new drivers to describe what they are controlling

The series has been tested (with additional, pending patches):
Zoom2 for twl4030 PWM0 (keypad light), PWM1 (LCD backlight)
BeagleBoard for twl4030 LEDB (PWMB - pmu_stat led)
OMAP4 Blaze (SDP4430) for twl6030 PWM1 (keypad light), PWM2 (LCD backlight) and
LED (charging indication led).

Intro mail from v1:

The currently available pwm-twl6030.c driver only supports TWL6030's Charging
indication LED.
Remove this driver and add two new ones which implements support for all PWM
driven outputs:
pwm-twl driver supports twl4030 (PWM 0/1) and twl6030 (PWM 1/2) instances
pwm-twl-led driver supports twl4030 (PWM driven LED A/B ports) and twl6030's
Charging indication LED (PWM driven).

Regards,
Peter
---
Peter Ujfalusi (3):
  pwm: Remove pwm-twl6030 driver
  pwm: New driver to support PWMs on TWL4030/6030 series of PMICs
  pwm: New driver to support PWM driven LEDs on TWL4030/6030 series of
    PMICs

 drivers/pwm/Kconfig       |  19 ++-
 drivers/pwm/Makefile      |   3 +-
 drivers/pwm/pwm-twl-led.c | 303 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-twl.c     | 330 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-twl6030.c | 184 --------------------------
 5 files changed, 650 insertions(+), 189 deletions(-)
 create mode 100644 drivers/pwm/pwm-twl-led.c
 create mode 100644 drivers/pwm/pwm-twl.c
 delete mode 100644 drivers/pwm/pwm-twl6030.c

-- 
1.8.0
