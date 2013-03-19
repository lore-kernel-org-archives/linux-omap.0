From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 4/8] ARM: dts: OMAP443x: Add CPU OPP table
Date: Tue, 19 Mar 2013 12:53:06 -0500
Message-ID: <1363715590-5131-5-git-send-email-nm@ti.com>
References: <1363715590-5131-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45140 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932135Ab3CSRxd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 13:53:33 -0400
In-Reply-To: <1363715590-5131-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jon Hunter <jon-hunter@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Add DT OPP table for OMAP443x family of devices. This data is
decoded by OF with of_init_opp_table() helper function.

OPP data here is based on existing opp4xxx_data.c

Since the omap4460 OPP tables would be different from OMAP443x,
introduce an new omap443x.dtsi for 443x specific entries and use
existing omap4.dtsi as the common dtsi file for all OMAP4 platforms.

This is in preparation to use generic cpufreq-cpu0 driver for device
tree enabled boot. Legacy non device tree enabled boot continues to
use omap-cpufreq.c and opp4xxx_data.c.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes in V2:
	- introduce omap443x.dtsi
	- donot delete the OPP table entries in omap4xxx_data.c
	- little more verbose commit log
V1: https://patchwork.kernel.org/patch/2273581/

 arch/arm/boot/dts/omap4-panda.dts   |    2 +-
 arch/arm/boot/dts/omap4-sdp.dts     |    2 +-
 arch/arm/boot/dts/omap4-var-som.dts |    2 +-
 arch/arm/boot/dts/omap443x.dtsi     |   27 +++++++++++++++++++++++++++
 4 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap443x.dtsi

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap=
4-panda.dts
index 1751a25..e05b1b0 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
=20
-/include/ "omap4.dtsi"
+/include/ "omap443x.dtsi"
 /include/ "elpida_ecb240abacn.dtsi"
=20
 / {
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-=
sdp.dts
index a93a19d..c387bdc 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
=20
-/include/ "omap4.dtsi"
+/include/ "omap443x.dtsi"
 /include/ "elpida_ecb240abacn.dtsi"
=20
 / {
diff --git a/arch/arm/boot/dts/omap4-var-som.dts b/arch/arm/boot/dts/om=
ap4-var-som.dts
index 6601e6a..222a413 100644
--- a/arch/arm/boot/dts/omap4-var-som.dts
+++ b/arch/arm/boot/dts/omap4-var-som.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
=20
-/include/ "omap4.dtsi"
+/include/ "omap443x.dtsi"
=20
 / {
 	model =3D "Variscite OMAP4 SOM";
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap44=
3x.dtsi
new file mode 100644
index 0000000..cccf39a
--- /dev/null
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -0,0 +1,27 @@
+/*
+ * Device Tree Source for OMAP443x SoC
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.c=
om/
+ *
+ * This file is licensed under the terms of the GNU General Public Lic=
ense
+ * version 2.  This program is licensed "as is" without any warranty o=
f any
+ * kind, whether express or implied.
+ */
+
+/include/ "omap4.dtsi"
+
+/ {
+	cpus {
+		cpu@0 {
+			/* OMAP443x variants OPP50-OPPNT */
+			operating-points =3D <
+				/* kHz    uV */
+				300000  1025000
+				600000  1200000
+				800000  1313000
+				1008000 1375000
+			>;
+			clock-latency =3D <300000>; /* From legacy driver */
+		};
+	};
+};
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
