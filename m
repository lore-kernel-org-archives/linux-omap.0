From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH v5 0/8] mfd: Add OF device table to I2C drivers that are missing it
Date: Wed, 12 Apr 2017 14:27:51 -0300
Message-ID: <20170412172800.23035-1-javier@osg.samsung.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,

This series add OF device ID tables to mfd I2C drivers whose devices are
either used in Device Tree source files or are listed in binding docs as
a compatible string.

That's done because the plan is to change the I2C core to report proper OF
modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
a device was registered via DT or using the legacy platform data mechanism.

So these patches will make sure that mfd I2C drivers modules will continue
to be autoloaded once the I2C core is changed to report proper OF modalias.

Users didn't have a vendor prefix in the used compatible strings, but since
there wasn't a DT binding document for these drivers, it can be said that
were working for mere luck and so this series fixes the users and add a DT
binding doc for the drivers.

Most patches can be applied independently, with the exception of patches
2 to 4 that should be applied in the same tree to keep bisect-ability. I
suggest these to go through the MFD subsystem tree.

Best regards,
Javier

Changes in v5:
- Add missing properties for interrupts to DT binding doc (Rob Herring).
- Add Rob Herring's Acked-by tag.
- Add Aaro Koskinen's Acked-by tag.
- Add Acked-by: Tony Lindgren <tony@atomide.com>'s Acked-by tag.
- Add Lee Jones <lee.jones@linaro.org>'s Acked-by tag.
- Add Rob Herring's Acked-by tag.
- Add Aaro Koskinen's Acked-by tag.
- Add Acked-by: Tony Lindgren <tony@atomide.com>'s Acked-by tag.
- Add Rob Herring's Acked-by tag.
- Add Aaro Koskinen's Acked-by tag.
- Add Acked-by: Tony Lindgren <tony@atomide.com>'s Acked-by tag.
- Add Lee Jones <lee.jones@linaro.org>'s Acked-by tag.
- Add Rob Herring's Acked-by tag.
- Add Aaro Koskinen's Acked-by tag.
- Add Acked-by: Tony Lindgren <tony@atomide.com>'s Acked-by tag.
- Add Rob Herring's Acked-by tag.
- Add Aaro Koskinen's Acked-by tag.
- Add Acked-by: Tony Lindgren <tony@atomide.com>'s Acked-by tag.
- Add Rob Herring's Acked-by tag.
- Add Acked-by: Tony Lindgren <tony@atomide.com>'s Acked-by tag.
- Add Rob Herring's Acked-by tag.
- Add Acked-by: Tony Lindgren <tony@atomide.com>'s Acked-by tag.
- Add Lee Jones <lee.jones@linaro.org>'s Acked-by tag.
- Add Rob Herring's Acked-by tag.
- Add Acked-by: Tony Lindgren <tony@atomide.com>'s Acked-by tag.

Changes in v4:
- Use "dt-bindings: mfd:" prefix in subject line (Rob Herring).
- Add information about what functions the device serve (Lee Jones).
- Avoid using MFD in Device Tree (Lee Jones).
- Drop -mfd suffix in compatible string (Lee Jones).
- Avoid using MFD in Device Tree (Lee Jones).
- Use "dt-bindings: mfd:" prefix in subject line (Rob Herring).
- Add information about what functions the device serve (Lee Jones).

Changes in v3:
- Add a vendor prefix to the compatible string (Rob Herring).
- Add a vendor prefix to the compatible string (Rob Herring).

Changes in v2:
- Don't use of_match_ptr() to avoid build warning when CONFIG_OF is disabled.
- Don't use of_match_ptr() to avoid build warning when CONFIG_OF is disabled.

Javier Martinez Canillas (8):
  dt-bindings: mfd: Add retu/tahvo ASIC chips bindings
  mfd: retu: Drop -mfd suffix from I2C device ID name
  mfd: retu: Add OF device ID table
  ARM: dts: n8x0: Add vendor prefix to retu node
  i2c: i2c-cbus-gpio: Add vendor prefix to retu node in example
  dt-bindings: mfd: Add TI tps6105x chip bindings
  mfd: tps6105x: Add OF device ID table
  ARM: ux500: Add vendor prefix to tps61052 node

 .../devicetree/bindings/i2c/i2c-cbus-gpio.txt      |  4 ++--
 Documentation/devicetree/bindings/mfd/retu.txt     | 23 ++++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/tps6105x.txt | 17 ++++++++++++++++
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |  4 ++--
 arch/arm/boot/dts/ste-hrefprev60.dtsi              |  2 +-
 arch/arm/mach-omap1/board-nokia770.c               |  4 ++--
 drivers/mfd/retu-mfd.c                             | 12 +++++++++--
 drivers/mfd/tps6105x.c                             |  8 ++++++++
 8 files changed, 65 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/retu.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/tps6105x.txt

-- 
2.9.3
