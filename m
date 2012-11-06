From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH/RESEND 2/2] usb: musb: dsps: document dt bindings properly
Date: Tue, 6 Nov 2012 20:47:35 +0530
Message-ID: <ca479a9bf35ee34190b3305a640b3a1d806bef48.1352213124.git.afzal@ti.com>
References: <cover.1352213124.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59625 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab2KFPRi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 10:17:38 -0500
In-Reply-To: <cover.1352213124.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

DT bindings normally use '-' (hyphens) instead of '_' (underscore),
driver has it the proper way, but binding documentation does not
reflect it, fix it.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 Documentation/devicetree/bindings/usb/am33xx-usb.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index ca8fa56..a922505 100644
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

