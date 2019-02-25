From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Subject: [PATCH v2 1/2] dt-bindings: regulator: add LS2 load switch documentation
Date: Mon, 25 Feb 2019 07:41:05 +0100
Message-ID: <1551076866-12578-2-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1551076866-12578-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551076866-12578-1-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Document device-tree settings of the load-switch LS2
in the tps65218 device.

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 Documentation/devicetree/bindings/regulator/tps65218.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
index 02f0e9b..b28e9bd 100644
--- a/Documentation/devicetree/bindings/regulator/tps65218.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
@@ -71,6 +71,11 @@ tps65218: tps65218@24 {
 		regulator-always-on;
 	};
 
+	ls2: regulator-ls2 {
+		regulator-min-microamp = <100000>;
+		regulator-max-microamp = <1000000>;
+	};
+
 	ls3: regulator-ls3 {
 		regulator-min-microvolt = <100000>;
 		regulator-max-microvolt = <1000000>;
-- 
2.7.4
