From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 0/2] backlight: Add TI LMU backlight driver
Date: Mon, 17 Jul 2017 15:39:54 +0200
Message-ID: <20170717133956.20691-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

This adds backlight support for TI LMU devices. I updated the
patches from Milo Kim according to the comments from Daniel
Thompson and tested the result on Droid 4.

Changes since PATCHv1 [0]:
 * split dt-binding documentation in its own patch
 * move include/linux/mfd/ti-lmu-backlight.h to drivers/video/backlight/ti-lmu-backlight-data.h
 * replace LMU_BL_REG() with a normal struct
 * add "const" keyword to lots of internal structures
 * improve error handling
 * use atomic pwm api

[0] https://lkml.org/lkml/2017/3/19/265

-- Sebastian

Milo Kim (2):
  dt-bindings: backlight: add ti-lmu-backlight binding
  backlight: add TI LMU backlight driver

 .../bindings/leds/backlight/ti-lmu-backlight.txt   |  66 ++
 drivers/video/backlight/Kconfig                    |   7 +
 drivers/video/backlight/Makefile                   |   3 +
 drivers/video/backlight/ti-lmu-backlight-core.c    | 729 +++++++++++++++++++++
 drivers/video/backlight/ti-lmu-backlight-data.c    | 304 +++++++++
 drivers/video/backlight/ti-lmu-backlight-data.h    |  95 +++
 6 files changed, 1204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti-lmu-backlight.txt
 create mode 100644 drivers/video/backlight/ti-lmu-backlight-core.c
 create mode 100644 drivers/video/backlight/ti-lmu-backlight-data.c
 create mode 100644 drivers/video/backlight/ti-lmu-backlight-data.h

-- 
2.13.2
