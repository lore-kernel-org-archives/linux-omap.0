From: Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 03/15] ARM: dts: omap5: Add clocks to usb3_phy node
Date: Thu, 19 Sep 2013 16:05:31 +0300
Message-ID: <1379595943-14622-4-git-send-email-rogerq@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379595943-14622-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, bcousson@baylibre.com, tony@atomide.com
Cc: balajitk@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The pipe3-phy driver expects certain named clocks.
Provide the necessary clocks.

CC: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 576b06a..97f361a 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -677,6 +677,8 @@
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 				ctrl-module = <&omap_control_usb3phy>;
+				clocks = <&usb_phy_cm_clk32k>, <&sys_clkin>;
+				clock-names = "wkupclk", "sysclk";
 				#phy-cells = <0>;
 			};
 		};
-- 
1.7.4.1
