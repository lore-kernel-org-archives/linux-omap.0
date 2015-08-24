From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 08/13] usb: doc: dt-binding: Add otg-controller property
Date: Mon, 24 Aug 2015 16:21:19 +0300
Message-ID: <1440422484-4737-9-git-send-email-rogerq@ti.com>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440422484-4737-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The otg-controller property is used to link the host/gadget
controllers to the otg controller. otg-controller property must
contain the phandle of the otg controller.

The otg core uses this property to tie the host/gadget
controllres to the correct otg controller.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/usb/generic.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index bba8257..5a457bc 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -24,6 +24,11 @@ Optional properties:
 			optional for OTG device.
  - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
 			optional for OTG device.
+ - otg-controller: phandle to otg controller. Host or gadget controllers can
+			contain this property to link it to a particular otg
+			controller. If this property is not present then otg
+			core assumes that host and gadget controllers are
+			children of the otg controller.
 
 This is an attribute to a USB controller such as:
 
-- 
2.1.4
