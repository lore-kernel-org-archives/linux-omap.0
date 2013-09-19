From: Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 07/15] ARM: dts: omap5: Update usb3phy node
Date: Thu, 19 Sep 2013 16:05:35 +0300
Message-ID: <1379595943-14622-8-git-send-email-rogerq@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379595943-14622-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, bcousson@baylibre.com, tony@atomide.com
Cc: balajitk@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Update compatible property for usb3phy node.

CC: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 97f361a..06aa665 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -671,7 +671,7 @@
 			};
 
 			usb3_phy: usb3phy@4a084400 {
-				compatible = "ti,omap-usb3";
+				compatible = "ti,phy-pipe3-usb3";
 				reg = <0x4a084400 0x80>,
 				      <0x4a084800 0x64>,
 				      <0x4a084c00 0x40>;
-- 
1.7.4.1
