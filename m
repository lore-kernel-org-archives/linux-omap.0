From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 4/4] ARM: dts: omap3-beagle-xm: Add USB host supprot for Rev. Ax/Bx
Date: Fri, 19 Apr 2013 12:57:37 +0300
Message-ID: <1366365457-28972-5-git-send-email-rogerq@ti.com>
References: <1366365457-28972-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366365457-28972-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: b-cousson@ti.com, tony@atomide.com
Cc: nm@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Rev. Ax/Bx boards have reversed polarity for USBHOST_PWR_ENable
signal when compared to Rev. C boards.

We create a new dts file for Ax/Bx boards.

Also update model and compatible flags for Rev. C board.

CC: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm-ab.dts |   19 +++++++++++++++++++
 arch/arm/boot/dts/omap3-beagle-xm.dts    |    4 ++--
 2 files changed, 21 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-beagle-xm-ab.dts

diff --git a/arch/arm/boot/dts/omap3-beagle-xm-ab.dts b/arch/arm/boot/d=
ts/omap3-beagle-xm-ab.dts
new file mode 100644
index 0000000..041b40e
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-beagle-xm-ab.dts
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.c=
om/
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/include/ "omap3-beagle-xm.dts"
+
+/ {
+        model =3D "TI OMAP3 BeagleBoard xM Rev: Ax/Bx";
+        compatible =3D "ti,omap3-beagle-xm-ab", "ti,omap3-beagle", "ti=
,omap3";
+};
+
+/* On Rev A/B USBHOST_PWR_EN is active high */
+&hsusb2_power {
+	enable-active-high;
+};
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/=
omap3-beagle-xm.dts
index 19a8ccb..49af2eb 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -10,8 +10,8 @@
 /include/ "omap36xx.dtsi"
=20
 / {
-	model =3D "TI OMAP3 BeagleBoard xM";
-	compatible =3D "ti,omap3-beagle-xm, ti,omap3-beagle", "ti,omap3";
+	model =3D "TI OMAP3 BeagleBoard xM Rev: C";
+	compatible =3D "ti,omap3-beagle-xm-c", "ti,omap3-beagle", "ti,omap3";
=20
 	cpus {
 		cpu@0 {
--=20
1.7.4.1
