From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 0/3] PWM Vibrator driver
Date: Fri, 14 Jul 2017 12:01:48 +0200
Message-ID: <20170714100151.31234-1-sebastian.reichel@collabora.co.uk>
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
that I found in the internet(tm) [0]. Since PATCHv4 the
Droid 4 also uses the generic PWM compatible and the
one specific to Motorola has been dropped.

Also I wrote a small tool to test the vibrator running
at different strength levels, since fftest(1) used a
fixed one.

Changes since PATCHv3:
 * Fix kernel doc comment
 * Use switch for error handling of direction pwm
 * Drop spin_lock_irqsave in suspend/resume handler
 * Drop Droid 4 specific code & binding
 * Add direction-duty-cycle-ns DT property
 * Dropped Tested-by due to restructuring
Changes since PATCHv2:
 * Add Kconfig dependency on INPUT_FF_MEMLESS
 * Add Tested-by from Tiny Lindgren
Changes since PATCHv1:
 * move driver removal code to input->close function
 * mark PM functions __maybe_unused and drop #ifdef CONFIG_PM_SLEEP
 * remove duplicate NULL check for vibrator in probe function
 * cancel work in suspend function

[0] https://lkml.org/lkml/2012/4/10/41
[1] https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumble-test.c

-- Sebastian

Sebastian Reichel (3):
  dt-bindings: input: add pwm-vibrator
  Input: pwm-vibra: new driver
  ARM: dts: omap4-droid4: Add vibrator

 .../devicetree/bindings/input/pwm-vibrator.txt     |  66 +++++
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  40 +++
 drivers/input/misc/Kconfig                         |  12 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/pwm-vibra.c                     | 267 +++++++++++++++++++++
 5 files changed, 386 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.txt
 create mode 100644 drivers/input/misc/pwm-vibra.c

-- 
2.13.2
