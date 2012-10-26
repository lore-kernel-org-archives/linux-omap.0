From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 3/3] ARM: OMAP: ocp2scp: create omap device for ocp2scp
Date: Fri, 26 Oct 2012 22:59:58 +0300
Message-ID: <20121026195958.GB29548@arwen.pp.htv.fi>
References: <1349675983-23803-1-git-send-email-kishon@ti.com>
 <1349675983-23803-4-git-send-email-kishon@ti.com>
 <20121026065012.GC22206@arwen.pp.htv.fi>
 <201210260747.11848.arnd@arndb.de>
 <20121026172140.GJ11908@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121026172140.GJ11908@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, balbi@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, linux@arm.linux.org.uk, b-cousson@ti.com, olof@lixom.net, rdunlap@xenotime.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2012 at 10:21:41AM -0700, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [121026 00:48]:
> > On Friday 26 October 2012, Felipe Balbi wrote:
> > > > +static void omap_init_ocp2scp(void)
> > > > +{
> > > > +     struct omap_hwmod       *oh;
> > > > +     struct platform_device  *pdev;
> > > > +     int                     bus_id =3D -1, dev_cnt =3D 0, i;
> > > > +     struct omap_ocp2scp_dev *ocp2scp_dev;
> > > > +     const char              *oh_name, *name;
> > > > +     struct omap_ocp2scp_platform_data *pdata;
> > > > +
> > > > +     oh_name =3D "ocp2scp_usb_phy";
> > > > +     name    =3D "omap-ocp2scp";
> > >=20
> > > how about adding checks here to return early case we're not running on
> > > OMAP4 or OMAP5 ??
> > >=20
> >=20
> > I suppose even OMAP4-only, since OMAP5 always has DT enabled.
>=20
> Hmm yes, currently omap_hwmod_lookup(oh_name) produces
> bogus errors for other omaps as the hwmod data is only
> there for omap4.

shouldn't that be fixed too ? I mean, if data isn't just return -ENODEV
or something similar.

--=20
balbi

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiuu+AAoJEIaOsuA1yqRE4f8P/ik/GdBk+FO/t+RYqb/bRcSP
JNcWonRo6oQE9OUweOz6AdxCB1k8aCJurMRXAy9X2LYFO/4YSrbTT0ITGZwyROTI
oODrnQHhkRkIayYU6fhxYFHHKU3wU4PVTVGqBhYxDYr7zZ/mewis0SK/iSp1NgYG
JKcRcsLn95LAX3HKvcuP4Vgc7cwpSAHGFU2ROXraPi/y7JjFOCuJEElXhWDeYcDv
AUWoHVXTe1u3JV3V63vcdL1A67CRLIQq3Qu1jcvj9c+1+RyQQa1xQ1LAlZUD2ZO1
T3XbJYULHCE1dQxezUmfkw/COdIqdRM/x2F56XIM55GWInfUY+fuKOjOBFJ2LZnU
mZts6WsYtn9llW0vNnskEmLJvhPbhMNOhW47rMy9QK0YdnNFM2nWzmqbeJDm1oFN
6iXoQjuHUEfq+jfpxhP3w0o/OHym/gcYONdEHf3QzC6L3Q5sRQDQhEYeOmNvvvAJ
eUrtBci5AKpVUMIIywZKe/+RIrm7bAs8GKrHTFiWpacKvaQCpxgYTtFQeA0Sr66u
CYBjLJgEFULuHxRlCvgj3owc1AvzHv7wQWR3sK1YGCbvuMVkf7yqsGFTUWckbOtp
/LvGjN9k8Q7/azfviI46chGc1BGurRYrvf6Oj7jz23c7b2AFR1WuDiKFte1XRFF9
FZeoy3pctvrJSmgnuqss
=xsdm
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
