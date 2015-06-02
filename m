From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 3/3] ARM: dts: dra7: Add syscon-pllreset syscon to SATA PHY
Date: Tue, 2 Jun 2015 12:10:42 +0300
Message-ID: <1433236242-26172-4-git-send-email-rogerq@ti.com>
References: <1433236242-26172-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53130 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758872AbbFBJK4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 05:10:56 -0400
In-Reply-To: <1433236242-26172-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

This register is required to be passed to the SATA PHY driver
to workaround errata i783 (SATA Lockup After SATA DPLL Unlock/Relock).

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index f03a091..260f300 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1135,6 +1135,7 @@
 				ctrl-module = <&omap_control_sata>;
 				clocks = <&sys_clkin1>, <&sata_ref_clk>;
 				clock-names = "sysclk", "refclk";
+				syscon-pllreset = <&dra7_ctrl_core 0x3fc>;
 				#phy-cells = <0>;
 			};
 
-- 
2.1.4

