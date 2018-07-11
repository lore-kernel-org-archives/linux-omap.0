From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Vibrations on Droid 4?
Date: Wed, 11 Jul 2018 16:25:26 +0200
Message-ID: <20180711142526.dto6iost57zx5t5l@earth.universe>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
 <20180711132739.GL99251@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nh3alkkyqinnafhb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180711132739.GL99251@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--nh3alkkyqinnafhb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 11, 2018 at 06:27:39AM -0700, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180711 08:05]:
> > Hi!
> >=20
> > > > Its parent is gpio@4805d000 , and that one seems to be present.
> > > >=20
> > > > user@devuan:/sys/bus/platform/devices$ ls 4805d000.gpio
> > > > driver				       driver_override  gpio
> > > > gpiochip5  modalias  of_node  power  subsystem  uevent
> > >=20
> > > Sorry, something went wrong with merging this. The parent
> > > of ti,omap-dmtimer-pwm and pwm-vibrator should be / and
> > > not gpio6.
> >=20
> > Ok, got it to probe... after dts fix and adding EPROBE_DEFFER to
> > driver.
> ..
> > --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> > +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> > @@ -159,13 +159,7 @@
> > =20
> >  		dais =3D <&mcbsp2_port>, <&mcbsp3_port>;
> >  	};
> > -};
> > -
> > -&dss {
> > -	status =3D "okay";
> > -};
> > =20
> > -&gpio6 {
> >  	pwm8: dmtimer-pwm-8 {
> >  		pinctrl-names =3D "default";
> >  		pinctrl-0 =3D <&vibrator_direction_pin>;
> > @@ -192,7 +186,10 @@
> >  		pwm-names =3D "enable", "direction";
> >  		direction-duty-cycle-ns =3D <10000000>;
> >  	};
> > +};
> > =20
> > +&dss {
> > +	status =3D "okay";
> >  };
> > =20
> >  &dsi1 {
>=20
> Hmm sorry if I did a mismerge on the above. A note to
> myself to stop applying patches that apply with fuzz,
> that is clearly dangerous with dts files with lots
> of similar named properties.

It might also have been me doing the mismerge before
sending the patch. Anyways, the patch from Pavel looks
good to me. As a side-effect dss and dsi references
come next to each other.

-- Sebastian

--nh3alkkyqinnafhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltGE1IACgkQ2O7X88g7
+prRQg//TVVAlEp2acCJvfFGnm3G8BHqpenYb/ijA3ili2taxLYGAGKAdkM4CAiZ
hqRMSUw7s2OhKGnyXxK+7OGVxeTlzDJYA0kEVvW+d7yFgmEpKYovkMYEiGSUZVlV
5ZOCFdju+QNgo/WBfp/GcWFcFZC02faxbsrniz3kANkIlFA7bAjGMcc+8SjkwgEC
76BiMYSX/IOst1bxlaMjuM6YWPyDvPfDlweZhmVo9C6+VoukjRZYOd2q/VdxTNFE
JFh6zKlJcLwjog857V7XzshiZA3ZvfzE+6ioEqRlCdFAx+QP/v7kZRmtGn5y5Zla
2CNrcw1XSrfrWQqkV249SZFSFFU7Zczv2ik8zgqq7lO4UUxh7Gtqi9xbN60M/upo
w8pnikOQZHdZIEdozJbLZD9Z96BMiUT6kMlC2E2IwTlYPBCh/nP4gpXaK2lh+lMx
2JN2WX29d8iuHbZcMO18a8zTSgs6A2V/Z8HxPmB0oN6irWTWk5NCk1phuWK5948r
HkmZvrsCtV7A7mAapnLIGtUALXMP3oMstUFSCOgw3RLoDg6D3FtzlpWCz4UQ8CT8
RKJsYymQly04KCxzHGMvYMry1Hg/+ASqZlYWYybzxZG/RniUolg/pdBv1dZJWhnA
tVeOxE0+FHr1SfFMgUVrprmJbT3cCNq2BnFxiqpk55G/mNBo1DI=
=0tye
-----END PGP SIGNATURE-----

--nh3alkkyqinnafhb--
