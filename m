From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH v2 0/9] TI LMU and Dedicated Drivers
Date: Fri, 28 Sep 2018 13:29:45 -0500
Message-ID: <20180928182954.25446-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

All

The following v2 patchset has been debugged and updated to support the
LM3697, LM3632 and LM3633.  The TI LMU common code has been used and can
be extended where need be.  If this approach is acceptable I will make code
changes based on review and submit v3 with additional bindings updates for
full review and merge.

These 3 LED drivers should be functional to provide basic lighting experiences.
Other features like PWM support will be included later and maybe part of the
common code.

I usually list all the deltas in my patch sets but due to the major rip in the
drivers I would repeat myself just saying that there are too many changes to
list.

Dan

Dan Murphy (8):
  dt-bindings: ti-lmu: Remove LM3697
  mfd: ti-lmu: Remove support for LM3697
  dt-bindings: leds: Add bindings for lm3697 driver
  leds: lm3697: Introduce the lm3697 driver
  dt-bindings: leds: Add support for the LM3633
  leds: lm3633: Introduce the lm3633 driver
  dt-bindings: leds: Add the LM3632 LED dt binding
  leds: lm3632: Introduce the TI LM3632 driver

Pavel Machek (1):
  leds: add TI LMU backlight driver

 .../devicetree/bindings/leds/leds-lm3632.txt  |  53 ++
 .../devicetree/bindings/leds/leds-lm3633.txt  | 102 +++
 .../devicetree/bindings/leds/leds-lm3697.txt  |  98 +++
 .../devicetree/bindings/mfd/ti-lmu.txt        |  26 +-
 drivers/leds/Kconfig                          |  30 +
 drivers/leds/Makefile                         |   4 +
 drivers/leds/leds-lm3632.c                    | 646 ++++++++++++++++++
 drivers/leds/leds-lm3633.c                    | 557 +++++++++++++++
 drivers/leds/leds-lm3697.c                    | 382 +++++++++++
 drivers/leds/ti-lmu-led-common.c              | 138 ++++
 drivers/leds/ti-lmu-led-common.h              |  54 ++
 drivers/mfd/Kconfig                           |   2 +-
 drivers/mfd/ti-lmu.c                          |  17 -
 include/linux/mfd/ti-lmu-register.h           |  44 --
 include/linux/mfd/ti-lmu.h                    |   1 -
 15 files changed, 2066 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3632.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3633.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
 create mode 100644 drivers/leds/leds-lm3632.c
 create mode 100644 drivers/leds/leds-lm3633.c
 create mode 100644 drivers/leds/leds-lm3697.c
 create mode 100644 drivers/leds/ti-lmu-led-common.c
 create mode 100644 drivers/leds/ti-lmu-led-common.h

-- 
2.19.0
