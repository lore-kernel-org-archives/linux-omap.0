From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 10/12] usb: doc: dt-binding: Add otg-controller property
Date: Tue, 5 Apr 2016 17:05:15 +0300
Message-ID: <1459865117-7032-11-git-send-email-rogerq@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The otg-controller property is used to link the host/gadget
controllers to the otg controller. otg-controller property must
contain the phandle of the otg controller.

The otg core uses this property to tie the host/gadget
controllres to the correct otg controller.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/usb/generic.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index bba8257..f6866c1 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -24,6 +24,9 @@ Optional properties:
 			optional for OTG device.
  - adp-disable: tells OTG controllers we want to disable OTG ADP, ADP is
 			optional for OTG device.
+ - otg-controller: phandle to otg controller. Host or gadget controllers can
+			contain this property to link it to a particular OTG
+			controller.
 
 This is an attribute to a USB controller such as:
 
-- 
2.5.0
