From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] arm: boot: dts: am4372: add operating points
Date: Fri, 8 May 2015 15:24:39 -0500
Message-ID: <20150508202439.GA25459@saruman.tx.rr.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
 <554D17F3.7090008@ti.com>
 <554D18AB.6060901@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <554D18AB.6060901@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2015 at 03:12:27PM -0500, Nishanth Menon wrote:
> On 05/08/2015 03:09 PM, Nishanth Menon wrote:
> > On 05/08/2015 02:57 PM, Felipe Balbi wrote:
> >> By adding operating points, cpufreq-dt has a
> >> chance of running and doing something useful.
> >>
> >> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> ---
> >>  arch/arm/boot/dts/am4372.dtsi | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.=
dtsi
> >> index c80a3e233792..ea1db20f64fc 100644
> >> --- a/arch/arm/boot/dts/am4372.dtsi
> >> +++ b/arch/arm/boot/dts/am4372.dtsi
> >> @@ -38,6 +38,15 @@
> >>  			clocks =3D <&dpll_mpu_ck>;
> >>  			clock-names =3D "cpu";
> >> =20
> >> +			operating-points =3D <
> >> +				/* kHz		uV */
> >> +				1000000		1325000 /* OPP_NITRO */
> >> +				 800000		1260000 /* OPP_TURBO */
> >> +				 720000		1200000 /* OPP_120 */
> >> +				 600000		1100000 /* OPP_100 */
> >> +				 300000		 950000 /* OPP_50 */
> >> +			>;
> >> +
> >>  			clock-latency =3D <300000>; /* From omap-cpufreq driver */
> >>  		};
> >>  	};
> >>
> > which of these OPPs need AVS? which of these are dependent on Efuse bit
> > dependent?
> >
>=20
>=20
> You can use
> http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-3.14.y/a=
rch/arm/mach-omap2/opp43xx_data.c
> for reference.

heh, why isn't that upstream yet ? Seems to be ready already. The point
is that as of now, u-boot will set maximum OPP it can find and, for
AM437x, that will be 800MHz or 1GHz depending on your board. 1GHz might
not be supported in all SoCs and letting that be used all the time is
likely going to reduce silicon lifetime.

At least allowing ondemand governor run, we will be mostly running at
300MHz and only jump to "invalid" OPPs under load which, granted, is
still not perfect, but better than running at 1GHz all the time, don't
you agree ?

--=20
balbi

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVTRuHAAoJEIaOsuA1yqREnzoP/2AkmJWWiTVt8ZXf4s0rsc1t
4sGHEL4UD6K97PWJHCs73s/Nv+kUAOK0JRG1+6xH1Vx7DNjO/4rAdDSC8P3TCpcO
cQAc7GMMy/JGGEFG4B+Od5kRSJkit/Z7KaFoGeA3B6bNTwYiTa1F7TR47tDUhLjz
ALLnWq/UPukCTo3yQmjy+ET6Bo4nC9b7MSU/1+6xHC/kk5GePfPZPwcMW3Tm3DEh
gEciaQZ7ZFEjG+YAZqc/UoebEk7yGSWYJegMQN+Lllo9/mi63Q9Y8Jg//tSlsnOS
iDbH+IJdo5WkqIuKe9iYDjfOfC6FEYrbKSG6WWnPQZ9N2WtGH0DKW2mH9cEyyTS2
By6caN/Kb7RUk8LkSCSeReqMBc7pq8YkrvmsIWeHL2V3Qdp0hQOKgzRrFBB5dn/n
a1DQIJKbZeh3sYtKpZvjdMHFsHyGfB+iWIGtN7Y0ZNoszOT1z468ZN61YDpaJrGr
hJju3NqhKquLIUoqLWRmTrOcJtwIIFi3PCejWkeLH5sNCGFnmZb3cWqMmfH0IDcR
urNRkkilyiBpewvRKpeLTILGIEXOvfbvKu24uBG39JsisCE7OLNbF72E8RfK/3J9
G58LdtIcF31+wNXuc4Cg2HE2qwLvqw/ORkbrEuJbwtRXNjfrDSjbCGM+Bboq2ka5
iUUDnEGdcqqsvdsBSjft
=L44J
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
