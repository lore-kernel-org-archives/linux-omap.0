From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 2/6] ARM: dts: OMAP5: Add 60MHz clock reference to USB Host
 module
Date: Tue, 8 Oct 2013 13:06:35 +0300
Message-ID: <1381226799-29158-3-git-send-email-rogerq@ti.com>
References: <1381226799-29158-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1381226799-29158-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

USB Host driver (drivers/mfd/omap-usb-host.c) expects the 60MHz
reference clock to be named "init_60m_fclk". Provide this
information.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index edc801f..6f98be2 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -703,6 +703,8 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			clocks = <&l3init_60m_fclk>;
+			clock-names = "init_60m_fclk";
 
 			usbhsohci: ohci@4a064800 {
 				compatible = "ti,ohci-omap3", "usb-ohci";
-- 
1.7.4.1
