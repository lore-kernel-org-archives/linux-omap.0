From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/6] phy: core: Add phy-supply to DT binding documentation
Date: Wed, 2 Jul 2014 15:03:56 +0300
Message-ID: <1404302638-3003-5-git-send-email-rogerq@ti.com>
References: <1404302638-3003-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404302638-3003-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, kishon@ti.com, balbi@ti.com
Cc: nsekhar@ti.com, nm@ti.com, george.cherian@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

phy-supply is a phandle to the regulator that provides power to the
PHY. This regulator is managed during the PHY power on/off sequence
by the phy core driver.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/phy/phy-bindings.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-bindings.txt b/Documentation/devicetree/bindings/phy/phy-bindings.txt
index 8ae844f..2aa1840 100644
--- a/Documentation/devicetree/bindings/phy/phy-bindings.txt
+++ b/Documentation/devicetree/bindings/phy/phy-bindings.txt
@@ -10,6 +10,10 @@ Required Properties:
 		provider can use the values in cells to find the appropriate
 		PHY.
 
+Optional Properties:
+phy-supply:	Phandle to a regulator that provides power to the PHY. This
+		regulator will be managed during the PHY power on/off sequence.
+
 For example:
 
 phys: phy {
-- 
1.8.3.2
