From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch 0/3] ARM: dts: dra7: add vpe nodes
Date: Wed, 9 Oct 2019 12:56:25 -0500
Message-ID: <20191009175628.20570-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series adds the needed clkctrl and ty-sysc nodes for VPE module.
We also document the VPE DT bindings.

Benoit Parrot (3):
  dt-bindings: media: ti-vpe: Document VPE driver
  ARM: dts: dra7: add vpe clkctrl node
  ARM: dts: dra7: Add ti-sysc node for VPE

 .../devicetree/bindings/media/ti-vpe.txt      | 48 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 arch/arm/boot/dts/dra7-l4.dtsi                | 30 ++++++++++--
 arch/arm/boot/dts/dra7xx-clocks.dtsi          | 18 ++++++-
 drivers/clk/ti/clk-7xx.c                      |  6 +++
 include/dt-bindings/clock/dra7.h              | 10 ++++
 6 files changed, 108 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/ti-vpe.txt

-- 
2.17.1
