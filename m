From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 4/4] ARM: dts: OMAP5: Fix SATA PHY node
Date: Tue, 13 Jan 2015 14:23:22 +0200
Message-ID: <1421151802-7396-5-git-send-email-rogerq@ti.com>
References: <1421151802-7396-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421151802-7396-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: nm-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The sata_ref_clk is a reference clock to the SATA phy.
This fixes SATA malfunction across suspend/resume or when
SATA driver is used as a module.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b321fdf..bb498e7 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -929,8 +929,8 @@
 				      <0x4A096800 0x40>; /* pll_ctrl */
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 				ctrl-module = <&omap_control_sata>;
-				clocks = <&sys_clkin>;
-				clock-names = "sysclk";
+				clocks = <&sys_clkin>, <&sata_ref_clk>;
+				clock-names = "sysclk", "refclk";
 				#phy-cells = <0>;
 			};
 		};
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
