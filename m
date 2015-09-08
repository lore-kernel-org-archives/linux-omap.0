From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 1/3] devicetree: Add TPS65217 charger binding.
Date: Tue,  8 Sep 2015 10:09:37 +0200
Message-ID: <1441699779-22189-2-git-send-email-enric.balletbo@collabora.com>
References: <1441699779-22189-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1441699779-22189-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, tony@atomide.com, sameo@linux.intel.com, lee.jones@linaro.org, sjoerd.simons@collabora.co.uk, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

The TPS65217 charger is a subnode of the TPS65217 MFD.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 .../devicetree/bindings/power_supply/tps65217_charger.txt    | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/tps65217_charger.txt

diff --git a/Documentation/devicetree/bindings/power_supply/tps65217_charger.txt b/Documentation/devicetree/bindings/power_supply/tps65217_charger.txt
new file mode 100644
index 0000000..98d131a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/tps65217_charger.txt
@@ -0,0 +1,12 @@
+TPS65217 Charger
+
+Required Properties:
+-compatible: "ti,tps65217-charger"
+
+This node is a subnode of the tps65217 PMIC.
+
+Example:
+
+	tps65217-charger {
+		compatible = "ti,tps65090-charger";
+	};
-- 
2.1.0

