From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap5-board-common: Describe the voltage
 supply mapping accurately
Date: Thu, 5 May 2016 12:27:32 -0700
Message-ID: <20160505192732.GC5995@atomide.com>
References: <1462389618-28860-1-git-send-email-nm@ti.com>
 <572A528C.4090302@ti.com>
 <20160505183611.GA5995@atomide.com>
 <572B984D.10203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <572B984D.10203-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, =?utf-8?Q?Agust=C3=AD?= Fontquerni <af-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>, Eduard Gavin <egavin-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>, Enric Balletbo i Serra <eballetbo-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [160505 12:02]:
> On 05/05/2016 01:36 PM, Tony Lindgren wrote:
> > Now I'm wondering if the x15 related vin-supply changes are actuall=
y all
> > ignored? It seems that "vin" is only automatically configured for t=
he
> > fixed-regulator? Maybe regulator-palmas should be updated to use th=
e
>=20
> ok /me goes duh!!!! ofcourse! Sorry about not catching it..
> hmm.. maybe we messed up am572x-idk as well.. I can quickly fix that
> up as well

OK yeah sounds like they won't do anything currently.

> ldoln is vsys_cobra as well.. I missed that.
>=20
> Others look good. we should probably get this merged to fix the
> regression.

OK I'll apply the following updated version of your patch later today.
I left out the links from the description and the timestamps too.

Regards,

Tony

8< -------------------------
=46rom: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Date: Thu, 5 May 2016 11:12:28 -0700
Subject: [PATCH] ARM: dts: omap5-board-common: Describe the voltage sup=
ply
 mapping accurately
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

OMAP5uEVM based platforms share a similar voltage rail map. This
should be properly described in device tree, without this regulator cor=
e
will be unable to determine the source voltage of LDOs such as LDO9 and
SMPS10 which could be configured for bypass depending on the voltage
requested of them. This results in conditions such as:

ldo9: bypassed regulator has no supply!
ldo9: failed to get the current voltage(-517)
palmas-pmic 48070000.i2c:palmas@48:palmas_pmic: failed to register
48070000.i2c:palmas@48:palmas_pmic regulator

Cc: Agust=C3=AD Fontquerni <af-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
Cc: Eduard Gavin <egavin-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
Cc: Enric Balletbo i Serra <eballetbo-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
[tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org: fixed to use palmas style in-supply]
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -14,6 +14,29 @@
 		display0 =3D &hdmi0;
 	};
=20
+	vmain: fixedregulator-vmain {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vmain";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+	};
+
+	vsys_cobra: fixedregulator-vsys_cobra {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vsys_cobra";
+		vin-supply =3D <&vmain>;
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+	};
+
+	vdds_1v8_main: fixedregulator-vdds_1v8_main {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "vdds_1v8_main";
+		vin-supply =3D <&smps7_reg>;
+		regulator-min-microvolt =3D <1800000>;
+		regulator-max-microvolt =3D <1800000>;
+	};
+
 	vmmcsd_fixed: fixedregulator-mmcsd {
 		compatible =3D "regulator-fixed";
 		regulator-name =3D "vmmcsd_fixed";
@@ -409,6 +432,26 @@
=20
 			ti,ldo6-vibrator;
=20
+			smps123-in-supply =3D <&vsys_cobra>;
+			smps45-in-supply =3D <&vsys_cobra>;
+			smps6-in-supply =3D <&vsys_cobra>;
+			smps7-in-supply =3D <&vsys_cobra>;
+			smps8-in-supply =3D <&vsys_cobra>;
+			smps9-in-supply =3D <&vsys_cobra>;
+			smps10_out2-in-supply =3D <&vsys_cobra>;
+			smps10_out1-in-supply =3D <&vsys_cobra>;
+			ldo1-in-supply =3D <&vsys_cobra>;
+			ldo2-in-supply =3D <&vsys_cobra>;
+			ldo3-in-supply =3D <&vdds_1v8_main>;
+			ldo4-in-supply =3D <&vdds_1v8_main>;
+			ldo5-in-supply =3D <&vsys_cobra>;
+			ldo6-in-supply =3D <&vdds_1v8_main>;
+			ldo7-in-supply =3D <&vsys_cobra>;
+			ldo8-in-supply =3D <&vsys_cobra>;
+			ldo9-in-supply =3D <&vmmcsd_fixed>;
+			ldoln-in-supply =3D <&vsys_cobra>;
+			ldousb-in-supply =3D <&vsys_cobra>;
+
 			regulators {
 				smps123_reg: smps123 {
 					/* VDD_OPP_MPU */
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
