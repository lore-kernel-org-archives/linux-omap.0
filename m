From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 0/8] drivers: touchscreen: tsc2007 and ads7846/tsc2046 improvements (use common touchscreen bindings, pre-calibration, spi fix and provide iio raw values)
Date: Fri, 13 Nov 2015 21:35:51 +0100
Message-ID: <cover.1447446957.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Haibo Chen <haibo.chen@freescale.com>, Andrey Gelman <andrey.gelman@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>, Aaron Sierra <asierra@xes-inc.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Changes V2:
* add a patch to make drivers still recognise the old "ti,swap-xy" property (suggested by Rob Herring)

2015-11-06 16:14:53: This patch series improves the drivers for the tsc2007 and
ads7846/tsc2046 touchscreen controllers which are e.g. used by the GTA04
OpenPandora and Pyra devices.

New common bindings have been defined by commit b98abe52fa8e:

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
  DT:omap3+tsc2007: use new common touchscreen bindings
  drivers:input:ads7846(+tsc2046): add new common binding names,
    pre-calibration and flipping
  drivers:input:ads7846(+tsc2046): recognise old binding for coordinate
    flipping
  drivers:input:ads7846(+tsc2046): fix spi module table
  DT:omap3+ads7846: use new common touchscreen bindings

 .../devicetree/bindings/input/ads7846.txt          |   8 +-
 .../bindings/input/touchscreen/tsc2007.txt         |  20 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  18 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |  17 +-
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |   2 +-
 drivers/input/touchscreen/Kconfig                  |   1 +
 drivers/input/touchscreen/ads7846.c                |  85 +++++-
 drivers/input/touchscreen/tsc2007.c                | 286 +++++++++++++++++++--
 include/linux/i2c/tsc2007.h                        |   8 +
 10 files changed, 401 insertions(+), 46 deletions(-)

-- 
2.5.1
