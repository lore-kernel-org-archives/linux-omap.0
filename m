From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 0/2] PWM Vibrator driver
Date: Tue,  2 May 2017 18:27:24 +0200
Message-ID: <20170502162726.11577-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

The Motorola Droid 4 has a vibrator, that is connected
to two GPIOs. Motorola's stock kernel names them vib_en
and vib_dir, which probably stand for vibrator_enable
and vibrator_direction. In their stock kernel both GPIOs
are toggled using a hrtimer and a custom vibrator "misc"
device is provided to userspace.

Thankfully the hardware designers the used GPIOs can
also be used from OMAP's dmtimers, so that they can
be driven as PWM output instead saving some CPU cycles
(and code).

The driver is loosely based on an old patch from Dmitry,
that I found in the internet(tm) [0]. Note, that I did
not check the generic vibrator stuff. I just kept it in
the driver, since it's probably what other people expect
from a pwm-vibra driver :)

[0] https://lkml.org/lkml/2012/4/10/41

-- Sebastian

Sebastian Reichel (2):
  Input: pwm-vibra: new driver
  ARM: dts: omap4-droid4: Add vibrator

 .../devicetree/bindings/input/pwm-vibrator.txt     |  60 ++++
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  38 +++
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/pwm-vibra.c                     | 348 +++++++++++++++++++++
 5 files changed, 458 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.txt
 create mode 100644 drivers/input/misc/pwm-vibra.c

-- 
2.11.0
