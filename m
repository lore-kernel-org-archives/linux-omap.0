From: George Cherian <george.cherian@ti.com>
Subject: [PATCH 5/5] doc: Add "ti,am437x-dwc3" comaptible for dwc3 glue
Date: Mon, 3 Mar 2014 19:23:54 +0530
Message-ID: <1393854834-23810-6-git-send-email-george.cherian@ti.com>
References: <1393854834-23810-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393854834-23810-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Cc: anatol.pomozov@gmail.com, gregkh@linuxfoundation.org, balbi@ti.com, rogerq@ti.com, kishon@ti.com, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Add the compatible "ti,am437x-dwc3" for dwc3 glue driver.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 Documentation/devicetree/bindings/usb/omap-usb.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
index c495135..1d38569 100644
--- a/Documentation/devicetree/bindings/usb/omap-usb.txt
+++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
@@ -44,7 +44,9 @@ Board specific device node entry
 };
 
 OMAP DWC3 GLUE
- - compatible : Should be "ti,dwc3"
+ - compatible : Should be
+	* "ti,dwc3" for OMAP5 and DRA7
+	* "ti,am437x-dwc3" for AM437x
  - ti,hwmods : Should be "usb_otg_ss"
  - reg : Address and length of the register set for the device.
  - interrupts : The irq number of this device that is used to interrupt the
-- 
1.8.3.1
