From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: [PATCH 1/6] ARM: dts: OMAP36xx: add device tree for ABB
Date: Thu, 28 Mar 2013 19:16:03 +0200
Message-ID: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54507 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756607Ab3C1RQb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 13:16:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-patch-review@list.ti.com
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org

=46rom: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Add DT ABB data for OMAP36xx family of devices.
This data is based on OMAP36XX_ES1.x_NDA_TRM_vAB.pdf
document.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org

Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 arch/arm/boot/dts/omap36xx.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36=
xx.dtsi
index 96bf028..72d5135 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -15,6 +15,22 @@
 		serial3 =3D &uart4;
 	};
=20
+	abb@0x483072f0 {
+		compatible =3D "ti,omap36xx-abb";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		reg =3D <0x483072f0 0x8>,
+		      <0x48306818 0x4>; /* PRM_IRQSTATUS_MPU */
+		operating-points =3D <
+			/* kHz   ABB */
+			300000  0
+			600000  0
+			800000  0
+			1000000 1
+		>;
+		ti,tranxdone_status_mask =3D <0x4000000>; /* (1 << 26) */
+	};
+
 	ocp {
 		uart4: serial@49042000 {
 			compatible =3D "ti,omap3-uart";
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
