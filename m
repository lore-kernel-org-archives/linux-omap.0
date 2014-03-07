From: George Cherian <george.cherian@ti.com>
Subject: [PATCH v3 4/5] ARM: dts: am437x-gp-evm: Enable USB
Date: Fri, 7 Mar 2014 17:27:01 +0530
Message-ID: <1394193422-18242-5-git-send-email-george.cherian@ti.com>
References: <1394193422-18242-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394193422-18242-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, rogerq@ti.com, kishon@ti.com, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, tony@atomide.com, anatol.pomozov@gmail.com, bcousson@baylibre.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Enable
	- ocp2scp
	- USB PHY control module
	- USB PHY
	- dwc3_omap
	- USB
for am437x-gp-evm

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 4eb72b8..347d367 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -98,3 +98,21 @@
 &gpio4 {
 	status = "okay";
 };
+
+&usb2_phy1 {
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usb2_phy2 {
+	status = "okay";
+};
+
+&usb2 {
+	dr_mode = "host";
+	status = "okay";
+};
-- 
1.8.3.1
