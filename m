From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCHv2 0/6] Motorola Droid 4 Audio Support
Date: Mon, 17 Jul 2017 16:13:47 +0200
Message-ID: <20170717141347.t2642xbkol3g36rv@earth>
References: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
 <20170717092904.GG10026@atomide.com>
 <20170717101258.llyly7kwfnwtoftr@earth>
 <20170717101709.GI10026@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cm5p2mw2utbxc7c6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170717101709.GI10026-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--cm5p2mw2utbxc7c6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 17, 2017 at 03:17:10AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170717 03:13]:
> > On Mon, Jul 17, 2017 at 02:29:04AM -0700, Tony Lindgren wrote:
> > > * Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170712 08:19=
]:
> > > >  * Switch from simple-audio-card to audio-graph-card
> > >=20
> > > Gave this a quick try against v4.13-rc1 with SND_AUDIO_GRAPH_CARD
> > > enabled as a loadable module. However loading it oopses for me,
> > > see below. Maybe some dependencies are missing?
> >=20
> > It works for me on top of v4.13-rc1 (my kernel is monolithic).
> > Looking at the stacktrace it seems to be a bug in audio graph
> > card and not in the codec driver.
>=20
> OK I do also have:
>=20
> CONFIG_DEBUG_LOCKDEP=3Dy
> CONFIG_DEBUG_ATOMIC_SLEEP=3Dy

I added those and I do not get a stacktrace for anything sound
related and audio works. I noticed one issue in dapm routing,
that I accidently added. That will be fixed in PATCHv3, but its
in untestable path anyways (EXT capture, probably FM radio is
connected to EXT).

-- Sebastian

--cm5p2mw2utbxc7c6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllsxhYACgkQ2O7X88g7
+pof1g//fgx37/YS/Mfei2ySl5Zp3avq0bATxMTWgn4HW9EeHJybfkS5JCK/cia6
5a14NhSmPps8S2p0ZWxDxwSPc3TpNP1f5Y85vJLz+DbG/hw+DpKBl1Sb9sbMGZ7V
dOFegZwozC/ydO+CMC4Qc09F/nA4WiKGcFVjcMDGUE4yiUazy2VedXtVzM5ejB0j
MmjNT+0wmk9IIl8FjrOUjwzEKpGE4hHsb0t56MrfFP3FoUjEzjLeFhLsDNrYdAmS
KEzAvlAlc4HYqo7zF+g00y1qtkbuSr4hRdQk+jBfIv4Uk68mHn0lZReLPNBIVO5C
2D0M9f6IctOAZKIaedxx+eMloS+m+IktYEWoCOKPw79UY1+Rkp3vJrqWocQKDHme
gHiuGsEaO8W1UYWdTIdXE0oTiZtDaNaql+3v7/OdcJ/UZkTzhJwMliBJe2p4120j
qqy87Ky1FdU0sHDB8N2Ey2ro0dtDDQWdV5bqyC0Ux7RW7K+VlGNkIFFfEcMFSmk3
+XZsZeOWfMGAFdTqycUwKkzkO9sxJThr3ZM5nTs3Hc9FFAQrNuvdaVuImYEtAY3E
cPXpBpelTbuDFc+Ep1bMrtMTregwwJpUUFEg2Hm1ulKPxB/dI6Nb6/1Bn0m+9IyJ
klqPVe+1RHU3Ibbz9wpXHa2IMRJHlFRNCLYINUo69iQQdCtxnC0=
=V9/d
-----END PGP SIGNATURE-----

--cm5p2mw2utbxc7c6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
