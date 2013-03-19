From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 6/8] ARM: dts: OMAP4460: Add CPU OPP table
Date: Tue, 19 Mar 2013 12:53:08 -0500
Message-ID: <1363715590-5131-7-git-send-email-nm@ti.com>
References: <1363715590-5131-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1363715590-5131-1-git-send-email-nm@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jon Hunter <jon-hunter@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add DT OPP table for OMAP4460 family of devices. This data is
decoded by OF with of_init_opp_table() helper function.

OPP data here is based on existing opp4xxx_data.c

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
	- depend on 4460.dtsi available in benoit/for_3.10/dts branch
	- donot delete the OPP table entries in omap4xxx_data.c
	- little more verbose commit log
V1: https://patchwork.kernel.org/patch/2273611/

 arch/arm/boot/dts/omap4460.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap44=
60.dtsi
index e09b3e1..7c2c23c 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -10,6 +10,19 @@
 /include/ "omap4.dtsi"
=20
 / {
+	cpus {
+		/* OMAP446x 'standard device' variants OPP50 to OPPTurbo */
+		cpu@0 {
+			operating-points =3D <
+				/* kHz    uV */
+				350000   975000
+				700000  1075000
+				920000  1200000
+			>;
+			clock-latency =3D <300000>; /* From legacy driver */
+		};
+	};
+
 	pmu {
 		compatible =3D "arm,cortex-a9-pmu";
 		interrupts =3D <0 54 0x4>,
--=20
1.7.9.5

