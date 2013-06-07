From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv3 3/6] arm: dts: add bandgap entry for OMAP443x devices
Date: Fri, 7 Jun 2013 16:46:05 -0400
Message-ID: <1370637968-23299-4-git-send-email-eduardo.valentin@ti.com>
References: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370637968-23299-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, grant.likely@linaro.org
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Eduardo Valentin <eduardo.valentin@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch add the bandgap entry for OMAP4430 devices.

Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap443x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap44=
3x.dtsi
index cccf39a..8d6c968 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -24,4 +24,8 @@
 			clock-latency =3D <300000>; /* From legacy driver */
 		};
 	};
+	bandgap {
+		reg =3D <0x4a002260 0x4 0x4a00232C 0x4>;
+		compatible =3D "ti,omap4430-bandgap";
+	};
 };
--=20
1.8.2.1.342.gfa7285d
