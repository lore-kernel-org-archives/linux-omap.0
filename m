From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: dts: omap4-droid4: add soundcard
Date: Tue, 25 Jul 2017 11:08:33 +0200
Message-ID: <20170725090833.lkqxwk4oakafsmgr@earth>
References: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
 <20170707164229.5868-4-sebastian.reichel@collabora.co.uk>
 <20170710122602.srdzonm3s6gcqhnf@sirena.org.uk>
 <20170724191954.GC32425@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3hmefpqmnp2nosxp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170724191954.GC32425@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--3hmefpqmnp2nosxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 24, 2017 at 09:19:54PM +0200, Pavel Machek wrote:
> On Mon 2017-07-10 13:26:02, Mark Brown wrote:
> > On Fri, Jul 07, 2017 at 06:42:29PM +0200, Sebastian Reichel wrote:
> >=20
> > > +	soundcard {
> > > +		compatible =3D "simple-audio-card";
> > > +		simple-audio-card,name =3D "Droid 4 Audio";
> >=20
> > New systems should be using the of-graph card which is more flexible and
> > extensible than simple-card.
>=20
> Well, if simple-card does what is needed here, and dts looks
> reasonable, is there reason for anything more complex?

There is already a PATCHv2 for this patchset, that switched to
the graph based card.

> Anyway, congratulations for getting the sound to work!

Thanks.

-- Sebastian

--3hmefpqmnp2nosxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3CpAACgkQ2O7X88g7
+pr5ehAAne4NZqj6gQH/r9gmRmPhGut8z86SsMpEYoQzyiU+hMPNMepwB3NiZg86
t01vN1nlVmngyZFHnuyJvGAGCzc5MAGKZZPpTdI3dvMWvrVZsw9oMlcjOB8a1U4d
jYVC03+wfwUtSJ0jwHQlVYWLM3YOexNdLDuKUwPiWLD+YzxZ8egYUNYmSwhTXw9T
6ZPdSg8ahEAIyuLo3w31vXvM2JUH/F+ZKgyUs/TaqfAsDCfw8BpvHNeFLpyftgre
gklrjSKi7VNPbVmyvtKzUQXW41+stginclUy2KgMVtEXpy0xwzHXCS/LsEVodcLY
6MwqF69CIeBgC+w8F6gr7FWJZse1pRUdJzuQfTUC0wXm0RmlvNmsPVhOXlGMNXWB
80Z1X3C0w8elqbiboy6c3cAmPRak5eDmDqF4QIA8ZP+33SJcJiQ3LyotylXjPbo2
tJ5G7TmdjLGF6U+LYPvk5Ea9eyDBWSpl5V3HASzEbe8XmVU6BstBzA+pSoS3VZQx
gszAaTTf3drTiakmQGsM0dfxThUIxfE+uyA/haQyak9rc5/yOY2seKT7z24O7s7z
01xvu4toElz/j/IXQFi0MIKPjNX4AePlcwmHOkV2+2dy6r02jhwpX0eU2xnAl2mO
iz8AMrPitLQZ7VZ1B0uDecPjcWbX4ow/dayAZj+hHKZN9YN3kLk=
=2dE1
-----END PGP SIGNATURE-----

--3hmefpqmnp2nosxp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
