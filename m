From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: boot: dts: dra7: add labels to DWC3 nodes
Date: Mon, 10 Nov 2014 15:27:09 -0800
Message-ID: <20141110232709.GB31454@atomide.com>
References: <1415032122-8230-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38463 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750904AbaKJX1x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2014 18:27:53 -0500
Content-Disposition: inline
In-Reply-To: <1415032122-8230-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [141103 08:30]:
> by adding labels to DWC3 nodes, it's far easier
> for boards to reference them.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applying into omap-for-v3.19/dt, had to update it because
of "ARM: dts: DRA7: Move USB_OTG 4 to dra74x.dtsi". Updated
patch below.

Regards,

Tony

8< -------------------
From: Felipe Balbi <balbi@ti.com>
Date: Mon, 3 Nov 2014 10:28:42 -0600
Subject: [PATCH] arm: boot: dts: dra7: add labels to DWC3 nodes

by adding labels to DWC3 nodes, it's far easier
for boards to reference them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
[tony@atomide.com: updated for otg 4 move to dra74x.dtsi]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1219,7 +1219,7 @@
 			};
 		};
 
-		omap_dwc3_1@48880000 {
+		omap_dwc3_1: omap_dwc3_1@48880000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss1";
 			reg = <0x48880000 0x10000>;
@@ -1240,7 +1240,7 @@
 			};
 		};
 
-		omap_dwc3_2@488c0000 {
+		omap_dwc3_2: omap_dwc3_2@488c0000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss2";
 			reg = <0x488c0000 0x10000>;
@@ -1262,7 +1262,7 @@
 		};
 
 		/* IRQ for DWC3_3 and DWC3_4 need IRQ crossbar */
-		omap_dwc3_3@48900000 {
+		omap_dwc3_3: omap_dwc3_3@48900000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss3";
 			reg = <0x48900000 0x10000>;
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -46,7 +46,7 @@
 	};
 
 	ocp {
-		omap_dwc3_4@48940000 {
+		omap_dwc3_4: omap_dwc3_4@48940000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss4";
 			reg = <0x48940000 0x10000>;
