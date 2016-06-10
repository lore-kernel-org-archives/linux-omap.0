From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 4/4] ARM: dts: am43xx: Enable dual-role on USB1
Date: Fri, 10 Jun 2016 16:17:30 +0300
Message-ID: <1465564650-27516-5-git-send-email-rogerq@ti.com>
References: <1465564650-27516-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465564650-27516-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

USB1 port is micro-AB type and can function as peripheral
as well as host. Enable dual-role mode for USB1.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts  | 5 ++++-
 arch/arm/boot/dts/am437x-sk-evm.dts  | 5 ++++-
 arch/arm/boot/dts/am43x-epos-evm.dts | 5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 5bcd3aa..d76a885 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -765,7 +765,10 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index d82dd6e..b11d50e 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -571,8 +571,11 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
 	status = "okay";
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
 };
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 3549b8c..9578602 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -676,8 +676,11 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
 	status = "okay";
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
 };
 
 &usb2_phy2 {
-- 
2.7.4
