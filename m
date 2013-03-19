From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 2/8] ARM: dts: OMAP36xx: Add CPU OPP table
Date: Tue, 19 Mar 2013 12:53:04 -0500
Message-ID: <1363715590-5131-3-git-send-email-nm@ti.com>
References: <1363715590-5131-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38019 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933267Ab3CSRxa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 13:53:30 -0400
In-Reply-To: <1363715590-5131-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jon Hunter <jon-hunter@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Add DT OPP table for OMAP36xx/37xx family of devices. This data is
decoded by OF with of_init_opp_table() helper function.

OPP data here is based on existing opp3xxx_data.c

This is in preparation to use generic cpufreq-cpu0 driver for device
tree enabled boot. Legacy non device tree enabled boot continues to
use omap-cpufreq.c and opp3xxx_data.c.

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
	- donot delete the OPP table entries in omap3xxx_data.c
	- little more verbose commit log
V1: https://patchwork.kernel.org/patch/2273681/

 arch/arm/boot/dts/omap36xx.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36=
xx.dtsi
index 96bf028..b89233e 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -15,6 +15,19 @@
 		serial3 =3D &uart4;
 	};
=20
+	cpus {
+		/* OMAP3630/OMAP37xx 'standard device' variants OPP50 to OPP130 */
+		cpu@0 {
+			operating-points =3D <
+				/* kHz    uV */
+				300000   975000
+				600000  1075000
+				800000  1200000
+			>;
+			clock-latency =3D <300000>; /* From legacy driver */
+		};
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
