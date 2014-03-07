From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 4/8] ARM: dts: omap5: Add clocks to USB3 PHY node
Date: Fri, 7 Mar 2014 12:15:04 +0200
Message-ID: <1394187308-19622-5-git-send-email-rogerq@ti.com>
References: <1394187308-19622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394187308-19622-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com, tony@atomide.com
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, balajitk@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, hdegoede@redhat.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

The USB3 PHY driver now expects named clocks. Add the
relevant clocks to the USB3 PHY node.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 859a800..88bd327 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -779,6 +779,12 @@
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 				ctrl-module = <&omap_control_usb3phy>;
+				clocks = <&usb_phy_cm_clk32k>,
+					 <&sys_clkin>,
+					 <&usb_otg_ss_refclk960m>;
+				clock-names =	"wkupclk",
+						"sysclk",
+						"refclk";
 				#phy-cells = <0>;
 			};
 		};
-- 
1.8.3.2
