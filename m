From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4/7] Documentation: dt bindings: move ..usb/usb-phy.txt to ..phy/omap-phy.txt
Date: Mon, 2 Sep 2013 21:13:08 +0530
Message-ID: <1378136591-7463-5-git-send-email-kishon@ti.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378136591-7463-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, kishon@ti.com, balbi@ti.com
Cc: bcousson@baylibre.com, tony@atomide.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, linux@arm.linux.org.uk, grant.likely@linaro.org, s.nawrocki@samsung.com, galak@codeaurora.org, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, george.cherian@ti.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Since now we have a separate folder for phy, move the PHY dt binding
documentation of OMAP to that folder.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/{usb/usb-phy.txt => phy/omap-phy.txt}        |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{usb/usb-phy.txt => phy/omap-phy.txt} (96%)

diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/phy/omap-phy.txt
similarity index 96%
rename from Documentation/devicetree/bindings/usb/usb-phy.txt
rename to Documentation/devicetree/bindings/phy/omap-phy.txt
index 36bdb17..2c485ee 100644
--- a/Documentation/devicetree/bindings/usb/usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/omap-phy.txt
@@ -1,4 +1,4 @@
-USB PHY
+OMAP PHY: DT DOCUMENTATION FOR PHYs in OMAP PLATFORM
 
 OMAP USB2 PHY
 
-- 
1.7.10.4
