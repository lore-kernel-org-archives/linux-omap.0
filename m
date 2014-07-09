From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/7] ARM: dts: AM43x: Add devcice tree nodes
Date: Wed, 9 Jul 2014 11:06:26 +0530
Message-ID: <1404884193-20580-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The patch series adds the device tree nodes and the corresponding
documentation. The series also enabled tps65218 config options
in the omap2plus_defconfig.

The series is boot tested on both AM43x-epos-evm and AM437x-gp-evm.

Keerthy (7):
  regulator: tps65218: Add fixed_uV fields for dcdc5 and dcdc6
  mfd: Add DT bindings for tps65218 PMIC
  regulator: Add DT bindings for tps65218 PMIC regulators.
  ARM: dts: AM43x: Add TPS65218 device tree nodes
  ARM: dts: AM437x: Fix i2c nodes indentation
  ARM: dts: AM437x: Add TPS65218 device tree nodes
  ARM: configs: omap2plus_defconfig: enable TPS65218 configs

 Documentation/devicetree/bindings/mfd/tps65218.txt |   89 ++++++++++++++++++++
 .../devicetree/bindings/regulator/tps65218.txt     |   23 +++++
 arch/arm/boot/dts/am437x-gp-evm.dts                |   71 ++++++++++++++--
 arch/arm/boot/dts/am43x-epos-evm.dts               |   59 +++++++++++++
 arch/arm/configs/omap2plus_defconfig               |    2 +
 drivers/regulator/tps65218-regulator.c             |   17 ++--
 6 files changed, 246 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/tps65218.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/tps65218.txt

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
