From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH 3/6] ARM: dts: OMAP5: add device tree for ABB
Date: Thu, 28 Mar 2013 19:16:05 +0200
Message-ID: <1364490968-13613-3-git-send-email-andrii.tseglytskyi@ti.com>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42103 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756607Ab3C1RQh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 13:16:37 -0400
In-Reply-To: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-patch-review@list.ti.com
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

=46rom: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Add DT ABB data for OMAP543x family of devices.
This data is based on OMAP543x_ES2.0_NDA_TRM_vR.pdf
document.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org

Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dts=
i
index 150bff6..eb11bb7 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -74,6 +74,37 @@
 		};
 	};
=20
+	abb@0x4ae07cdc {
+		compatible =3D "ti,omap5-abb";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		reg =3D <0x4ae07cdc 0x8>,
+		      <0x4ae06014 0x4>; /* PRM_IRQSTATUS_MPU_2 */
+		operating-points =3D <
+				/* kHz   ABB */
+				499200  0
+				1099800 1
+				1500000 1
+				1699200 1
+		>;
+		ti,tranxdone_status_mask =3D <0x80>; /* (1 << 7) */
+	};
+
+	abb@0x4ae07ce4 {
+		compatible =3D "ti,omap5-abb";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		reg =3D <0x4ae07ce4 0x8>,
+		      <0x4ae06010 0x4>; /* PRM_IRQSTATUS_MPU */
+		operating-points =3D <
+				/* kHz   ABB */
+				194100	0
+				388310	0
+				531200	0
+		>;
+		ti,tranxdone_status_mask =3D <0x80000000>; /* (1 << 31) */
+	};
+
 	/*
 	 * XXX: Use a flat representation of the OMAP3 interconnect.
 	 * The real OMAP interconnect network is quite complex.
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
