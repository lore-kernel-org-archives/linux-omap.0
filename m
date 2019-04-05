From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] ARM: dts: dra7: Introduce AM57 dtsi files
Date: Fri, 5 Apr 2019 16:28:04 +0300
Message-ID: <20190405132806.20772-1-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: robh+dt@kernel.org, s-anna@ti.com, nm@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

AM5 and DRA7 SoC families have different set of modules
in them so the SoC sepecific dtsi files need to be seperated.

e.g. Some of the major differences between AM576 and DRA76

	DRA76x	AM576x

USB3		x
USB4		x
ATL		x
VCP		x
MLB		x
ISS		x
PRU-ICSS1		x
PRU-ICSS2		x

This patch only deals with disabling USB3, USB4 and ATL for
AM57 variants.

cheers,
-roger

Roger Quadros (2):
  dt-binding: arm: omap: Add information for AM5748
  ARM: dts: dra7: Separate AM57 dtsi files

 .../devicetree/bindings/arm/omap/omap.txt     |  6 ++++
 arch/arm/boot/dts/am5718.dtsi                 | 32 ++++++++++++++++++
 arch/arm/boot/dts/am571x-idk.dts              |  2 +-
 arch/arm/boot/dts/am5728.dtsi                 | 33 +++++++++++++++++++
 arch/arm/boot/dts/am572x-idk.dts              |  5 ++-
 arch/arm/boot/dts/am5748.dtsi                 | 33 +++++++++++++++++++
 arch/arm/boot/dts/am574x-idk.dts              |  4 +--
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts     |  2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                |  6 ++--
 9 files changed, 113 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/am5718.dtsi
 create mode 100644 arch/arm/boot/dts/am5728.dtsi
 create mode 100644 arch/arm/boot/dts/am5748.dtsi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
