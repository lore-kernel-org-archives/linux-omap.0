From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 2/8] phy: ti-pipe3: Add clocks to PIPE3 PHY Documentation
 binding
Date: Fri, 7 Mar 2014 12:15:02 +0200
Message-ID: <1394187308-19622-3-git-send-email-rogerq@ti.com>
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

Add wakeup, system and reference clocks to DT binding documentation.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 073a623..96ba29e 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -59,6 +59,12 @@ Required properties:
    filled in "reg".
  - #phy-cells: determine the number of cells that should be given in the
    phandle while referencing this phy.
+ - clocks: a list of phandles and clock-specifier pairs, one for each entry in
+   clock-names.
+ - clock-names: should include:
+   * "wkupclk" - wakeup clock.
+   * "sysclk" - system clock.
+   * "refclk" - reference clock.
 
 Optional properties:
  - ctrl-module : phandle of the control module used by PHY driver to power on
@@ -74,4 +80,10 @@ usb3phy@4a084400 {
 	reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 	ctrl-module = <&omap_control_usb>;
 	#phy-cells = <0>;
+	clocks = <&usb_phy_cm_clk32k>,
+		 <&sys_clkin>,
+		 <&usb_otg_ss_refclk960m>;
+	clock-names =	"wkupclk",
+			"sysclk",
+			"refclk";
 };
-- 
1.8.3.2
