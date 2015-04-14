From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH v2 11/13] usb: add "dual-role" mode to dr_mode device tree helper
Date: Tue, 14 Apr 2015 13:41:58 +0300
Message-ID: <1429008120-5395-12-git-send-email-rogerq@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47071 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754817AbbDNKmr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Apr 2015 06:42:47 -0400
In-Reply-To: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

We need to differentiat between "otg" and "dual-role" operation.
dual-role means capability to operate as host or device depending
on the ID pin status but no support for any of the OTG features
like SRP, HNP and on the fly role-swap.

The only way to change the role for a dual-role device is to
toggle the ID pin by changing the cable.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/usb/generic.txt | 2 +-
 drivers/usb/common/common.c                       | 1 +
 include/linux/usb/otg.h                           | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index 477d5bb..64438f9 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -8,7 +8,7 @@ Optional properties:
 			HW capability.
  - dr_mode: tells Dual-Role USB controllers that we want to work on a
 			particular mode. Valid arguments are "host",
-			"peripheral" and "otg". In case this attribute isn't
+			"peripheral", "otg", "dual-role". In case this attribute isn't
 			passed via DT, USB DRD controllers should default to
 			OTG.
 
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index b530fd4..faf51fe 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -87,6 +87,7 @@ static const char *const usb_dr_modes[] = {
 	[USB_DR_MODE_HOST]		= "host",
 	[USB_DR_MODE_PERIPHERAL]	= "peripheral",
 	[USB_DR_MODE_OTG]		= "otg",
+	[USB_DR_MODE_DRD]		= "dual-role",
 };
 
 /**
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 52661c5..d6057fb 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -102,6 +102,7 @@ enum usb_dr_mode {
 	USB_DR_MODE_HOST,
 	USB_DR_MODE_PERIPHERAL,
 	USB_DR_MODE_OTG,
+	USB_DR_MODE_DRD,
 };
 
 #endif /* __LINUX_USB_OTG_H */
-- 
2.1.0

