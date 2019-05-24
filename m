From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH 2/7] ARM: dts: am335x phytec boards: Remove regulator node
Date: Fri, 24 May 2019 15:19:58 +0200
Message-ID: <1558704003-393769-3-git-send-email-t.remmet@phytec.de>
References: <1558704003-393769-1-git-send-email-t.remmet@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1558704003-393769-1-git-send-email-t.remmet@phytec.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Daniel Schultz <d.schultz@phytec.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Move regulators directly to the root node like most am335x boards do.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 18 +++++++-----------
 arch/arm/boot/dts/am335x-wega.dtsi        | 16 ++++++----------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 23c3039c567e..f5b53d30e9a9 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -30,17 +30,13 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
-	regulators {
-		compatible = "simple-bus";
-
-		vcc5v: fixedregulator0 {
-			compatible = "regulator-fixed";
-			regulator-name = "vcc5v";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-boot-on;
-			regulator-always-on;
-		};
+	vcc5v: fixedregulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
 	};
 };
 
diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 84581fed3d06..d91ff3e99470 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -15,16 +15,12 @@
 		compatible = "ti,da830-evm-audio";
 	};
 
-	regulators {
-		compatible = "simple-bus";
-
-		vcc3v3: fixedregulator1 {
-			compatible = "regulator-fixed";
-			regulator-name = "vcc3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-boot-on;
-		};
+	vcc3v3: fixedregulator1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
 	};
 };
 
-- 
2.7.4
