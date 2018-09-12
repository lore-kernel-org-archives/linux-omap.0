From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 08/11] arm: dts: omap: Update coresight bindings for hardware ports
Date: Wed, 12 Sep 2018 14:53:49 +0100
Message-ID: <20180912135352.19722-9-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912135352.19722-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com, coresight@lists.linaro.org, leo.yan@linaro.org, suzuki.poulose@arm.com, linux-omap@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
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
index d80587de0bbf..9985ee2aae0c 100644
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
index 3ca8991a6c3e..91bb50ad9a4f 100644
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
2.19.0
