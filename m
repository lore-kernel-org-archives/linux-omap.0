From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] ARM: dts: DRA7X: drop id property in pcie_phy
Date: Tue, 16 Dec 2014 14:52:51 +0530
Message-ID: <1418721771-31184-3-git-send-email-vigneshr@ti.com>
References: <1418721771-31184-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418721771-31184-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Since phyid is no longer used by pcie driver, this field can be dropped
from the DT.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 63bf99be1762..889e3023e68f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1111,7 +1111,6 @@
 					      "wkupclk", "refclk",
 					      "div-clk", "phy-div";
 				#phy-cells = <0>;
-				id = <1>;
 				ti,hwmods = "pcie1-phy";
 			};
 
@@ -1132,7 +1131,6 @@
 					      "div-clk", "phy-div";
 				#phy-cells = <0>;
 				ti,hwmods = "pcie2-phy";
-				id = <2>;
 				status = "disabled";
 			};
 		};
-- 
1.9.1
