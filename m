From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] arm: boot: dts: dra7: enable dwc3 suspend PHY quirk
Date: Thu, 15 Jan 2015 09:38:03 -0600
Message-ID: <1421336283-17904-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37024 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbbAOPjK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2015 10:39:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Whenever Suspend PHY bit is set on DRA7x devices,
USB will not work due to Set EP Configuration command
always failing.

This was only found after a recent commit 2164a47 (usb:
dwc3: set SUSPHY bit for all cores, which will be merged
for v3.19) added a missing *required* step to dwc3
initialization. Synopsys Databook requires that we enable
Suspend PHY bit after initialization but that, unfortunately,
breaks DRA7x.

Note that the same regression was already patched for AM437x.

Reported-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Tony, this fixes a regression with v3.19

 arch/arm/boot/dts/dra7.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 22771bc1643a..63f8b007bdc5 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1257,6 +1257,8 @@
 				tx-fifo-resize;
 				maximum-speed = "super-speed";
 				dr_mode = "otg";
+				snps,dis_u3_susphy_quirk;
+				snps,dis_u2_susphy_quirk;
 			};
 		};
 
@@ -1278,6 +1280,8 @@
 				tx-fifo-resize;
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
+				snps,dis_u3_susphy_quirk;
+				snps,dis_u2_susphy_quirk;
 			};
 		};
 
@@ -1299,6 +1303,8 @@
 				tx-fifo-resize;
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
+				snps,dis_u3_susphy_quirk;
+				snps,dis_u2_susphy_quirk;
 			};
 		};
 
-- 
2.2.0

