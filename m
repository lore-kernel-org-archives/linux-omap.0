From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv5 12/20] arm: dts: add cooling properties on omap4430 cpu node
Date: Tue, 12 Nov 2013 15:46:14 -0400
Message-ID: <1384285582-16933-13-git-send-email-eduardo.valentin@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com
Cc: wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

OMAP4430 devices can reach high temperatures and thus
needs to have cpufreq-cooling on systems running on it.

This patch adds the required cooling device properties
so that cpufreq-cpu0 driver loads the cooling device.

Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap443x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap44=
3x.dtsi
index e9c97d6..930ab47 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -22,6 +22,11 @@
 				1008000 1375000
 			>;
 			clock-latency =3D <300000>; /* From legacy driver */
+
+			/* cooling options */
+			cooling-min-level =3D <0>;
+			cooling-max-level =3D <3>;
+			#cooling-cells =3D <2>; /* min followed by max */
 		};
 	};
=20
--=20
1.8.2.1.342.gfa7285d
