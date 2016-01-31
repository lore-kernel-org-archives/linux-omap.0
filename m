From: Sebastian Reichel <sre@kernel.org>
Subject: Re: 3-color led too bright
Date: Sun, 31 Jan 2016 01:24:07 +0100
Message-ID: <20160131002406.GA21238@earth>
References: <20160130200750.GB30429@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160130200750.GB30429@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pavel,

On Sat, Jan 30, 2016 at 09:07:50PM +0100, Pavel Machek wrote:
> The indicator 3-color LED in mainline kernel seem to be a bit too
> bright. .. more bright to look at comfortably. I believe it is also
> brighter than in original maemo... I believe I've seen note somewhere
> that hardware may allow too much current to the 3-color led damaging
> hardware... but I can't find the link now.

Safe current limits for the leds are configured in the DTS
(led-cur and max-cur) and can be checked in sysfs. I remember
testing the safety limits when I added them to DT, but the
driver has changed a bit since then.

-- Sebastian

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWrVQkAAoJENju1/PIO/qa0EkQAJR2ATyWfe43E85/gqeO0Mct
qyIStKG4nx4el6xEcsfXvInfInuUgt70NQo11SH1WD3ug9Xl3nOV/aj9rN5k3OdM
2Na7RQjOEpncpOi6ALFkPoJInOt1hFD2qbaN1yVSIyase3SHmdOgxJKTT3GbnEQ1
atn241gubQ2yJFowPE5A9CJSiYPAe8kO+9tZ2wP6610ky/TNTE9lG/Cg6R+ZXVp2
2hJFYO33MT9M6aKRY3IZFALxIBwNxi50fcr/fCTwOOw/9RIzJO8pWZx87cxRRINz
MLP+Mjrf3RaXqCuCgpWqQLNDROl+iEmTFCKp7/+2LEcUkrCr8ZN0T2YZrSMVk0hP
HeAHJGV6/v7aYGOVTwYg0lhjNYYbvLE9tg7IYIjmmPI3T8s95+CdPvY444kPK5Lr
/ryhjDPshVZ08cuufAcEQZIyWyyAIW3JyxptTCzl5tb0fA5yOwMDTTkzklgsISlq
Fkx3KHIGjRJyiKqcBg3JCTFebcc9KqzuqD8P8BVc4qkwlaxopgam0sqQZWk51SWO
0rFFbqocVvwQGxVNDTln1R/GZOe+piIfe9b78ImuSlVV5NihNrYPTZA8xymd5qGG
YshTfuqvLMMEZaVU8fI1cJSckaUaei2wiuFDksF47+Wk5ZZMyCUYxMP6Iou9Cajh
NrSgVBBilS5tPibvPCQ2
=UAEQ
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
