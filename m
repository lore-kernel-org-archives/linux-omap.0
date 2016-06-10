From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 3/4] ARM: dts: dra7*-evm: Enable dual-role for usb1
Date: Fri, 10 Jun 2016 16:17:29 +0300
Message-ID: <1465564650-27516-4-git-send-email-rogerq@ti.com>
References: <1465564650-27516-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465564650-27516-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Now that we have dual-role support working at USB core,
enable dual-role support for usb1 controller.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts          | 5 ++++-
 arch/arm/boot/dts/dra72-evm-common.dtsi | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index bafcfac..75a4065 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -731,7 +731,10 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
 };
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index 093538e..24ad2ff 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -571,7 +571,10 @@
 };
 
 &usb2 {
-	dr_mode = "host";
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb2_pins>;
 };
-- 
2.7.4
