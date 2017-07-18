From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD, ARM and I2C due for the
 v4.14 merge window
Date: Tue, 18 Jul 2017 09:04:41 +0100
Message-ID: <20170718080441.g3kmastovt32y33y@dell>
References: <20170615184928.12007-1-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170615184928.12007-1-javier@dowhile0.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Enjoy!

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-arm-i2c-v4.14

for you to fetch changes up to ea5ae803192eb2b03e0bd23db63d2f355fd23eda:

  ARM: ux500: Add vendor prefix to tps61052 node (2017-07-18 08:27:46 +0100)

----------------------------------------------------------------
Immutable branch between MFD, ARM and I2C due for the v4.14 merge window

----------------------------------------------------------------
Javier Martinez Canillas (8):
      dt-bindings: mfd: Add retu/tahvo ASIC chips bindings
      mfd: retu: Drop -mfd suffix from I2C device ID name
      ARM: dts: n8x0: Add vendor prefix to retu node
      mfd: retu: Add OF device ID table
      i2c: i2c-cbus-gpio: Add vendor prefix to retu node in example
      dt-bindings: mfd: Add TI tps6105x chip bindings
      mfd: tps6105x: Add OF device ID table
      ARM: ux500: Add vendor prefix to tps61052 node

 .../devicetree/bindings/i2c/i2c-cbus-gpio.txt      |  4 ++--
 Documentation/devicetree/bindings/mfd/retu.txt     | 25 ++++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/tps6105x.txt | 17 +++++++++++++++
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |  4 ++--
 arch/arm/boot/dts/ste-hrefprev60.dtsi              |  2 +-
 arch/arm/mach-omap1/board-nokia770.c               |  4 ++--
 drivers/mfd/retu-mfd.c                             | 12 +++++++++--
 drivers/mfd/tps6105x.c                             |  8 +++++++
 8 files changed, 67 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/retu.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/tps6105x.txt

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
