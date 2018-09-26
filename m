From: Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 0/9] TI LMU and Dedicated LED drivers
Date: Wed, 26 Sep 2018 08:09:12 -0500
Message-ID: <20180926130921.12329-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

All

This is an attempt to create a common TI LMU code base that can be leveraged
by dedicate LED drivers.

This code is by no means complete as I am looking for comments on the
implementation and demonstrating the advantage of adding unique features within
a dedicated LED driver while using common code to perform common features.

Assuming that the implementation can be used the code will be debugged and the
DT bindings and TI-lmu code will be scrubbed.

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
 .../devicetree/bindings/leds/leds-lm3633.txt  |  69 +++
 .../devicetree/bindings/leds/leds-lm3697.txt  |  98 ++++
 .../devicetree/bindings/mfd/ti-lmu.txt        |  26 +-
 drivers/leds/Kconfig                          |  29 +
 drivers/leds/Makefile                         |   4 +
 drivers/leds/leds-lm3632.c                    | 547 ++++++++++++++++++
 drivers/leds/leds-lm3633.c                    | 430 ++++++++++++++
 drivers/leds/leds-lm3697.c                    | 389 +++++++++++++
 drivers/leds/ti-lmu-led-common.c              | 175 ++++++
 drivers/leds/ti-lmu-led-common.h              |  43 ++
 drivers/mfd/Kconfig                           |   2 +-
 drivers/mfd/ti-lmu.c                          |  17 -
 include/linux/mfd/ti-lmu-register.h           |  44 --
 include/linux/mfd/ti-lmu.h                    |   1 -
 15 files changed, 1839 insertions(+), 88 deletions(-)
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
