From: George Cherian <george.cherian@ti.com>
Subject: [PATCH v2 0/5] Add USB nodes for am43xx epos and gp evm
Date: Fri, 7 Mar 2014 14:45:53 +0530
Message-ID: <1394183758-3821-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, rogerq@ti.com, kishon@ti.com, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, tony@atomide.com, anatol.pomozov@gmail.com, bcousson@baylibre.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

The patch series adds USB dt nodes for am43xx epos and gp evm

Boot tested with  Benoit's for_3.15 + following patches

https://patchwork.kernel.org/patch/3600821/
https://patchwork.kernel.org/patch/3600831/
https://patchwork.kernel.org/patch/3600851/
https://patchwork.kernel.org/patch/3600841/


Changes from v1 -> v2
	* Reorder "doc: Add "ti,am437x-dwc3" comaptible for dwc3 glue"
	* Address v1 coments on "ARM: dts: AM4372: Add USB nodes"  


George Cherian (5):
  doc: Add "ti,am437x-dwc3" comaptible for dwc3 glue
  ARM: dts: am43xx clock data
  ARM: dts: AM4372: Add USB nodes
  ARM: dts: am437x-gp-evm: Enable USB
  ARM: dts: am43x-epos-evm: Enable USB

 Documentation/devicetree/bindings/usb/omap-usb.txt |  4 +-
 arch/arm/boot/dts/am4372.dtsi                      | 95 ++++++++++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts                | 28 +++++++
 arch/arm/boot/dts/am43x-epos-evm.dts               | 27 ++++++
 arch/arm/boot/dts/am43xx-clocks.dtsi               | 17 ++++
 5 files changed, 170 insertions(+), 1 deletion(-)

-- 
1.8.3.1

