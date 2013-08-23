From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RFC PATCH 08/14] arm: dts: add omap4460 thermal data
Date: Fri, 23 Aug 2013 19:15:49 -0400
Message-ID: <1377299755-5134-9-git-send-email-eduardo.valentin@ti.com>
References: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377299755-5134-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, grant.likely@linaro.org, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, wni@nvidia.com
Cc: durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@linaro.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch changes the dtsi entry on omap4460 to contain
the thermal data. This data will enable the passive
cooling with CPUfreq cooling device at 100C and the
system will do a thermal shutdown at 125C.

Cc: "Beno=C3=AEt Cousson" <b-cousson@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap4460.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap44=
60.dtsi
index c2f0f39..9855f29 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -30,6 +30,10 @@
 		ti,hwmods =3D "debugss";
 	};
=20
+	thermal_zones{
+		#include "omap4-cpu-thermal.dtsi"
+	};
+
 	bandgap {
 		reg =3D <0x4a002260 0x4
 		       0x4a00232C 0x4
@@ -37,5 +41,6 @@
 		compatible =3D "ti,omap4460-bandgap";
 		interrupts =3D <0 126 IRQ_TYPE_LEVEL_HIGH>; /* talert */
 		gpios =3D <&gpio3 22 0>; /* tshut */
+		monitored-zones =3D <&cpu_thermal 0>;
 	};
 };
--=20
1.8.2.1.342.gfa7285d
