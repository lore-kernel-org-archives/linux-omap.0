From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v7 0/6] LM3697 dedicated LED driver
Date: Tue, 11 Sep 2018 12:08:19 -0500
Message-ID: <20180911170825.17789-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-omap@vger.kernel.org

All

The LM3697 LED driver has two opportunities to be included in the Linux
kernel source.

The ti-lmu MFD driver and the leds-lm3697 driver contained in this series.

This LED driver is basic in nature and is not really suitable for the MFD
inclusion.  This device has no other function than to control the LEDs.

So this series will remove the lm3697 from the ti-lmu and add the driver
in the LEDs directory.

Dan Murphy


Dan Murphy (6):
  dt-bindings: ti-lmu: Remove LM3697
  mfd: ti-lmu: Remove support for LM3697
  dt-bindings: leds: Add bindings for lm3697 driver
  leds: lm3697: Introduce the lm3697 driver
  dt-bindings: leds: Add runtime ramp node for LM3697
  leds: lm3697: Add ramp rate feature

 .../devicetree/bindings/leds/leds-lm3697.txt  |  98 ++++
 .../devicetree/bindings/mfd/ti-lmu.txt        |  26 +-
 drivers/leds/Kconfig                          |   9 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-lm3697.c                    | 449 ++++++++++++++++++
 drivers/mfd/Kconfig                           |   2 +-
 drivers/mfd/ti-lmu.c                          |  17 -
 include/linux/mfd/ti-lmu-register.h           |  44 --
 include/linux/mfd/ti-lmu.h                    |   1 -
 9 files changed, 559 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
 create mode 100644 drivers/leds/leds-lm3697.c

-- 
2.17.0.1855.g63749b2dea
