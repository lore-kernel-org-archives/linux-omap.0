From: Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 12/15] ARM: dts: omap5: add ocp2scp1 address resource
Date: Thu, 19 Sep 2013 16:23:39 +0300
Message-ID: <1379597019-15294-1-git-send-email-rogerq@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379595943-14622-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, bcousson@baylibre.com, tony@atomide.com
Cc: balajitk@ti.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add OCP2SCP1 module address space.

CC: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 06aa665..8a88a94 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -663,6 +663,7 @@
 			#size-cells = <1>;
 			ranges;
 			ti,hwmods = "ocp2scp1";
+			reg = <0x4a080000 0x1f>;
 			usb2_phy: usb2phy@4a084000 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x7c>;
-- 
1.7.4.1
