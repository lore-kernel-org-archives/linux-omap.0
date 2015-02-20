From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/2] ARM: dts: dra7: remove ti,hwmod property from pcie phy
Date: Fri, 20 Feb 2015 14:21:14 +0530
Message-ID: <1424422274-27946-2-git-send-email-kishon@ti.com>
References: <1424422274-27946-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52600 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186AbbBTIvs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Feb 2015 03:51:48 -0500
In-Reply-To: <1424422274-27946-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grygorii.strashko@linaro.org, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com
Cc: linux-omap@vger.kernel.org, sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, t-kristo@ti.com, kishon@ti.com

Now that we don't have hwmod entry for pcie PHY remove the
ti,hwmod property from PCIE PHY's

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5827fed..18a904d 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1111,7 +1111,6 @@
 					      "wkupclk", "refclk",
 					      "div-clk", "phy-div";
 				#phy-cells = <0>;
-				ti,hwmods = "pcie1-phy";
 			};
 
 			pcie2_phy: pciephy@4a095000 {
@@ -1130,7 +1129,6 @@
 					      "wkupclk", "refclk",
 					      "div-clk", "phy-div";
 				#phy-cells = <0>;
-				ti,hwmods = "pcie2-phy";
 				status = "disabled";
 			};
 		};
-- 
1.7.9.5

