From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 02/13] Documentation: update charger-manager devicetree
 bindings
Date: Mon, 14 Apr 2014 13:46:13 +0200
Message-ID: <1397475984-28001-3-git-send-email-r.baldyga@samsung.com>
References: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dbaryshkov@gmail.com, dwmw2@infradead.org, balbi@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, ldewangan@nvidia.com, kishon@ti.com, gg@slimlogic.co.uk, anton@enomsg.org, jonghwa3.lee@samsung.com, rongjun.ying@csr.com, linux@roeck-us.net, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi, m.szyprowski@samsung.com, t.figa@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch changes charger-manager bindings to be compatible with
new extcon bindings.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 .../bindings/power_supply/charger-manager.txt      |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/power_supply/charger-manager.txt b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
index 2b33750..f987bb5 100644
--- a/Documentation/devicetree/bindings/power_supply/charger-manager.txt
+++ b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
@@ -10,8 +10,7 @@ Required properties :
  - subnode <regulator> :
 	- cm-regulator-name : name of charger regulator
 	- subnode <cable> :
-		- cm-cable-name : name of charger cable
-		- cm-cable-extcon : name of extcon dev
+		- extcon-cable : specified extcon cable
 (optional)	- cm-cable-min : minimum current of cable
 (optional)	- cm-cable-max : maximum current of cable
 
@@ -65,14 +64,14 @@ Example :
 		regulator@0 {
 			cm-regulator-name = "chg-reg";
 			cable@0 {
-				cm-cable-name = "USB";
-				cm-cable-extcon = "extcon-dev.0";
+				/* USB cable */
+				extcon-cable = <&extcon 0>;
 				cm-cable-min = <475000>;
 				cm-cable-max = <500000>;
 			};
 			cable@1 {
-				cm-cable-name = "TA";
-				cm-cable-extcon = "extcon-dev.0";
+				/* TA cable */
+				extcon-cable = <&extcon 1>;
 				cm-cable-min = <650000>;
 				cm-cable-max = <675000>;
 			};
-- 
1.7.9.5
