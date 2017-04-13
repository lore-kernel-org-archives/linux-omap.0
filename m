From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH v2 00/22] eeprom: at24: Add OF device ID table
Date: Thu, 13 Apr 2017 15:28:17 -0300
Message-ID: <20170413182839.25381-1-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-i2c@vger.kernel.org, Hongtao Jia <hongtao.jia@nxp.com>, Mark Jackson <mpfj@newflow.co.uk>, Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-arm-kernel@lists.infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Cooper <jason@lakedae>
List-Id: linux-omap@vger.kernel.org

Hello Wolfram,

This series is a follow-up to patch [0] that added an OF device ID table
to the at24 EEPROM driver. As you suggested [1], this version instead of
adding entries for every used <vendor,device> tuple, only adds a single
entry for each chip type using the "atmel" vendor as a generic fallback.

The first patch adds the OF device ID table for the at24 driver and the
next patches adds a generic fallback compatible string to each DTS that
defines a compatible I2C EEPROM device node.

Patches can be applied independently since the DTS change without the
driver change is a no-op and the OF device table won't be used without
the DTS changes.

[0]: https://lkml.org/lkml/2017/3/14/589
[1]: https://lkml.org/lkml/2017/3/15/99

Best regards,
Javier

Changes in v2:
- Only add a single OF device ID entry for each device type (Wolfram Sang).

Javier Martinez Canillas (22):
  dt-bindings: i2c: eeprom: Document manufacturer used as generic
    fallback
  eeprom: at24: Add OF device ID table
  ARM: dts: omap: Add generic compatible string for I2C EEPROM
  ARM: dts: turris-omnia: Add generic compatible string for I2C EEPROM
  ARM: dts: at91: Add generic compatible string for I2C EEPROM
  ARM: dts: efm32: Add generic compatible string for I2C EEPROM
  ARM: dts: imx: Add generic compatible string for I2C EEPROM
  ARM: dts: keystone: Add generic compatible string for I2C EEPROM
  ARM: dts: lpc18xx: Add generic compatible string for I2C EEPROM
  ARM: dts: r7s72100: Add generic compatible string for I2C EEPROM
  ARM: dts: koelsch: Add generic compatible string for I2C EEPROM
  ARM: dts: socfpga: Add generic compatible string for I2C EEPROM
  ARM: dts: uniphier: Add generic compatible string for I2C EEPROM
  ARM: dts: zynq: Add generic compatible string for I2C EEPROM
  arm64: dts: ls1043a: Add generic compatible string for I2C EEPROM
  arm64: zynqmp: Add generic compatible string for I2C EEPROM
  powerpc/5200: Add generic compatible string for I2C EEPROM
  powerpc/fsl: Add generic compatible string for I2C EEPROM
  powerpc/512x: Add generic compatible string for I2C EEPROM
  powerpc/83xx: Add generic compatible string for I2C EEPROM
  powerpc/5200: Add generic compatible string for I2C EEPROM
  powerpc/44x: Add generic compatible string for I2C EEPROM

 .../devicetree/bindings/eeprom/eeprom.txt          |  3 +-
 arch/arm/boot/dts/am335x-baltos.dtsi               |  2 +-
 arch/arm/boot/dts/am335x-base0033.dts              |  2 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          | 10 ++--
 arch/arm/boot/dts/am335x-nano.dts                  |  2 +-
 arch/arm/boot/dts/am335x-pepper.dts                |  2 +-
 arch/arm/boot/dts/am335x-shc.dts                   |  2 +-
 arch/arm/boot/dts/am335x-sl50.dts                  |  2 +-
 arch/arm/boot/dts/am437x-idk-evm.dts               |  2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                |  2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |  2 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |  2 +-
 arch/arm/boot/dts/armada-385-turris-omnia.dts      |  2 +-
 arch/arm/boot/dts/at91-linea.dtsi                  |  2 +-
 arch/arm/boot/dts/at91-tse850-3.dts                |  2 +-
 arch/arm/boot/dts/efm32gg-dk3750.dts               |  2 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi  |  2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |  2 +-
 arch/arm/boot/dts/imx28-evk.dts                    |  2 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi                |  2 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  2 +-
 arch/arm/boot/dts/imx6q-utilite-pro.dts            |  2 +-
 arch/arm/boot/dts/keystone-k2e-evm.dts             |  2 +-
 arch/arm/boot/dts/keystone-k2hk-evm.dts            |  2 +-
 arch/arm/boot/dts/keystone-k2l-evm.dts             |  2 +-
 arch/arm/boot/dts/lpc4337-ciaa.dts                 |  6 +-
 arch/arm/boot/dts/lpc4350-hitex-eval.dts           |  2 +-
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts        |  2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |  2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  2 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi                |  2 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |  2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |  2 +-
 arch/arm/boot/dts/omap5-sbc-t54.dts                |  2 +-
 arch/arm/boot/dts/r7s72100-genmai.dts              |  2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  2 +-
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts |  2 +-
 arch/arm/boot/dts/uniphier-pro4-ace.dts            |  2 +-
 arch/arm/boot/dts/uniphier-pro4-sanji.dts          |  2 +-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts         |  2 +-
 arch/arm/boot/dts/zynq-zc702.dts                   |  2 +-
 arch/arm/boot/dts/zynq-zc706.dts                   |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |  4 +-
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts        |  4 +-
 arch/powerpc/boot/dts/digsy_mtc.dts                |  2 +-
 arch/powerpc/boot/dts/fsl/b4qds.dtsi               |  8 +--
 arch/powerpc/boot/dts/fsl/c293pcie.dts             |  2 +-
 arch/powerpc/boot/dts/fsl/p1010rdb.dtsi            |  2 +-
 arch/powerpc/boot/dts/fsl/p1023rdb.dts             |  2 +-
 arch/powerpc/boot/dts/fsl/p2041rdb.dts             |  4 +-
 arch/powerpc/boot/dts/fsl/p3041ds.dts              |  4 +-
 arch/powerpc/boot/dts/fsl/p4080ds.dts              |  4 +-
 arch/powerpc/boot/dts/fsl/p5020ds.dts              |  4 +-
 arch/powerpc/boot/dts/fsl/p5040ds.dts              |  4 +-
 arch/powerpc/boot/dts/fsl/t208xqds.dtsi            |  8 +--
 arch/powerpc/boot/dts/fsl/t4240qds.dts             | 12 ++--
 arch/powerpc/boot/dts/fsl/t4240rdb.dts             |  6 +-
 arch/powerpc/boot/dts/mpc5121ads.dts               |  2 +-
 arch/powerpc/boot/dts/mpc8308_p1m.dts              |  2 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts             |  2 +-
 arch/powerpc/boot/dts/mpc8377_rdb.dts              |  2 +-
 arch/powerpc/boot/dts/mpc8377_wlan.dts             |  2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts              |  2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts              |  2 +-
 arch/powerpc/boot/dts/pcm030.dts                   |  2 +-
 arch/powerpc/boot/dts/pcm032.dts                   |  2 +-
 arch/powerpc/boot/dts/warp.dts                     |  2 +-
 drivers/misc/eeprom/at24.c                         | 69 +++++++++++++++++++++-
 68 files changed, 162 insertions(+), 94 deletions(-)

-- 
2.9.3
