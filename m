From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 16/20] dts: arm: omap: Update coresight bindings for hardware ports
Date: Tue,  5 Jun 2018 22:43:27 +0100
Message-ID: <1528235011-30691-17-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com, charles.garcia-tobin@arm.com, coresight@lists.linaro.org, devicetree@vger.kernel.org, mike.leach@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>, linux-omap@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Switch to the new coresight bindings for hardware ports

Cc: linux-omap@vger.kernel.org
Cc: "Benoît Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 5 ++++-
 arch/arm/boot/dts/omap3-beagle.dts    | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 0349fcc..b5f40069 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -155,8 +155,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etb_in: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&etm_out>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -169,7 +170,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm_out: endpoint {
+				direction = <1>;
 				remote-endpoint = <&etb_in>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 3ca8991..b32e35b 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -149,8 +149,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etb_in: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&etm_out>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -163,7 +164,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm_out: endpoint {
+				direction = <1>;
 				remote-endpoint = <&etb_in>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
-- 
2.7.4
