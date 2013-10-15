From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 3/7] Documentation: dt bindings: move ..usb/usb-phy.txt to
 ..phy/ti-phy.txt
Date: Wed, 16 Oct 2013 01:24:13 +0530
Message-ID: <1381866857-3861-4-git-send-email-kishon@ti.com>
References: <1381866857-3861-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1381866857-3861-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kishon@ti.com, balbi@ti.com, gregkh@linuxfoundation.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux@arm.linux.org.uk, bcousson@baylibre.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, swarren@wwwdotorg.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, rob@landley.net, galak@codeaurora.org, grant.likely@linaro.org, s.nawrocki@samsung.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Since now we have a separate folder for phy, move the PHY dt binding
documentation of TI to that folder.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/{usb/usb-phy.txt => phy/ti-phy.txt}   |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/{usb/usb-phy.txt => phy/ti-phy.txt} (86%)

diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
similarity index 86%
rename from Documentation/devicetree/bindings/usb/usb-phy.txt
rename to Documentation/devicetree/bindings/phy/ti-phy.txt
index c0245c8..355acf0 100644
--- a/Documentation/devicetree/bindings/usb/usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -1,4 +1,4 @@
-USB PHY
+TI PHY: DT DOCUMENTATION FOR PHYs in TI PLATFORMs
 
 OMAP USB2 PHY
 
@@ -21,10 +21,11 @@ usb2phy@4a0ad080 {
 	#phy-cells = <0>;
 };
 
-OMAP USB3 PHY
+TI PIPE3 PHY
 
 Required properties:
- - compatible: Should be "ti,omap-usb3"
+ - compatible: Should be "ti,phy-usb3", "ti,phy-pcie" or "ti,phy-sata".
+   "ti,omap-usb3" is deprecated.
  - reg : Address and length of the register set for the device.
  - reg-names: The names of the register addresses corresponding to the registers
    filled in "reg".
@@ -38,7 +39,7 @@ Optional properties:
 This is usually a subnode of ocp2scp to which it is connected.
 
 usb3phy@4a084400 {
-	compatible = "ti,omap-usb3";
+	compatible = "ti,phy-usb3";
 	reg = <0x4a084400 0x80>,
 	      <0x4a084800 0x64>,
 	      <0x4a084c00 0x40>;
-- 
1.7.10.4
