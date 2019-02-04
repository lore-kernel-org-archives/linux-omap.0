From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/4] AM57xx: PRU ICSS Support
Date: Mon, 4 Feb 2019 17:53:53 +0200
Message-ID: <1549295637-24890-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: s-anna@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, david@lechnology.com, woods.technical@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This series adds PRU-ICSS support for AM57xx IDK.

PRU-ICSS is not present only on AM57xx SoCs so the PRUSS
nodes are left disabled in dra7.dtsi. The board that uses
a AM57xx SoC will have to enable them if required.

PRU-ICSS has a SYSC register but it requires custom handling.
So we add a new "ti,sysc-pruss" type to the ti-sysc bus driver.

This series depends on 

[1] - PRU ICSS support v2
 https://lkml.org/lkml/2019/2/4/677

cheers,
-roger

Roger Quadros (2):
  dt-binding: bus: ti-sysc: Add support for PRUSS SYSC type
  bus: ti-sysc: Add support for PRUSS SYSC type

Suman Anna (2):
  ARM: dts: dra7: add PRU-ICSS modules
  ARM: dts: am57xx-idk-common: Enable PRU-ICSS nodes

 Documentation/devicetree/bindings/bus/ti-sysc.txt |   1 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi          |   8 +
 arch/arm/boot/dts/dra7.dtsi                       | 194 ++++++++++++++++++++++
 drivers/bus/ti-sysc.c                             |  77 +++++++++
 include/linux/platform_data/ti-sysc.h             |   1 +
 5 files changed, 281 insertions(+)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
