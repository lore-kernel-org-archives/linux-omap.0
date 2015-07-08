From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 4/5] ARM: dts: dra7*-evm: Enable dual-role for usb1
Date: Wed, 8 Jul 2015 13:42:33 +0300
Message-ID: <1436352154-28966-5-git-send-email-rogerq@ti.com>
References: <1436352154-28966-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436352154-28966-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Now that we have dual-role support working at USB core,
enable dual-role support for usb1 controller.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts  | 2 +-
 arch/arm/boot/dts/dra72-evm.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index aa46590..9daaf46 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -550,7 +550,7 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
 };
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 4e1b605..2ec0985 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -476,7 +476,7 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
 };
-- 
2.1.4
