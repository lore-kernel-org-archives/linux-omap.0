From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 0/2] AM335x-ICE: Add support for rotary switch
Date: Wed, 24 Aug 2016 13:28:57 +0530
Message-ID: <20160824075859.30979-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Daniel Hung-yu Wu <hywu@google.com>, Grant Grundler <grundler@chromium.org>, S Twiss <stwiss.opensource@diasemi.com>, Vignesh R <vigneshr@ti.com>, Moritz Fischer <moritz.fischer@ettus.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, John Stultz <john.stultz@linaro.org>, "Andrew F . Davis" <afd@ti.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This series adds support for rotary-switch on AM335x-ICE that is
connected to TI PCA9536 I2C GPIO expander.
First patch adds new generic driver to read status of group of GPIO
lines and report the value as an input event. The second patch adds DT
entries for the same.

v2: https://lkml.org/lkml/2016/8/23/111
v1: https://lkml.org/lkml/2016/8/12/7


Vignesh R (2):
  input: misc: Add generic input driver to read encoded GPIO lines
  ARM: dts: am335x-icev2: Add nodes for gpio-decoder

 .../devicetree/bindings/input/gpio-decoder.txt     |  23 ++++
 arch/arm/boot/dts/am335x-icev2.dts                 |   9 ++
 drivers/input/misc/Kconfig                         |  12 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/gpio_decoder.c                  | 134 +++++++++++++++++++++
 5 files changed, 179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-decoder.txt
 create mode 100644 drivers/input/misc/gpio_decoder.c

-- 
2.9.2
