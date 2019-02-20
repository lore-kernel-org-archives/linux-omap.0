From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Subject: [PATCH 2/3] dt-bindings: regulator: Add LS2 load switch
Date: Wed, 20 Feb 2019 09:15:51 +0100
Message-ID: <1550650552-26013-3-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

and change units of LS3 example from microvolt to microamp

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 Documentation/devicetree/bindings/regulator/tps65218.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
index 02f0e9b..54aded3 100644
--- a/Documentation/devicetree/bindings/regulator/tps65218.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
@@ -71,8 +71,13 @@ tps65218: tps65218@24 {
 		regulator-always-on;
 	};
 
+	ls2: regulator-ls2 {
+		regulator-min-microamp = <100000>;
+		regulator-max-microamp = <1000000>;
+	};
+
 	ls3: regulator-ls3 {
-		regulator-min-microvolt = <100000>;
-		regulator-max-microvolt = <1000000>;
+		regulator-min-microamp = <100000>;
+		regulator-max-microamp = <1000000>;
 	};
 };
-- 
2.7.4
