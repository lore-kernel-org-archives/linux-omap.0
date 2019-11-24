From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 0/8] ARM/MIPS: DTS: add child nodes describing the PVRSGX GPU present in some OMAP SoC and JZ4780 (and many more)
Date: Sun, 24 Nov 2019 12:40:20 +0100
Message-ID: <cover.1574595627.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-mips@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

* reworked YAML format with help by Rob Herring
* removed .txt binding document
* change compatible "ti,am335x-sgx" to "ti,am3352-sgx" - suggested by Tony Lindgren

PATCH V2 2019-11-07 12:06:17:
* tried to convert bindings to YAML format - suggested by Rob Herring
* added JZ4780 DTS node (proven to load the driver)
* removed timer and img,cores properties until we know we really need them - suggested by Rob Herring

PATCH V1 2019-10-18 20:46:35:

This patch series defines child nodes for the SGX5xx interface inside
different SoC so that a driver can be found and probed by the
compatible strings and can retrieve information about the SGX revision
that is included in a specific SoC. It also defines the interrupt number
to be used by the SGX driver.

There is currently no mainline driver for these GPUs, but a project [1]
is ongoing with the goal to get the open-source part as provided by TI/IMG
and others into drivers/gpu/drm/pvrsgx.

The kernel modules built from this project have successfully demonstrated
to work with the DTS definitions from this patch set on AM335x BeagleBone
Black, DM3730 and OMAP5 Pyra and Droid 4. They partially work on OMAP3530 and
PandaBoard ES but that is likely a problem in the kernel driver or the
(non-free) user-space libraries and binaries.

Wotk for JZ4780 (CI20 board) is in progress and there is potential to extend
this work to e.g. BananaPi-M3 (A83) and  some Intel Poulsbo and CedarView
devices.

[1]: https://github.com/openpvrsgx-devgroup


H. Nikolaus Schaller (8):
  dt-bindings: add img,pvrsgx.yaml for Imagination GPUs
  ARM: DTS: am33xx: add sgx gpu child node
  ARM: DTS: am3517: add sgx gpu child node
  ARM: DTS: omap3: add sgx gpu child node
  ARM: DTS: omap36xx: add sgx gpu child node
  ARM: DTS: omap4: add sgx gpu child node
  ARM: DTS: omap5: add sgx gpu child node
  MIPS: DTS: jz4780: add sgx gpu node

 .../devicetree/bindings/gpu/img,pvrsgx.yaml   | 83 +++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi                 | 38 ++++++++-
 arch/arm/boot/dts/am3517.dtsi                 | 11 +--
 arch/arm/boot/dts/omap34xx.dtsi               | 11 +--
 arch/arm/boot/dts/omap36xx.dtsi               | 11 +--
 arch/arm/boot/dts/omap4.dtsi                  |  9 +-
 arch/arm/boot/dts/omap4470.dts                | 15 ++++
 arch/arm/boot/dts/omap5.dtsi                  |  9 +-
 arch/mips/boot/dts/ingenic/jz4780.dtsi        | 11 +++
 9 files changed, 171 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
 create mode 100644 arch/arm/boot/dts/omap4470.dts

-- 
2.23.0
