From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/13] ARM: dts: OMAP2+: Enable gpio controller for GPMC and add NAND ready pin
Date: Thu, 7 Apr 2016 13:25:27 +0300
Message-ID: <1460024740-19716-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

We will be adding gpio controller support to GPMC in [1].
The GPIO controller can also be used to provide the Read/Busy#
pin status to the OMAP2+ nand driver.

These patches enable the gpio controller in the gpmc nodes
and add ready pin information to the NAND nodes.

Tested on dra-evm, am437x-gp-evm, beagleboard-c4.

[1] - http://thread.gmane.org/gmane.linux.kernel/2192971

cheers,
-roger

Roger Quadros (13):
  ARM: dts: omap24xx: Enable gpio and interrupt controller for GPMC
  ARM: dts: omap4: Enable gpio and interrupt controller for GPMC
  ARM: dts: omap5: Enable gpio and interrupt controller for GPMC
  ARM: dts: dra7: Enable gpio controller for GPMC
  ARM: dts: am335x: Enable gpio controller for GPMC
  ARM: dts: am4372: Enable gpio controller for GPMC
  ARM: dts: omap3: Enable gpio controller for GPMC
  ARM: dts: dm814x: Enable gpio controller for GPMC
  ARM: dts: dm816x: Enable gpio controller for GPMC
  ARM: dts: dra7x-evm: Provide NAND ready pin
  ARM: dts: am437x: Provide NAND ready pin
  ARM: dts: am335x: Provide NAND ready pin
  ARM: dts: omap3-beagle: Provide NAND ready pin

 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 1 +
 arch/arm/boot/dts/am335x-chilisom.dtsi     | 1 +
 arch/arm/boot/dts/am335x-cm-t335.dts       | 1 +
 arch/arm/boot/dts/am335x-evm.dts           | 1 +
 arch/arm/boot/dts/am335x-igep0033.dtsi     | 1 +
 arch/arm/boot/dts/am335x-phycore-som.dtsi  | 1 +
 arch/arm/boot/dts/am33xx.dtsi              | 2 ++
 arch/arm/boot/dts/am4372.dtsi              | 2 ++
 arch/arm/boot/dts/am437x-gp-evm.dts        | 1 +
 arch/arm/boot/dts/am43x-epos-evm.dts       | 1 +
 arch/arm/boot/dts/dm814x.dtsi              | 2 ++
 arch/arm/boot/dts/dm816x.dtsi              | 2 ++
 arch/arm/boot/dts/dra7-evm.dts             | 1 +
 arch/arm/boot/dts/dra7.dtsi                | 2 ++
 arch/arm/boot/dts/dra72-evm.dts            | 1 +
 arch/arm/boot/dts/omap2420.dtsi            | 4 ++++
 arch/arm/boot/dts/omap2430.dtsi            | 4 ++++
 arch/arm/boot/dts/omap3-beagle.dts         | 1 +
 arch/arm/boot/dts/omap3.dtsi               | 2 ++
 arch/arm/boot/dts/omap4.dtsi               | 4 ++++
 arch/arm/boot/dts/omap5.dtsi               | 4 ++++
 21 files changed, 39 insertions(+)

-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
