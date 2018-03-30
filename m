From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 00/10] backlight: Add TI LMU backlight driver
Date: Fri, 30 Mar 2018 19:24:04 +0200
Message-ID: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

This adds backlight support for TI LMU devices. It was tested with
an lm3532 on Motorola Droid 4, which uses one channel for display
backlight and one channel for keyboard backlight.

Changes since PATCHv3:
 * Complete overhaul to satisfy Rob's remarks regarding to the binding
 * Implement LED subsystem support for keyboard backlights
 * Add lots of cleanup patches for the TI LMU MFD driver

Changes since PATCHv2:
 * Drop all binding parts, that were NAK'd by Rob.

Changes since PATCHv1:
 * split dt-binding documentation in its own patch
 * move include/linux/mfd/ti-lmu-backlight.h to drivers/video/backlight/ti-lmu-backlight-data.h
 * replace LMU_BL_REG() with a normal struct
 * add "const" keyword to lots of internal structures
 * improve error handling
 * use atomic pwm api

-- Sebastian

Sebastian Reichel (10):
  mfd: ti-lmu: constify mfd_cell tables
  mfd: ti-lmu: switch to gpiod
  mfd: ti-lmu: use managed resource for everything
  mfd: ti-lmu: drop of_compatible for backlight driver
  mfd: ti-lmu: use of_device_get_match_data() helper
  mfd: ti-lmu: add PWM support
  mfd: ti-lmu: register one backlight device per channel
  backlight: add TI LMU backlight driver
  dt-bindings: mfd: ti-lmu: update for backlight
  ARM: dts: omap4-droid4: update backlight led-controller

 Documentation/devicetree/bindings/mfd/ti-lmu.txt | 119 ++--
 arch/arm/boot/dts/omap4-droid4-xt894.dts         |  20 +-
 drivers/mfd/ti-lmu.c                             | 170 +++---
 drivers/video/backlight/Kconfig                  |   7 +
 drivers/video/backlight/Makefile                 |   3 +
 drivers/video/backlight/ti-lmu-backlight-core.c  | 666 +++++++++++++++++++++++
 drivers/video/backlight/ti-lmu-backlight-data.c  | 304 +++++++++++
 drivers/video/backlight/ti-lmu-backlight-data.h  |  95 ++++
 include/linux/mfd/ti-lmu.h                       |  10 +-
 9 files changed, 1257 insertions(+), 137 deletions(-)
 create mode 100644 drivers/video/backlight/ti-lmu-backlight-core.c
 create mode 100644 drivers/video/backlight/ti-lmu-backlight-data.c
 create mode 100644 drivers/video/backlight/ti-lmu-backlight-data.h

-- 
2.16.2
