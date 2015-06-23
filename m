From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 00/17] Deprecate phy-omap-control and use SYSCON
Date: Tue, 23 Jun 2015 17:28:45 +0530
Message-ID: <1435060743-5511-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com, tony@atomide.com, balbi@ti.com, rogerq@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, kishon@ti.com
Cc: mark.rutland@arm.com, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, gregkh@linuxfoundation.org, nsekhar@ti.com, robh+dt@kernel.org, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

phy-omap-control driver was added when there was no proper
infrastructure for doing control module initializations.
Now with SYSCON framework being added to the kernel, phy-omap-control
shouldn't be needed.

This series is about adapting phy-omap-usb2, phy-ti-pipe3 and omap2430
to use SYSCON framework instead of phy-omap-control.
However we can't remove the phy-omap-control driver altogether since
that will break older dtbs.

Performed USB enumeration testing in DRA72-EVM, AM43XX-EVM, OMAP5-uEVM
and OMAP4 PANDA.

Performed SATA enumeration testing in DRA72-EVM and OMAP5-uEVM

Performed PCIe enumeration testing in DRA72-EVM.

This patch series is developed on top of Linux 4.1-rc8 +
http://lkml.iu.edu/hypermail/linux/kernel/1505.1/03099.html

Kishon Vijay Abraham I (17):
  phy: ti-pipe3: use ti_pipe3_power_off to power off the PHY during
    probe
  phy: ti-pipe3: use *syscon* framework to power on/off the PHY
  phy: ti-pipe3: use *syscon* framework to set PCS value of the PHY
  phy: omap-usb2: use omap_usb_power_off to power off the PHY during
    probe
  phy: omap-usb2: Add a new compatible string for USB2 PHY2
  phy: omap-usb2: use *syscon* framework to power on/off the PHY
  usb: musb: omap2430: use *syscon* framework to write to mailbox
    register
  ARM: dts: dra7: Add dt node for the sycon pcie
  ARM: dts: dra7: Use "syscon-phy-power" instead of "ctrl-module" in
    SATA PHY node
  ARM: dts: dra7: Use "syscon-phy-power" and "syscon-pcs" in PCIe PHY
    node
  ARM: dts: dra7: Use "ti,dra7x-usb2-phy2" compatible string for USB2
    PHY2
  ARM: dts: dra7: Use "syscon-phy-power" instead of "ctrl-module" in
    USB PHY node
  ARM: dts: am4372: Use "syscon-phy-power" instead of "ctrl-module" in
    USB PHY node
  ARM: dts: OMAP5: Use "syscon-phy-power" instead of "ctrl-module" in
    USB PHY node
  ARM: dts: OMAP5: Use "syscon-phy-power" instead of "ctrl-module" in
    SATA PHY node
  ARM: dts: omap4: Use "syscon-phy-power" instead of "ctrl-module" in
    USB PHY node
  ARM: dts: omap4: Use "syscon-otghs" instead of "ctrl-module" in USB
    node

 Documentation/devicetree/bindings/phy/ti-phy.txt   |   20 +++-
 Documentation/devicetree/bindings/usb/omap-usb.txt |    7 +-
 arch/arm/boot/dts/am4372.dtsi                      |   16 +--
 arch/arm/boot/dts/dra7.dtsi                        |   69 +++--------
 arch/arm/boot/dts/omap4.dtsi                       |   16 +--
 arch/arm/boot/dts/omap5.dtsi                       |   26 +---
 drivers/phy/phy-omap-usb2.c                        |  112 +++++++++++++++---
 drivers/phy/phy-ti-pipe3.c                         |  125 +++++++++++++++++---
 drivers/usb/musb/omap2430.c                        |  118 ++++++++++++++----
 include/linux/phy/omap_usb.h                       |   18 +++
 10 files changed, 365 insertions(+), 162 deletions(-)

-- 
1.7.9.5
