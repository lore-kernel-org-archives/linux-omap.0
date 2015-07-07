From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] ARM: dts: dra7x-evm: Prevent glitch on DCAN1 pinmux
Date: Tue, 7 Jul 2015 17:27:57 +0300
Message-ID: <1436279277-3386-3-git-send-email-rogerq@ti.com>
References: <1436279277-3386-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1436279277-3386-1-git-send-email-rogerq@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, tony@atomide.com
Cc: jay.schroeder@garmin.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Driver core sets "default" pinmux on on probe and CAN driver
sets "sleep" pinmux during register. This causes a small window
where the CAN pins are in "default" state with the DCAN module
being disabled.

Change the "default" state to be like sleep so this glitch is
avoided. Add a new "active" state that is used by the driver
when CAN is actually active.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts  | 5 +++--
 arch/arm/boot/dts/dra72-evm.dts | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index aa46590..096f68b 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -686,7 +686,8 @@
 
 &dcan1 {
 	status = "ok";
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&dcan1_pins_default>;
+	pinctrl-names = "default", "sleep", "active";
+	pinctrl-0 = <&dcan1_pins_sleep>;
 	pinctrl-1 = <&dcan1_pins_sleep>;
+	pinctrl-2 = <&dcan1_pins_default>;
 };
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 4e1b605..8037384 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -587,9 +587,10 @@
 
 &dcan1 {
 	status = "ok";
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&dcan1_pins_default>;
+	pinctrl-names = "default", "sleep", "active";
+	pinctrl-0 = <&dcan1_pins_sleep>;
 	pinctrl-1 = <&dcan1_pins_sleep>;
+	pinctrl-2 = <&dcan1_pins_default>;
 };
 
 &qspi {
-- 
2.1.4

