From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH 2/6] ARM: dts: OMAP4: add device tree for ABB
Date: Thu, 28 Mar 2013 19:16:04 +0200
Message-ID: <1364490968-13613-2-git-send-email-andrii.tseglytskyi@ti.com>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59411 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756607Ab3C1RQe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 13:16:34 -0400
In-Reply-To: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-patch-review@list.ti.com
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org

=46rom: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Add DT ABB data for OMAP44xx family of devices.
This data is based on OMAP4430_ES2.x_NDA_TRM_vAA.pdf
document.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org

Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi    |   18 ++++++++++++++++++
 arch/arm/boot/dts/omap443x.dtsi |   20 ++++++++++++++++++++
 arch/arm/boot/dts/omap446x.dtsi |   36 +++++++++++++++++++++++++++++++=
+++++
 3 files changed, 74 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap446x.dtsi

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dts=
i
index 739bb79..0bc3ef1 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -81,6 +81,24 @@
 		};
 	};
=20
+	abb@0x4a307bd0 {
+		compatible =3D "ti,omap4-abb";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		reg =3D <0x4a307bd0 0x8>,
+		      <0x4a306014 0x4>; /* PRM_IRQSTATUS_MPU_A9_2 */
+		ti,tranxdone_status_mask =3D <0x80>; /* (1 << 7) */
+	};
+
+	abb@0x4a307bd8 {
+		compatible =3D "ti,omap4-abb";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		reg =3D <0x4a307bd8 0x8>,
+		      <0x4a306010 0x4>; /* PRM_IRQSTATUS_MPU_A9 */
+		ti,tranxdone_status_mask =3D <0x80000000>; /* (1 << 31) */
+	};
+
 	/*
 	 * XXX: Use a flat representation of the OMAP4 interconnect.
 	 * The real OMAP interconnect network is quite complex.
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap44=
3x.dtsi
index cccf39a..6c511c6 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -24,4 +24,24 @@
 			clock-latency =3D <300000>; /* From legacy driver */
 		};
 	};
+
+	abb@0x4a307bd0 {
+		operating-points =3D <
+			/* kHz   ABB */
+			300000  0
+			600000  0
+			800000  0
+			1008000 1
+		>;
+	};
+
+	abb@0x4a307bd8 {
+		operating-points =3D <
+			/* kHz   ABB */
+			133000  0
+			266100  0
+			332000  0
+		>;
+	};
+
 };
diff --git a/arch/arm/boot/dts/omap446x.dtsi b/arch/arm/boot/dts/omap44=
6x.dtsi
new file mode 100644
index 0000000..b884c60
--- /dev/null
+++ b/arch/arm/boot/dts/omap446x.dtsi
@@ -0,0 +1,36 @@
+/*
+ * Device Tree Source for OMAP446x SoC
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
+	abb@0x4a307bd0 {
+		operating-points =3D <
+			/* kHz   ABB */
+			350000  0
+			700000  0
+			920000  0
+			1200000 1
+			1500000 1
+		>;
+	};
+
+	abb@0x4a307bd8 {
+		operating-points =3D <
+			/* kHz   ABB */
+			133000  0
+			266100  0
+			332000  0
+			430000  1
+			500000  1
+		>;
+	};
+
+};
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
