From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/7] ARM: dts: Add nodes for missing omap4 interconnect
 target modules
Date: Wed, 11 Oct 2017 18:58:51 +0200
Message-ID: <20171011165850.jnaievrgcszcawh3@earth>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-6-tony@atomide.com>
 <f5c57f0b-1423-c362-0fda-4069b77a2e38@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ytumvpxylcykktz4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f5c57f0b-1423-c362-0fda-4069b77a2e38-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--ytumvpxylcykktz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Wed, Oct 11, 2017 at 06:54:04PM +0300, Peter Ujfalusi wrote:
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20
> On 09/30/2017 01:34 AM, Tony Lindgren wrote:
> > On omap4 we are missing dts nodes for several interconnect target
> > modules that we are idling on init. This currently works with the
> > legacy platform data still around.
> >=20
> > To fix this, let's add the interconnect target modules so we can
> > idle the unused interconnect target module on init.
> >=20
> > Also note that adding the interconnect target module node does not
> > necessarily mean that there is a driver available for the child IP
> > block, or that the child IP block is even functional.
> >=20
> > In the SGX case, the PowerVR driver is closed source. And McASP on
> > omap4 has at least the TX path disabled and is not supported by the
> > davinci-mcasp driver.
>=20
> RX path is disabled, TX is supposed to work.
>=20
> ...
>=20
> > +		target-module@40128000 {
> > +			compatible =3D "ti,sysc-mcasp";
> > +			ti,hwmods =3D "mcasp";
> > +			reg =3D <0x40128004 0x4>;
> > +			reg-names =3D "sysc";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			ranges =3D <0x00000000 0x40128000 0x1000>, /* MPU */
> > +				 <0x49028000 0x49028000 0x1000>; /* L3 */
> > +
> > +			/*
> > +			 * Child device unsupported by davinci-mcasp. At least
> > +			 * TX path is disabled for omap4, and only DIT mode
>=20
> s/TX/RX
>=20
> > +			 * works with no I2S. See also old Android kernel
> > +			 * omap-mcasp driver for more information.
>=20
> I'll look at the schema of PandaBoard to see if I can route out the McASP
> lines to somewhere then I can add support for this revision to davinci-mc=
asp
> driver.

Not sure if this is helpful information:

Motorola Droid 4 is OMAP4430 based and has McASP lines routed
to the audio codec (either McASP or McBSP can be used). Codec
is a custom one, which is not yet supported mainline, but
patches are WIP (*):

https://lkml.org/lkml/2017/7/12/368

(*) My patches use McBSP instead of McASP, since McASP looked
mostly unsupported. Motorola's kernel uses McASP.

-- Sebastian

--ytumvpxylcykktz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlneTccACgkQ2O7X88g7
+prbIw//dkzc5xbtfN8j112SdDg5WFR+Z97MFIaf74OBEmei+QsK2Ipq5Bg571uJ
bdtJ6sjkylS9MpRboRVSmuZQliWEUAioEN5M1XyTh/Uqy1WoXapILo6W1BMNW7yq
J66osSS0ZRP/4q75FWH845DoA44knbJ5UBuR/m6fD9NCrEOgVtJwK2XeivDpacLS
fTgl173afsK9DVhZl61EXoRpSFYP8onWacFT3lmiByctPa+JcFyMQvip+EyFPpR0
RjzeGU8lPMmF97+FGXgegBzzzoy47/Uh2LtKa7UXzEkfIF+BiNEwEv30u2G/x4GE
1Ss+GoDV4qA+17q85HvcmH3ZCMfSwKNZBVx8HxtypOzzeLMXv4zM0zY3EmuLbPmY
htG34dKa8fKrIpXk0pnwES5c9CbErznRVR9LFHcn8sEwlU9m2nSIcCw7EjH3dOMB
+T7Ore69h5knISk6nfqNRHHYsLWjkSDi/SojQWPetWLJlNrms5xuWfrN9fjeRbBL
rpDmyPiOguCU2sNO8BbKxy7xdPNNQXZTLbNc6to9v/VT5TvbIG4h8I36cjV6a82R
xKF7ZFoy4vQoX8ITps6jTSSebQ8gfDtkqiPmLSkZk7vAZ7DfYELVeW3ZzQH5jRB9
4viZcOTmA2SibzjGX9UewUpu39A6rIvAI2p3njMDVD6xAZrkaYY=
=8DUs
-----END PGP SIGNATURE-----

--ytumvpxylcykktz4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
