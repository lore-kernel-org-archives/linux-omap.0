From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] Documentation: devicetree: bindings: regulator: palmas-pmic.txt
Date: Tue, 29 Mar 2016 18:12:43 +0530
Message-ID: <1459255363-21101-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com
Cc: spatton@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

From: Schuyler Patton <spatton@ti.com>

Adding support for the tps659038 pmic so it doesn't generate a warning
when running the patch check script to
Documentation/devicetree/bindings/regulator/palmas-pmic.txt

Adding a note that the tps659037 device is a OTP spin of the
tps659038 pmic and device compatible.

Signed-off-by: Schuyler Patton <spatton@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 Documentation/devicetree/bindings/regulator/palmas-pmic.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/palmas-pmic.txt b/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
index 725393c..9987281 100644
--- a/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
+++ b/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
@@ -1,5 +1,12 @@
 * palmas regulator IP block devicetree bindings
 
+The tps659038 for the AM57x class have OTP spins that
+have different part numbers but the same functionality. There
+is not a need to add the OTP spins to the palmas driver. The
+spin devices should use the tps659038 as it's compatible value.
+This is the list of those devices:
+tps659037
+
 Required properties:
 - compatible : Should be from the list
   ti,twl6035-pmic
@@ -8,6 +15,7 @@ Required properties:
   ti,tps65913-pmic
   ti,tps65914-pmic
   ti,tps65917-pmic
+  ti,tps659038-pmic
 and also the generic series names
   ti,palmas-pmic
 - interrupt-parent : The parent interrupt controller which is palmas.
-- 
1.9.1
