From: George Cherian <george.cherian@ti.com>
Subject: [PATCH v4 0/5] Add USB nodes for am43xx epos and gp evm
Date: Thu, 13 Mar 2014 20:41:11 +0530
Message-ID: <1394723476-8580-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, rogerq@ti.com, kishon@ti.com, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, tony@atomide.com, anatol.pomozov@gmail.com, bcousson@baylibre.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

The patch series adds USB dt nodes for am43xx epos and gp evm
Boot tested with linux-next + Tony's omap-for-v3.15/dt

Changes from v1 -> v2
	* Reorder "doc: Add "ti,am437x-dwc3" comaptible for dwc3 glue"
	* Address v1 coments on "ARM: dts: AM4372: Add USB nodes"  

Changes from v2 -> v3
	* Removed unwanted dwc3_1 and dwc3_2 nodes from am437x-gp-evm.dts 
	  and am43x-epos-evm.dts 

Changes from v3 -> v4
	* Refreshed on top of Tony's omap-for-v3.15/dt tree
	* Added usb_phy0_always_on_clk32k and usb_phy1_always_on_clk32k Patch 2
	* Used the above clocks in Patch 3 
	* Patch 4 and 5 edited the unwanted portions of commit log

George Cherian (5):
  doc: Add "ti,am437x-dwc3" comaptible for dwc3 glue
  ARM: dts: am43xx clock data
  ARM: dts: AM4372: Add USB nodes
  ARM: dts: am437x-gp-evm: Enable USB
  ARM: dts: am43x-epos-evm: Enable USB

 Documentation/devicetree/bindings/usb/omap-usb.txt |  4 +-
 arch/arm/boot/dts/am4372.dtsi                      | 94 ++++++++++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts                | 26 ++++++
 arch/arm/boot/dts/am43x-epos-evm.dts               | 27 +++++++
 arch/arm/boot/dts/am43xx-clocks.dtsi               | 33 ++++++++
 5 files changed, 183 insertions(+), 1 deletion(-)

-- 
1.8.3.1

