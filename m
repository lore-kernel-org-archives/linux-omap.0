From: George Cherian <george.cherian@ti.com>
Subject: [PATCH 4/5] ARM: dts: am43x-epos-evm: Enable USB
Date: Mon, 3 Mar 2014 19:23:53 +0530
Message-ID: <1393854834-23810-5-git-send-email-george.cherian@ti.com>
References: <1393854834-23810-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393854834-23810-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Cc: anatol.pomozov@gmail.com, gregkh@linuxfoundation.org, balbi@ti.com, rogerq@ti.com, kishon@ti.com, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Enable
	- ocp2scp
	- USB PHY control module
	- USB PHY
	- dwc3_omap
	- USB

for am43x-epos-evm

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index a7d0db1..165026b 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -251,3 +251,47 @@
 	pinctrl-0 = <&spi1_pins>;
 	status = "okay";
 };
+
+&am43xx_control_usb2phy1 {
+	status = "okay";
+};
+
+&ocp2scp0 {
+	status = "okay";
+};
+
+&usb2_phy1 {
+	status = "okay";
+};
+
+&dwc3_1 {
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	status = "okay";
+};
+
+&am43xx_control_usb2phy2 {
+	status = "okay";
+};
+
+&ocp2scp1 {
+	status = "okay";
+};
+
+&usb2_phy2 {
+	status = "okay";
+};
+
+&dwc3_2 {
+	status = "okay";
+};
+
+&usb2 {
+	dr_mode = "host";
+	maximum-speed = "high-speed";
+	status = "okay";
+};
-- 
1.8.3.1
