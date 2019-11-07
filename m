From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 0/8] ARM/MIPS: DTS: add child nodes describing the PVRSGX present in some OMAP SoC and JZ4780
Date: Thu,  7 Nov 2019 12:06:03 +0100
Message-ID: <cover.1573124770.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-mips@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Changes:
* tried convert bindings to YAML format - suggested by Rob Herring
* added JZ4780 DTS node (proven to load the driver)
* removed timer and img,cores properties until we know we really need them - suggested by Rob Herring

PATCH V1 2019-10-18 20:46:35:

This patch set defines child nodes for the SGX5xx interface inside
the OMAP SoC so that a driver can be found and probed by the
compatible strings and can retrieve information about the SGX revision
that is included in a specific SoC. It also defines the interrupt number
to be used by the SGX driver.

There is currently no mainline driver for these GPUs, but a project [1]
is ongoing with the goal to get the open-source part as provided by TI/IMG
into drivers/staging/pvr.

The kernel modules built from this project have successfully demonstrated
to work with the DTS definitions from this patch set on AM335x BeagleBone
Black and OMAP5 Pyra. They partially works on DM3730 and PandaBoard ES but
that is likely a problem in the kernel driver or the (non-free) user-space
blobs.

There is potential to extend this work to JZ4780 (CI20 board) and
BananaPi-M3 (A83) and even some Intel Poulsbo and CedarView devices.

[1]: https://github.com/openpvrsgx-devgroup

H. Nikolaus Schaller (8):
  RFC: dt-bindings: add img,pvrsgx.yaml for Imagination GPUs
  ARM: DTS: am33xx: add sgx gpu child node
  ARM: DTS: am3517: add sgx gpu child node
  ARM: DTS: omap3: add sgx gpu child node
  ARM: DTS: omap36xx: add sgx gpu child node
  ARM: DTS: omap4: add sgx gpu child node
  ARM: DTS: omap5: add sgx gpu child node
  MIPS: DTS: jz4780: add sgx gpu node

 .../devicetree/bindings/gpu/img,pvrsgx.yaml   | 128 ++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi                 |   9 +-
 arch/arm/boot/dts/am3517.dtsi                 |  11 +-
 arch/arm/boot/dts/omap34xx.dtsi               |  11 +-
 arch/arm/boot/dts/omap36xx.dtsi               |  11 +-
 arch/arm/boot/dts/omap4.dtsi                  |   9 +-
 arch/arm/boot/dts/omap4470.dts                |  15 ++
 arch/arm/boot/dts/omap5.dtsi                  |   9 +-
 arch/mips/boot/dts/ingenic/jz4780.dtsi        |  11 ++
 9 files changed, 187 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
 create mode 100644 arch/arm/boot/dts/omap4470.dts

-- 
2.23.0
