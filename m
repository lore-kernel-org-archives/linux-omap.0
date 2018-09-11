From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 07/11] dts: arm: omap: Update coresight bindings for hardware ports
Date: Tue, 11 Sep 2018 11:17:08 +0100
Message-ID: <1536661032-30481-8-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, mathieu.poirier@linaro.org, arm@kernel.org, sudeep.holla@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>, linux-omap@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Switch to the new coresight bindings for hardware ports

Cc: linux-omap@vger.kernel.org
Cc: "Benoît Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 17 ++++++++++-------
 arch/arm/boot/dts/omap3-beagle.dts    | 17 ++++++++++-------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index d80587d..9985ee2 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -160,10 +160,11 @@
 
 		clocks = <&emu_src_ck>;
 		clock-names = "apb_pclk";
-		port {
-			etb_in: endpoint {
-				slave-mode;
-				remote-endpoint = <&etm_out>;
+		in-ports {
+			port {
+				etb_in: endpoint {
+					remote-endpoint = <&etm_out>;
+				};
 			};
 		};
 	};
@@ -174,9 +175,11 @@
 
 		clocks = <&emu_src_ck>;
 		clock-names = "apb_pclk";
-		port {
-			etm_out: endpoint {
-				remote-endpoint = <&etb_in>;
+		out-ports {
+			port {
+				etm_out: endpoint {
+					remote-endpoint = <&etb_in>;
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 3ca8991..91bb50a 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -147,10 +147,11 @@
 
 		clocks = <&emu_src_ck>;
 		clock-names = "apb_pclk";
-		port {
-			etb_in: endpoint {
-				slave-mode;
-				remote-endpoint = <&etm_out>;
+		in-ports {
+			port {
+				etb_in: endpoint {
+					remote-endpoint = <&etm_out>;
+				};
 			};
 		};
 	};
@@ -161,9 +162,11 @@
 
 		clocks = <&emu_src_ck>;
 		clock-names = "apb_pclk";
-		port {
-			etm_out: endpoint {
-				remote-endpoint = <&etb_in>;
+		out-ports {
+			port {
+				etm_out: endpoint {
+					remote-endpoint = <&etb_in>;
+				};
 			};
 		};
 	};
-- 
2.7.4
