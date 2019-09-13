From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Fri, 13 Sep 2019 08:55:57 +0200
Message-ID: <D4F7E03C-1880-45AC-8F7C-6C8A336E2A01@goldelico.com>
References: <20190912183037.18449-1-aford173@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190912183037.18449-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, neolynx@gmail.com, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, andreas@kemnade.info, nm@ti.com, adam.ford@logicpd.com
List-Id: linux-omap@vger.kernel.org

Hi Adam,

> Am 12.09.2019 um 20:30 schrieb Adam Ford <aford173@gmail.com>:
>=20
> The thermal sensor in the omap3 family isn't accurate, but it's
> better than nothing.  The various OPP's enabled for the omap3630
> support up to OPP1G, however the datasheet for the DM3730 states
> that OPP130 and OPP1G are not available above TJ of 90C.

We may have to add similar things for omap34xx as well. See
data sheet 3.3 Recommended Operating Conditions

But when reading them they do not limit temperature but
number of operation hours of each OPP depending on temperature...
That is clearly beyond what a kernel can do (we would have to
have access to some NVRAM in the kernel counting hours).

>=20
> This patch configures the thermal throttling to limit the
> operating points of the omap3630 to Only OPP50 and OPP100 if

s/Only/only/

> the thermal sensor reads a value above 90C.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> diff --git a/arch/arm/boot/dts/omap36xx.dtsi =
b/arch/arm/boot/dts/omap36xx.dtsi
> index 4bb4f534afe2..58b9d347019f 100644
> --- a/arch/arm/boot/dts/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/omap36xx.dtsi
> @@ -25,6 +25,7 @@
>=20
> 			vbb-supply =3D <&abb_mpu_iva>;
> 			clock-latency =3D <300000>; /* =46rom =
omap-cpufreq driver */
> +			#cooling-cells =3D <2>;
> 		};
> 	};
>=20
> @@ -195,6 +196,31 @@
> 	};
> };
>=20
> +&cpu_thermal {
> +	cpu_trips: trips {

Yes, that is comparable to what I have seen in omap5 DT where I know
that thermal throttling works.

> +		/* OPP130 and OPP1G are not available above TJ of 90C. =
*/
> +		cpu_alert0: cpu_alert {
> +			temperature =3D <90000>; /* millicelsius */
> +			hysteresis =3D <2000>; /* millicelsius */
> +			type =3D "passive";
> +		};
> +
> +		cpu_crit: cpu_crit {
> +			temperature =3D <125000>; /* millicelsius */

Shouldn't this be 105=C2=B0C for all omap3 chips (industrial temperature =
range)?

> +			hysteresis =3D <2000>; /* millicelsius */
> +			type =3D "critical";
> +		};
> +	};
> +
> +	cpu_cooling_maps: cooling-maps {
> +		map0 {
> +			trip =3D <&cpu_alert0>;
> +			/* Only allow OPP50 and OPP100 */
> +			cooling-device =3D <&cpu 0 1>;

omap4-cpu-thermal.dtsi uses THERMAL_NO_LIMIT constants but I do not
understand their meaning (and how it relates to the opp list).

> +		};
> +	};

Seems to make sense when comparing to omap4-cpu-thermal.dtsi...

Maybe we can add the trip points to omap3-cpu-thermal.dtsi
because they seem to be the same for all omap3 variants and
just have a SoC variant specific cooling map for omap36xx.dtsi.

> +};
> +
> /* OMAP3630 needs dss_96m_fck for VENC */
> &venc {
> 	clocks =3D <&dss_tv_fck>, <&dss_96m_fck>;
> --=20
> 2.17.1
>=20

The question is how we can test that. Heating up the omap36xx to 90=C2=B0C=

or even 105=C2=B0C isn't that easy like with omap5...

Maybe we can modify the millicelsius values for testing purposes to
something in reachable range, e.g. 60=C2=B0C and 70=C2=B0C and watch =
what happens?

BR,
Nikolaus
