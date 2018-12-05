From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/4] dt-bindings: phy: ti: Add support for AM654x USB2 PHY
Date: Wed, 5 Dec 2018 17:03:25 +0200
Message-ID: <1544022206-2300-4-git-send-email-rogerq@ti.com>
References: <1544022206-2300-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544022206-2300-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com
Cc: robh+dt@kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add support for USB2 PHY on AM654x SoC.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index 57dfda8..8f93c3b 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -35,6 +35,7 @@ Required properties:
 	       DRA7x
 	       Should be "ti,dra7x-usb2-phy2" for the 2nd instance of USB2 PHY
 	       in DRA7x
+	       Should be "ti,am654-usb2" for the USB2 PHYs on AM654.
  - reg : Address and length of the register set for the device.
  - #phy-cells: determine the number of cells that should be given in the
    phandle while referencing this phy.
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
