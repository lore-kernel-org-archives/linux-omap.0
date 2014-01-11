From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 5/6] DTS: ARM: OMAP3-N900: Add isp1704 support
Date: Sat, 11 Jan 2014 22:17:02 +0100
Message-ID: <1389475023-11616-6-git-send-email-sre@debian.org>
References: <1389475023-11616-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:51017 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbaAKVRo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Jan 2014 16:17:44 -0500
In-Reply-To: <1389475023-11616-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>

This adds support for the isp1704 chip to the Nokia N900
DTS file.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 0ceacad..86cceaf 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -74,6 +74,11 @@
 		};
 	};
 
+	isp1704: isp1704 {
+		compatible = "nxp,isp1704";
+		nxp,enable-gpio = <&gpio3 3 GPIO_ACTIVE_HIGH>;
+		usb-phy = <&usb2_phy>;
+	};
 };
 
 &omap3_pmx_core {
-- 
1.8.5.2

