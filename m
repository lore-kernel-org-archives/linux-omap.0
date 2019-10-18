From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 0/7] ARM: DTS: OMAP: add child nodes describing the PVRSGX present in some OMAP SoC
Date: Fri, 18 Oct 2019 20:46:23 +0200
Message-ID: <cover.1571424390.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This patch set defines child nodes for the SGX5xx interface inside
the OMAP SoC so that a driver can be found and probed by the
compatible strings and can retrieve information about the SGX revision
that is included in a specific SoC. It also defines the interrupt number
and the timer to be used by the SGX driver.

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

H. Nikolaus Schaller (7):
  dt-bindings: gpu: pvrsgx: add initial bindings
  ARM: DTS: am33xx: add sgx gpu child node
  ARM: DTS: am3517: add sgx gpu child node
  ARM: DTS: omap3: add sgx gpu child node
  ARM: DTS: omap36xx: add sgx gpu child node
  ARM: DTS: omap4: add sgx gpu child node
  ARM: DTS: omap5: add sgx gpu child node

 .../devicetree/bindings/gpu/img,pvrsgx.txt    | 76 +++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi                 | 11 ++-
 arch/arm/boot/dts/am3517.dtsi                 | 13 ++--
 arch/arm/boot/dts/omap34xx.dtsi               | 13 ++--
 arch/arm/boot/dts/omap36xx.dtsi               | 13 ++--
 arch/arm/boot/dts/omap4.dtsi                  | 11 ++-
 arch/arm/boot/dts/omap4470.dts                | 16 ++++
 arch/arm/boot/dts/omap5.dtsi                  | 12 ++-
 8 files changed, 138 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/img,pvrsgx.txt
 create mode 100644 arch/arm/boot/dts/omap4470.dts

-- 
2.19.1
