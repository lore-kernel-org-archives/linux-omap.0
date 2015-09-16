From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 4/5] ASoC: davinci-mcasp: Get rid of bclk_lrclk_ratio
 in private data
Date: Wed, 16 Sep 2015 18:01:07 +0100
Message-ID: <20150916170107.GK12027@sirena.org.uk>
References: <cover.1441806963.git.jsarha@ti.com>
 <f23dab7c68fe1cc899a8bc95cb5c3c5bd1038e18.1441806963.git.jsarha@ti.com>
 <55F12E4E.9020607@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aH2JhRPj1O1v615i"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55F12E4E.9020607-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, misael.lopez-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--aH2JhRPj1O1v615i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2015 at 10:16:30AM +0300, Jyri Sarha wrote:
> On 09/09/15 21:27, Jyri Sarha wrote:

> >+			dev_warn(mcasp->dev,
> >+				 "%s(): BCLK/LRCLK %d is not divisible by %d tdm slots",
> >+				 div, mcasp->tdm_slots);
>=20
> Oops, there is a __func__ missing here.

The patch is basically fine but please send a new version with this
fixed!

--aH2JhRPj1O1v615i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+aBTAAoJECTWi3JdVIfQvNkH/jy5GvBKmPbJK4chSwOzBkVk
A6XRMLRpMspKv3fe0F6rSDX6jpC6707RXkHoJqbFREw7o6F0AFcEbyZ/6LFx5O3U
ufWsC1bLSyH6G4rxNfPWYMMljrNrKQjDKf41YKYc84NCAP95FsVyRiFMpdaPTKCY
7OfL+vn688QS2VVlM6yshYeP0CVjNQNjUwah9yXUssBtfCMMyYJ2tuHYz658EENA
C3mJjHU/tvXpffKUe5j/kgHnwhzNq0B3KkNqleTFpX1pNH0+qGFbvTNZd+A+R8dk
D3+5sd4/P96kFIxi7X9O5u8w/eNyJWbaW4dC1obklaskt/67F+mJv7mE/dsaxGM=
=al72
-----END PGP SIGNATURE-----

--aH2JhRPj1O1v615i--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
