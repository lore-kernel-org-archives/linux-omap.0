From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/3] dt-bindings: phy: ti: add documentation for ti,dra7x-usb2
Date: Tue, 23 Aug 2016 11:57:40 +0300
Message-ID: <1471942661-1728-3-git-send-email-rogerq@ti.com>
References: <1471942661-1728-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471942661-1728-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: robh+dt@kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

Commit 7e472402ca30 ("phy: omap-usb2: Provide workaround for
USB2PHY false disconnect") added a new binding for USB2 PHYs
on DRA7x. But it has remained undocumented so far.

Add documentation for the binding.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/phy/ti-phy.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
index a3b3945..cd13e615 100644
--- a/Documentation/devicetree/bindings/phy/ti-phy.txt
+++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
@@ -31,6 +31,8 @@ OMAP USB2 PHY
 
 Required properties:
  - compatible: Should be "ti,omap-usb2"
+	       Should be "ti,dra7x-usb2" for the 1st instance of USB2 PHY on
+	       DRA7x
 	       Should be "ti,dra7x-usb2-phy2" for the 2nd instance of USB2 PHY
 	       in DRA7x
  - reg : Address and length of the register set for the device.
-- 
2.7.4
