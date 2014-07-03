From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5] ARM: dts: AM43x: Add devcice tree nodes
Date: Thu, 3 Jul 2014 19:14:57 +0530
Message-ID: <1404395102-21469-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The patch series adds the device tree nodes and the corresponding
documentation. The series also enabled tps65218 config options
in the omap2plus_defconfig.

The series is boot tested on both AM43x-epos-evm and AM437x-gp-evm.

Keerthy (5):
  mfd: Add DT bindings for tps65218 PMIC
  regulator: Add DT bindings for tps65218 PMIC regulators.
  ARM: dts: AM43x: Add TPS65218 device tree nodes
  ARM: dts: AM437x: Add TPS65218 device tree nodes
  ARM: configs: omap2plus_defconfig: enable TPS65218 configs

 Documentation/devicetree/bindings/mfd/tps65218.txt |   57 ++++++++++++++++++++
 .../devicetree/bindings/regulator/tps65218.txt     |   21 ++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts                |   38 +++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts               |   38 +++++++++++++
 arch/arm/configs/omap2plus_defconfig               |    2 +
 5 files changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/tps65218.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/tps65218.txt

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
