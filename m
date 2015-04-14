From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH v2 13/13] ARM: dts: dra7x-evm: Enable dual-role for usb1
Date: Tue, 14 Apr 2015 13:42:00 +0300
Message-ID: <1429008120-5395-14-git-send-email-rogerq@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35591 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754850AbbDNKmy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Apr 2015 06:42:54 -0400
In-Reply-To: <1429008120-5395-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Now that we have dual-role support working at USB core,
enable dual-role support for usb1 controller.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts  | 2 +-
 arch/arm/boot/dts/dra72-evm.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 746cddb..2f495c9 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -552,7 +552,7 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "dual-role";
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
 };
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index e0264d0..93cdf89 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -381,7 +381,7 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "dual-role";
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
 };
-- 
2.1.0

