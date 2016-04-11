From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 09/10] ARM: dts: dra7*-evm: Enable dual-role for usb1
Date: Mon, 11 Apr 2016 14:35:05 +0300
Message-ID: <1460374506-9779-10-git-send-email-rogerq@ti.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460374506-9779-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Now that we have dual-role support working at USB core,
enable dual-role support for usb1 controller.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts  | 2 +-
 arch/arm/boot/dts/dra72-evm.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index d9b8723..61c88f7 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -722,7 +722,7 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
 };
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 6affe2d..f7d345e 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -592,7 +592,7 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
 };
-- 
2.5.0
