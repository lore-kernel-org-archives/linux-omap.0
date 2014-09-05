From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 1/3] Documentation: dt-bindings: mfd: palmas: Fix example style of i2c peripheral
Date: Fri, 5 Sep 2014 15:51:49 -0500
Message-ID: <1409950311-25236-2-git-send-email-nm@ti.com>
References: <1409950311-25236-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409950311-25236-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Mark Brown <broonie@linaro.org>, Nishanth Menon <nm@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Use device@address as name for device nodes.

Suggested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 Documentation/devicetree/bindings/mfd/palmas.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/palmas.txt b/Documentation/devicetree/bindings/mfd/palmas.txt
index eda8989..d193859 100644
--- a/Documentation/devicetree/bindings/mfd/palmas.txt
+++ b/Documentation/devicetree/bindings/mfd/palmas.txt
@@ -33,7 +33,7 @@ Optional properties:
 
 Example:
 
-palmas {
+palmas@48 {
 	compatible = "ti,twl6035", "ti,palmas";
 	reg = <0x48>
 	interrupt-parent = <&intc>;
-- 
1.7.9.5
