From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH v5 11/11] arm/dts: am33xx: add phy phandle to usbss
Date: Wed, 25 Jul 2012 17:37:29 +0530
Message-ID: <1343218049-29917-12-git-send-email-ajay.gupta@ti.com>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39563 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756600Ab2GYMHn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 08:07:43 -0400
In-Reply-To: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Added NOP PHY phandle to usbss device node as same will be used
to get the phy from otg framework.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index b03a9b5..d3ab69a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -172,6 +172,8 @@
 			port0_mode = <3>;
 			port1_mode = <1>;
 			power = <250>;
+			usb0-phy = <&usb0_phy>;
+			usb1-phy = <&usb1_phy>;
 		};
 	};
 };
-- 
1.7.0.4

