From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 3/3] usb: musb: dsps: document dt bindings properly
Date: Thu, 27 Sep 2012 11:13:45 +0530
Message-ID: <fe89d32d700223ee023d6b486a13e46d21645e10.1348722157.git.afzal@ti.com>
References: <a1dd07e020850703ed5294db176ea1298d69a4ed.1348722156.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58728 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755283Ab2I0Fnt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 01:43:49 -0400
In-Reply-To: <a1dd07e020850703ed5294db176ea1298d69a4ed.1348722156.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Ravi Babu <ravibabu@ti.com>, Afzal Mohammed <afzal@ti.com>

DT bindings have '-' (hyphens) instead of '_' (underscore),
update the documentation to reflect it.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 Documentation/devicetree/bindings/usb/am33xx-usb.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index 9782585..6d5d5f0 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -3,12 +3,12 @@ AM33XX MUSB GLUE
  - ti,hwmods : must be "usb_otg_hs"
  - multipoint : Should be "1" indicating the musb controller supports
    multipoint. This is a MUSB configuration-specific setting.
- - num_eps : Specifies the number of endpoints. This is also a
+ - num-eps : Specifies the number of endpoints. This is also a
    MUSB configuration-specific setting. Should be set to "16"
- - ram_bits : Specifies the ram address size. Should be set to "12"
- - port0_mode : Should be "3" to represent OTG. "1" signifies HOST and "2"
+ - ram-bits : Specifies the ram address size. Should be set to "12"
+ - port0-mode : Should be "3" to represent OTG. "1" signifies HOST and "2"
    represents PERIPHERAL.
- - port1_mode : Should be "1" to represent HOST. "3" signifies OTG and "2"
+ - port1-mode : Should be "1" to represent HOST. "3" signifies OTG and "2"
    represents PERIPHERAL.
  - power : Should be "250". This signifies the controller can supply upto
    500mA when operating in host mode.
-- 
1.7.12

