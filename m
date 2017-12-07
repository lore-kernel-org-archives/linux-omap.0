From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 04/20] ARM: dts: am43xx: add fck under timers1/2
Date: Thu, 7 Dec 2017 10:46:37 +0200
Message-ID: <1512636413-25243-5-git-send-email-t-kristo@ti.com>
References: <1512636413-25243-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512636413-25243-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

=EF=BB=BFAdd the functional clock definition for timers1/2. This is needed =
so that
the clock rate calculations continue to function properly once am33xx
transitions away from hwmod data and towards the clkctrl clocks.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index e5b0614..549b9f4 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -346,6 +346,8 @@
 			interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-alwon;
 			ti,hwmods =3D "timer1";
+			clocks =3D <&timer1_fck>;
+			clock-names =3D "fck";
 		};
=20
 		timer2: timer@48040000  {
@@ -353,6 +355,8 @@
 			reg =3D <0x48040000  0x400>;
 			interrupts =3D <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods =3D "timer2";
+			clocks =3D <&timer2_fck>;
+			clock-names =3D "fck";
 		};
=20
 		timer3: timer@48042000 {
--=20
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
