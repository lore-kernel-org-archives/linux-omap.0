From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 4/7] ARM: dts: AM437x: Fix i2c nodes indentation
Date: Tue, 8 Jul 2014 15:46:34 +0530
Message-ID: <1404814597-4404-5-git-send-email-j-keerthy@ti.com>
References: <1404814597-4404-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404814597-4404-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: mark.rutland@arm.com, galak@codeaurora.org, robh+dt@kernel.org, linux@arm.linux.org.uk, balbi@ti.com, tony@atomide.com, kishon@ti.com, broonie@kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Fix i2c nodes indentation.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 003766c..85ca430 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -257,16 +257,15 @@
 };
 
 &i2c0 {
-        status = "okay";
-        pinctrl-names = "default";
-        pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
 };
 
 &i2c1 {
-        status = "okay";
-        pinctrl-names = "default";
-        pinctrl-0 = <&i2c1_pins>;
-
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
 	pixcir_ts@5c {
 		compatible = "pixcir,pixcir_tangoc";
 		pinctrl-names = "default";
-- 
1.7.9.5
