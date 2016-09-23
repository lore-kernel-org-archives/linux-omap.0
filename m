From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 0/8] drivers: touchscreen: tsc2007 and ads7846/tsc2046 improvements (use common touchscreen bindings, pre-calibration, spi fix and provide iio raw values)
Date: Fri, 23 Sep 2016 14:41:08 +0200
Message-ID: <cover.1474634475.git.hns@goldelico.com>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

It was quite a while ago that this patch set was in review, but here is a new version for consideration.

Changes V3:
* fix an issue with swapping
* remove hard clipping to min/max rectangle - some systems expect to handle negative coordinates
* make use of commit ed7c9870c9bc ("Input: of_touchscreen - add support for inverted / swapped axes")

2015-11-13 21:36:07: Changes V2:
* add a patch to make drivers still recognise the old "ti,swap-xy" property (suggested by Rob Herring)

2015-11-06 16:14:53: This patch series improves the drivers for the tsc2007 and
ads7846/tsc2046 touchscreen controllers which are e.g. used by the GTA04
OpenPandora and Pyra devices.

New common bindings have been defined by
commit b98abe52fa8e ("Input: add common DT binding for touchscreens"):

	Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

which also defines a helper function to parse the DT. These new parameters
allow to specify the fuzz factors (jitter suppression), inversion of x or y axis and
swapping of x and y to achieve inversion and rotation so that the touch
coordinate axes match the natural orientation of the display panel.

Another improvement is to better use the min/max ADC values and
scale to the screen size as defined by the DT. This allows to coarsely
calibrate the touch to match the LCD to which it is glued on so that the
touch can quite precisely be operated before any user-space fine-calibration
can be (and needs to be) started.

For the adc7846 we fix an issue with the spi module table.

Finally we add an iio interface for the AUX and temperature ADC channels of
the tsc2007 and also provide the touch screen raw values. This allows to read
an optional ambient light sensor installed on the gta04 board and improves
calibration and hardware monitoring.


H. Nikolaus Schaller (8):
  drivers:input:tsc2007: add new common binding names, pre-calibration,
    flipping and rotation
  drivers:input:tsc2007: send pendown and penup only once like
    ads7846(+tsc2046) driver does
  drivers:input:tsc2007: add iio interface to read external ADC input,
    temperature and raw conversion values
  drivers:input:tsc2007: check for presence and power down tsc2007
    during probe
  DT:omap3+tsc2007: use new common touchscreen bindings
  drivers:input:ads7846(+tsc2046): add new common binding names,
    pre-calibration and flipping
  drivers:input:ads7846(+tsc2046): fix spi module table
  DT:omap3+ads7846: use new common touchscreen bindings

 .../devicetree/bindings/input/ads7846.txt          |   9 +-
 .../bindings/input/touchscreen/tsc2007.txt         |  20 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  25 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |  17 +-
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |   3 +-
 drivers/input/touchscreen/Kconfig                  |   1 +
 drivers/input/touchscreen/ads7846.c                |  71 +++++-
 drivers/input/touchscreen/tsc2007.c                | 281 +++++++++++++++++++--
 include/linux/i2c/tsc2007.h                        |   8 +
 10 files changed, 382 insertions(+), 55 deletions(-)

-- 
2.7.3

