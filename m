From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 00/10] ARM: dts: use syscon property instead of ctrl-module
Date: Tue, 4 Aug 2015 21:00:23 +0530
Message-ID: <1438702233-8027-1-git-send-email-kishon@ti.com>
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
To: rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nsekhar@ti.com, linux@arm.linux.org.uk, bcousson@baylibre.com, balbi@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

This series is split from [1] to include only the dt patches.

This series is basically to deprecate using ctrl-module property and use
corresponding syscon properties to program the control module registers.

Changes from [1] in PHY patches include
*) series created after applying [2]

Did basic enumeration testing in the below platforms.
*) Tested PCIe, SATA and USB in dra7
*) Tested SATA and USB in omap5
*) Tested USB(dwc3) in am43xx_evm
*) Tested USB(musb) in omap4 panda after including [3]

All the testing was done after applying [4]

[1] -> https://lkml.org/lkml/2015/6/23/189
[2] -> http://www.spinics.net/lists/linux-omap/msg120644.html
[3] -> http://permalink.gmane.org/gmane.linux.kernel/2012427
[4] -> http://permalink.gmane.org/gmane.linux.kernel/2012604

Kishon Vijay Abraham I (10):
  ARM: dts: dra7: Add dt node for PCIe registers in sysctrl space
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

 arch/arm/boot/dts/am4372.dtsi |   16 ++--------
 arch/arm/boot/dts/dra7.dtsi   |   69 ++++++++++-------------------------------
 arch/arm/boot/dts/omap4.dtsi  |   16 ++--------
 arch/arm/boot/dts/omap5.dtsi  |   26 ++--------------
 4 files changed, 24 insertions(+), 103 deletions(-)

-- 
1.7.9.5
